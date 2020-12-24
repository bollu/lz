// Test lowering force.
// RUN: hask-opt %s --lz-lower-to-llvm
module {
  func @f (%i : !lz.thunk<i64>, %j : !lz.thunk<!lz.value>) -> i64 {
    %ival = lz.force(%i): i64
    %jval = lz.force(%j): !lz.value
    return %ival : i64
  }
}
