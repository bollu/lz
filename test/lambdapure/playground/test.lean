set_option trace.compiler.ir.init true
def higherorder(f:Nat -> Nat ->Nat) (x:Nat) (y:Nat) : Nat:= f x x
