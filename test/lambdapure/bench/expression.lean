set_option trace.compiler.ir.init true
inductive Expr
| Val : Nat → Expr
| Add : Expr → Expr → Expr
| Mul : Expr → Expr → Expr

open Expr


def const_fold : Expr -> Expr
| Val n => Val n
| Add (Val x) (Val y) => Val (x + y)
| Mul (Val x) (Val y) => Val (x * y)
| e => e
