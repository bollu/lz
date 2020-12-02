// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// CHECK: 41
// Test that case of int works.
module {
  // strict function
  func @prec (%ihash: !lz.value) -> !lz.value {
    // do we know that %ihash is an int here?
    %ret = lz.caseint %ihash
             [0 -> { ^entry(%ival: !lz.value):
               lz.return %ival : !lz.value
             }]
             [@default -> { ^entry: // ... or here?
               %lit_one = lz.make_i64(1)
               %pred = lz.primop_sub(%ihash, %lit_one)
               lz.return %pred : !lz.value
             }]
    return %ret : !lz.value
  }

  func @main() -> !lz.value {
    %lit_42 = lz.make_i64(42)
    %prec = constant @prec : (!lz.value) -> !lz.value
    %out_v = lz.ap(%prec : (!lz.value) -> !lz.value, %lit_42)
    %out_v_forced = lz.force(%out_v): !lz.value
    %x = lz.construct(@X, %out_v_forced:!lz.value)
    return %x  : !lz.value
  }
}
