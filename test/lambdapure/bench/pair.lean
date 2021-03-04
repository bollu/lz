--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- CHECK: func @fold
set_option trace.compiler.ir.init true
inductive L
| Nil
| Cons1 : Nat -> L -> L
| Cons2 : Nat -> Nat -> L -> L

open L

def fold : L -> L
| Nil => Nil
| Cons1 n l => Cons1 n (fold l)
| Cons2 x y l => Cons1 (x + y) (fold l)
