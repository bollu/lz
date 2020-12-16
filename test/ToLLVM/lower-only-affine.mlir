// Check that MLIR is capable of lowering the subset of linalg we want.
// RUN: hask-opt --lower-affine %s
module {
  func @main() -> i64 {
    %c0_i64 = constant 0 : i64
    %c1024 = constant 1024 : index
    %0 = alloc(%c1024) : memref<?xi64>
    affine.for %arg0 = 0 to 1024 {
      %2 = index_cast %arg0 : index to i64
      affine.store %2, %0[%arg0] : memref<?xi64>
    }
    %1 = affine.for %arg0 = 0 to 1024 iter_args(%arg1 = %c0_i64) -> (i64) {
      %2 = affine.load %0[%arg0] : memref<?xi64>
      %3 = addi %arg1, %2 : i64
      affine.yield %3 : i64
    }
    return %1 : i64
  }

}
