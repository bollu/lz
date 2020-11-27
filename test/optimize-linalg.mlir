// RUN: ../build/bin/hask-opt --lz-worker-wrapper --affine-loop-fusion %s | FileCheck %s
// How to get it to optimize this?!
// CHECK:         %1 = affine.for %arg0 = 0 to 1024 iter_args(%arg1 = %c0_i64) -> (i64) {
// CHECK-NEXT:      %2 = index_cast %arg0 : index to i64
// CHECK-NEXT:      affine.store %2, %0[0] : memref<1xi64>
// CHECK-NEXT:      %3 = affine.load %0[0] : memref<1xi64>
// CHECK-NEXT:      %4 = addi %arg1, %3 : i64
// CHECK-NEXT:      affine.yield %4 : i64
// CHECK-NEXT:    }


module {

    // sum up all values in the buffer
    func @sum(%buffert: !lz.thunk<memref<?xi64>>) -> i64 {
     %buffer = lz.force(%buffert) :  memref<?xi64>
     %c0 = constant 0 : index
     %N = dim %buffer, %c0 : memref<?xi64>
     %sum_0 = constant 0 : i64
     %sum = affine.for %i = 0 to %N step 1
       iter_args(%sum_iter = %sum_0) -> (i64) {
       %t = affine.load %buffer[%i] : memref<?xi64>
       %sum_next = std.addi %sum_iter, %t : i64
       affine.yield %sum_next : i64
     }
     lz.return (%sum) : i64
    }

  // create a sequence [0..upper_bound)
  func @seq(%upper_bound: i64) ->  memref<?xi64> {
    %upper_bound_ix = std.index_cast %upper_bound : i64 to index
    %buf = alloc(%upper_bound_ix) : memref<?xi64>
    affine.for %i = 0 to %upper_bound_ix step 1 {
          %ival = std.index_cast %i : index to i64
          affine.store %ival, %buf[%i] : memref<?xi64>
      }
      lz.return (%buf) : memref<?xi64>
  }



  func @main () -> i64 {
      %seqf = lz.ref(@seq)  : !lz.fn<(i64) ->  memref<?xi64> >
      %size = std.constant 1024 : i64
      %seqt = lz.ap(%seqf: !lz.fn<(i64) -> memref<?xi64>>, %size) 
      
      %sumf = lz.ref(@sum)  : !lz.fn<(!lz.thunk<memref<?xi64>>) ->  i64 >
      %outt = lz.ap(%sumf : !lz.fn<(!lz.thunk<memref<?xi64>>) -> i64>, %seqt)
      %outv = lz.force(%outt): i64
      lz.return(%outv) : i64
    }
}


