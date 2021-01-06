// RUN: hask-opt --lz-interpret %s | FileCheck %s
// RUN: hask-opt --lz-worker-wrapper --lz-interpret %s | FileCheck --check-prefix="CHECK-WW" %s
// RUN: hask-opt %s  --lz-lower --convert-scf-to-std --ptr-lower
// RUN: hask-opt %s  --lz-worker-wrapper --lz-lower --convert-scf-to-std --ptr-lower
// RUN: run-optimized.sh < %s | FileCheck %s
// CHECK: 523776
// CHECK-WW: num_force_calls(0)



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
    return %buf : memref<?xi64>
  }

  func private @printInt(%i: i64)

  // computes sum of numbers upto 1023?
  func @main ()  -> i64 {
    %seqf = constant @seq : (i64) ->  memref<?xi64>
    %size = std.constant 1024 : i64
    %seqt = lz.ap(%seqf: (i64) -> memref<?xi64>, %size)

    %sumf = constant @sum : (!lz.thunk<memref<?xi64>>) -> i64
    %outt = lz.ap(%sumf : (!lz.thunk<memref<?xi64>>) -> i64, %seqt)
    %outv = lz.force(%outt): i64
    call @printInt(%outv) : (i64) -> ()
    %zero = constant 0 : i64
    return %zero : i64
  }
}


