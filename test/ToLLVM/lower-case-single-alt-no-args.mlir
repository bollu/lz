// Lower a case with a single alt and no block arguments.
// RUN: hask-opt %s  --lz-interpret | FileCheck --check-prefix=CHECK-OUT %s
// RUN: hask-opt %s  --lz-lower-to-llvm 
// Test that case of int works.
// CHECK-OUT: 10
module {
  func @main() -> i64 {
    %boxedx = lz.construct(@Nothing)
    %y = lz.case @Maybe %boxedx
          [@Nothing -> { 
            %one = constant 10 : i64
            lz.return %one : i64
          }]
    lz.return %y  : i64
  }
}

