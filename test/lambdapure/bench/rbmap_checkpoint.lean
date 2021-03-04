--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- CHECK: func @main

/-
Copyright (c) 2017 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Leonardo de Moura
-/
prelude
import Init.Data.Option.Basic
import Init.Data.List.BasicAux
import Init.Data.String
import Init.System.IO

universes u v w w'

inductive color
| Red | Black

inductive Tree
| Leaf  {}                                                                       : Tree
| Node  (color : color) (lchild : Tree) (key : Nat) (val : Bool) (rchild : Tree) : Tree

instance : Inhabited Tree := ⟨Tree.Leaf⟩

variable {σ : Type w}
open color Nat Tree

def fold (f : Nat → Bool → σ → σ) : Tree → σ → σ
| Leaf, b               => b
| Node _ l k v r,     b => fold f r (f k v (fold f l b))

@[inline]
def balance1 : Nat → Bool → Tree → Tree → Tree
| kv, vv, t, Node _ (Node Red l kx vx r₁) ky vy r₂   => Node Red (Node Black l kx vx r₁) ky vy (Node Black r₂ kv vv t)
| kv, vv, t, Node _ l₁ ky vy (Node Red l₂ kx vx r)   => Node Red (Node Black l₁ ky vy l₂) kx vx (Node Black r kv vv t)
| kv, vv, t, Node _ l  ky vy r                       => Node Black (Node Red l ky vy r) kv vv t
| _,  _,  _,                                       _ => Leaf

@[inline]
def balance2 : Tree → Nat → Bool → Tree → Tree
| t, kv, vv, Node _ (Node Red l kx₁ vx₁ r₁) ky vy r₂    => Node Red (Node Black t kv vv l) kx₁ vx₁ (Node Black r₁ ky vy r₂)
| t, kv, vv, Node _ l₁ ky vy (Node Red l₂ kx₂ vx₂ r₂)   => Node Red (Node Black t kv vv l₁) ky vy (Node Black l₂ kx₂ vx₂ r₂)
| t, kv, vv, Node _ l ky vy r                           => Node Black t kv vv (Node Red l ky vy r)
| _, _, _,                                         _    => Leaf

def isRed : Tree → Bool
| Node Red _ _ _ _   => true
| _                  => false

def ins : Tree → Nat → Bool → Tree
| Leaf,                 kx, vx => Node Red Leaf kx vx Leaf
| Node Red a ky vy b,   kx, vx =>
   (if kx < ky then Node Red (ins a kx vx) ky vy b
    else if kx = ky then Node Red a kx vx b
    else Node Red a ky vy (ins b kx vx))
| Node Black a ky vy b,   kx, vx =>
    if kx < ky then
      (if isRed a then balance1 ky vy b (ins a kx vx)
       else Node Black (ins a kx vx) ky vy b)
    else if kx = ky then Node Black a kx vx b
    else if isRed b then balance2 a ky vy (ins b kx vx)
         else Node Black a ky vy (ins b kx vx)

def setBlack : Tree → Tree
| Node _ l k v r   => Node Black l k v r
| e                => e

def insert (t : Tree) (k : Nat) (v : Bool) : Tree :=
if isRed t then setBlack (ins t k v)
else ins t k v

def mkMapAux (freq : Nat) : Nat → Tree → List Tree → List Tree
| 0,     m, r => m::r
| n+1,   m, r =>
  let m := insert m n (n % 10 = 0);
  let r := if n % freq == 0 then m::r else r;
  mkMapAux freq n m r

def mkMap (n : Nat) (freq : Nat) : List Tree :=
mkMapAux freq n Leaf []

def myLen : List Tree → Nat → Nat
| Node _ _ _ _ _ :: xs,   r => myLen xs (r + 1)
| _ :: xs,   r => myLen xs r
| [], r => r

def main (xs : List String) : IO UInt32 := do
let [n, freq] ← pure xs | throw $ IO.userError "invalid input";
let n     := n.toNat!;
let freq  := freq.toNat!;
let freq  := if freq == 0 then 1 else freq;
let mList := mkMap n freq;
let v     := fold (fun (k : Nat) (v : Bool) (r : Nat) => if v then r + 1 else r) mList.head! 0;
IO.println (toString (myLen mList 0) ++ " " ++ toString v) *>
pure 0
