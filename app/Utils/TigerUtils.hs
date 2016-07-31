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

import LLVM.General.PassManager
import LLVM.General.Transforms
import LLVM.General.Analysis

import qualified LLVM.General.Module as Mod
import qualified LLVM.General.Context as Context
import qualified LLVM.General.ExecutionEngine as EE
import Foreign.Ptr (FunPtr, castFunPtr)

-- native function call
foreign import ccall "dynamic" haskFun :: FunPtr (IO Double) -> (IO Double)

run :: FunPtr a -> IO Double
run fn = haskFun (castFunPtr fn :: FunPtr (IO Double))

passes :: PassSetSpec
passes = defaultCuratedPassSetSpec { optLevel = Just 3 }


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

jit :: Context.Context -> (EE.MCJIT -> IO a) -> IO a
jit c = EE.withMCJIT c optlevel model ptrelim fastins
  where
    optlevel = Just 2  -- optimization level
    model    = Nothing -- code model ( Default )
    ptrelim  = Nothing -- frame pointer elimination
    fastins  = Nothing -- fast instruction selection

runJIT :: AST.Module -> IO (Either String AST.Module)
runJIT mod = do
  Context.withContext $ \context ->
    jit context $ \executionEngine ->
      runExceptT $ Mod.withModuleFromAST context mod $ \m ->
        withPassManager passes $ \pm -> do
          -- Optimization Pass
          {-runPassManager pm m-}
          optmod <- Mod.moduleAST m
          s <- Mod.moduleLLVMAssembly m
          putStrLn s

          EE.withModuleInEngine executionEngine m $ \ee -> do
            mainfn <- EE.getFunction ee (AST.Name "main")
            case mainfn of
              Just fn -> do
                res <- run fn
                putStrLn $ "Evaluated to: " ++ show res
              Nothing -> return ()

          -- Return the optimized module
          return optmod



initModule :: AST.Module
initModule = emptyModule "hello world!"

executeCodegen :: Exp -> AST.Module
executeCodegen exp = runLLVM initModule (codegenProgram exp)

process :: String -> IO ()
process line = print $ tigerParser (scanTokens line)
