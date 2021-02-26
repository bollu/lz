set_option trace.compiler.ir.init true
def add (x : Nat) (y : Nat ) :Nat := x + y
def sub (x : Nat) (y : Nat ) :Nat := x - y
def mul (x : Nat) (y : Nat ) :Nat := x * y
def div (x : Nat) (y : Nat ) :Nat := x / y
def lt (x : Nat) (y : Nat) : Bool := x > y
def eq (x : Nat) (y : Nat) : Bool := x == y
def le (x : Nat) (y : Nat) : Bool := x >= y
def gt (x : Nat) (y : Nat) : Bool := x < y


unsafe def main : List String → IO UInt32
| [s] => do
  let n := s.toNat;
  let e  := (mkExpr n 1);
  let v₁ := eval e;
  let v₂ := eval (constFolding (reassoc e));
  IO.println (toString v₁ ++ " " ++ toString v₂);
  pure 0
| _ => pure 1
