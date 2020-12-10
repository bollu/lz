// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// CHECK: 41
// Test that case of int works.
module {
  // strict function
  func @prec (%ihash: i64) -> i64 {
    // do we know that %ihash is an int here?
    %ret = lz.caseint %ihash
             [0 -> { ^entry(%ival: i64):
               lz.return %ival : i64
             }]
             [@default -> { ^entry: // ... or here?
               %lit_one = constant 1 : i64
               %pred = subi %ihash, %lit_one : i64
               lz.return %pred : i64
             }]
    return %ret : i64
  }

  func @main() -> !lz.value {
    %lit_42 = constant 42 : i64
    %prec = constant @prec : (i64) -> i64
    %out_v = lz.ap(%prec : (i64) -> i64, %lit_42)
    %out_v_forced = lz.force(%out_v): i64
    %x = lz.construct(@X, %out_v_forced: i64)
    return %x  : !lz.value
  }
}
