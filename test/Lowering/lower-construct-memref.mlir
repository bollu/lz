// Check that we can store a memref in a struct
// RUN: hask-opt --lz-lower
// RUN: hask-opt %s  --lz-lower --convert-scf-to-std --ptr-lower

module {

  func @main () -> !lz.value {
    %sz = constant 10 : index
    %buf = memref.alloc(%sz) : memref<?xi64>
    %x = lz.construct(@Memref, %buf : memref<?xi64>)
    return  %x : !lz.value
  }
}




