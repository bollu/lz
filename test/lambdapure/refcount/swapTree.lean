--  RUN: lean %s 2>&1 |  hask-opt --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET

-- 2^5 - 1 since make 5
-- CHECK-INTERPRET: 31

set_option trace.compiler.ir.init true
inductive Tree
| Nil : Tree
| Node : Tree -> Tree -> Tree
| Node1 : Tree -> Tree -- do I need these?
open Tree

instance : Inhabited Tree := ⟨Nil⟩


def swap : Tree -> Tree
| Nil => Nil
| Node l r => Node (swap r) (swap l)
| Node1 s => Node1 s


partial def make : Nat -> Tree
| 0 => Nil
| n => Node  (make (n-1)) (make (n-1))

def sumTree : Tree -> Nat
| Nil => 0
| Node  l r => 1 +  (sumTree l) + (sumTree r)
| Node1 child => 1 + sumTree child

unsafe def main : List String → IO Unit
| _ => IO.println (sumTree (swap (make 5)))
