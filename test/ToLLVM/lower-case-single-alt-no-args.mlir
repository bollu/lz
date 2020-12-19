// Lower a case with a single alt and no block arguments.
// RUN: hask-opt %s  --lz-interpret | FileCheck --check-prefix=CHECK-OUT %s
// RUN: hask-opt %s  --lz-lower-to-llvm 
// Test that case of int works.
// CHECK-OUT: 10
module {
  func @main() {
    %boxedx = lz.construct(@Nothing)
    %y = lz.case @Maybe %boxedx
          [@Nothing -> { 
            %one = constant 10 : i32
            lz.return %one : i32 // to only be used inside a case.
          }]
    return
  }
}

