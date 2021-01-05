// Check that we can successfully lower a combination of scf.for and
// lz so we can lower loops and the like
// RUN: hask-opt --lz-interpret %s | FileCheck %s
// RUN: hask-opt --lz-lower
// RUN: hask-opt %s  --lz-lower --convert-scf-to-std --ptr-lower
// CHECK: 523776
// CHECK: num_force_calls(2)
// CHECK-WW: 523776
// CHECK-WW: num_thunkify_calls(0)
// CHECK-WW: num_force_calls(0)



module {

  // sum up all values in the buffer
  func @sum(%buffert: !lz.thunk<memref<?xi64>>) -> i64 {
    %buffer = lz.force(%buffert) :  memref<?xi64>
    %cix0 = constant 0 : index
    %cix1 = constant 1 : index
    %N = dim %buffer, %cix0 : memref<?xi64>
    %sum_0 = constant 0 : i64
    %sum = scf.for %i = %cix0 to %N step %cix1
    iter_args(%sum_iter = %sum_0) -> (i64) {
      %t = load %buffer[%i] : memref<?xi64>
      %sum_next = std.addi %sum_iter, %t : i64
      scf.yield %sum_next : i64
    }
    return %sum : i64
  }

  // create a sequence [0..upper_bound)
  func @seq(%upper_bound: i64) ->  memref<?xi64> {
    %cix0 = constant 0 : index
    %cix1 = constant 1 : index
    %upper_bound_ix = std.index_cast %upper_bound : i64 to index
    %buf = alloc(%upper_bound_ix) : memref<?xi64>
    scf.for %i = %cix0 to %upper_bound_ix step %cix1 {
      %ival = std.index_cast %i : index to i64
      store %ival, %buf[%i] : memref<?xi64>
    }
    return %buf : memref<?xi64>
  }


  // computes sum of numbers upto 1023?
  func @main () -> i64 {
    %seqf = constant @seq : (i64) ->  memref<?xi64>
    %size = std.constant 1024 : i64
    %seqt = lz.ap(%seqf: (i64) -> memref<?xi64>, %size)

    %sumf = constant @sum : (!lz.thunk<memref<?xi64>>) -> i64
    %outt = lz.ap(%sumf : (!lz.thunk<memref<?xi64>>) -> i64, %seqt)
    %outv = lz.force(%outt): i64
    return %outv : i64
  }
}


