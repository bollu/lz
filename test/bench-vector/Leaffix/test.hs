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



leaffix :: (Vector Int, Vector Int) -> Vector Int
{-# NOINLINE leaffix #-}
leaffix (ls,rs)
    = go (V.replicate (V.length ls) 1) ls rs
    where
      go xs ls rs
        = let zs   = V.replicate (V.length ls * 2) 0
              vs   = V.update_ zs ls xs
              sums = V.prescanl' (+) 0 vs
          in
          V.zipWith (-) (V.backpermute sums ls) (V.backpermute sums rs)

leaffixDebug :: (Vector Int, Vector Int) -> IO (Vector Int)
leaffixDebug (ls,rs) = do
  let xs = V.replicate (V.length ls) 1  
  let zs   = V.replicate (V.length ls * 2) 0

  putStrLn $ "ls: " <> show ls
  putStrLn $ "rs: " <> show rs
  putStrLn $ "xs: " <> show xs
  putStrLn $ "zs: " <> show zs

  let vs  = V.update_ zs ls xs
  putStrLn $ "vs: " <> show vs

  let sums = V.prescanl' (+) 0 vs
  putStrLn $ "sums: " <> show sums

  let out = V.zipWith (-) (V.backpermute sums ls) (V.backpermute sums rs)
  putStrLn $ "out: " <> show out
  return out 


encodeVecInt32ToFile :: String -> Vector Int -> IO ()
encodeVecInt32ToFile f vs = 
  B.writeFile f $ runPut $ 
    (genericPutVectorWith 
      (putInt32le . fromIntegral)
      (putInt32le . fromIntegral) vs)


useSize :: Int
useSize = 2000000

useSeed :: Int
useSeed = 42

main :: IO ()
main = do
  let (lparens, rparens) = parenTree useSize
  lparens `seq` rparens `seq` return ()
  
  -- leaffixDebug (lparens, rparens)

  encodeVecInt32ToFile "lparens.bin" lparens
  encodeVecInt32ToFile "rparens.bin" rparens
  defaultMain $ [ bench "leaffix"    $ whnf leaffix (lparens, rparens)]
  let out = leaffix (lparens, rparens)
  encodeVecInt32ToFile "out-hs.bin" out
