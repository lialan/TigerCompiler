module Utils.TigerUtils where

import System.Environment (getArgs)
import System.Console.Haskeline

import Tiger.TigerParser
import Tiger.TigerLexer (scanTokens)

import Codegen.TigerCodegen


process :: String -> IO ()
process line = print $ tigerParser (scanTokens line)

runFile :: IO ()
runFile = do
  args <- getArgs
  inStr <- readFile $ head args
  let parseTree = tigerParser (scanTokens inStr)
  print parseTree

lower2LLVM :: Exp -> String
lower2LLVM = undefined
