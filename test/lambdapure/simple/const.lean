--  RUN: lean %s 2>&1 1>/dev/null | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s
-- CHECK: func @const
set_option trace.compiler.ir.init true
def const : Nat -> Nat
| x => x

unsafe def main : List String → IO UInt32
| _ =>  pure 0

