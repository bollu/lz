--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize  --lz-interpret=mode=lambdapure | FileCheck --check-prefix=CHECK-INTERPRET %s

-- CHECK: func @main
-- 42 is for argv.
-- CHECK-INTERPRET: constructor(0 7 constructor(0 420 420))

set_option trace.compiler.ir.init true
unsafe def main : List String → IO UInt32
| _ => pure 7
