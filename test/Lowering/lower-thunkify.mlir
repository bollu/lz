// RUN: hask-opt %s  --lz-lower 
// RUN: hask-opt %s  --lz-lower  --ptr-lower
// Test that thunkify works.
module {
  func @main() -> !lz.thunk<i64> {
    %one = constant 1 : i64
    %boxedx = lz.thunkify(%one : i64)
    return %boxedx  : !lz.thunk<i64>
  }
}

