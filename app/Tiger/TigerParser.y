{
module Tiger.TigerParser where
import Tiger.TigerLanguage
import Tiger.TigerLexer
}

%name tigerParser
%tokentype { TigerLexerToken }
%error { parseError }

%token
  "while"         { TWhile }
  "for"           { TFor }
  "to"            { TTo }
  "break"         { TBreak }
  "let"           { TLet }
  "in"            { TIn }
  "end"           { TEnd }
  "function"      { TFunction }
  "var"           { TVar }
  "type"          { TType }
  "array"         { TArray }
  "if"            { TIf }
  "then"          { TThen }
  "else"          { TElse }
  "do"            { TDo }
  "of"            { TOf }
  "nil"           { TNil }
  ident           { TIdent $$ }
  int_literal     { TIntLit $$ }
  string_literal  { TStrLit $$ }
  ","             { TComma }
  ":"             { TColon }
  ";"             { TSemicolon }
  "("             { TLParen }
  ")"             { TRParen }
  "["             { TLBracket }
  "]"             { TRBracket }
  "{"             { TLBrace }
  "}"             { TRBrace }
  "."             { TDot }
  "+"             { TPlus }
  "-"             { TMinus }
  "*"             { TTimes }
  "/"             { TDivide }
  "="             { TEq }
  "<>"            { TNeq }
  "<="            { TLe }
  ">="            { TGe }
  "<"             { TLt }
  ">"             { TGt }
  ":="            { TAssign }
  "&"             { TAnd }
  "|"             { TOr }

%left '+' '-'
%left '*' '/'
%%

program
 : exp                                      { $1 }

exp
 : lvalue                                   { VarExp $1 }
 | "nil"                                    { VarExp (SimpleVar "nil") }
 | "(" ")"                                  { NilExp }
 | int_literal                              { IntExp $1 }
 | string_literal                           { StringExp $1 }
 | funcall                                  { $1 }
 | arith_exp                                { $1 }
 | comp_exp                                 { $1 }
 | bool_exp                                 { $1 }
 | record_create                            { $1 }
 | array_create                             { $1 }
 | lvalue ":=" exp                          { AssignExp $1 $3 }
 | "if" exp "then" exp "else" exp           { IfExp $2 $4 (Just $6) }
 | "if" exp "then" exp                      { IfExp $2 $4 Nothing }
 | "while" exp "do" exp                     { WhileExp $2 $4 }
 | "for" ident ":=" exp "to" exp "do" exp   { ForExp $2 False $4 $6 $8 }
 | "break"                                  { BreakExp }
 | "let" decs "in" exp "end"                { LetExp $2 $4 }
 | "(" expseq ")"                           { SeqExp $2 }

funcall
  : ident "(" explist ")"                   { CallExp $1 $3 }

arith_exp
  : exp "+" exp                             { OpExp $1 PlusOp $3 }
  | exp "-" exp                             { OpExp $1 MinusOp $3 }
  | exp "*" exp                             { OpExp $1 TimesOp $3 }
  | exp "/" exp                             { OpExp $1 DivideOp $3 }

comp_exp
  : exp "="  exp                            { OpExp $1 EqOp $3 }
  | exp "<>" exp                            { OpExp $1 NeqOp $3 }
  | exp "<"  exp                            { OpExp $1 LtOp $3 }
  | exp ">"  exp                            { OpExp $1 GtOp $3 }
  | exp "<=" exp                            { OpExp $1 LeOp $3 }
  | exp ">=" exp                            { OpExp $1 GeOp $3 }

bool_exp
  : exp "&" exp                             { OpExp $1 AndOp $3 }
  | exp "|" exp                             { OpExp $1 OrOp $3 }

record_create
  : ident "(" record_create_list ")"        { RecordExp $3 $1 }

record_create_list
  : {- empty -}                             { [] }
  | record_create_field                     { [$1] }
  | record_create_list "," record_create_field
                                            { $3 : $1 }
record_create_field
  : ident "=" exp                           { ($1, $3) }

array_create
  : ident "[" exp "]" "of" exp              { ArrayExp $1 $3 $6 }

decs
  : {- empty -}                             { [] }
  | decs dec                                { $2 : $1 }

dec
  : tydeclist                               { TypeDec $1 }
  | vardec                                  { $1 }
  | fundeclist                              { FunctionDec $1 }

tydec
  : "type" ident "=" ty                     { ($2, $4) }

tydeclist
  : tydec                                   { [$1] }
  | tydeclist tydec                         { $2 : $1 }

vardec
  : "var" ident ":=" exp                    { VarDec $2 True Nothing $4 }
  | "var" ident ":" ident ":=" exp          { VarDec $2 True (Just (NameTy $4)) $6 }

fundeclist
  : {- empty -}                             { [] }
  | fundeclist fundec                       { $2 : $1 }

fundec
  : "function" ident "(" tyfields ")" "=" exp
                                            { FunDec $2 $4 Nothing $7 }
  | "function" ident "(" tyfields ")" ":" ident "=" exp
                                            { FunDec $2 $4 (Just (NameTy $7)) $9 }

ty
  : ident                                   { NameTy $1 }
  | "{" tyfields "}"                        { RecordTy $2 }
  | "array" "of" ident                      { ArrayTy (NameTy $3) }

tyfield
  : ident ":" ident                         { Field $1 True (NameTy $3) }

tyfields
  : {- empty -}                             { [] }
  | tyfield                                 { [$1] }
  | tyfields "," tyfield                    { $3 : $1 }

expseq
  : exp                                     { [$1] }
  | expseq ";" exp                          { $3 : $1 }

explist
  : {- empty -}                             { [] }
  | exp                                     { [$1] }
  | explist "," exp                         { $3 : $1 }

lvalue
 : ident                                    { SimpleVar $1 }
 | ident "(" exp ")"                        { SubscriptVar (SimpleVar $1) $3 }
 | lvalue "(" exp ")"                       { SubscriptVar $1 $3 }
 | lvalue "." ident                         { FieldVar $1 $3 }

{
parseError :: [TigerLexerToken] -> a
parseError tokenList = undefined
}
