module Codegen.TigerInstruction where

import Tiger.TigerLanguage
import Codegen.TigerCodegen

import LLVM.General.AST as A
import LLVM.General.AST.Type as T
import LLVM.General.AST.Global as G
import LLVM.General.AST.Instruction as I
import LLVM.General.AST.IntegerPredicate as IP
import LLVM.General.AST.Constant as C
import LLVM.General.AST.CallingConvention as CC



-- arithmatic instructions
add, sub, mul :: A.Operand -> A.Operand -> Codegen A.Operand
add a b = instr $ A.Add True True a b []
sub a b = instr $ A.Sub True True a b []
mul a b = instr $ A.Mul True True a b []

-- comparisons:
lt, gt, le, ge, eq, ne :: A.Operand -> A.Operand -> Codegen A.Operand
lt l r = instr $ I.ICmp IP.SLT l r []
gt l r = instr $ I.ICmp IP.SGT l r []
le l r = instr $ I.ICmp IP.SLE l r []
ge l r = instr $ I.ICmp IP.SGE l r []
ne l r = instr $ I.ICmp IP.NE  l r []
eq l r = instr $ I.ICmp IP.EQ  l r []

-- bitwise:
and_, or_ :: A.Operand -> A.Operand -> Codegen A.Operand
and_ l r = instr $ A.And l r []
or_  l r = instr $ A.Or  l r []


-- branch instructions
br :: A.Name -> Codegen (A.Named A.Terminator)
br val = terminator $ I.Do $ I.Br val []

cbr :: A.Operand -> A.Name -> A.Name -> Codegen (A.Named A.Terminator)
cbr cond tr fl = terminator $ I.Do $ I.CondBr cond tr fl []

ret :: A.Operand -> Codegen (A.Named A.Terminator)
ret val = terminator $ I.Do $ I.Ret (Just val) []


-- effect instructions
call :: A.Operand -> [A.Operand] -> Codegen A.Operand
call fn args = instr $ I.Call Nothing CC.C [] (Right fn) (toArgs args) [] []
    where toArgs = map (\x -> (x , []))

alloca :: A.Type -> Codegen A.Operand
alloca ty = instr $ I.Alloca ty Nothing 0 []

store :: A.Operand -> A.Operand -> Codegen A.Operand
store ptr val = instr $ I.Store False ptr val Nothing 0 []

load :: A.Operand -> Codegen A.Operand
load ptr = instr $ I.Load False ptr Nothing 0 []

-- function references
externFunc :: A.Name -> A.Operand
externFunc = A.ConstantOperand . C.GlobalReference T.i64

local :: A.Name -> A.Operand
local = A.LocalReference T.i64