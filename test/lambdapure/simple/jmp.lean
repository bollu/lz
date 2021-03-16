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

-- def Expr.eval (arg : obj) : obj :=
-- | case arg : obj of
-- | Expr.Add → // arg = Add ...
-- |   let l : obj := proj[0] arg;
-- |   let r : obj := proj[1] arg;
-- |   JUMPBB (### : obj) :=  // CHECKS FOR (ADD ? VAL)
-- |   | case r : obj of Add ? ?
-- |   | Expr.Add → Add ? (Add ? ?)
-- |   | | let cl1 : obj := Expr.eval._closed_1; // 2
-- |   | | ret cl1
-- |   | Expr.Foo → // Add ? Foo
-- |   | | let cl1 : obj := Expr.eval._closed_1; // 2
-- |   | | ret cl1
-- |   | Expr.Val → // Add ? Val
-- |   | | let cl2 : obj := Expr.eval._closed_2; // 0
-- |   | | ret cl2;
-- |   case l : obj of  Add l ?
-- |   Expr.Add → // Add (Add ? ?)
-- |   | let x_5 : obj := ctor_0[PUnit.unit];
-- |   | jmp JUMPBB x_5 // Add (Add ? ?) => JUMP
-- |   Expr.Foo → // Add Foo ?
-- |   | let x_6 : obj := ctor_0[PUnit.unit];
-- |   | jmp JUMPBB x_6  // Add Foo ? => JUMP
-- |   Expr.Val → // Add Val ?
-- |   | case r : obj of
-- |   | Expr.Add → // Add Val (Add ? ?)
-- |   | | let cl3 : obj := Expr.eval._closed_3; // 1
-- |   | | ret cl3
-- |   | Expr.Foo → // Add Val Foo
-- |   | | let cl3 : obj := Expr.eval._closed_3; // 1
-- |   | | ret cl3
-- |   | Expr.Val → // Add Val Val
-- |   | | let cl2 : obj := Expr.eval._closed_2; // 0
-- |   | | ret cl2
-- | Expr.Foo → // Foo 
-- | | let cl1 : obj := Expr.eval._closed_1; // 2
-- | | ret cl1
-- | Expr.Val → // Val 
-- | | let cl1 : obj := Expr.eval._closed_1; // 2
-- | | ret cl1



def eval : Expr -> Expr
 | Add e (Val b) => Val 0
 | Add (Val b) e => Val 1
 |  x            => Val 2


def toNat : Expr -> Nat
 | Add l r => (toNat l) + (toNat r)
 | _ => 1
 	

unsafe def main (xs: List String) : IO Unit := 
  IO.println (toString (toNat (eval (Add (Val 1) (Val 2)))))

