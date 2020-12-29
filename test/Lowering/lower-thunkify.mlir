// RUN: hask-opt %s  --lz-lower 
// RUN: hask-opt %s  --lz-lower  --ptr-lower
// Test that thunkify works.
module {
  func @main() -> !lz.value {
    %one = constant 1 : i64
    %boxedx = lz.thunkify(%one : i64)
    return %boxedx  : !lz.value
  }
}

