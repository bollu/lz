--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

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
