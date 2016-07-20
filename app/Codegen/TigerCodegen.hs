{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}

module Codegen.TigerCodegen where

-- Tiger compiler bindings
import Tiger.TigerLanguage

-- LLVM bindings
import qualified LLVM.General.AST as AST

-- states and monads
import Control.Monad.State.Strict
import Control.Applicative

-- Utilities
import qualified Data.Map.Strict as Map
import Control.Lens

type SymbolTable = Map.Map Symbol AST.Operand

emptySymbolTable :: SymbolTable
emptySymbolTable = Map.empty

type Names = Map.Map Symbol Int

emptyNames :: Names
emptyNames = Map.empty

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


