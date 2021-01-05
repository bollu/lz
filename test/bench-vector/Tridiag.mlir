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

func @prescanr(%f: (f64, f64) -> f64, %seed: f64, %mem: tensor<?x!lz.value>) -> tensor<?x!lz.value> {
    return %mem : tensor<?x!lz.value>
}

// Example: @prescanl (+) 0 \<1,2,3,4\> = \<0,1,3,6\>@
// v we should take a closure, right?
func @prescanl(%f: (f64, f64) -> f64, %seed: f64, %mem: tensor<?xf64>) -> tensor<?xf64> {
    return %mem : tensor<?xf64>
}

// func @zip4(%x: tensor<?xf64>, %y: tensor<?xf64>, %z: tensor<?xf64>) -> tensor<?xf64> {
// }
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
