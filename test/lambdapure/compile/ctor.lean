--  RUN: ./run-lean.sh %s | FileCheck %s --prefix=CHECK-INTERPRET

-- CHECK-INTERPRET: {{{{{{nil , nil}} , {{nil , nil}}}} , {{{{nil , nil}} , {{nil , nil}}}}}}
-- CHECK: func @mkTree

set_option trace.compiler.ir.init true
inductive Tree
| Nil
| Node (l r : Tree) : Tree
open Tree

instance : Inhabited Tree := ⟨Nil⟩

def mkTree : Nat -> Tree
| 0  => Nil
| (x+1) => Node (mkTree (x)) (mkTree (x))

def treeToStr: Tree -> String
| Nil => "nil"
| Node l r => "{{" ++ (treeToStr l) ++ " , " ++ (treeToStr r) ++ "}}"


def main (xs: List String) : IO Unit := 
  IO.println (treeToStr (mkTree 3))
