--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck --check-prefix=CHECK-INTERPRET %s

-- 120 for return value, 42 for argv, 0 for success constructor tag.
-- CHECK: func @main
-- CHECK-INTERPRET: 7
-- CHECK-INTERPRET: constructor(0 120 420)

set_option trace.compiler.ir.init true
def main (xs: List String) : IO UInt32 := IO.println 7 *> pure 120

