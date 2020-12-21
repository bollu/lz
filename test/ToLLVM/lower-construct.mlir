// RUN: hask-opt %s  --lz-interpret | FileCheck %s --check-prefix=CHECK-OUT
// RUN: hask-opt %s  --lz-lower-to-llvm 
// Test that case of int works.
// CHECK-OUT: constructor(Just 42)
module {
  func @main() {
    %y = constant 42 : i64
    %boxy = lz.construct(@Just, %y: i64) // check box of i64
    // %boxboxy = lz.construct(@Just, %boxy: !lz.value) // check box of box
    // return %boxboxy  : !lz.value
    // return %boxy : !lz.value
    return
  }
}

