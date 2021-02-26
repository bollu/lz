set_option trace.compiler.ir.init true

inductive Tree
| Nil
| Node (l r : Tree) : Tree
| Node3 (l m r : Tree) : Tree
open Tree

def cut : Tree -> Tree
| Nil => Nil
| Node l r => Node (cut l) (cut r)
| Node3 l m r => Node (cut l) (cut m)
