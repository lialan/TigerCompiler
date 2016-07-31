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
import Control.Monad (when)


-- register a variable to symbol table
registerIntVar :: Symbol -> Codegen A.Operand
registerIntVar var = do
  -- create memory space for symbol
  opnd <- emitInst $ alloca T.i64
  -- register symbol
  st <- use symtab
  symtab .= [Map.insert var opnd (head st)] ++ (tail st)
  return opnd

codegenProgram :: Exp -> LLVM ()
codegenProgram e = do
  let blocks = createBlocks $ execCodegen $ do
        entry <- addBB entryBlockName
        setBB entry
        codegen e >>= ret
      mainFunction = createFuncDef T.i64 "main" [] blocks
  addDefinition mainFunction

-- all integers are 64 bit at the moment...
codegen :: Exp -> Codegen A.Operand
-- constant
codegen (IntExp i) = return $ A.ConstantOperand $ C.Int 64 i

-- variables should be handled separately
codegen (VarExp v) = emitInst =<< load <$> cgVar v

codegen (OpExp lhs op rhs) = case binops^.at op of
    Just f  -> do
                 emitInst =<< f <$> codegen lhs <*> codegen rhs
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

codegen (IfExp test then' (Just else')) = do
  thenBlock <- addBB "cond_true"
  elseBlock <- addBB "cond_false"
  exitBlock <- addBB "cond_next"

  c <- codegen test
  test <- emitInst $ ifelseTest c
  cbr test thenBlock elseBlock

  -- then block
  setBB thenBlock >> codegen then' >> br exitBlock

  -- else block
  setBB elseBlock >> codegen else' >> br exitBlock
  emitInst nop

codegen (IfExp test then' Nothing) = do
  thenBlock <- addBB "cond_true"
  exitBlock <- addBB "cond_next"

  -- test
  c <- codegen test
  test <- emitInst $ ifelseTest c
  cbr test thenBlock exitBlock

  -- then block
  setBB thenBlock >> codegen then' >> br exitBlock
  setBB exitBlock
  emitInst nop

codegen (ForExp iter _ lo hi body) = do
  testBlock <- addBB "for.test"
  forBlock  <- addBB "for.loop"
  exitBlock <- addBB "for.exit"

  enterSTScope
  registerIntVar iter
  emitInst =<< store <$> getvar iter <*> codegen lo
  br testBlock

  -- condition
  setBB testBlock
  iter'' <- emitInst =<< load <$> getvar iter
  test <- emitInst =<< ne <$> pure iter'' <*> codegen hi
  cbr test forBlock exitBlock

  setBB forBlock >> codegen body

  --increment at the end of forBlock
  setBB forBlock
  iter' <- emitInst =<< load <$> getvar iter
  newIter <- emitInst $ increment iter'
  emitInst =<< store <$> getvar iter <*> pure newIter
  br testBlock

  exitSTScope
  setBB exitBlock
  emitInst nop

codegen BreakExp = do
  ls <- use loopScope
  when (null ls) $ error $ "BreakExp in non-loop scope."
  br (head ls)
  emitInst nop

codegen (WhileExp test body) = do
  testBlock <- addBB "while.test"
  bodyBlock <- addBB "while.body"
  exitBlock <- addBB "while.exit"

  setBB testBlock
  t <- codegen test
  cbr t bodyBlock exitBlock

  setBB bodyBlock
  codegen body
  br testBlock

  setBB exitBlock
  emitInst nop


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
-- TODO: aggregated types implementation
cgVar (FieldVar var field) = undefined

cgVar (SubscriptVar var idx) = emitInst =<< gep <$> cgVar var <*> codegen idx

-- top level declaration dispatch:
cgDecls :: [Dec] -> Codegen ()
cgDecls decList = mapM_ cgDec decList

-- dispatch for declaration types:
cgDec :: Dec -> Codegen ()
cgDec (VarDec name _ mty initExp) = do
  -- assign value to initial value and register name to var table
  case mty of
    Just ty -> undefined
    Nothing -> store <$> registerIntVar name <*> codegen initExp >>= emitInst >> return ()

cgDec (TypeDec tydecs) = mapM_ cgTypeDecl tydecs
  where cgTypeDecl = uncurry registerNewType

cgDec (FunctionDec funcdecs) = mapM_ cgFuncDec funcdecs
  where cgFuncDec (FunDec nm names rtty funBody) = undefined

