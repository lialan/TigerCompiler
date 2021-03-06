module Codegen.TigerEmit where

import Tiger.TigerLanguage
import Codegen.TigerEnvironment
import Codegen.TigerCodegen
import Codegen.TigerInstruction
import Codegen.TigerIntrinsics

import qualified LLVM.General.AST as A
import qualified LLVM.General.AST.Constant as C
import qualified LLVM.General.AST.Type as T

import Control.Lens
import qualified Data.Map as Map
import Control.Applicative
import Control.Monad (when)
import Data.Maybe (isJust, fromJust, fromMaybe)
import Debug.Trace

-- register a variable to symbol table
registerIntVar :: Symbol -> Codegen A.Operand
registerIntVar var = registerVar var T.i32

registerVar :: Symbol -> T.Type -> Codegen A.Operand
registerVar var ty = do
  -- create memory space for symbol
  opnd <- emitInst $ alloca ty
  -- register symbol
  st <- use symtab
  symtab .= [Map.insert var opnd (head st)] ++ (tail st)
  return opnd


-- Topmost function to call
codegenProgram :: Exp -> LLVM ()
codegenProgram e = do
  let cgs = execCodegen emptyCodegen $ do
        entry <- addBB entryBlockName
        setBB entry
        codegen e >>= ret
      blocks = createBlocks cgs
      mainFunction = createFuncDef T.i32 "main" [] blocks
      defList = [mainFunction] ++ cgs^.funcDefs
  mapM_ addDefinition (intrinsics ++ defList)

-- codegen function
codegenFunction :: FunDec -> Codegen ()
codegenFunction fd@(FunDec nm params rtty funBody) = do
  st <- use symtab
  tt <- use tytab
  ft <- use functab
  rty <- if isJust rtty then getType (fromJust rtty) else return T.void
  functab .= [Map.insert nm rty (head ft)] ++ tail ft
  fps <- mapM constructFormal params
  let fcg = execCodegen (newCodegen st tt ft) $ do
        entry <- addBB entryBlockName
        setBB entry
        -- push formal params to symbol table and set up function structure
        mapM_ loadParam params
        -- duplicate params and gen body
        rt <- codegen funBody
        if isJust rtty then ret rt else retvoid
      f = createFuncDef rty nm fps (createBlocks fcg)
      fds = [f] ++ fcg^.funcDefs
  fdlist <- use funcDefs
  funcDefs .= fds ++ fdlist

constructFormal :: Field -> Codegen (T.Type, A.Name)
constructFormal (Field sym _ ty) = do
  aty <- getType ty
  return $ (aty, A.Name sym)


loadParam :: Field -> Codegen ()
loadParam fd@(Field sym _ fty) = do
  ty   <- getType fty
  -- dupliate formal argument, and register to symtab
  st <- use symtab
  opnd <- emitInst $ alloca ty
  symtab .= [Map.insert sym opnd (head st)] ++ (tail st)
  let origVar = A.LocalReference ty (A.Name sym)
  emitInst $ store opnd origVar
  return ()
-- end of codegen function


-- all integers are 32 bit at the moment...
codegen :: Exp -> Codegen A.Operand
-- constant
codegen (IntExp i) = return $ A.ConstantOperand $ C.Int 32 i

-- variables should be handled separately
codegen (VarExp v) = emitInst =<< load <$> cgVar v

codegen (OpExp lhs op rhs) = case binops^.at op of
    Just f  -> emitInst =<< f <$> codegen lhs <*> codegen rhs
    Nothing -> error $ "unsupported operation: " ++ show op

-- call
codegen (CallExp f args) = do
  ty <- lookupFuncTable f
  case f of
    "printf" -> do
                 let strg = C.GlobalReference (T.ArrayType 3 T.i8) (A.Name "str")
                 let strhead = A.ConstantOperand $ C.GetElementPtr True strg [C.Int 32 0, C.Int 32 0]
                 trace ("strhead: " ++ show strhead) $ return ()
                 arg <- mapM codegen args
                 emitInst $ call (externFunc (A.Name f)) ([strhead] ++ arg)
    _        -> emitInst =<< call (externFunc (A.Name f)) <$> mapM codegen args

-- assign
codegen (AssignExp var exp) = emitInst =<< store <$> cgVar var <*> codegen exp

-- get the last exp's result as the sequence's result
codegen (SeqExp exps) = mapM_ codegen exps >> return zero

codegen (LetExp decs body) = do
  enterDefScope
  cgDecls decs
  result <- codegen body
  exitDefScope
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

  enterDefScope
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

  exitDefScope
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

-- don't need to load the array header because there is only one of it and we remember it.
cgVar (SubscriptVar var idx) = emitInst =<< gep <$> cgVar var <*> codegen idx

-- top level declaration dispatch:
cgDecls :: [Dec] -> Codegen ()
cgDecls decList = mapM_ cgDec decList

-- dispatch for declaration types:
cgDec :: Dec -> Codegen ()
cgDec (VarDec name _ mty initExp) =
  -- assign value to initial value and register name to var table
  case mty of
    Just t  -> do
                 ty <- getType t
                 case ty == T.i32 of
                   True  -> simpleVarDec
                   False -> cgArray name ty initExp
    Nothing -> simpleVarDec
    where simpleVarDec = store <$> registerIntVar name <*> codegen initExp >>= emitInst >> return ()

cgDec (TypeDec tydecs) = mapM_ cgTypeDecl tydecs
  where cgTypeDecl = uncurry registerNewType

cgDec (FunctionDec funcdecs) = mapM_ codegenFunction funcdecs



cgArray :: Symbol -> T.Type -> Exp -> Codegen ()
cgArray aname ty (ArrayExp aty' (IntExp asize) ainit) = do
  -- type check
  aty <- lookupTypeTable aty'
  when (ty /= aty) $ error "Array variable declartion: type does not match."
  -- construt array using arrlen, initval, and ty.
  let getArrayElemType (T.ArrayType _ elemType) = elemType
      elemty = getArrayElemType aty
  array <- emitInst $ allocaArray elemty (fromIntegral asize)
  -- TODO: init array
  initval <- codegen ainit
  aptr <- emitInst $ bitcast (T.ptr T.i8) array
  emitInst $ call (memset elemty) [aptr, i8val 0, int asize, int 1, i1false]
  -- register type
  st <- use symtab
  symtab .= [Map.insert aname array (head st)] ++ (tail st)

cgArray _ _ _ = error $ "cgArray called to match non-ArrayExp."

