// Test lowering of ap & force.
// RUN: hask-opt %s  --lz-interpret  | FileCheck %s
// RUN: hask-opt %s --lz-lower-to-llvm
// CHECK: 1
module {
  func @f (%i : !lz.thunk<i64>, %j: !lz.thunk<i64>) -> i64 {
    %ival = lz.force(%i): i64
    %jval = lz.force(%j):i64
    return %ival : i64
  }

  func @one () -> i64 {
    %v = std.constant 1 : i64
    return %v: i64
  }


  func @main() -> i64 {
    %onef = constant @one : () -> i64
    %f = constant @f : (!lz.thunk<i64>, !lz.thunk<i64>) -> i64
    %onet = lz.ap(%onef : () -> i64)
    
    %outt = lz.ap(%f: (!lz.thunk<i64>, !lz.thunk<i64>) -> i64, %onet, %onet)
    %out = lz.force(%outt) : i64

    return %out : i64
  }
}
