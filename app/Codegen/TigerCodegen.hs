{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell #-}

module Codegen.TigerCodegen where

-- Tiger compiler bindings
import Tiger.TigerLanguage

-- LLVM bindings
import qualified LLVM.General.AST as AST
import qualified LLVM.General.AST.Type as Type
import qualified LLVM.General.AST.Global as Global
import qualified LLVM.General.AST.Constant as Constant
-- states and monads
import Control.Monad.State.Strict
import Control.Applicative

-- Utilities
import qualified Data.Map.Strict as Map
import Control.Lens
import Data.Map.Lens
import Data.String
import qualified Data.Sequence as Seq
import Data.Maybe

-- Symbol Table
type SymbolTable = [Map.Map Symbol AST.Operand]

emptySymbolTable :: SymbolTable
emptySymbolTable = [Map.empty]

-- Name Table
type Names = Map.Map Symbol Int
emptyNames :: Names
emptyNames = Map.empty

instance IsString AST.Name where
  fromString = AST.Name . fromString

uniqueName :: Symbol -> Names -> (Symbol, Names)
uniqueName nm ns =
  case ns^.at nm of
    Nothing  -> (nm, Map.insert nm 1 ns)
    Just idx -> (nm ++ show idx, Map.insert nm (idx+1) ns)

-- Instruction aliases
type NamedInstruction = AST.Named AST.Instruction
type NamedTerminator  = AST.Named AST.Terminator


data BasicBlock = BasicBlock {
  _idx :: Int,
  _instrs :: Seq.Seq NamedInstruction,
  _term :: Maybe (NamedTerminator),
  _name :: AST.Name
} deriving Show

type BB = BasicBlock

makeLenses ''BasicBlock

emptyBlockTable :: Map.Map AST.Name BB
emptyBlockTable = Map.empty

emptyBlock :: Int -> AST.Name -> BB
emptyBlock i name = BasicBlock i Seq.empty Nothing name

data CodegenState = CodegenState {
  _curBlkName   :: AST.Name,
  _bbs          :: Map.Map AST.Name BB,
  _symtab       :: SymbolTable,
  _blockCount   :: Int,
  _count        :: Word,
  _names        :: Names
} deriving Show

makeLenses ''CodegenState

emptyCodegen :: CodegenState
emptyCodegen = CodegenState (AST.Name entryBlockName)
                            emptyBlockTable emptySymbolTable 1 0
                            emptyNames

newtype Codegen a = Codegen { runCodegen :: State CodegenState a }
  deriving (Functor, Applicative, Monad, MonadState CodegenState)

newtype LLVM a = LLVM { unLLVM :: State AST.Module a }
  deriving (Functor, Applicative, Monad, MonadState AST.Module)

runLLVM :: AST.Module -> LLVM a -> AST.Module
runLLVM = flip (execState . unLLVM)

emptyModule :: Symbol -> AST.Module
emptyModule label = AST.defaultModule { AST.moduleName = label }

entry :: Codegen AST.Name
entry = use curBlkName

entryBlockName :: String
entryBlockName = "entry"

execCodegen :: Codegen a -> CodegenState
execCodegen mcg = execState (runCodegen mcg) emptyCodegen


nextCount :: Codegen Word
nextCount = count += 1 >> use count

-- Returns the reference to the generated instruction
instr :: AST.Instruction -> Codegen AST.Operand
instr i = do
  n <- nextCount
  let ref = (AST.UnName n)
  let newInst = ref AST.:= i
  emitInst newInst
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
  st <- use symtab
  symtab .= [Map.empty] ++ st

exitSTScope :: Codegen ()
exitSTScope = do
  st <- use symtab
  symtab .= tail st

assign :: Symbol -> AST.Operand -> Codegen ()
assign var x = do
    st@(h:t) <- use symtab
    when (st == []) $ error $ "Current symbol table is empty."
    symtab .= [Map.insert var x h] ++ t

-- find the first occurrence from the stack.
getvar :: Symbol -> Codegen AST.Operand
getvar var = do
  st <- use symtab
  let result = lookupST st var
  when (isFunction result) $ error $ "var " ++ show var ++ " is shadowed by a function."
  return result

lookupST :: SymbolTable -> Symbol -> AST.Operand
lookupST st s = case st of
  []     -> error $ "Local variable not in scope: " ++ show s
  (x:xs) -> case x^.at s of
              Just x  -> x
              Nothing -> lookupST xs s

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

emitInst :: NamedInstruction -> Codegen ()
emitInst inst = do
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
type Arguments = [(Type.Type, AST.Name)]
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
