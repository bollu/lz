// RUN: hask-opt %s  --lz-lower 

// Lower a case with a single alt that has a block argument
// RUN: hask-opt %s  --lz-lower 
// Test that case of int works.
module {
  func @main(%boxedx: !lz.value) -> i64 {
    %y = lz.case @Maybe %boxedx
          [@Just -> { ^entry(%jhash: i64):
            lz.return %jhash : i64
          }]
    return %y  : i64
  }
}

