// RUN: hask-opt %s  --lz-lower 

// Check that private function declarations work.
module {
  func private @fnt (%i : !lz.thunk<i64>) -> i64
  func @main() {
    %f = constant @fnt : (!lz.thunk<i64>) -> i64
    return
  }
}
