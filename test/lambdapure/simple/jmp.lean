-- Testcase to check a join point / jump instruction
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-interpret="mode=lambdapure stdio=1" | FileCheck %s --check-prefix=CHECK-INTERPRET-1
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-interpret="mode=lambdapure stdio=2" | FileCheck %s --check-prefix=CHECK-INTERPRET-2

-- CHECK: func @main

set_option trace.compiler.ir.init true


inductive Expr
| Add : Expr -> Expr -> Expr
| Foo : Nat -> Expr
| Val : Nat -> Expr

namespace Expr
open Nat

def eval2 : Expr -> Expr
 | Add e (Val b) => Add (Val b) e
 | Add (Val b) e => Add (Val b) e
 |  x             => x


def toNat : Expr -> Nat
 | Add l r => (toNat l) + (toNat r)
 | Val n => n
 | Foo _  => 42
 	

unsafe def main (xs: List String) : IO Unit := 
  IO.println (toString 1) -- (toNat (eval (Val 1) (Val 2))))

