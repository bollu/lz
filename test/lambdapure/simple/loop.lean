--  RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | hask-opt | FileCheck %s
--  RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | hask-opt  --lz-interpret=mode=lambdapure 
--  RUN: lean %s 2>&1 | lambdapure-translate --import-lambdapure | hask-opt  --lz-interpret=mode=lambdapure | FileCheck --check-prefix=CHECK-INTERPRET %s

-- CHECK: func @_lean_main
-- CHECK-INTERPRET: 5050

set_option trace.compiler.ir.init true

def mkRandomArray : Nat -> Array Nat -> Array Nat
| 0,   as => as
| i+1, as => mkRandomArray i (as.push (i+1))

-- | sumAux <length> arr[0..length-1]
def sumAux : Nat -> Array Nat -> Nat
| 0, arr => arr[0]
| ix+1, arr => arr[ix] + sumAux ix arr



def main (xs: List String) : IO Unit := 
  let len := 100; let tot := sumAux len (mkRandomArray len Array.empty); IO.println (toString tot)

