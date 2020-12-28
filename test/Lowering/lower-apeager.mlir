// Test lowering of apEager
// RUN: hask-opt %s  --lz-interpret  | FileCheck %s
// RUN: hask-opt %s --lz-lower
// RUN: hask-opt %s --lz-lower --ptr-lower
// CHECK: 1
module {
  func @f (%i : i64, %j: i64) -> i64 {
    return %i: i64
  }

  func @main() -> i64 {
    %v = std.constant 1 : i64
    %w = std.constant 2 : i64
    %f = constant @f : (i64, i64) -> i64
    %out = lz.apEager(%f: (i64, i64) -> i64, %v, %w)
    return %out : i64
  }
}
