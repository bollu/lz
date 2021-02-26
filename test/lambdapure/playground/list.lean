  set_option trace.compiler.ir.init true
  inductive L
  | Nil
  | Cons : Nat -> L -> L


  open L

  def map : (Nat -> Nat) -> L -> L
  | f , Nil => Nil
  | f, Cons n l => Cons (f n) l

  def add_one (x:Nat) :Nat := x + 1
