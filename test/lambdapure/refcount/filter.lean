--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET

-- CHECK: func @filter
-- we only keep elements that are not greater than 5, starting from 0.
-- So that gives us  0 <= x <= 5, which is 6 elements.
-- CHECK-INTERPRET: 6


set_option trace.compiler.ir.init true
inductive L
| Nil
| Cons : Nat -> L -> L

open L
instance : Inhabited L := ⟨Nil⟩
def filter : L -> L
| Nil => Nil
| Cons n l => if n > 5 then filter l else Cons n (filter l)

def length : L -> Nat
| Nil => 0
| Cons n l => 1 + length l


partial def make' : Nat -> Nat -> L
| n,d =>
  if d = 0 then Cons n Nil
  else Cons (n-d) (make' n (d -1))

def make (n : Nat) : L := make' n n

def main (xs: List String) : IO Unit := let l := length (filter (make 10)); IO.println (toString l)
