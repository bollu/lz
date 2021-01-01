// RUN: run-optimized.sh < %s | FileCheck %s
// CHECK: Box(42)
module {
  func private @printConstructor(%x: !lz.value, %s: !ptr.char) -> ()

  func @main() -> !lz.value {
    %v = constant 42: i64
    %v_box = lz.construct(@Box, %v : i64) // : !lz.value
    %s = ptr.string "(i)"
    call @printConstructor(%v_box, %s) : (!lz.value, !ptr.char) -> ()
    return %v_box : !lz.value
  }
}

