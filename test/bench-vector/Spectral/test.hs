import Gauge.Main
import Data.Vector.Unboxed as V
import Data.Word
import System.Random.Stateful
import Data.Binary
import Data.Vector.Binary
import Data.Binary.Put
import qualified Data.ByteString.Lazy as B
import Data.Bits

spectral :: Vector Double -> Vector Double
{-# NOINLINE spectral #-}
spectral us = us `seq` V.map row (V.enumFromTo 0 (n-1))
    where
      n = V.length us

      row i = i `seq` V.sum (V.imap (\j uj -> eval_A i j * uj) us)

      eval_A i j = 1 / fromIntegral r
        where
          r = u + (i+1)
          u = t `shiftR` 1
          t = n * (n+1)
          n = i+j

useSize :: Int
--useSize = 2000000
useSize = 20000

useSeed :: Int
useSeed = 42

encodeVecToFile :: String -> Vector Double -> IO ()
encodeVecToFile f vs = B.writeFile f $ runPut $ (genericPutVectorWith (putInt32le . fromIntegral) putDoublele vs)

main :: IO ()
main = do
  gen <- newIOGenM (mkStdGen useSeed)
  let randomVector l = V.replicateM l (uniformDoublePositive01M gen)
  as <- randomVector useSize
  encodeVecToFile "as.bin" as

  defaultMain $ [bench "spectral" $ whnf spectral (as)]

  let out = spectral as
  encodeVecToFile "out-hs.bin" out
