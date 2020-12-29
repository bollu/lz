// File to see memref lowering. Is kept around to check how memrefs are
// lowered to LLVM
// RUN: hask-opt %s  --convert-std-to-llvm
module {

  func @takeAndRetMemref(%x: memref<?xi64>) -> memref<?xi64> {
    return %x : memref<?xi64>
  }

  func @main ()  -> memref<?xi64> {
    %sz = constant 10 : index
    %buf = alloc(%sz) : memref<?xi64>
    return %buf : memref<?xi64>
  }
}




