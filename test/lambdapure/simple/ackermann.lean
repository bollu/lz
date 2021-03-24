--  RUN: lean %s 2>&1 | hask-opt | FileCheck %s
--  RUN: lean %s 2>&1 | hask-opt  --lz-canonicalize --lz-lazify --lz-wrapper-worker --lz-interpret=mode=lambdapure | FileCheck --check-prefix=CHECK-INTERPRET %s

-- CHECK: func @main
-- CHECK-INTERPRET: 42

set_option trace.compiler.ir.init true

-- | I'm not sure why lean4 does not understand that this is decidable.
-- | They too define it as "partial def" in the file
-- | lean4/tests/lean/run/trace.lean


partial def ackermann : Nat -> Nat -> Nat
| 0, n => n + 1
| m+1, 0 => ackermann m 1
| m+1, n+1 => ackermann m  (ackermann (m+1) n)


-- | K combinator
def k: a -> b -> a
| x, y => x

-- | S combinator
def s : (c -> a -> b) -> (c -> a) -> (c -> b)
| f, g, x => f x (g x)


-- | this evaluates to the K combinator. 
def foo : Nat -> Nat -> Nat -> Nat
| x, y, z => if z == 0 then x else y

-- | This example is not so interesting because dead code elimination gets rid of the work.
def main (xs: List String) : IO Unit :=
   let x := ackermann 4 1; 
   IO.println (foo 42 x 0)


