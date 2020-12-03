// TOOO: find some way to eliminate the repetition
// RUN: hask-opt %s  --lz-worker-wrapper | FileCheck %s
// CHECK:    %0 = "lz.caseint" 
// CHECK:    %1 = "lz.construct"(%0) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
// CHECK-NEXT: lz.return %1 : !lz.value

module {
  // case v of 1 -> SimpleInt 0; 0 -> SimpleInt 1; default -> SimpleInt 42
  // We want this to become: SimpleInt (case v of 0 -> -1; _ -> 42)
  func @main (%v: !lz.value) -> !lz.value {
      %w = lz.caseint %v
          [1 -> {
                %zero = std.constant 0 : i64
                %boxed = lz.construct(@SimpleInt, %zero: i64)
                lz.return %boxed : !lz.value
          }]
          [0 -> {
                %one = std.constant 1 : i64
                %boxed = lz.construct(@SimpleInt, %one: i64)
                lz.return %boxed : !lz.value
          }]
          [@default ->  {
                %fortytwo = std.constant 42 : i64
                %boxed = lz.construct(@SimpleInt, %fortytwo: i64)
                lz.return %boxed : !lz.value
          }]
      lz.return %w : !lz.value
    }
 }
