-- RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | hask-opt --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET 
-- RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | hask-opt --lz-lambdapure-reference-rewriter |  hask-opt --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET 
-- RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | hask-opt --lz-lambdapure-reference-rewriter --lz-lambdapure-destructive-updates |  hask-opt --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET 

-- sum of first 10 numbers
-- CHECK-INTERPRET: 55

set_option trace.compiler.ir.init true
inductive L
| Nil
| Cons : Nat -> L -> L

open L

instance : Inhabited L := ⟨Nil⟩

def make (n : Nat) : L := make' n n

def sum : L -> Nat
| Cons x l => x + (sum l)
| Nil =>  0


unsafe def main : List String → IO Unit
| _ => IO.println (sum (make 10))
