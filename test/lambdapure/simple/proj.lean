--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- CHECK: func @check

set_option trace.compiler.ir.init true
inductive Tree
| Nil
| Node (l r : Tree) : Tree

open Tree
def check : Tree → UInt32
| Nil => 0
| Node l r => 1 + check l + check r

