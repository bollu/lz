--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize --lz-interpret=mode=lambdapure | FileCheck --check-prefix=CHECK-INTERPRET %s
-- A variant of main-print-ret that prints a little more, and uses more variables.
-- I want to understand how codegen is affected by other declarations, hence this version.


def seven : Float := 7.0
def eight : Float := 8.0

def print_eight : IO Unit := do
  IO.print "("
  IO.print eight
  IO.print ")"



-- 120 for return value, 42 for argv, 0 for success constructor tag.
-- CHECK: func @main
-- CHECK-INTERPRET: 7
-- CHECK-INTERPRET: constructor(0 120 420)

set_option trace.compiler.ir.init true
def main (xs: List String) : IO UInt32 := do
  IO.println seven
  print_eight
  pure 120


