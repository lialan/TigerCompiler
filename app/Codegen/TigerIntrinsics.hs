module Codegen.TigerIntrinsics where

import Codegen.TigerCodegen
import Codegen.TigerInstruction

import qualified LLVM.General.AST as A
import qualified LLVM.General.AST.Type as T
import qualified LLVM.General.AST.ParameterAttribute as PA

-- intrinsics that we should export
intrinsics = [
               createExternFuncDef T.void "llvm.memset.p0i8.i32" [A.Parameter (T.ptr(T.i8)) (A.UnName 0) [PA.NoCapture],
                                                                  A.Parameter T.i8  (A.UnName 1) [], 
                                                                  A.Parameter T.i32 (A.UnName 2) [],
                                                                  A.Parameter T.i32 (A.UnName 3) [],
                                                                  A.Parameter T.i1  (A.UnName 4) []],
               createVarExternFuncDef T.i32  "printf"            [A.Parameter (T.ptr(T.i8)) (A.UnName 0) []],
               createStringDef "str" "%d\00"
             ]
