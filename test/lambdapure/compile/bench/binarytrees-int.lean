-- Int version (as compared to UInt32) of binarytrees.lean, because the UInt32 generates weird
-- extern code like (x5 == x6)
-- RUN: ../validate-lean.sh %s

-- STATUS: can be round-tripped, DOES NOT interpret.
-- STATUS: DOES NOT interpret because it needs support for tasks.

-- CHECK: func @main

-- set_option trace.compiler.ir.init true


inductive Tree
| Nil
| Node (l r : Tree) : Tree
open Tree
instance : Inhabited Tree := ⟨Nil⟩

-- This Function has an extra argument to suppress the
-- common sub-expression elimination optimization
partial def make' : Int -> Int -> Tree
| n, d =>
  if d = 0 then Node Nil Nil
  else Node (make' n (d - 1)) (make' (n + 1) (d - 1))

-- build a tree
def make (d : Int) := make' d d

def check : Tree → Int
| Nil => 0
| Node l r   => 1 + check l + check r

def minN := 4

def out (s : String) (n : Nat) (t : Int) : IO Unit :=
IO.println (s ++ " of depth " ++ toString n ++ "\t check: " ++ toString t)

-- allocate and check lots of trees
partial def sumT : Int -> Int -> Int -> Int
| d, i, t =>
  if i = 0 then t
  else
    let a := check (make d);
    sumT d (i-1) (t + a)

-- generate many trees
partial def depth : Nat -> Nat -> List (Nat × Nat × Task Int)
| d, m => if d ≤ m then
    let n := 2 ^ (m - d + minN);
    (n, d, Task.spawn (fun _ => sumT (Int.ofNat d) (Int.ofNat n) 0)) :: depth (d+2) m
  else []

-- def main : List String → IO Int
-- | [s] => do
--   let n := s.toNat!;
--   let maxN := Nat.max (minN + 2) n;
--   let stretchN := maxN + 1;
-- 
--   -- stretch memory tree
--   let c := check (make $ Int.ofNat stretchN);
--   out "stretch tree" stretchN c;
-- 
--   -- allocate a long lived tree
--   let long := make $ Int.ofNat maxN;
-- 
--   -- allocate, walk, and deallocate many bottom-up binary trees
--   let vs := (depth minN maxN); -- `using` (parList $ evalTuple3 r0 r0 rseq)
--   vs.forM (fun (m, d, i) => out (toString m ++ "\t trees") d i.get);
-- 
--   -- confirm the the long-lived binary tree still exists
--   out "long lived tree" maxN (check long);
--   pure 0
-- | _ => pure 1

def main (xs: List String): IO Unit := do
  let n := (xs.get! 0).toNat!
  let maxN := Nat.max (minN + 2) n;
  let stretchN := maxN + 1;

  -- stretch memory tree
  let c := check (make $ Int.ofNat stretchN);
  out "stretch tree" stretchN c;

  -- allocate a long lived tree
  let long := make $ Int.ofNat maxN;

  -- allocate, walk, and deallocate many bottom-up binary trees
  let vs := (depth minN maxN); -- `using` (parList $ evalTuple3 r0 r0 rseq)
  vs.forM (fun (m, d, i) => out (toString m ++ "\t trees") d i.get);

  -- confirm the the long-lived binary tree still exists
  out "long lived tree" maxN (check long);
  -- pure 0
