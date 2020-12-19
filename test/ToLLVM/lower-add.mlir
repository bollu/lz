// RUN: hask-opt %s  --lz-interpret | FileCheck %s --check-prefix=CHECK-OUT
// RUN: hask-opt %s  --lz-lower-to-llvm 
// Test that case of int works.
// CHECK-OUT: constructor(Just 42)
module {
  func @main() -> !lz.value {
    %one = constant 1 : i64
    %x = constant 41 : i64
    %y = addi %x, %one: i64
    %boxedx = lz.construct(@Just, %y: i64)
    return %boxedx  : !lz.value
  }

  func @main2() -> i64 {
    %one = constant 1 : i64
    %x = constant 41 : i64
    %y = addi %x, %one: i64
    return %y  : i64
  }
}
