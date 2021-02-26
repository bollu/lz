set_option trace.compiler.ir.init true
inductive L
| Nil
| Cons1 : Nat -> L -> L
| Cons2 : Nat -> Nat -> L -> L


open L

def fold : L -> L
| Nil => Nil
| Cons1 n l => Cons1 n (fold l)
| Cons2 x y l => Cons1 (x + y) (fold l)
