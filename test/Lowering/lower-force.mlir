// Test lowering force.
// RUN: hask-opt %s --lz-lower
// RUN: hask-opt %s  --lz-lower --convert-scf-to-std --ptr-lower

module {
  func @f (%t : !lz.thunk<!lz.value>) -> !lz.value {
    %v = lz.force(%t) : !lz.value
    return %v : !lz.value
  }

  func @g (%t : !lz.thunk<i64>) -> i64 {
    %v = lz.force(%t): i64
    return %v : i64
  }
}
