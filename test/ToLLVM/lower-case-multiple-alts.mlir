// RUN: hask-opt %s  --lz-lower-to-llvm 
// Test that case of int works.
module {
  func @main(%boxedx : !lz.value) -> !lz.value {
    %y = lz.case @Maybe %boxedx
          [@Nothing -> { ^entry:
            %nothing = lz.construct(@Nothing)
            lz.return %nothing : !lz.value
          }]
          [@Just -> { ^entry(%jhash: i64):
            %one_inner = constant 1: i64
            %jhash_incr =  addi %jhash, %one_inner: i64
            %boxed_jash_incr = lz.construct(@Just, %jhash_incr: i64)
            lz.return %boxed_jash_incr : !lz.value
          }]
    return %y  : !lz.value
  }
}

