import Gauge.Main
import Data.Vector.Unboxed as V
import Data.Word
import System.Random.Stateful

tridiag :: (Vector Double, Vector Double, Vector Double, Vector Double)
            -> Vector Double
{-# NOINLINE tridiag #-}
tridiag (as,bs,cs,ds) = V.prescanr' (\(c,d) x' -> d - c*x') 0
                      $ V.prescanl' modify (0,0)
                      $ V.zip (V.zip as bs) (V.zip cs ds)
    where
      modify (c',d') ((a,b),(c,d)) = 
                   let id = 1 / (b - c'*a)
                   in
                   id `seq` (c*id, (d-d'*a)*id)



useSize :: Int
useSize = 2000000

useSeed :: Int
useSeed = 42

indexFindThreshold :: Double
indexFindThreshold = 2e-5

main :: IO ()
main = do
  gen <- newIOGenM (mkStdGen useSeed)
  let randomVector l = V.replicateM l (uniformDoublePositive01M gen)
  as <- randomVector useSize
  bs <- randomVector useSize
  cs <- randomVector useSize
  ds <- randomVector useSize
  defaultMain $ [bench "tridiag" $ whnf tridiag (as,bs,cs,ds)]
