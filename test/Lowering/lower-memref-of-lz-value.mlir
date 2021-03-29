// RUN: hask-opt %s  --lz-lower 
// RUN: hask-opt %s  --lz-lower  --lower-affine --convert-scf-to-std --ptr-lower
func @zip(%xs: memref<?xf64>, %ys: memref<?xf64>) -> memref<?x!lz.value> {
    %N = constant 1024 : index
    %out = memref.alloc(%N) : memref<?x!lz.value>
    affine.for %i = 0 to %N step 1 {
      %x = affine.load %xs[%i] : memref<?xf64>
      %y = affine.load %ys[%i] : memref<?xf64>
      %zip = lz.construct(@Tuple2, %x: f64, %y: f64)
      affine.store %zip, %out[%i] : memref<?x!lz.value>
    }
    return %out : memref<?x!lz.value>
}


func private @fndecl(%xs: memref<?xf64>, %ys: memref<?xf64>) -> memref<?x!lz.value>
func private @erand48(%xsubi: memref<3xi16>) -> f64


// generate a random vector of doubles
func @randomVec(%n: i64, %xsubi: memref<3xi16>) -> memref<?xf64> {
    %N = index_cast %n : i64 to index
    %out = alloc(%N) : memref<?xf64>

    affine.for %i = 0 to %N step 1 {
      %cval = call @erand48(%xsubi) : (memref<3xi16>) -> f64
      affine.store %cval, %out[%i] : memref<?xf64>
    }
    return %out : memref<?xf64>
}

func @main() -> i64 {
   %out = constant 0  : i64

   %c3 = constant 3 : index
   %xsubi = alloc() : memref<3xi16>

   %useSize = constant 2000000 : i64
   %useSeed = constant 42 : i16

   %c2 = constant 2 : index
   affine.store %useSeed, %xsubi[%c2] : memref<3xi16>

   %as = call @randomVec(%useSize, %xsubi)  : (i64, memref<3xi16>) -> memref<?xf64>
   %bs = call @randomVec(%useSize, %xsubi)  : (i64, memref<3xi16>) -> memref<?xf64>
   %asbs = call @zip (%as, %bs) 
        : (memref<?xf64>, memref<?xf64>) -> memref<?x!lz.value>
   return %out : i64
}
