set_option trace.compiler.ir.init true
inductive Tree
| Nil : Tree
| Node : Nat -> Tree -> Tree -> Tree
open Tree
partial def make : Nat -> Tree
| 0 => Leaf
| n => Node n (make (n-1)) (make (n-1))

def mapTree : (Nat -> Nat) -> Tree -> Tree
| _, Nil => Nil
| f, Node n l r => Node (f n) (mapTree f l) (mapTree f r)
