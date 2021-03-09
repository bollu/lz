--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- XXXXX: func @main
-- CHECK: module {

set_option trace.compiler.ir.init true


inductive Expr
| Var : Nat → Expr
| Val : Nat → Expr
| Add : Expr → Expr → Expr
| Mul : Expr → Expr → Expr

namespace Expr
open Nat

def constFolding : Expr → Expr
| Add e₁ e₂   =>
  let e₁ := constFolding e₁;
  let e₂ := constFolding e₂;
  (match e₁, e₂ with
   | Val a, Val b         => Val (a+b)
   | Val a, Add e (Val b) => Add (Val (a+b)) e
   | Val a, Add (Val b) e => Add (Val (a+b)) e
   | _,     _             => Add e₁ e₂)
| e         => e

end Expr
-- 
-- open Expr
-- 
-- unsafe def main : List String → IO UInt32
-- | [s] => do
--   let n := s.toNat!;
--   let e  := (mkExpr n 1);
--   let v₁ := eval e;
--   let v₂ := eval (constFolding (reassoc e));
--   IO.println (toString v₁ ++ " " ++ toString v₂);
--   pure 0
-- | _ => pure 1
