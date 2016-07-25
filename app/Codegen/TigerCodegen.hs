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

uniqueName :: Symbol -> Names -> (Symbol, Names)
uniqueName nm ns =
  case ns^.at nm of
    Nothing  -> (nm, Map.insert nm 1 ns)
    Just idx -> (nm ++ show idx, Map.insert nm (idx+1) ns)


runLLVM :: AST.Module -> LLVM a -> AST.Module
runLLVM = flip (execState . unLLVM)

emptyModule :: Symbol -> AST.Module
emptyModule label = AST.defaultModule { AST.moduleName = label }

execCodegen :: Codegen a -> CodegenState
execCodegen mcg = execState (runCodegen mcg) emptyCodegen

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

-- variables, they are all 64bits.
local :: AST.Name -> AST.Operand
local = AST.LocalReference Type.i64

currentBB :: Codegen BB
currentBB = do
  c <- use curBlkName
  blks <- use bbs
  case  blks^.at c of
    Just x -> return x
    Nothing -> error $ "No such block: " ++ show c


-- Symbol Table
enterSTScope :: Codegen ()
enterSTScope = do
  st <- use $ symtab
  symtab .= [Map.empty] ++ st

exitSTScope :: Codegen ()
exitSTScope = do
  st <- use $ symtab
  symtab .= tail st

registerVar :: Symbol -> AST.Operand -> Codegen ()
registerVar var x = do
  st@(h:t) <- use symtab
  when (st == []) $ error $ "Current symbol table is empty."
  symtab .= [Map.insert var x h] ++ t


-- record types in type table
registerNewType :: Symbol -> Ty -> Codegen ()
registerNewType nm (NameTy tyname) = do
  tt <- use tytab
  let ty = case tt^.at nm of
             Just x  -> x
             Nothing -> error $ "Wrong type: " ++ show nm
  tytab .= Map.insert nm ty tt

-- TODO: for aggregated types, we should add to global definition.
registerNewType nm (RecordTy _) = undefined
registerNewType nm (ArrayTy _)  = undefined

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

-- Function definitions

type FunctionBody = [Global.BasicBlock]
createFuncDef :: Type.Type -> Symbol -> Arguments -> FunctionBody -> AST.Definition
createFuncDef rt fn args body = AST.GlobalDefinition $ AST.functionDefaults {
  Global.name        = AST.Name fn,
  Global.parameters  = ([AST.Parameter ty nm [] | (ty, nm) <- args], False),
  Global.returnType  = rt,
  Global.basicBlocks = body
}

-- we need a way to identify
isFunction :: AST.Operand -> Bool
isFunction (AST.ConstantOperand (Constant.GlobalReference (Type.FunctionType _ _ _) _)) = True
isFunction _ = False


-- Types

embeddedTypes = Map.fromList [("int", Type.i64)]

lookupType :: SymbolTable -> Symbol -> Type.Type
lookupType st nm = case embeddedTypes^.at nm of
                     Just x  -> x
                     Nothing -> error $ "Custom types are not yet implemented: " ++ show nm


