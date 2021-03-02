set_option trace.compiler.ir.init true
inductive Tree
| Nil
| Node (l r : Tree) : Tree
open Tree

def mkTree : Nat -> Tree
| 0  => Nil
| x => Node Nil Nil
