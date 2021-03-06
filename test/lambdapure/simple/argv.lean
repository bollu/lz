--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | hask-opt --lz-canonicalize | hask-opt  --lz-interpret="mode=lambdapure stdio=2" | FileCheck %s --check-prefix=CHECK-INTERPRET

-- CHECK: func @main
-- CHECK-INTERPRET: 2  ;  2

set_option trace.compiler.ir.init true
unsafe def main : List String → IO UInt32
| [s] => do
  IO.println (s ++ " ; " ++ s);
  pure 0
| _ => pure 1
