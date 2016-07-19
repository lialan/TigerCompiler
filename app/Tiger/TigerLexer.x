{
{-# OPTIONS_GHC -w #-}
module Tiger.TigerLexer (lexer, TigerLexerToken(..), scanTokens) where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]

$graphic    = $printable # $white
@string     = \" ($graphic # \")* \"

tokens :-
  $white+         ;
  "while"         { \s -> TWhile }
  "for"           { \s -> TFor }
  "to"            { \s -> TTo }
  "break"         { \s -> TBreak }
  "let"           { \s -> TLet }
  "in"            { \s -> TIn }
  "end"           { \s -> TEnd }
  "function"      { \s -> TFunction }
  "var"           { \s -> TVar }
  "type"          { \s -> TType }
  "array"         { \s -> TArray }
  "if"            { \s -> TIf }
  "then"          { \s -> TThen }
  "else"          { \s -> TElse }
  "do"            { \s -> TDo }
  "of"            { \s -> TOf }
  "nil"           { \s -> TNil }
  $digit+         { \s -> TIntLit (read s)}
  $alpha[$alpha $digit \_ \']* { \s -> TIdent s }
  ","             { \s -> TComma }
  ":"             { \s -> TColon }
  ";"             { \s -> TSemicolon }
  "("             { \s -> TLParen }
  ")"             { \s -> TRParen }
  "["             { \s -> TLBracket }
  "]"             { \s -> TRBracket }
  "{"             { \s -> TLBrace }
  "}"             { \s -> TRBrace }
  "."             { \s -> TDot }
  "+"             { \s -> TPlus }
  "-"             { \s -> TMinus }
  "*"             { \s -> TTimes }
  "/"             { \s -> TDivide }
  "="             { \s -> TEq }
  "<>"            { \s -> TNeq }
  "<="            { \s -> TLe }
  ">="            { \s -> TGe }
  "<"             { \s -> TLt }
  ">"             { \s -> TGt }
  ":="            { \s -> TAssign }
  "&"             { \s -> TAnd }
  "|"             { \s -> TOr }
  [\n \r\n]       { \s -> TNewline }
  @string         { \s -> TStrLit s }

{

-- Token types:
data TigerLexerToken =
  TWhile          |
  TFor            |
  TTo             |
  TBreak          |
  TLet            |
  TIn             |
  TEnd            |
  TFunction       |
  TVar            |
  TType           |
  TArray          |
  TIf             |
  TThen           |
  TElse           |
  TDo             |
  TOf             |
  TNil            |
  TComma          |
  TColon          |
  TSemicolon      |
  TLParen         |
  TRParen         |
  TLBracket       |
  TRBracket       |
  TDot            |
  TLBrace         |
  TRBrace         |
  TPlus           |
  TMinus          |
  TTimes          |
  TDivide         |
  TEq             |
  TNeq            |
  TLt             |
  TLe             |
  TGt             |
  TGe             |
  TAssign         |
  TAnd            |
  TOr             |
  TNewline        |
  TStrLit String  |
  TIntLit Integer |
  TIdent String
  deriving (Eq, Show)


lexer = do
  s <- getContents
  print (alexScanTokens s)

scanTokens = alexScanTokens

}
