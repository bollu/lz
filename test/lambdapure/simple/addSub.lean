--  RUN: lean %s 2>&1 | hask-opt  --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET

-- | Check that the C code generates a subtract of x_1 with itself.
-- vvv TODO: figure out how to get this to work vvv
--  run: lean %s -c /tmp/addSub.c && FileCheck /tmp/addSub.c --check-prefix=CHECK-C
-- CHECK-C: x_1 = lean_unsigned_to_nat(10u);
-- CHECK-C: x_2 = lean_nat_sub(x_1, x_1);
-- CHECK-C: return x_2;

-- CHECK-INTERPRET: 0

set_option trace.compiler.ir.init true
def casef : Nat -> Nat
| 0 => 10
| 1 => 20
| x => x + 1

-- | This example is not so interesting because dead code elimination gets rid of the work.
def main (xs: List String) : IO Unit := do
   IO.println (10 - 10)



