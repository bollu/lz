// module Algo.Tridiag ( tridiag ) where
// 
// tridiag :: (tensor Double, tensor Double, tensor Double, tensor Double)
//             -> tensor Double
// {-# NOINLINE tridiag #-}
// tridiag (as,bs,cs,ds) = V.prescanr' (\(c,d) x' -> d - c*x') 0
//                       $ V.prescanl' modify (0,0)
//                       $ V.zip (V.zip as bs) (V.zip cs ds)
//     where
//       modify (c',d') ((a,b),(c,d)) = 
//                    let id = 1 / (b - c'*a)
//                    in
//                    id `seq` (c*id, (d-d'*a)*id)

// Example: @prescanl (+) 0 \<1,2,3,4\> = \<0,1,3,6\>@
func @prescanr(%f: (!lz.value, !lz.value) -> (!lz.value), %seed: !lz.value, %xs: memref<?x!lz.value>) -> memref<?x!lz.value> {
    %N = constant 1024 : index
    %out = alloc(%N) : memref<?x!lz.value>
    affine.for %i = 0 to %N step 1 
    iter_args(%accum = %seed) -> (!lz.value) {
      affine.store %accum, %out[%i] : memref<?x!lz.value>
      %x = affine.load %xs[%i] : memref<?x!lz.value>
      %accum_cur = std.call_indirect %f (%x, %accum) : (!lz.value, !lz.value) -> !lz.value
      affine.yield %accum_cur : !lz.value
    }
    return %out : memref<?x!lz.value>
}

// Example: @prescanl (+) 0 \<1,2,3,4\> = \<0,1,3,6\>@
// v we should take a closure, right?
func @prescanl(%f: (!lz.value, !lz.value) -> (!lz.value), %seed: !lz.value, %xs: memref<?x!lz.value>) -> memref<?x!lz.value> {
    %N = constant 1024 : index
    %out = alloc(%N) : memref<?x!lz.value>
    affine.for %i = 0 to %N step 1 
    iter_args(%accum = %seed) -> (!lz.value) {
      affine.store %accum, %out[%i] : memref<?x!lz.value>
      %x = affine.load %xs[%i] : memref<?x!lz.value>
      %accum_cur = std.call_indirect %f (%x, %accum) : (!lz.value, !lz.value) -> !lz.value
      affine.yield %accum_cur : !lz.value
    }
    return %out : memref<?x!lz.value>
}

func @zip(%xs: memref<?xi64>, %ys: memref<?xi64>) -> memref<?x!lz.value> {
    %N = constant 1024 : index
    %out = alloc(%N) : memref<?x!lz.value>
    affine.for %i = 0 to %N step 1 {
      %x = affine.load %xs[%i] : memref<?xi64>
      %y = affine.load %ys[%i] : memref<?xi64>
      %zip = lz.construct(@Tuple2, %x: i64, %y: i64)
      affine.store %zip, %out[%i] : memref<?x!lz.value>
    }
    return %out : memref<?x!lz.value>
}

// 
// func @trihs() -> tensor<?xf64> {
// }
// 
// func @trihand(%as: tensor<?xf64>, %bs: tensor<?xf64>, %cs: tensor<?xf64>, %ds: tensor<?xf64>) -> tensor<?xf64> {
//     
// }
// 
// func @main() -> tensor<?xf64> {
// }
