import Gauge.Main
import Data.Int
import Data.Vector.Unboxed as V
import Data.Word
import System.Random.Stateful
import Data.Binary
import Data.Vector.Binary
import Data.Binary.Put
import qualified Data.ByteString.Lazy as B


go1 :: Int64 -> Int64 -> Int64
go1 accum 0 = accum; go1 accum i = go1 (accum + go2 0 i) (i-1)

go2 :: Int64 -> Int64 -> Int64
go2 accum 0 = accum; go2 accum i = go2 (accum + go3 0 i) (i-1)

go3 :: Int64 -> Int64 -> Int64
go3 accum 0 = accum; go3 accum i = go3 (accum + i) (i - 1)

test :: Int64 -> Int64
{-# NOINLINE test #-}
test d = go1 0 d


encodeVecDoubleToFile :: String -> Vector Double -> IO ()
encodeVecDoubleToFile f vs = B.writeFile f $ runPut $ (genericPutVectorWith (putInt32le . fromIntegral) putDoublele vs)

encodeVecIntToFile :: String -> Vector Int64 -> IO ()
encodeVecIntToFile f vs = B.writeFile f $ runPut $ (genericPutVectorWith (putInt32le . fromIntegral) (putInt64le . fromIntegral) vs)


input :: Int64
input = 2000

main :: IO ()
main = do
  encodeVecIntToFile "input.bin" (V.fromList [input] :: Vector Int64)
  encodeVecIntToFile "out-hs.bin" (V.fromList [test input] :: Vector Int64)
  defaultMain $ [bench "test" $ whnf test input]
