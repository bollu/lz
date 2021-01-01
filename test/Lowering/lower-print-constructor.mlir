// RUN: run-optimized.sh < %s
// CHECK: Box(42)
module {
  func private @printConstructor(%x: !lz.value, %s: !ptr.char) -> ()

  func @main() -> i64 {
    %v = constant 42: i64
    %v_box = lz.construct(@Box, %v : i64) // : !lz.value
    %s = ptr.string "(i)"
    call @printConstructor(%v_box, %s) : (!lz.value, !ptr.char) -> ()
    %zero = constant 0 : i64
    return %zero : i64 
  }
}

