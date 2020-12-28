// RUN: hask-opt %s  --lz-interpret | FileCheck %s --check-prefix=CHECK-OUT
// RUN: hask-opt %s  --lz-lower 
// RUN: hask-opt %s  --lz-lower --convert-scf-to-std --ptr-lower
// Test that case of int works.
// CHECK-OUT: constructor(Just 42)
module {
  func @main() -> !lz.value {
    %y = constant 42 : i64
    %boxy = lz.construct(@Just, %y: i64) // check box of i64
    return  %boxy : !lz.value
  }
}

