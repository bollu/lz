--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- CHECK: func @filter

set_option trace.compiler.ir.init true
inductive L
| Nil
| Cons : Nat -> L -> L

open L
instance : Inhabited L := ⟨Nil⟩
def filter : L -> L
| Nil => Nil
| Cons n l => if n > 5 then filter l else Cons n (filter l)

partial def make' : Nat -> Nat -> L
| n,d =>
  if d = 0 then Cons n Nil
  else Cons (n-d) (make' n (d -1))

def make (n : Nat) : L := make' n n

unsafe def main : List String → IO UInt32
| _ => pure 0
