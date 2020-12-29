// Check that we can partially apply a function that returns a memref.
// RUN: hask-opt --lz-lower
// RUN: hask-opt %s  --lz-lower --convert-scf-to-std --ptr-lower

module {

  func @buf() ->  memref<?xi64> {
    %sz = constant 10 : index
    %buf = alloc(%sz) : memref<?xi64>
    return %buf : memref<?xi64>
  }

  func @main () {
    %f = constant @buf : () ->  memref<?xi64>
    %buft = lz.ap(%f: () -> memref<?xi64>)
    %outv = lz.force(%buft): memref<?xi64>
    return 
  }
}



