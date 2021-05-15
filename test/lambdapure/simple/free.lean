--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck --check-prefix=CHECK-INTERPRET %s

-- CHECK: func @sumAux

-- | universes dislike this code. So use the Agda encoding:
-- http://casperbp.net/posts/2019-04-nondeterminism-using-a-free-monad/


set_option trace.compiler.ir.init true
-- | TODO: make this a free monad
inductive Vec : Type 
| VecNum (l: Nat) (i: Nat): Vec
| VecAdd (v: Vec) (w: Vec) : Vec
| VecSum (v: Vec): Vec
open Vec

def runVec : Vec -> IO Unit
| v => pure ()

def main (xs: List String) : IO Unit := do
  let v := VecNum 10 42
  runVec (VecSum (VecAdd v v))
