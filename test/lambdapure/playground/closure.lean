set_option trace.compiler.ir.init true

def bar : Nat ->  Nat -> Nat -> Nat
| x,y,z => if x > y + z then 0 else 1


def foo (n : Nat) : (Nat -> Nat -> Nat) := bar n
