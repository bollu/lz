--  RUN: lean %s 2>&1 |  hask-opt --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET

-- 5 + 4 + 3 + 2 + 1 = 15
-- CHECK-INTERPRET: 15

set_option trace.compiler.ir.init true
inductive MyList
| Nil : MyList
| Cons : Nat -> MyList -> MyList
open MyList

instance : Inhabited MyList := ⟨Nil⟩

def swap: MyList -> MyList
| Nil => Nil
| Cons x1 (Cons x2 xs) => Cons x2 (Cons x1 (swap xs))
| Cons x y => Cons x y

partial def make: Nat -> MyList
| 0 => Nil
| n => Cons  n (make (n-1))

def sumList: MyList -> Nat
| Nil => 0
| Cons x xs => x + sumList xs

unsafe def main : List String → IO Unit
| _ => IO.println (sumList (swap (make 5)))
