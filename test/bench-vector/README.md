# Benchmark notes

##### tridiag

```
clang++ -O3 tridiag.cpp -o tridiagc.out -lbenchmark -L/usr/local/lib/ -lpthread
rm tridiag-out-hs.bin
rm tridiag-out-cpp.bin
./tridiaghs.out
benchmarking tridiag ... took 7.698 s, total 56 iterations
benchmarked tridiag
time                 134.3 ms   (130.7 ms .. 136.9 ms)
                     0.999 R²   (0.998 R² .. 1.000 R²)
mean                 141.8 ms   (139.4 ms .. 145.1 ms)
std dev              4.755 ms   (3.410 ms .. 6.941 ms)

./tridiagc.out
2021-01-08T23:22:24+05:30
Running ./tridiagc.out
Run on (8 X 3400 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
  L4 Unified 131072 KiB (x1)
Load Average: 1.14, 1.05, 0.75
***WARNING*** CPU scaling is enabled, the benchmark real time measurements may be noisy and will incur extra overhead.
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_tridiag       37.9 ms         37.9 ms           18
sha256sum tridiag-out-hs.bin
b288ee288a2bc1800ca18beecb7df9a07edd1355876f44cf6342cf368a11e9c4  tridiag-out-hs.bin
sha256sum tridiag-out-cpp.bin
b288ee288a2bc1800ca18beecb7df9a07edd1355876f44cf6342cf368a11e9c4  tridiag-out-cpp.bin
```

#### AwShCC
```
GenGraph.hs:11:24: error:
    Not in scope: type constructor or class ‘MV.PrimMonad’
    Module ‘Data.Vector.Mutable’ does not export ‘PrimMonad’.
   |
11 |   :: (StatefulGen g m, MV.PrimMonad m)
   |                        ^^^^^^^^^^^^

GenGraph.hs:24:24: error:
    Not in scope: type constructor or class ‘MV.PrimMonad’
    Module ‘Data.Vector.Mutable’ does not export ‘PrimMonad’.
   |
24 |   :: (StatefulGen g m, MV.PrimMonad m)
   |                        ^^^^^^^^^^^^

GenGraph.hs:27:18: error:
    Not in scope: type constructor or class ‘MV.PrimState’
    Module ‘Data.Vector.Mutable’ does not export ‘PrimState’.
   |
27 |   -> MV.MVector (MV.PrimState m) [Int]
   |                  ^^^^^^^^^^^^
```
##### FindIndexR
- Unable to test, because this function was introduced in a new version of `vector`.
  Will need to upgrade my GHC install.

##### HybCC
- Unable to test, because it depends on the same dependencies as `AwShCC`.

##### Leaffix
##### Listrank
##### MutableSet
##### Quickhull
##### Rootfix
##### Spectral

##### closed-form-gauss

compute closed form for sum of `1...n` added to itself `n^2` times.

```
[I] /home/bollu/work/mlir/lz/test/bench-vector/closed-form-gauss > make
clang++ -O3 test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread
rm out-hs.bin
rm out-cpp.bin
./hs.out
benchmarking test ... took 26.65 s, total 56 iterations
benchmarked test
time                 484.8 ms   (483.9 ms .. 485.7 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 484.3 ms   (483.9 ms .. 485.0 ms)
std dev              912.8 μs   (558.2 μs .. 1.405 ms)

./cpp.out
2021-01-09T00:02:33+05:30
Running ./cpp.out
Run on (8 X 3400 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
  L4 Unified 131072 KiB (x1)
Load Average: 0.84, 0.52, 0.47
***WARNING*** CPU scaling is enabled, the benchmark real time measurements may be noisy and will incur extra overhead.
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_test         0.000 us        0.000 us   1000000000
sha256sum out-hs.bin
479b57015fba54eb547d9453d85ba9e282dcf619316987b29b22f5c7ac6ac1d7  out-hs.bin
sha256sum out-cpp.bin
479b57015fba54eb547d9453d85ba9e282dcf619316987b29b22f5c7ac6ac1d7  out-cpp.bin
```



#### Reference of original benchmark runner

```hs
module Main where

import Gauge.Main

import Algo.MutableSet (mutableSet)
import Algo.ListRank   (listRank)
import Algo.Rootfix    (rootfix)
import Algo.Leaffix    (leaffix)
import Algo.AwShCC     (awshcc)
import Algo.HybCC      (hybcc)
import Algo.Quickhull  (quickhull)
import Algo.Spectral   (spectral)
import Algo.Tridiag    (tridiag)
import Algo.FindIndexR (findIndexR, findIndexR_naive, findIndexR_manual)

import TestData.ParenTree (parenTree)
import TestData.Graph     (randomGraph)

import qualified Data.Vector.Mutable as MV
import qualified Data.Vector.Unboxed as U
import Data.Word
import System.Random.Stateful

useSize :: Int
useSize = 2000000

useSeed :: Int
useSeed = 42

indexFindThreshold :: Double
indexFindThreshold = 2e-5

main :: IO ()
main = do
  gen <- newIOGenM (mkStdGen useSeed)

  let (lparens, rparens) = parenTree useSize
  (nodes, edges1, edges2) <- randomGraph gen useSize
  lparens `seq` rparens `seq` nodes `seq` edges1 `seq` edges2 `seq` return ()

  let randomVector l = U.replicateM l (uniformDoublePositive01M gen)
  as <- randomVector useSize
  bs <- randomVector useSize
  cs <- randomVector useSize
  ds <- randomVector useSize
  sp <- randomVector (floor $ sqrt $ fromIntegral useSize)
  as `seq` bs `seq` cs `seq` ds `seq` sp `seq` return ()

  vi <- MV.new useSize

  defaultMain
    [ bench "listRank"   $ whnf listRank useSize
    , bench "rootfix"    $ whnf rootfix (lparens, rparens)
    , bench "leaffix"    $ whnf leaffix (lparens, rparens)
    , bench "awshcc"     $ whnf awshcc (nodes, edges1, edges2)
    , bench "hybcc"      $ whnf hybcc  (nodes, edges1, edges2)
    , bench "quickhull"  $ whnf quickhull (as,bs)
    , bench "spectral"   $ whnf spectral sp
    , bench "tridiag"    $ whnf tridiag (as,bs,cs,ds)
    , bench "mutableSet" $ nfIO $ mutableSet vi
    , bench "findIndexR" $ whnf findIndexR ((<indexFindThreshold), as)
    , bench "findIndexR_naïve" $ whnf findIndexR_naive ((<indexFindThreshold), as)
    , bench "findIndexR_manual" $ whnf findIndexR_manual ((<indexFindThreshold), as)
    ]
```
