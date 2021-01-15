module Main where
import GenGraph
import Gauge.Main
import Data.Vector.Unboxed as V
import Data.Word
import System.Random.Stateful
import Data.Binary
import Data.Vector.Binary
import Data.Binary.Put
import qualified Data.ByteString.Lazy as B


pack_index :: Vector Bool -> Vector Int
pack_index bs = V.map fst
            . V.filter snd
            $ V.zip (V.enumFromTo 0 (V.length bs - 1)) bs

enumerate :: Vector Bool -> Vector Int
enumerate bs = V.prescanl' (+) 0 $ V.map (\b -> if b then 1 else 0) bs

shortcut_all :: Vector Int -> Vector Int 
shortcut_all p | p == pp   = pp
             | otherwise = shortcut_all pp
    where
      pp = V.backpermute p p

shortcut_allDebug :: Vector Int -> IO (Vector Int)
shortcut_allDebug p =  do
  putStrLn $ "shortcut_all.p: " <> show p
  let pp = V.backpermute p p
  if p == pp
  then return pp
  else shortcut_allDebug pp

compress :: Vector Int -> Vector (Int, Int) -> (Vector (Int, Int), Vector Int)
compress p es = (new_es, pack_index roots) where
      (e1,e2) = V.unzip es
      es_permute = V.zip (V.backpermute p e1) (V.backpermute p e2)
      es' = V.map (\(x,y) -> if x > y then (y,x) else (x,y))
          . V.filter (\(x,y) -> x /= y) $  es_permute

      roots = V.zipWith (==) p (V.enumFromTo 0 (V.length p - 1))
      labels = enumerate roots
      (e1',e2') = V.unzip es'
      new_es = V.zip (V.backpermute labels e1') (V.backpermute labels e2')

compressDebug :: Vector Int -> Vector (Int, Int) -> IO (Vector (Int, Int), Vector Int)
compressDebug p es = do
  putStrLn $ "compressDebug.p: " <> show p
  let (e1,e2) = V.unzip es
  let es_permute = V.zip (V.backpermute p e1) (V.backpermute p e2)
  putStrLn $ "compressDebug.es_permute: " <> show es_permute
  let es' = V.map (\(x,y) -> if x > y then (y,x) else (x,y)) . V.filter (\(x,y) -> x /= y) $ es_permute
  let roots = V.zipWith (==) p (V.enumFromTo 0 (V.length p - 1))
  let labels = enumerate roots
  let (e1',e2') = V.unzip es'
  let new_es = V.zip (V.backpermute labels e1') (V.backpermute labels e2')
  return $ (new_es, pack_index roots) 


concomp :: Vector (Int, Int) -> Int -> Vector Int
concomp es n
    | V.null es = V.enumFromTo 0 (n-1)
    | otherwise = V.backpermute ins ins
    where
      p = shortcut_all $ V.update (V.enumFromTo 0 (n-1)) es
      (es',i) = compress p es
      r = concomp es' (V.length i)
      ins = V.update_ p i $ V.backpermute i r

hybcc :: (Int, Vector Int, Vector Int) -> Vector Int
{-# NOINLINE hybcc #-}
hybcc (n, e1, e2) = concomp (V.zip e1 e2) n



concompDebug :: Vector (Int, Int) -> Int -> IO (Vector Int)
concompDebug es n = do
    putStrLn $ "es:" <>  show es
    if V.null es
    then return $ V.enumFromTo 0 (n-1)
    else do 
      p <- shortcut_allDebug $ V.update (V.enumFromTo 0 (n-1)) es
      (es',i) <- compressDebug p es
      putStrLn $ "es':" <> show es'
      r <- concompDebug es' (V.length i)
      let ins = V.update_ p i $ V.backpermute i r
      return $ V.backpermute ins ins

hybccDebug :: (Int, Vector Int, Vector Int) -> IO (Vector Int)
hybccDebug (n, e1, e2) = concompDebug (V.zip e1 e2) n

encodeVecInt32ToFile :: String -> Vector Int -> IO ()
encodeVecInt32ToFile f vs = 
  B.writeFile f $ runPut $ (genericPutVectorWith (putInt32le . fromIntegral) (putInt32le . fromIntegral) vs)

useSize :: Int
useSize = 22000

useSeed :: Int
useSeed = 42

main :: IO ()
main = do
  gen <- newIOGenM (mkStdGen useSeed)
  (nodes, edges1, edges2) <- randomGraph gen useSize
  nodes `seq` edges1 `seq` edges2 `seq` return () 
  defaultMain $ [bench "hybcc" $ whnf hybcc  (nodes, edges1, edges2)]

  -- out <- hybccDebug (nodes, edges1, edges2)
  let out = hybcc (nodes, edges1, edges2)
  encodeVecInt32ToFile "nodes.bin" (V.singleton nodes)
  encodeVecInt32ToFile "edges1.bin" edges1
  encodeVecInt32ToFile "edges2.bin" edges2
  encodeVecInt32ToFile "out-hs.bin" out
