set_option trace.compiler.ir.init true
inductive L
| Nil
| Cons : Nat -> L -> L

open L
instance : Inhabited L := ⟨Nil⟩

def addElement (n:Nat) (l:L) : L := Cons n l

mkList () := Cons 1 Nil

def sort :  List -> Nat
| Nil => n
| Cons x (Cons y l) => if x > y then  Cons y (Cons x (sort l)) else  Cons x (Cons y (sort l))
