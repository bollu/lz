--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | hask-opt  --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET

-- CHECK-INTERPRET: 42
-- CHECK: func @f

def fib : Nat → Nat
  | 0   => 0
  | 1   => 1
  | x+2 => fib (x+1) + fib x

def f (c : Bool) (x : Thunk Nat) : Nat :=
  if c then
    x.get
  else
    42


def main (xs: List String) : IO Unit := do
   IO.println (f False (fib 1000))
