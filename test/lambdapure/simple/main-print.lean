--  RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | hask-opt | FileCheck %s
--  RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | hask-opt  --lz-interpret=mode=lambdapure | FileCheck --check-prefix=CHECK-INTERPRET %s

-- CHECK: func @_lean_main
-- CHECK-INTERPRET: 7

set_option trace.compiler.ir.init true
def main (xs: List String) : IO Unit := IO.println 7
