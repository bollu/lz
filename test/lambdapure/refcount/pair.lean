set_option trace.compiler.ir.init true
inductive L
| Nil
| Cons1 : Nat -> L -> L
| Cons2 : Nat -> Nat -> L -> L

open L

instance : Inhabited L := ⟨Nil⟩

def fold : L -> L
| Nil => Nil
| Cons1 n l => Cons1 n (fold l)
| Cons2 x y l => Cons1 (x + y) (fold l)

partial def make' : Nat -> Nat -> L
| n,d =>
  if d = 0 then Cons2 n n Nil
  else Cons2 (n-d)  (n-d) (make' n (d -1))


def make : Nat -> L
| n => make' n n

def sum: L -> Nat
| Nil => 0
| Cons1 x xs => x + sum xs
| Cons2 x y xs => x + y + sum xs


def main (xs: List String) : IO Unit := let l := sum (fold (make 10)); IO.println (toString l)
