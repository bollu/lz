set_option trace.compiler.ir.init true
set_option trace.compiler.lambda_pure true

inductive L
| Nil
| Cons : Nat -> L -> L

open L
def m : Nat -> L -> Nat
 | n , Nil => n
 | n, Cons x l =>  if n > x then m n l else m x l
