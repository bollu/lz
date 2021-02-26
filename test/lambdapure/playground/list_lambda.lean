set_option trace.compiler.ir.init true


inductive L
| Nil
| Cons : Nat -> L -> L


open L
def map : (Nat -> Nat) -> L -> L
| f, Nil => Nil
| f, Cons n l => Cons (f n) (map f l)



inductive Tree
| Nil
| Node_2 (l r : Tree) : Tree
| Node_3 (l m r : Tree) : Tree

open Tree

def t : Tree -> Tree
| Nil => Nil
| Node_3 l m r => Node_2 (t l) (t m)
| Node_2 l r => Node_2 (t l) (t r)
