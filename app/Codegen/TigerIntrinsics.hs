module Codegen.TigerIntrnisics where

import Codegen.TigerInstruction

import qualified LLVM.General.AST as A
import qualified LLVM.General.AST.Type as T


-- intrinsics that we should export
intrinsics = [
               createExternFuncDef T.void "llvm.memset.p0i8.i32" [A.Parameter (T.ptr(T.i8)) A.UnName 0, [A.Nocapture],
                                                                  A.Parameter T.i8  A.UnName 1 [], 
                                                                  A.Parameter T.i32 A.UnName 2 [],
                                                                  A.Parameter T.i32 A.UnName 3 []]
             ]
