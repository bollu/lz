set_option trace.compiler.ir.init true

inductive Tree
| Nil
| Node (l r : Tree) : Tree

open Tree
instance : Inhabited Tree := ⟨Nil⟩


def swap : Tree -> Tree
| Nil =>  Nil
| Node l r => Node r l
