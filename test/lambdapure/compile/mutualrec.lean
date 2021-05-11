--  RUN: ./run-lean.sh %s | FileCheck %s --check-prefix=CHECK-INTERPRET

--  run: lean %s 2>&1 1>/dev/null | hask-opt  --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck %s --check-prefix=CHECK-INTERPRET

-- CHECK-INTERPRET: 1
-- CHECK-INTERPRET: 0
-- CHECK-INTERPRET: 1
-- CHECK-INTERPRET: 0


// TODO: why is a join point created?
// func @l_even(%arg0: !lz.value) -> !lz.value {
//   %0 = call @l_odd(%arg0) : (!lz.value) -> !lz.value
//   lz.return %0 : !lz.value
// }
// func @l_odd(%arg0: !lz.value) -> !lz.value {
//   %0 = call @l_even(%arg0) : (!lz.value) -> !lz.value
//   lz.return %0 : !lz.value
// }

set_option trace.compiler.ir.init true

mutual 
  partial def even (a : Nat) : Nat := odd a
  partial def odd (a : Nat) : Nat := even a
end

-- | This example is not so interesting because dead code elimination gets rid of the work.
def main (xs: List String) : IO Unit := do
   IO.println (even 0)
   IO.println (even 1)
   IO.println (even 2)
   IO.println (even 3)


