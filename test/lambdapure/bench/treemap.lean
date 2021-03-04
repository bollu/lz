--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- CHECK: func @mapTree

set_option trace.compiler.ir.init true
inductive Tree
| Nil : Tree
| Node : Nat -> Tree -> Tree -> Tree

open Tree
partial def make : Nat -> Tree
| 0 => Leaf
| n => Node n (make (n-1)) (make (n-1))

def mapTree : (Nat -> Nat) -> Tree -> Tree
| _, Nil => Nil
| f, Node n l r => Node (f n) (mapTree f l) (mapTree f r)
