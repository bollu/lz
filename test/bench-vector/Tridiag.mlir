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
func @prescanr(%f: (!lz.value, f64) -> (f64),
               %seed: f64,
               %xs: memref<?x!lz.value>) -> memref<?xf64> {
    %N = constant 1024 : index
    %out = alloc(%N) : memref<?xf64>
    affine.for %i = 0 to %N step 1 
    iter_args(%accum = %seed) -> (f64) {
      affine.store %accum, %out[%i] : memref<?xf64>
      %x = affine.load %xs[%i] : memref<?x!lz.value>
      %accum_cur = std.call_indirect %f (%x, %accum) 
        : (!lz.value, f64) -> f64
      affine.yield %accum_cur : f64
    }
    return %out : memref<?xf64>
}

// Example: @prescanl (+) 0 \<1,2,3,4\> = \<0,1,3,6\>@
// v we should take a closure, right?
func @prescanl(%f: (!lz.value, !lz.value) -> (!lz.value), 
               %seed: !lz.value, 
               %xs: memref<?x!lz.value>) -> memref<?x!lz.value> {
    %N = constant 1024 : index
    %out = alloc(%N) : memref<?x!lz.value>
    affine.for %i = 0 to %N step 1 
    iter_args(%accum = %seed) -> (!lz.value) {
      affine.store %accum, %out[%i] : memref<?x!lz.value>
      %x = affine.load %xs[%i] : memref<?x!lz.value>
      %accum_cur = std.call_indirect %f (%x, %accum) 
        : (!lz.value, !lz.value) -> !lz.value
      affine.yield %accum_cur : !lz.value
    }
    return %out : memref<?x!lz.value>
}

func @zip(%xs: memref<?xf64>, %ys: memref<?xf64>) -> memref<?x!lz.value> {
    %N = constant 1024 : index
    %out = alloc(%N) : memref<?x!lz.value>
    affine.for %i = 0 to %N step 1 {
      %x = affine.load %xs[%i] : memref<?xf64>
      %y = affine.load %ys[%i] : memref<?xf64>
      %zip = lz.construct(@Tuple2, %x: f64, %y: f64)
      affine.store %zip, %out[%i] : memref<?x!lz.value>
    }
    return %out : memref<?x!lz.value>
}


func @zipLzLz(%xs: memref<?x!lz.value>, %ys: memref<?x!lz.value>) -> memref<?x!lz.value> {
    %N = constant 1024 : index
    %out = alloc(%N) : memref<?x!lz.value>
    affine.for %i = 0 to %N step 1 {
      %x = affine.load %xs[%i] : memref<?x!lz.value>
      %y = affine.load %ys[%i] : memref<?x!lz.value>
      %zip = lz.construct(@Tuple2, %x: !lz.value, %y: !lz.value)
      affine.store %zip, %out[%i] : memref<?x!lz.value>
    }
    return %out : memref<?x!lz.value>
}

// write c', d' as c2, d2
func @modify(%cd2: !lz.value, %abcd: !lz.value) -> !lz.value {
    %out = lz.case @Tuple %cd2 
    [@Tuple -> { ^entry(%c2: f64, %d2: f64):
        %out = lz.case @Tuple %abcd 
        [@Tuple ->  { ^entry(%ab: !lz.value, %cd: !lz.value):
            %out = lz.case @Tuple %ab 
            [@Tuple ->  { ^entry(%a: f64, %b: f64):
                   %out = lz.case @Tuple %cd 
                   [@Tuple ->  { ^entry(%c: f64, %d: f64):
                       %c2a = std.mulf %c2, %a : f64
                       %b_minus_c2a = std.subf %b, %c2a : f64
                       %c1 = constant 1.0 : f64
                       %id = divf %c1, %b_minus_c2a : f64
                       %c_x_id = std.mulf %c, %id : f64
                       %d_min_d2 = std.subf %d, %d2 : f64
                       %d_min_d2_x_a = std.mulf %d_min_d2, %a : f64
                       %d_min_d2_x_a_x_id = std.mulf %d_min_d2_x_a, %id : f64
                       %out = lz.construct (@Tuple, %c_x_id : f64, %d_min_d2_x_a_x_id : f64)
                       lz.return %out : !lz.value
                   }]
                 lz.return %out : !lz.value
            }]
            lz.return %out : !lz.value
        }]
        lz.return %out : !lz.value
  }]
  return %out : !lz.value
}

func @scanrf(%cd: !lz.value, %x2: f64) -> f64 {
   %out = lz.case @Tuple %cd 
   [@Tuple ->  { ^entry(%c: f64, %d: f64):
        %cx2 = mulf %c, %x2 : f64
        %ret = subf %d, %cx2 : f64
        lz.return %ret : f64
   }]
   return %out : f64
}

func @trihs(%as: memref<?xf64>, 
            %bs: memref<?xf64>,
            %cs: memref<?xf64>,
            %ds: memref<?xf64>) -> memref<?xf64> {
    %asbs = call @zip (%as, %bs) 
        : (memref<?xf64>, memref<?xf64>) -> memref<?x!lz.value>
    %csds = call @zip (%cs, %ds) 
        : (memref<?xf64>, memref<?xf64>) -> memref<?x!lz.value>
    %abcd = call @zipLzLz(%asbs, %csds) 
        : (memref<?x!lz.value>, memref<?x!lz.value>) -> memref<?x!lz.value>

    %modify = std.constant @modify : (!lz.value, !lz.value) -> !lz.value
    %c0 = constant 0.0 : f64
    %c0c0 = lz.construct (@Tuple, %c0: f64, %c0: f64)
    %scanl = call @prescanl(%modify, %c0c0, %abcd) 
        : ((!lz.value, !lz.value) -> (!lz.value),  !lz.value, memref<?x!lz.value>) -> memref<?x!lz.value>


    %scanrf = std.constant @scanrf : (!lz.value, f64) -> f64
    %scanr = call @prescanr(%scanrf, %c0, %scanl) 
        : ((!lz.value, f64) -> (f64),  f64, memref<?x!lz.value>) -> memref<?xf64>

    return %cs : memref<?xf64>
}

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
   %cs = call @randomVec(%useSize, %xsubi)  : (i64, memref<3xi16>) -> memref<?xf64>
   %ds = call @randomVec(%useSize, %xsubi)  : (i64, memref<3xi16>) -> memref<?xf64>
   return %out : i64
}
