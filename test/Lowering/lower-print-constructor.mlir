// RUN: hask-opt %s --lz-lower --convert-scf-to-std --ptr-lower
// RUN: hask-opt %s --lz-lower --convert-scf-to-std --ptr-lower | mlir-translate --mlir-to-llvmir
// RUN: hask-opt %s --lz-worker-wrapper --lz-lower --convert-scf-to-std --ptr-lower
// RUN: hask-opt %s --lz-worker-wrapper --lz-lower --convert-scf-to-std --ptr-lower | mlir-translate --mlir-to-llvmir
module {
  func private @printConstructor(%x: !lz.value, %s: !ptr.char) -> ()

  // 37 + 5 = 42
  func @main() -> !lz.value {
    %v = constant 37: i64
    %v_box = lz.construct(@Box, %v : i64) // : !lz.value
    %s = ptr.string "(i)"
    call @printConstructor(%v_box, %s) : (!lz.value, !ptr.char) -> ()
    // return %out_v : !lz.value
    return %v_box : !lz.value
  }
}

