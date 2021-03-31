--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck --check-prefix=CHECK-INTERPRET %s

-- CHECK: func @main
-- CHECK-INTERPRET: 7

set_option trace.compiler.ir.init true
def main (xs: List String) : IO Unit := IO.println (7.9)
