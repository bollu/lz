--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- CHECK: func @make

set_option trace.compiler.ir.init true

inductive Tree
| Nil
| Node (l r : Tree) : Tree
open Tree
instance : Inhabited Tree := ⟨Nil⟩

-- This Function has an extra argument to suppress the
-- common sub-expression elimination optimization
partial def make' : UInt32 -> UInt32 -> Tree
| n, d =>
  if d = 0 then Node Nil Nil
  else Node (make' n (d - 1)) (make' (n + 1) (d - 1))

-- build a tree
def make (d : UInt32) := make' d d
