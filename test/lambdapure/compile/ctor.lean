--  RUN: lean %s 2>&1 | hask-opt --lz-canonicalize | FileCheck %s
--  RUN: ./run-lean.sh %s | FileCheck %s --check-prefix=CHECK-INTERPRET

-- CHECK-INTERPRET: {{{{{{nil , nil}} , {{nil , nil}}}} , {{{{nil , nil}} , {{nil , nil}}}}}}
-- CHECK: func @mkTree

set_option trace.compiler.ir.init true
inductive Ctor
| MkCtor
open Ctor

instance : Inhabited Ctor := ⟨MkCtor⟩

def ctorToStr: Ctor -> String
| MkCtor => "ctor"


def main (xs: List String) : IO Unit := 
  IO.println (ctorToStr (MkCtor))
