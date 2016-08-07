module Codegen.TigerCodegen where

-- Tiger compiler bindings
import Tiger.TigerLanguage
import Codegen.TigerSymbolTable
import Codegen.TigerEnvironment

-- LLVM bindings
import qualified LLVM.General.AST as AST
import qualified LLVM.General.AST.Type as Type
import qualified LLVM.General.AST.Global as Global
import qualified LLVM.General.AST.Constant as Constant
import qualified LLVM.General.AST.Linkage as Linkage

-- states and monads
import Control.Applicative

-- Utilities
import Control.Lens
import Data.Map.Lens
import Data.Maybe
import qualified Data.Map as Map
import qualified Data.Sequence as Seq
import Control.Monad
import Control.Monad.State.Strict
import Data.Foldable (toList)
import qualified Data.List as List (sortBy)
import Data.Function (on)
import Data.Char (ord)

uniqueName :: Symbol -> Names -> (Symbol, Names)
uniqueName nm ns =
  case ns^.at nm of
    Nothing  -> (nm, Map.insert nm 1 ns)
    Just idx -> (nm ++ show idx, Map.insert nm (idx+1) ns)


runLLVM :: AST.Module -> LLVM a -> AST.Module
runLLVM = flip (execState . unLLVM)

emptyModule :: Symbol -> AST.Module
emptyModule label = AST.defaultModule { AST.moduleName = label }

execCodegen :: CodegenState -> Codegen a -> CodegenState
execCodegen cgs mcg = execState (runCodegen mcg) cgs

nextCount :: Codegen Word
nextCount = count += 1 >> use count

-- Returns the reference to the generated instruction
emitInst :: AST.Instruction -> Codegen AST.Operand
emitInst i = do
  n <- nextCount
  let ref = (AST.UnName n)
  let newInst = ref AST.:= i
  emitNamedInst newInst
  return $ local ref

terminator :: NamedTerminator -> Codegen (NamedTerminator)
terminator trm = emitTerm trm >> return trm

insertInstruction :: NamedInstruction -> Codegen ()
insertInstruction inst = undefined

-- References

-- variables, they are all 32 bits.
local :: AST.Name -> AST.Operand
local = AST.LocalReference Type.i32

currentBB :: Codegen BB
currentBB = do
  c <- use curBlkName
  blks <- use bbs
  case  blks^.at c of
    Just x -> return x
    Nothing -> error $ "No such block: " ++ show c


-- Symbol Table
enterDefScope :: Codegen ()
enterDefScope = do
  st <- use symtab
  symtab .= [Map.empty] ++ st
  tt <- use tytab
  tytab .= [Map.empty] ++ tt
  ft <- use functab
  functab .= [Map.empty] ++ ft

exitDefScope :: Codegen ()
exitDefScope = do
  st <- use symtab
  symtab .= tail st
  tt <- use tytab
  tytab .= tail tt
  ft <- use functab
  functab .= tail ft

-- record types in type table
registerNewType :: Symbol -> Ty -> Codegen ()
registerNewType nm (NameTy tyname) = do
  ty <- lookupTypeTable tyname
  insertTypeTable nm ty

-- TODO: for aggregated types, we should add to global definition.
registerNewType nm (RecordTy _) = error "registerNewType for RecordTy not implemented."

registerNewType nm (ArrayTy ty)  = do
  elemty <- getType ty
  -- create array type
  let aty = Type.ArrayType 0 elemty
  insertTypeTable nm aty

-- utility functiosn for type tables
lookupTypeTable :: Symbol -> Codegen Type.Type
lookupTypeTable sym = do
  tt <- use tytab
  lookupTableHelper sym tt

lookupFuncTable :: Symbol -> Codegen Type.Type
lookupFuncTable sym = do
  ft <- use functab
  lookupTableHelper sym ft

lookupTableHelper :: Symbol -> [Map.Map Symbol a] -> Codegen a
lookupTableHelper sym tt = do
  when (null tt) $ do error $ "lookupTypeTable: cannot find symbol: " ++ show sym
  let t = (head tt)^.at sym
  if isNothing t
  then lookupTableHelper sym (tail tt)
  else return (fromJust t)

insertTypeTable :: Symbol -> Type.Type -> Codegen ()
insertTypeTable sym ty = do
  tt <- use tytab
  when (null tt) $ error "insertTypeTable: encounter empty TypeTable list."
  tytab .= [Map.insert sym ty (head tt)] ++ tail tt

getType :: Ty -> Codegen Type.Type
getType (NameTy tysym) = lookupTypeTable tysym
getType _ = error $ "undefined function: getType"

-- find the first occurrence from the stack.
getvar :: Symbol -> Codegen AST.Operand
getvar var = do
  st <- use symtab
  let result = lookupST st var
  when (isFunction result) $ error $ "var " ++ show var ++ " is shadowed by a function."
  return result

-- Blocks
addBB :: Symbol -> Codegen AST.Name
addBB bn = do
  bls <- use bbs
  ix  <- use blockCount
  nms <- use names
  let (qname, supply) = uniqueName bn nms
      newName = AST.Name qname
      new = emptyBlock ix newName
  blockCount += 1
  names .= supply
  modify' $ \s -> s { _bbs = Map.insert newName new bls }
  return newName


setBB :: AST.Name -> Codegen AST.Name
setBB name = do
  curBlkName .= name
  return name

emitNamedInst :: NamedInstruction -> Codegen ()
emitNamedInst inst = do
  b  <- currentBB
  bn <- use curBlkName
  let b' = over instrs (\x -> x |> inst) b
  modify' $ bbs . at bn ?~ b'

emitTerm :: NamedTerminator -> Codegen ()
emitTerm t = do
  b <- currentBB
  bn <- use curBlkName
  modify' $ bbs . at bn ?~ set term (Just t) b

-- definitions
type FunctionBody = [Global.BasicBlock]
createFuncDef :: Type.Type -> Symbol -> Arguments -> FunctionBody -> AST.Definition
createFuncDef rt fn args body = AST.GlobalDefinition $ AST.functionDefaults {
  Global.name        = AST.Name fn,
  Global.parameters  = ([AST.Parameter ty nm [] | (ty, nm) <- args], False),
  Global.returnType  = rt,
  Global.basicBlocks = body
}

addDefinition :: AST.Definition -> LLVM ()
addDefinition def = do
  definitions <- gets AST.moduleDefinitions
  modify' $ \s -> s { AST.moduleDefinitions = [def] ++ definitions }

createExternFuncDef :: Type.Type -> Symbol -> [AST.Parameter] -> AST.Definition
createExternFuncDef rt fn args = AST.GlobalDefinition $ AST.functionDefaults {
  Global.name        = AST.Name fn,
  Global.parameters  = (args, False),
  Global.returnType  = rt,
  Global.basicBlocks = []
}

createVarExternFuncDef :: Type.Type -> Symbol -> [AST.Parameter] -> AST.Definition
createVarExternFuncDef rt fn args = AST.GlobalDefinition $ AST.functionDefaults {
  Global.name        = AST.Name fn,
  Global.parameters  = (args, True),
  Global.returnType  = rt,
  Global.basicBlocks = []
}

createStringDef :: Symbol -> String -> AST.Definition
createStringDef name val = AST.GlobalDefinition $ AST.globalVariableDefaults {
  Global.name        = AST.Name name,
  Global.linkage     = Linkage.Private,
  Global.isConstant  = True,
  Global.type'       = Type.ArrayType (fromIntegral $ length val) Type.i8,
  Global.initializer = Just (Constant.Array Type.i8 (fmap (\c -> Constant.Int 8 (fromIntegral $ ord c)) val))
}


-- we need a way to identify
isFunction :: AST.Operand -> Bool
isFunction (AST.ConstantOperand (Constant.GlobalReference (Type.FunctionType _ _ _) _)) = True
isFunction _ = False


-- Types
embeddedTypes = Map.fromList [("int", Type.i32)]

lookupType :: SymbolTable -> Symbol -> Type.Type
lookupType st nm = case embeddedTypes^.at nm of
                     Just x  -> x
                     Nothing -> error $ "Custom types are not yet implemented: " ++ show nm

isSimpleType :: Type.Type -> Bool
isSimpleType i32 = True
isSimpleType _   = False

-- Basic block
toBasicBlock :: (AST.Name, BasicBlock) -> AST.BasicBlock
toBasicBlock (_, BasicBlock idx insts term name) = AST.BasicBlock name (toList insts) (getTerm term)
  where getTerm t = case t of
          Just x  -> x
          Nothing -> error $ "basic block has no terminator: " ++ show idx

sortBlocks :: [(AST.Name, BasicBlock)] ->  [(AST.Name, BasicBlock)]
sortBlocks = List.sortBy (compare `on` (_idx . snd))

createBlocks :: CodegenState -> [AST.BasicBlock]
createBlocks cgs = map toBasicBlock (sortBlocks $ Map.toList $ cgs^.bbs)

