set_option trace.compiler.ir.init true
inductive L
| Nil
| Cons : Nat -> L -> L


open L


def map : (Nat -> Nat) -> L -> L
| f , Nil => Nil
| f, Cons n l => Cons (f n) l


def makeList : Nat -> L
| n => Cons n (makeList n-1)
| 0 => Nil
