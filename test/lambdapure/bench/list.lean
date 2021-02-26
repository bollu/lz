inductive L
| Nil
| Cons : Nat -> L -> L


open L

instance : Inhabited L := ⟨Nil⟩

def map : (Nat -> Nat) -> L -> L
| f, Nil => Nil
| f, Cons n l => Cons (f n) (map f l)


def add_one (x:Nat) := x + 1

def map_with_one : (Nat -> Nat -> Nat) -> L -> L
| f,Nil => Nil
| f,Cons n l => map (f 1) (Cons n l)

partial def make' : Nat -> Nat -> L
| n,d =>
  if d = 0 then Cons n Nil
  else Cons (n-d) (make' n (d -1))

def make (n : Nat) : L := make' n n

def foo : Nat -> Nat  ×  Nat
| x => (x, x)


def sum : L -> Nat
| Cons x l => x + (sum l)
| Nil =>  0


unsafe def main : List String → IO UInt32
| _ => pure 0
