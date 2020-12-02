// RUN: hask-opt %s  --lz-worker-wrapper | FileCheck %s
// CHECK:    %0 = "lz.case" 
// CHECK:    %1 = "lz.construct"(%0) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
// CHECK-NEXT: lz.return %1 : !lz.value

module {
  // case v of Foo -> SimpleInt -1; Bar -> SimpleInt 42
  // We want this to become: SimpleInt (case v of 0 -> -1; _ -> 42)
  func @main (%v: !lz.value) -> !lz.value {
      %w = lz.case @Ty %v
          [@Foo -> {
                %minusone = std.constant -1 : i64
                %boxed = lz.construct(@SimpleInt, %minusone: i64)
                lz.return %boxed : !lz.value
          }]
          [@Bar ->  {
                %fortytwo = std.constant 42 : i64
                %boxed = lz.construct(@SimpleInt, %fortytwo: i64)
                lz.return %boxed : !lz.value
          }]
      lz.return %w : !lz.value
    }
 }
