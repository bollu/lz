// Test lowering of function arguments
// RUN: hask-opt %s --lz-lower-to-llvm
module {
  func @f (%i : !lz.thunk<i64>, %j: !lz.value) {
    return 
  }
}
