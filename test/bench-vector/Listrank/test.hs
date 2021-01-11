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

listRank :: Int -> Vector Int
{-# NOINLINE listRank #-}
listRank n = pointer_jump xs val
  where
    xs = 0 `V.cons` V.enumFromTo 0 (n-2)

    val = V.zipWith (\i j -> if i == j then 0 else 1)
                    xs (V.enumFromTo 0 (n-1))

    pointer_jump pt val
      | npt == pt = val
      | otherwise = pointer_jump npt nval
      where
        npt  = V.backpermute pt pt
        valAtPt = (V.backpermute val pt)
        nval = V.zipWith (+) val valAtPt

listRankDebug :: Int -> IO (Vector Int)
listRankDebug n = do 
    let xs = 0 `V.cons` V.enumFromTo 0 (n-2)
    putStrLn $ "xs: " <> show xs
    let val = V.zipWith (\i j -> if i == j then 0 else 1)
                    xs (V.enumFromTo 0 (n-1))
    putStrLn $ "val: " <> show val
    pointer_jump xs val

    where pointer_jump pt val = do
            putStrLn $ "pt: " <> show pt <> " |val: " <> show val
            let npt =  V.backpermute pt pt
            putStrLn $ "npt: " <> show npt
            if npt == pt then return  val
            else do
               let valAtPt = (V.backpermute val pt)
               putStrLn $ "val@pt: " <> show valAtPt
               let nval = V.zipWith (+) val valAtPt
               putStrLn $ "nval: " <> show nval
               pointer_jump npt nval

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
  encodeVecInt32ToFile "useSize.bin" (V.fromList [useSize])

  defaultMain $ [bench "listRank"   $ whnf listRank useSize]
  -- out <- listRankDebug useSize
  let out = listRank useSize
  encodeVecInt32ToFile "out-hs.bin" out
