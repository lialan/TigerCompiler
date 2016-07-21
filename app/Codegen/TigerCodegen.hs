{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}
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

type SymbolTable = [(Symbol, AST.Operand)]

emptySymbolTable :: SymbolTable
emptySymbolTable = []

-- Names
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

-- TODO: add lenses: Ubuntu 16.04 does not handle templates. Ignoring at the moment
data Block = Block {
  idx :: Int,
  instrs :: [AST.Named AST.Instruction],
  term :: Maybe (AST.Named AST.Terminator)
} deriving Show

emptyBlockTable :: Map.Map AST.Name Block
emptyBlockTable = Map.empty

emptyBlock :: Int -> Block
emptyBlock i = Block i [] Nothing

data CodegenState = CodegenState {
  currentBlock :: AST.Name,
  blocks       :: Map.Map AST.Name Block,
  symtab       :: SymbolTable,
  blockCount   :: Int,
  count        :: Word,
  names        :: Names
} deriving Show


emptyCodegen :: CodegenState
emptyCodegen = CodegenState (AST.Name entryBlockName)
                            emptyBlockTable emptySymbolTable 1 0
                            emptyNames

modifyBlock :: Block -> Codegen ()
modifyBlock nb = do
  active <- gets currentBlock
  modify $ \s -> s { blocks = Map.insert active nb (blocks s)}


newtype Codegen a = Codegen { runCodegen :: State CodegenState a }
  deriving (Functor, Applicative, Monad, MonadState CodegenState)

newtype LLVM a = LLVM { unLLVM :: State AST.Module a }
  deriving (Functor, Applicative, Monad, MonadState AST.Module)

runLLVM :: AST.Module -> LLVM a -> AST.Module
runLLVM = flip (execState . unLLVM)

emptyModule :: Symbol -> AST.Module
emptyModule label = AST.defaultModule { AST.moduleName = label }

entry :: Codegen AST.Name
entry = gets currentBlock

entryBlockName :: String
entryBlockName = "entry"

execCodegen :: Codegen a -> CodegenState
execCodegen mcg = execState (runCodegen mcg) emptyCodegen


fresh :: Codegen Word
fresh = do
    i <- gets count
    modify' $ \s -> s { count = 1 + i }
    return $ i + 1

instr :: AST.Instruction -> Codegen AST.Operand
instr ins = do
  n <- fresh
  let ref = (AST.UnName n)
  blk <- current
  let i = instrs blk
  modifyBlock (blk { instrs = i ++ [ref AST.:= ins ] })
  return $ local ref

terminator :: AST.Named AST.Terminator -> Codegen (AST.Named AST.Terminator)
terminator trm = do
  blk <- current
  modifyBlock (blk { term = Just trm })
  return trm


-- References

-- variables, they are all 64bits.
local :: AST.Name -> AST.Operand
local = AST.LocalReference Type.i64

current :: Codegen Block
current = do
  c <- gets currentBlock
  blks <- gets blocks
  case Map.lookup c blks of
    Just x -> return x
    Nothing -> error $ "No such block: " ++ show c


-- Symbol Table
assign :: Symbol -> AST.Operand -> Codegen ()
assign var x = do
    st <- gets symtab
    modify $ \s -> s { symtab = [(var, x)] ++ st }


getvar :: Symbol -> Codegen AST.Operand
getvar var = do
  st <- gets symtab
  case lookup var st of
    Just x  -> return x
    Nothing -> error $ "Local variable not in scope: " ++ show var


-- Blocks
setBlock :: AST.Name -> Codegen AST.Name
setBlock name = do
  modify $ \s -> s { currentBlock = name }
  return name











