module Algo.FindIndexR (findIndexR, findIndexR_naive, findIndexR_manual)
where

import Data.Vector.Unboxed (Vector)
import qualified Data.Vector.Generic as V
import System.Random.Stateful
import Data.Binary
import Data.Vector.Binary
import Data.Binary.Put
import qualified Data.ByteString.Lazy as B

findIndexR :: (Double -> Bool, Vector Double) -> Maybe Int
{-# NOINLINE findIndexR #-}
findIndexR = uncurry V.findIndexR

findIndexR_naive :: (Double -> Bool, Vector Double) -> Maybe Int
{-# NOINLINE findIndexR_naive #-}
findIndexR_naive (pred, v) = fmap (V.length v - 1 -)
    $ V.foldl (\a x -> if pred x
                        then Just 1
                        else succ<$>a) Nothing v

findIndexR_manual :: (Double -> Bool, Vector Double) -> Maybe Int
{-# NOINLINE findIndexR_manual #-}
findIndexR_manual (pred, v) = go $ V.length v - 1
 where go i | i < 0                     = Nothing
            | pred (V.unsafeIndex v i)  = Just i
            | otherwise                 = go $ i-1
indexFindThreshold :: Double
indexFindThreshold = 2e-5

encodeVecDoubleToFile :: String -> Vector Double -> IO ()
encodeVecDoubleToFile f vs = 
  B.writeFile f $ runPut $ (genericPutVectorWith (putInt32le . fromIntegral) putDoublele vs)

main :: IO ()
main = do
  as <- randomVector useSize
  as `seq` return ()
  encodeVecDoubleToFile "as.bin" as

  bench ["findIndexR_manual" $ whnf findIndexR_manual ((<indexFindThreshold), as),
         "findIndexR_naive" $ whnf findIndexR_manual ((<indexFindThreshold), as)]
  let out_manual =  findIndexR_manual ((<indexFindThreshold), as)
  encodeVecDoubleToFile "out-hs.bin" as
