module Codegen.TigerEmit where

import Tiger.TigerLanguage
import Codegen.TigerEnvironment
import Codegen.TigerCodegen
import Codegen.TigerInstruction

import qualified LLVM.General.AST as A
import qualified LLVM.General.AST.Constant as C
import qualified LLVM.General.AST.Type as T

import Control.Lens
import qualified Data.Map as Map
import Control.Applicative

{-
codegenProgram :: Exp -> LLVM ()
codegenProgram e = do
  define T.i64 "main" [] blocks
  where
    blocks = createBlocks $ execCodegen $ do
      entry <- addBlock entryBlockName
      setBlock entry
      codegen e >>= ret
-}


-- all integers are 64 bit at the moment...
codegen :: Exp -> Codegen A.Operand
-- constant
codegen (IntExp i) = return $ A.ConstantOperand $ C.Int 64 i

-- variables should be handled separately
codegen (VarExp v) = emitInst =<< load <$> cgVar v

codegen (OpExp lhs op rhs) = case binops^.at op of
    Just f  -> emitInst =<< f <$> codegen lhs <*> codegen rhs
    Nothing -> error $ "unsupported operation: " ++ show op

-- call
codegen (CallExp f args) = emitInst =<< call (externFunc (A.Name f)) <$> mapM codegen args

-- assign
codegen (AssignExp var exp) = emitInst =<< store <$> cgVar var <*> codegen exp

codegen (SeqExp [exps]) = undefined

codegen (LetExp decs body) = do
  enterSTScope
  cgDecls decs
  result <- codegen body
  exitSTScope
  return result

-- binary ops
binops = Map.fromList [(PlusOp,  add),
                       (MinusOp, sub),
                       (TimesOp, mul),
                       (LtOp,  lt),
                       (GtOp,  gt),
                       (LeOp,  le),
                       (GeOp,  ge),
                       (NeqOp, ne),
                       (EqOp,  eq),
                       (AndOp, and_),
                       (OrOp,  or_)
                       ]

-- vars
cgVar :: Var -> Codegen A.Operand
cgVar (SimpleVar v) = getvar v
cgVar (FieldVar var field) = undefined
cgVar (SubscriptVar var idx) = undefined

-- top level declaration dispatch:
cgDecls :: [Dec] -> Codegen ()
cgDecls decList = mapM_ cgDec decList

-- dispatch for declaration types:
cgDec :: Dec -> Codegen ()
cgDec (VarDec name _ ty initExp) = do
  evaluatedExp <- codegen initExp
  registerVar name evaluatedExp

cgDec (TypeDec tydecs) = mapM_ cgTypeDecl tydecs
  where cgTypeDecl = uncurry registerNewType

cgDec (FunctionDec funcdecs) = mapM_ cgFuncDec funcdecs
  where cgFuncDec (FunDec nm names rtty funBody) = undefined

-- Field
cgField :: Field -> Codegen (Symbol, A.Operand)
cgField (Field nm _ tysym) = do
  st <- use tytab
  let ty = case st^.at nm of
             Just x  -> x
             Nothing -> error $ "undefined type: " ++ show nm
  return (nm, A.LocalReference ty (A.Name nm))

