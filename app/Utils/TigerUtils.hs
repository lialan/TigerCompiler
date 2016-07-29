module Utils.TigerUtils where

import System.Environment (getArgs)
import System.Console.Haskeline
import Control.Monad.Except

import Tiger.TigerParser
import Tiger.TigerLexer (scanTokens)
import Tiger.TigerLanguage

import Codegen.TigerCodegen
import Codegen.TigerInstruction
import Codegen.TigerEmit
import Codegen.TigerTypeChecker

import qualified LLVM.General.AST as AST
import qualified LLVM.General.Module as Mod
import qualified LLVM.General.Context as Context
process :: String -> IO ()
process line = print $ tigerParser (scanTokens line)

runFile :: IO ()
runFile = do
  args <- getArgs
  inStr <- readFile $ head args
  let parseTree = tigerParser (scanTokens inStr)
  putStrLn "Parsed tree:"
  print parseTree
  putStrLn "LLVM-General-pure print:"
  let codegenResult = lower2LLVMAST parseTree
  print (show codegenResult)
  putStrLn "LLVM-General print:"
  ppModule codegenResult

dump2File :: AST.Module -> FilePath -> IO ()
dump2File mod fn = writeFile fn (show mod)


lower2LLVMAST :: Exp -> AST.Module
lower2LLVMAST exp = executeCodegen exp

llvmAST2IR :: AST.Module -> Mod.Module
llvmAST2IR = undefined

ppModule :: AST.Module -> IO ()
ppModule ast = do
  result <- Context.withContext $ \ctx ->
    runExceptT $ Mod.withModuleFromAST ctx ast $ \m -> do
      llstr <- Mod.moduleLLVMAssembly m
      putStrLn llstr
  case result of
    Left err  -> error $ "compiling error: " ++ show err
    Right rs  -> return rs

initModule :: AST.Module
initModule = emptyModule "hello world!"

executeCodegen :: Exp -> AST.Module
executeCodegen exp = runLLVM initModule (codegenProgram exp)