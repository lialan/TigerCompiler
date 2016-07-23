{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell #-}

module Codegen.TigerCodegen where

-- Tiger compiler bindings
import Tiger.TigerLanguage

-- LLVM bindings
import qualified LLVM.General.AST as AST
import qualified LLVM.General.AST.Type as Type


-- states and monads
import Control.Monad.State.Strict
import Control.Applicative

-- Utilities
import qualified Data.Map.Strict as Map
import Control.Lens
import Data.Map.Lens
import Data.String

-- Symbol Table
type SymbolTable = [(Symbol, AST.Operand)]

emptySymbolTable :: SymbolTable
emptySymbolTable = []

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
  _instrs :: [NamedInstruction],
  _term :: Maybe (NamedTerminator),
  _name :: AST.Name
} deriving Show

type BB = BasicBlock

makeLenses ''BasicBlock

emptyBlockTable :: Map.Map AST.Name BB
emptyBlockTable = Map.empty

emptyBlock :: Int -> AST.Name -> BB
emptyBlock i name = BasicBlock i [] Nothing name

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

modifyBlock :: BB -> Codegen ()
modifyBlock nb = do
  active <- use curBlkName
  modify' $ bbs . at active ?~ nb


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


fresh :: Codegen Word
fresh = do
    count += 1
    use count

instr :: AST.Instruction -> Codegen AST.Operand
instr ins = do
  n <- fresh
  let ref = (AST.UnName n)
  blk <- current
  let i = _instrs blk
  let newInst = ref AST.:= ins
  modifyBlock (blk { _instrs = i ++ [newInst] })
  return $ local ref

terminator :: NamedTerminator -> Codegen (NamedTerminator)
terminator trm = do
  blk <- current
  modifyBlock (blk { _term = Just trm })
  return trm

insertInstruction :: NamedInstruction -> Codegen ()
insertInstruction inst = undefined

-- References

-- variables, they are all 64bits.
local :: AST.Name -> AST.Operand
local = AST.LocalReference Type.i64

current :: Codegen BB
current = do
  c <- use curBlkName
  blks <- use bbs
  case  blks^.at c of
    Just x -> return x
    Nothing -> error $ "No such block: " ++ show c


-- Symbol Table
assign :: Symbol -> AST.Operand -> Codegen ()
assign var x = do
    st <- use symtab
    symtab .= [(var, x)] ++ st

-- TODO: this will have to change to a stack type.
getvar :: Symbol -> Codegen AST.Operand
getvar var = do
  st <- use symtab
  case lookup var st of
    Just x  -> return x
    Nothing -> error $ "Local variable not in scope: " ++ show var


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











