--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- CHECK: func @const_fold

set_option trace.compiler.ir.init true
inductive Expr
| Val : Nat → Expr
| Add : Expr → Expr → Expr
| Mul : Expr → Expr → Expr

open Expr

def const_fold : Expr -> Expr
| Val n => Val n
| Add (Val x) (Val y) => Val (x + y)
| Mul (Val x) (Val y) => Val (x * y)
| e => e
