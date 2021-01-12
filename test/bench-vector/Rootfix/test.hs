module Main where

import Gauge.Main
import Data.Vector.Unboxed as V
import Data.Word
import System.Random.Stateful
import Data.Binary
import Data.Vector.Binary
import Data.Binary.Put
import qualified Data.ByteString.Lazy as B
import qualified Data.List as L

rootfix :: (V.Vector Int, V.Vector Int) -> V.Vector Int
{-# NOINLINE rootfix #-}
rootfix (ls, rs) = rootfix (V.replicate (V.length ls) 1) ls rs
    where
      rootfix xs ls rs
        = let zs   = V.replicate (V.length ls * 2) 0
              vs   = V.update_ (V.update_ zs ls xs) rs (V.map negate xs)
              sums = V.prescanl' (+) 0 vs
          in
          V.backpermute sums ls


parenTree :: Int -> (V.Vector Int, V.Vector Int)
parenTree n = case go ([],[]) 0 (if even n then n else n+1) of
               (ls,rs) -> (V.fromListN (L.length ls) (L.reverse ls),
                           V.fromListN (L.length rs) (L.reverse rs))
  where
    go (ls,rs) i j = case j-i of
                       0 -> (ls,rs)
                       2 -> (ls',rs')
                       d -> let k = ((d-2) `div` 4) * 2
                            in
                            go (go (ls',rs') (i+1) (i+1+k)) (i+1+k) (j-1)
      where
        ls' = i:ls
        rs' = j-1:rs

encodeVecInt32ToFile :: String -> Vector Int -> IO ()
encodeVecInt32ToFile f vs = 
  B.writeFile f $ runPut $ 
    (genericPutVectorWith 
      (putInt32le . fromIntegral)
      (putInt32le . fromIntegral) vs)


useSize :: Int
useSize = 20000000

useSeed :: Int
useSeed = 42

main :: IO ()
main = do
  let (lparens, rparens) = parenTree useSize
  encodeVecInt32ToFile "lparens.bin" lparens
  encodeVecInt32ToFile "rparens.bin" rparens
  defaultMain [bench "rootfix" $ whnf rootfix (lparens, rparens)]
  let out = rootfix (lparens, rparens)
  encodeVecInt32ToFile "out-hs.bin" out
