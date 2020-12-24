// RUN: hask-opt %s  --lz-lower-to-llvm 
// Check that references to functions and private function declarations work.
module {
  func private @fnt (%i : !lz.thunk<i64>) -> i64
  func private @fnv (%i: !lz.value) -> i64

  func @main(%i: !lz.value) -> i64 {
    %fnt = constant @fnt : (!lz.thunk<i64>) -> i64
    %fnv = constant @fnv : (!lz.value) -> i64
    return %j : i64
  }
}
