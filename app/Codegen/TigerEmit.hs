module Codegen.TigerEmit where

import Codegen.TigerCodegen
import Codegen.TigerInstruction

import Tiger.TigerLanguage

import qualified LLVM.General.AST as A
import qualified LLVM.General.AST.Constant as C


import Control.Lens
import qualified Data.Map as Map

-- all integers are 64 bit at the moment...
codegen :: Exp -> Codegen A.Operand
-- constant
codegen (IntExp i) = return $ A.ConstantOperand $ C.Int 64 i

-- variables should be handled separately
codegen (VarExp v) = instr =<< load <$> cgVar v

codegen (OpExp lhs op rhs) = case binops^.at op of
    Just f  -> instr =<< f <$> codegen lhs <*> codegen rhs
    Nothing -> error $ "unsupported operation: " ++ show op

-- call
codegen (CallExp f args) = instr =<< call (externFunc (A.Name f)) <$> mapM codegen args

-- assign
codegen (AssignExp var exp) = instr =<< store <$> cgVar var <*> codegen exp

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

-- declarations
cgDecls :: [Dec] -> Codegen ()
cgDecls = undefined





