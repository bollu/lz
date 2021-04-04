--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: ./run-lean.sh %s | FileCheck %s --check-prefix=CHECK-INTERPRET

-- CHECK-INTERPRET: {{{{{{nil , nil}} , {{nil , nil}}}} , {{{{nil , nil}} , {{nil , nil}}}}}}
-- CHECK: func @mkTree

set_option trace.compiler.ir.init true
inductive Tree
| Nil
| Node (l r : Tree) : Tree
open Tree

instance : Inhabited Tree := ⟨Nil⟩

-- def mkTree : Nat -> Tree
-- | 0  => Nil
-- | (x+1) => Node (mkTree (x)) (mkTree (x))
-- 
def treeToStr: Tree -> String
| Nil => "nil"
| Node l r =>  "node" -- "{{" ++ (treeToStr l) ++ " , " ++ (treeToStr r) ++ "}}"


def main (xs: List String) : IO Unit := 
  IO.println (treeToStr (Nil))
  -- IO.println (treeToStr (mkTree 3))
