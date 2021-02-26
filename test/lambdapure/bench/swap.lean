set_option trace.compiler.ir.init true
inductive Tree
| Nil : Tree
| Node : Tree -> Tree -> Tree
| Node1 : Tree -> Tree
open Tree


def swap : Tree -> Tree
| Nil => Nil
| Node l r => Node (swap r) (swap l)
| Node1 s => Node1 s

def cut : Tree -> Tree
| Nil => Nil
| Node l r => Node1 (cut l)
| Node1 s => Node1 s
