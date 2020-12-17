// RUN: hask-opt %s  --lz-interpret | FileCheck %s --check-prefix=CHECK-OUT
// RUN: hask-opt %s  --lz-lower-to-llvm 
// Test that case of int works.
// CHECK-OUT: constructor(Just 42)
module {
  func @main() -> !lz.value {
    %x = constant 42 : i64
    %boxedx = lz.construct(@Just, %x: i64)
    return %boxedx  : !lz.value
  }
}

