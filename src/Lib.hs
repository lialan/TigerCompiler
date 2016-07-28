module Lib where

import qualified LLVM.General.AST as AST
import LLVM.General.Module

stringAsASTModule :: BS.ByteString -> AST.Module
stringAsASTModule = read

ast2module :: AST.Module -> IO Module
ast2module mod = withContext $ \context -> liftError $ withModuleFromAST context mod


