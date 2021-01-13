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
import Control.Applicative

import Data.Vector.Unboxed as V

quickhull :: (Vector Double, Vector Double) -> (Vector Double, Vector Double)
{-# NOINLINE quickhull #-}
quickhull (xs, ys) = xs' `seq` ys' `seq` (xs',ys')
    where
      (xs',ys') = V.unzip
                $ hsplit points pmin pmax V.++ hsplit points pmax pmin

      imin = V.minIndex xs
      imax = V.maxIndex xs

      points = V.zip xs ys
      pmin   = points V.! imin
      pmax   = points V.! imax

      cross (x,y) (x1,y1) (x2,y2) = (x1-x)*(y2-y) - (y1-y)*(x2-x)

      hsplit points p1 p2
        | V.length packed < 2 = p1 `V.cons` packed
        | otherwise = hsplit packed p1 pm V.++ hsplit packed pm p2
        where
          cs     = V.map (\p -> cross p p1 p2) points
          packed = V.map fst
                 $ V.filter (\t -> snd t > 0)
                 $ V.zip points cs

          pm     = points V.! V.maxIndex cs

quickhullDebug :: (Vector Double, Vector Double) -> IO (Vector Double, Vector Double)
quickhullDebug (xs, ys) = do 
      let imin = V.minIndex xs
      let imax = V.maxIndex xs
      let points = V.zip xs ys
      let pmin   = points V.! imin
      let pmax   = points V.! imax
      let cross (x,y) (x1,y1) (x2,y2) = (x1-x)*(y2-y) - (y1-y)*(x2-x)

      let hsplit points p1 p2 = do
          putStrLn "\n===\n"
          putStrLn $ "points: " <> show points
          putStrLn $ "p1: " <> show p1
          putStrLn $ "p2: " <> show p2
          let cs     = V.map (\p -> cross p p1 p2) points
          putStrLn $ "cs: " <> show cs
          let pm     = points V.! V.maxIndex cs
          let packed = V.map fst
                  $ V.filter (\t -> snd t > 0)
                  $ V.zip points cs
          putStrLn $ "packed: " <> show packed
          if V.length packed < 2 
          then do 
             let outcons =  p1 `V.cons` packed
             putStrLn $ "$quickhull.cons$ " <> show outcons
             return $ outcons
          else do
            l <- (hsplit packed p1 pm)
            r <- (hsplit packed pm p2)
            let appendout = l V.++ r 
            putStrLn $ "l: " <> show l
            putStrLn $ "r: " <> show r
            putStrLn $ "$quickhull.append$: " <> show appendout
            return appendout

      (xs',ys') <- do
        l <- hsplit points pmin pmax
        r <- hsplit points pmax pmin
        return $ V.unzip $ l V.++ r
      return (xs',ys')
      


encodeVecDoubleToFile :: String -> Vector Double -> IO ()
encodeVecDoubleToFile f vs = 
  B.writeFile f $ runPut $ (genericPutVectorWith (putInt32le . fromIntegral) putDoublele vs)


useSize :: Int
useSize = 20000000

useSeed :: Int
useSeed = 42


main :: IO ()
main = do 
  gen <- newIOGenM (mkStdGen useSeed)
  let randomVector l = V.replicateM l (uniformDoublePositive01M gen)

  as <- randomVector useSize
  encodeVecDoubleToFile "as.bin" as
  bs <- randomVector useSize
  encodeVecDoubleToFile "bs.bin" bs
  
  -- putStrLn $ "as: " <> show as
  -- putStrLn $ "bs: " <> show bs

  defaultMain $ [bench "quickhull"  $ whnf quickhull (as,bs)]
  -- (outl, outr) <- quickhullDebug (as, bs)
  let (outl, outr) = quickhull (as, bs)
  let out = (outl V.++ outr);
  -- putStrLn $ "outl: " <> show outl
  -- putStrLn $ "outr: " <> show outr
  -- putStrLn $ "out: " <> show out
  encodeVecDoubleToFile "out-hs.bin" out 
  
