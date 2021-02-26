set_option trace.compiler.ir.init true

inductive N 
 | Z : N
 | S : Nat -> N -> N


def map : (Nat -> Nat) -> N -> N
| _, N.Z => N.Z
| f, N.S x xs => N.S (f x) (map f xs)
