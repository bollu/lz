import Gauge.Main
import Data.Vector.Unboxed as V
import Data.Word
import System.Random.Stateful
import Data.Binary
import Data.Vector.Binary
import Data.Binary.Put
import qualified Data.ByteString.Lazy as B


modifyfn (c',d') ((a,b),(c,d)) = 
           let id = 1 / (b - c'*a)
           in
           id `seq` (c*id, (d-d'*a)*id)


tridiag :: (Vector Double, Vector Double, Vector Double, Vector Double)
            -> Vector Double
{-# NOINLINE tridiag #-}
tridiag (as,bs,cs,ds) = V.prescanr' (\(c,d) x' -> d - c*x') 0
                      $ V.prescanl' modifyfn (0,0)
                      $ V.zip (V.zip as bs) (V.zip cs ds)



useSize :: Int
useSize = 2000000

useSeed :: Int
useSeed = 42

indexFindThreshold :: Double
indexFindThreshold = 2e-5


encodeVecToFile :: String -> Vector Double -> IO ()
encodeVecToFile f vs = B.writeFile f $ runPut $ (genericPutVectorWith (putInt32le . fromIntegral) putDoublele vs)


main :: IO ()
main = do
  gen <- newIOGenM (mkStdGen useSeed)
  let randomVector l = V.replicateM l (uniformDoublePositive01M gen)
  as <- randomVector useSize
  -- print as 
  encodeVecToFile "tridiag-as.bin" as
  bs <- randomVector useSize
  -- print bs
  encodeVecToFile "tridiag-bs.bin" bs
  cs <- randomVector useSize
  -- print cs
  encodeVecToFile "tridiag-cs.bin" cs
  ds <- randomVector useSize
  -- print ds
  encodeVecToFile "tridiag-ds.bin" ds

  let out = tridiag (as, bs, cs, ds)
  encodeVecToFile "tridiag-out-hs.bin" out
  defaultMain $ [bench "tridiag" $ whnf tridiag (as,bs,cs,ds)]
