// RUN: ../build/bin/hask-opt --lz-worker-wrapper --lz-interpret %s
module {

  func @sum(%buffer: memref<?xi64>) -> (i64) {
  %c0 = constant 0 : index
  %N = dim %buffer, %c0 : memref<?xi64>
  %sum_0 = constant 0 : i64
  %sum = affine.for %i = 0 to %N step 1
    iter_args(%sum_iter = %sum_0) -> (i64) {
    %t = affine.load %buffer[%i] : memref<?xi64>
    %sum_next = std.addi %sum_iter, %t : i64
    affine.yield %sum_next : i64
  }
  return %sum : i64
  }

  // create a sequence [0..upper_bound)
  func @seq(%upper_bound: i64) ->  memref<?xi64> {
    %upper_bound_ix = std.index_cast %upper_bound : i64 to index
    %buf = alloc(%upper_bound_ix) : memref<?xi64>
    affine.for %i = 0 to %upper_bound_ix step 1 {
          %ival = std.index_cast %i : index to i64
          affine.store %ival, %buf[%i] : memref<?xi64>
      }
      std.return %buf: memref<?xi64>
  }

  lz.func @f (%i : !lz.thunk<memref<5000xi64>>) -> !lz.value {
      %v = lz.make_i64(2)
      lz.return(%v): !lz.value
    }

  
  lz.func @valf () -> memref<5000xi64> {
       %v = alloc() : memref<5000xi64>
       affine.for %i = 0 to 5000 step 1 {
            %ival = std.index_cast %i : index to i64
            // %ival = std.constant(%i : index) : i64
            // %t = affine.load %buffer[%i] : memref<1024xf32>
            // %sum_next = addf %sum_iter, %t : f32
            affine.store %ival, %v[%i] : memref<5000xi64>
       }
       lz.return(%v): memref<5000xi64>
     }


  // 1 + 2 = 3
  lz.func @main () -> !lz.value {
      %f = lz.ref(@f)  : !lz.fn<(!lz.thunk<memref<5000xi64>>) ->  !lz.value>
      %valf = lz.ref(@valf) :!lz.fn<() -> memref<5000xi64>>
      %int = lz.ap(%valf: !lz.fn<() -> memref<5000xi64>>) 
      %out_t = lz.ap(%f : !lz.fn<(!lz.thunk<memref<5000xi64>>) -> !lz.value>, %int)
      %out_v = lz.force(%out_t): !lz.value
      lz.return(%out_v) : !lz.value
    }
}


