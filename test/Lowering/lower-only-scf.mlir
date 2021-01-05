// Check that MLIR is capable of lowering the subset of SCF we want.
// RUN: hask-opt --convert-scf-to-std %s
// RUN: hask-opt --convert-scf-to-std --convert-std-to-llvm %s
module {
  func @main() -> i64 {
    %c0 = constant 0 : i64
    %c0ix = constant 0 : index
    %c1ix = constant 1 : index
    %c1024ix = constant 1024 : index
    %0 = alloc(%c1024ix) : memref<?xi64>
    // affine.for %arg0 = 0 to 1024 {
    //   %2 = index_cast %arg0 : index to i64
    //   affine.store %2, %0[%arg0] : memref<?xi64>
    // }
    %1 = scf.for %arg0 = %c0ix to %c1024ix step %c1ix iter_args(%arg1 = %c0) -> (i64) {
      %2 = load %0[%arg0] : memref<?xi64>
      %3 = addi %arg1, %2 : i64
      scf.yield %3 : i64
    }
    return %1 : i64
  }

}
