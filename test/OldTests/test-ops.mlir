// mlir-opt --inline test-ops.mlir --affine-loop-fusion -canonicalize
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


func @main () -> i64 {
   %size = constant 1024 : i64
   %buf = call @seq(%size) : (i64) -> memref<?xi64>
    %out = call @sum(%buf) : (memref<?xi64>) -> i64
    std.return %out : i64
}
