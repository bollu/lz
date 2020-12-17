// RUN: hask-opt %s  --lz-interpret | FileCheck --check-prefix=CHECK-OUT %s
// RUN: hask-opt %s  --lz-lower-to-llvm 
// CHECK-OUT: constructor(Just 43)

// Lower a case with a single alt that has a block argument
// RUN: hask-opt %s  --lz-lower-to-llvm 
// Test that case of int works.
module {
  func @main() -> !lz.value {
    %x = constant 42 : i64
    %boxedx = lz.construct(@Just, %x: i64)
    %y = lz.case @Maybe %boxedx
          [@Just -> { ^entry(%jhash: i64):
            // %one_inner = constant 1: i64
            // %jhash_incr =  addi %jhash, %one_inner: i64
            // %boxed_jash_incr = lz.construct(@Just, %jhash_incr: i64)
            %boxednew = lz.construct(@Just, %jhash : i64)
            lz.return %boxednew : !lz.value
          }]
    lz.return %y  : !lz.value
  }
}

