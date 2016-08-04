{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleContexts #-}

module Codegen.TigerEnvironment where

import Tiger.TigerLanguage
import Codegen.TigerSymbolTable

import qualified LLVM.General.AST as AST
import qualified LLVM.General.AST.Type as Type

import Control.Lens
import Control.Monad.State.Strict
import Data.String
import qualified Data.Map.Strict as Map
import qualified Data.Sequence as Seq


instance IsString AST.Name where
  fromString = AST.Name . fromString

-- Instruction aliases
type NamedInstruction = AST.Named AST.Instruction
type NamedTerminator  = AST.Named AST.Terminator

-- Basic block
data BasicBlock = BasicBlock {
  _idx :: Int,
  _instrs :: Seq.Seq NamedInstruction,
  _term :: Maybe (NamedTerminator),
  _name :: AST.Name
} deriving Show

type BB = BasicBlock

makeLenses ''BasicBlock


-- Codegen
data CodegenState = CodegenState {
  _curBlkName   :: AST.Name,
  _bbs          :: Map.Map AST.Name BB,
  _symtab       :: SymbolTable,
  _tytab        :: TypeTable,
  _blockCount   :: Int,
  _count        :: Word,
  _loopScope    :: [AST.Name],
  _returnType   :: Maybe Type.Type,
  _names        :: Names
} deriving Show

makeLenses ''CodegenState

-- we need a monad for codegen
newtype Codegen a = Codegen { runCodegen :: State CodegenState a }
  deriving (Functor, Applicative, Monad, MonadState CodegenState)

-- we need another monad for generating AST.Module
newtype LLVM a = LLVM { unLLVM :: State AST.Module a }
  deriving (Functor, Applicative, Monad, MonadState AST.Module)

type TypeVarPair = (Type.Type, AST.Name)
type Arguments = [TypeVarPair]

entry :: Codegen AST.Name
entry = use curBlkName

entryBlockName :: String
entryBlockName = "entry"

emptyCodegen :: CodegenState
emptyCodegen = CodegenState (AST.Name entryBlockName)
                            emptyBlockTable
                            emptySymbolTable
                            initTypeTable 1 0
                            [] (Just Type.i64) emptyNames

emptyBlockTable :: Map.Map AST.Name BB
emptyBlockTable = Map.empty

emptyBlock :: Int -> AST.Name -> BB
emptyBlock i name = BasicBlock i Seq.empty Nothing name

newCodegen :: SymbolTable -> TypeTable -> CodegenState
newCodegen st tt = CodegenState (AST.Name entryBlockName)
                                emptyBlockTable
                                st tt 1 0 [] Nothing emptyNames
