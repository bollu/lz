set_option trace.compiler.ir.init true
inductive Tree
| Nil
| Node (l r : Tree) : Tree


open Tree
def check : Tree → UInt32
| Nil => 0
| Node l r   => 1 + check l + check r
