module Codegen.TigerInstruction where

import Tiger.TigerLanguage
import Codegen.TigerEnvironment
import Codegen.TigerCodegen

import LLVM.General.AST as A
import LLVM.General.AST.Type as T
import LLVM.General.AST.Global as G
import LLVM.General.AST.Instruction as I
import LLVM.General.AST.IntegerPredicate as IP
import LLVM.General.AST.Constant as C
import LLVM.General.AST.CallingConvention as CC



-- arithmatic instructions
add, sub, mul :: A.Operand -> A.Operand -> A.Instruction
add a b = A.Add True True a b []
sub a b = A.Sub True True a b []
mul a b = A.Mul True True a b []

-- comparisons:
lt, gt, le, ge, eq, ne :: A.Operand -> A.Operand -> A.Instruction
lt l r = I.ICmp IP.SLT l r []
gt l r = I.ICmp IP.SGT l r []
le l r = I.ICmp IP.SLE l r []
ge l r = I.ICmp IP.SGE l r []
ne l r = I.ICmp IP.NE  l r []
eq l r = I.ICmp IP.EQ  l r []

-- bitwise:
and_, or_ :: A.Operand -> A.Operand -> A.Instruction
and_ l r = A.And l r []
or_  l r = A.Or  l r []


-- branch instructions
br :: A.Name -> Codegen (NamedTerminator)
br val = terminator $ I.Do $ I.Br val []

cbr :: A.Operand -> A.Name -> A.Name -> Codegen (NamedTerminator)
cbr cond tr fl = terminator $ I.Do $ I.CondBr cond tr fl []

ret :: A.Operand -> Codegen (NamedTerminator)
ret val = terminator $ I.Do $ I.Ret (Just val) []

retvoid :: Codegen (NamedTerminator)
retvoid = terminator $ I.Do $ I.Ret Nothing []

-- effect instructions
call :: A.Operand -> [A.Operand] -> A.Instruction
call fn args = I.Call Nothing CC.C [] (Right fn) (toArgs args) [] []
    where toArgs = map (\x -> (x , []))

alloca :: A.Type -> A.Instruction
alloca ty = I.Alloca ty Nothing 0 []

allocaArray :: A.Type -> Integer -> A.Instruction
allocaArray ty arlen = I.Alloca ty (Just (A.ConstantOperand (C.Int 32 arlen))) 0 []

store :: A.Operand -> A.Operand -> A.Instruction
store ptr val = I.Store False ptr val Nothing 0 []

load :: A.Operand -> A.Instruction
load ptr = I.Load False ptr Nothing 0 []

-- function references
externFunc :: A.Name -> A.Operand
externFunc = A.ConstantOperand . C.GlobalReference T.i64

local :: A.Name -> A.Operand
local = A.LocalReference T.i64

-- First argument: reference to the array
gep :: A.Operand -> A.Operand -> A.Instruction
gep h idx = I.GetElementPtr True h [idx] []

bitcast :: A.Type -> A.Operand -> A.Instruction
bitcast toTy value = I.BitCast value toTy []


memset :: A.Type -> A.Operand
memset ty =
  case ty of
    i64 -> A.ConstantOperand $ C.GlobalReference (ptr T.i8) (A.Name "llvm.memset.i32")
    _   -> error $ "memset function not implemented for type: " ++ show ty


ifelseTest :: A.Operand -> A.Instruction
ifelseTest cond = I.ICmp IP.NE zero cond []

int :: Integer -> A.Operand
int val = A.ConstantOperand $ C.Int 64 val

zero, one :: A.Operand
zero = int 0
one  = int 1


nop :: A.Instruction
nop = add zero zero

increment :: A.Operand -> A.Instruction
increment opnd = add opnd one
