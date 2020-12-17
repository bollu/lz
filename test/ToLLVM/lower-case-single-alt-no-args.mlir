// Lower a case with a single alt and no block arguments.
// RUN: hask-opt %s  --lz-interpret | FileCheck --check-prefix=CHECK-OUT %s
// RUN: hask-opt %s  --lz-lower-to-llvm 
// Test that case of int works.
// CHECK-OUT: constructor(Nothing )
module {
  func @main() -> !lz.value {
    %boxedx = lz.construct(@Nothing)
    %y = lz.case @Maybe %boxedx
          [@Nothing -> { ^entry:
            %nothing = lz.construct(@Nothing)
            lz.return %nothing : !lz.value
          }]
    lz.return %y  : !lz.value
  }
}

