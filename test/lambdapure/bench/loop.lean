set_option trace.compiler.ir.init true

def sum (xs : Array Nat) : Nat := do
  let mut s := 0
  for x in xs do
    s := s + x
  return s

