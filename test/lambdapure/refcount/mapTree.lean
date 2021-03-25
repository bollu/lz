--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET


-- MAKE: 
--          3
--   2               2
-- 1   1        1        1

-- INCREMENT: 
--           4
--   3               3
-- 2   2        2        2


-- 4 + 3*2 + 2*4 = 4 + 6 + 8 = 18
-- CHECK-INTERPRET: 18

set_option trace.compiler.ir.init true
inductive Tree
| Nil : Tree
| Node : Nat -> Tree -> Tree -> Tree

open Tree

instance : Inhabited Tree := ⟨Nil⟩


partial def make : Nat -> Tree
| 0 => Nil
| n => Node n (make (n-1)) (make (n-1))

def mapTree : (Nat -> Nat) -> Tree -> Tree
| _, Nil => Nil
| f, Node n l r => Node (f n) (mapTree f l) (mapTree f r)

def sumTree : Tree -> Nat
| Nil => 0
| Node x l r => x + (sumTree l) + (sumTree r)

def increment : Nat -> Nat
| x => x + 1



unsafe def main : List String → IO Unit
| _ => IO.println (sumTree (mapTree increment (make 3)))
