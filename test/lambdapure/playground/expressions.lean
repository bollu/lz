set_option trace.compiler.ir.init true
inductive Expr
| Val : Nat → Expr
| Add : Expr → Expr → Expr
| Mul : Expr → Expr → Expr

open Expr Nat

def evaLExpr : Expr -> Nat
| Val n => n
| Add x y => (evaLExpr x) + (evaLExpr y)
| _ => 1


def oneplustwo : Nat := evaLExpr(Add (Val 2) (Val 1))


unsafe def main : List String → IO UInt32
| _ => pure 0
