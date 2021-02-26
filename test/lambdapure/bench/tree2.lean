


inductive Tree
| Nil
| Node (l r : Tree) : Tree
open Tree
instance : Inhabited Tree := ⟨Nil⟩

-- This Function has an extra argument to suppress the
-- common sub-expression elimination optimization
partial def make' : UInt32 -> UInt32 -> Tree
| n, d =>
  if d = 0 then Node Nil Nil
  else Node (make' n (d - 1)) (make' (n + 1) (d - 1))

-- build a tree
def make (d : UInt32) := make' d d
