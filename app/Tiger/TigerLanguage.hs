module Tiger.TigerLanguage where

type Symbol = String

data Var = SimpleVar Symbol
         | FieldVar Var Symbol
         | SubscriptVar Var Exp
         deriving Show

data Exp = VarExp Var
         | NilExp
         | IntExp Integer
         | StringExp String
         | CallExp { func :: Symbol, args :: [Exp] }
         | OpExp { left :: Exp, oper :: Oper, right :: Exp }
         | RecordExp { fields :: [(Symbol, Exp)], typ :: Symbol }
         | SeqExp [Exp]
         | AssignExp { var :: Var, exp :: Exp }
         | IfExp { test :: Exp,  then' :: Exp, else' :: Maybe Exp }
         | WhileExp { test :: Exp, body :: Exp }
         | ForExp { forVar :: Symbol, escape :: Bool, lo :: Exp, hi :: Exp, body :: Exp }
         | BreakExp
         | LetExp { decs :: [Dec], body :: Exp }
         | ArrayExp { arrayType :: Symbol, arraySize :: Exp, arrayIndex :: Exp }
         deriving Show

data Dec = FunctionDec [FunDec]
         | VarDec { name :: Symbol, decEscape :: Bool, varType :: Maybe Ty, varInit :: Exp }
         | TypeDec [(Symbol, Ty)]
         deriving Show

data Ty = NameTy Symbol
        | RecordTy [Field]
        | ArrayTy Ty
           deriving Show

data Oper = PlusOp | MinusOp | TimesOp | DivideOp | AndOp | OrOp
          | EqOp | NeqOp | LtOp | LeOp | GtOp | GeOp
         deriving (Eq, Ord, Show)

data Field = Field { fieldName :: Symbol, fieldEscape :: Bool, fieldType :: Ty }
           deriving Show
data FunDec = FunDec { funDecName :: Symbol, params :: [Field], result :: Maybe Ty, funDecBody :: Exp }
           deriving Show
