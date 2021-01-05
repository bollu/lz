// module Algo.Tridiag ( tridiag ) where
// 
// import Data.tensor.Unboxed as V
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

// | /O(n)/ Right-to-left prescan
// 
// @
// prescanr f z = 'reverse' . 'prescanl' (flip f) z . 'reverse'
// @
func @prescanr(%f: (f64, f64) -> f64, %seed: f64, %mem: tensor<?x!lz.value>) -> tensor<?x!lz.value> {
    return %mem : tensor<?x!lz.value>
}

// Example: @prescanl (+) 0 \<1,2,3,4\> = \<0,1,3,6\>@
func @prescanl(%f: (f64, f64) -> f64, %seed: f64, %mem: tensor<?xf64>) -> tensor<?xf64> {
    return %mem : tensor<?xf64>
}

// func @zip() -> tensor<?xf64> {
// }
// 
// func @mainhs() -> tensor<?xf64> {
// }
// 
// func @mainhand() -> tensor<?xf64> {
// }
// 
// func @main() -> tensor<?xf64> {
// }
