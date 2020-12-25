// RUN: hask-opt %s  --lz-lower 
// Test that case of int works.
// CHECK-OUT: constructor(Just 42)
module {
  func @main() {
    %y = constant 42 : i64
    %boxy = lz.construct(@Just, %y: i64) 
    return
  }
}

