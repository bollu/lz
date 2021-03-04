--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- CHECK: module {

set_option trace.compiler.ir.init true

inductive Tree
| Nil
| Node (l r : Tree) : Tree
| Node3 (l m r : Tree) : Tree
open Tree

def cut : Tree -> Tree
| Nil => Nil
| Node l r => Node (cut l) (cut r)
| Node3 l m r => Node (cut l) (cut m)
