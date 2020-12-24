// RUN: hask-opt %s  --lz-lower-to-llvm 
// CHECK: func private @fnt(!ptr.void) -> i64
// CHECK: func private @fnv(!ptr.void) -> i64

// Check that private function declarations work.
module {
  func private @fnt (%i : !lz.thunk<i64>) -> i64
  func private @fnv (%i: !lz.value) -> i64
}
