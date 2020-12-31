// Check that we can partially apply a function that returns a memref.
// RUN: hask-opt --lz-lower
// RUN: hask-opt %s  --lz-lower --convert-scf-to-std --ptr-lower

module {

  func @buf(%m: memref<?xi64>) -> i64 {
    %x = constant 42 : i64
    return %x : i64
  }

  func @main () {
    %sz = constant 10 : index
    %buf = alloc(%sz) : memref<?xi64>
    %f = constant @buf : (memref<?xi64>) ->  i64
    %buft = lz.ap(%f: (memref<?xi64>) -> i64, %buf)
    // %outv = lz.force(%buft): i64
    return 
  }
}



