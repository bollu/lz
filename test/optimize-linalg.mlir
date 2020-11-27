// RUN: ../build/bin/hask-opt -worker-wrapper %s
module {
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


