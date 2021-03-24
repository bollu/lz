--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck --check-prefix=CHECK-INTERPRET %s

-- CHECK: func @main
-- CHECK-INTERPRET: 7
-- Final result is 42-7 = 35
-- CHECK-INTERPRET: constructor(0 35 420)

set_option trace.compiler.ir.init true
def main (xs: List String) : IO UInt32 := let l := 7; let m := 42; IO.println (toString l) *> pure (m - l)
