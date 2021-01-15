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
or/AwShCC/ > make
ghc test.hs -O2 -fllvm -o hs.out -package primitive
Loaded package environment from /home/bollu/.ghc/x86_64-linux-8.10.2/environments/default
[2 of 2] Compiling Main             ( test.hs, test.o )
You are using an unsupported version of LLVM!
Currently only 9 is supported. System LLVM version: 12.0.0
We will try though...
Linking hs.out ...
clang++ -O3 -Wall -Werror test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread
rm out-hs.bin
rm out-cpp.bin
./hs.out
benchmarked awshcc
time                 46.24 ms   (44.98 ms .. 48.07 ms)
                     0.997 R²   (0.993 R² .. 0.999 R²)
mean                 46.35 ms   (45.82 ms .. 47.04 ms)
std dev              1.246 ms   (857.3 μs .. 1.731 ms)

./cpp.out
2021-01-15T07:05:30+05:30
Running ./cpp.out
Run on (8 X 3400 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
  L4 Unified 131072 KiB (x1)
Load Average: 0.97, 0.91, 0.77
***WARNING*** CPU scaling is enabled, the benchmark real time measurements may be noisy and will incur extra overhead.
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_test          27.4 ms         27.4 ms           25
sha256sum out-hs.bin
894d7ef5f46d0517ed4a932291c9776f8c3b6101c6e87975bd297f20749ea343  out-hs.bin
sha256sum out-cpp.bin
894d7ef5f46d0517ed4a932291c9776f8c3b6101c6e87975bd297f20749ea343  out-cpp.bin
```
##### FindIndexR
- Unable to test, because this function was introduced in a new version of `vector`.
  Will need to upgrade my GHC install.

##### HybCC
- Unable to test, because it depends on the same dependencies as `AwShCC`.
- OK, I started testing it. Unable to get it running, because the large problem
  size, while terminates in haskell, consumes too much memory.
- Setting `useSize=20` causes the haskell program to never halt. I feel the
  test is bugged. Skipping.

```
bollu@cantordust:~/work/mlir/lz/test/bench-vector/HybCC/ > make
ghc test.hs -O2 -fllvm -o hs.out -package primitive 
Loaded package environment from /home/bollu/.ghc/x86_64-linux-8.10.2/environments/default
[2 of 2] Compiling Main             ( test.hs, test.o )
You are using an unsupported version of LLVM!
Currently only 9 is supported. System LLVM version: 12.0.0
We will try though...
Linking hs.out ...
clang++ -Wall -Werror -O3 test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread
rm out-hs.bin
rm out-cpp.bin
./hs.out
benchmarked hybcc
time                 374.4 μs   (357.8 μs .. 397.7 μs)
                     0.980 R²   (0.970 R² .. 0.996 R²)
mean                 362.9 μs   (357.2 μs .. 370.8 μs)
std dev              22.51 μs   (15.55 μs .. 31.00 μs)
variance introduced by outliers: 38% (moderately inflated)

./cpp.out
2021-01-15T08:02:15+05:30
Running ./cpp.out
Run on (8 X 3400 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
  L4 Unified 131072 KiB (x1)
Load Average: 0.81, 0.79, 0.63
***WARNING*** CPU scaling is enabled, the benchmark real time measurements may be noisy and will incur extra overhead.
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_test          1142 us         1142 us          619
sha256sum out-hs.bin
ce2b96591f4c532e6eee8c2bd94418c8d54c03b1916c968a0d66cba8b54e0e78  out-hs.bin
sha256sum out-cpp.bin
ce2b96591f4c532e6eee8c2bd94418c8d54c03b1916c968a0d66cba8b54e0e78  out-cpp.bin
```

##### Leaffix

```
[I] /home/bollu/work/mlir/lz/test/bench-vector/Leaffix > make
ghc test.hs -O2 -fllvm -o hs.out
Loaded package environment from /home/bollu/.ghc/x86_64-linux-8.10.2/environments/default
clang++ -O3 test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread
rm *.bin
./hs.out
benchmarked leaffix
time                 11.73 ms   (11.50 ms .. 11.99 ms)
                     0.998 R²   (0.997 R² .. 0.999 R²)
mean                 12.02 ms   (11.91 ms .. 12.18 ms)
std dev              341.3 μs   (247.7 μs .. 444.9 μs)
variance introduced by outliers: 10% (moderately inflated)

./cpp.out
2021-01-11T23:09:14+05:30
Running ./cpp.out
Run on (8 X 3400 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
  L4 Unified 131072 KiB (x1)
Load Average: 0.83, 0.74, 0.70
***WARNING*** CPU scaling is enabled, the benchmark real time measurements may be noisy and will incur extra overhead.
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_test          11.4 ms         11.4 ms           60
sha256sum out-hs.bin
a5236d1a9a72d11379d8f85a41d0bb0e17d665cdc0545836ea8cf5914590a031  out-hs.bin
sha256sum out-cpp.bin
```
##### Listrank

```
[I] /home/bollu/work/mlir/lz/test/bench-vector/Listrank > make
ghc test.hs -O2 -fllvm -o hs.out
Loaded package environment from /home/bollu/.ghc/x86_64-linux-8.10.2/environments/default
[1 of 1] Compiling Main             ( test.hs, test.o )
You are using an unsupported version of LLVM!
Currently only 9 is supported. System LLVM version: 12.0.0
We will try though...
Linking hs.out ...
# clang++ -O3 test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread
clang++ -O0 -g test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread
rm out-hs.bin
rm out-cpp.bin
./hs.out
benchmarking listRank ... took 23.12 s, total 56 iterations
benchmarked listRank
time                 441.9 ms   (387.1 ms .. 498.6 ms)
                     0.954 R²   (0.863 R² .. 0.996 R²)
mean                 405.6 ms   (383.7 ms .. 447.6 ms)
std dev              49.68 ms   (31.42 ms .. 75.01 ms)
variance introduced by outliers: 38% (moderately inflated)

./cpp.out
2021-01-12T01:56:59+05:30
Running ./cpp.out
Run on (8 X 3400 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
  L4 Unified 131072 KiB (x1)
Load Average: 2.40, 1.55, 1.09
***WARNING*** CPU scaling is enabled, the benchmark real time measurements may be noisy and will incur extra overhead.
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_test           666 ms          665 ms            1
sha256sum out-hs.bin
0bc580290a3e79b1e8d721b228e4dec4adea68b807304a8e7c848a5bd578a220  out-hs.bin
sha256sum out-cpp.bin
0bc580290a3e79b1e8d721b228e4dec4adea68b807304a8e7c848a5bd578a220  out-cpp.bin
```

##### MutableSet
- Uninteresting, benchmarks cost of setting a value in an array.
  Will port this last.

##### Quickhull


```
[I] /home/bollu/work/mlir/lz/test/bench-vector/Quickhull > make 
ghc test.hs -O2 -fllvm -o hs.out
Loaded package environment from /home/bollu/.ghc/x86_64-linux-8.10.2/environments/default
[1 of 1] Compiling Main             ( test.hs, test.o )
You are using an unsupported version of LLVM!
Currently only 9 is supported. System LLVM version: 12.0.0
We will try though...
Linking hs.out ...
clang++ -O3 test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread
rm out-hs.bin
rm: cannot remove 'out-hs.bin': No such file or directory
makefile:4: recipe for target 'run' failed
make: [run] Error 1 (ignored)
rm out-cpp.bin
rm: cannot remove 'out-cpp.bin': No such file or directory
makefile:4: recipe for target 'run' failed
make: [run] Error 1 (ignored)
./hs.out | tee hs.log
benchmarking quickhull ... took 65.07 s, total 56 iterations
benchmarked quickhull
time                 1.257 s    (1.040 s .. 1.446 s)
                     0.965 R²   (0.930 R² .. 0.998 R²)
mean                 1.170 s    (1.124 s .. 1.244 s)
std dev              93.82 ms   (59.29 ms .. 148.9 ms)
variance introduced by outliers: 19% (moderately inflated)

#############################
./cpp.out | tee cpp.log
2021-01-13T07:01:34+05:30
Running ./cpp.out
Run on (8 X 3400 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
  L4 Unified 131072 KiB (x1)
Load Average: 1.27, 0.72, 0.61
***WARNING*** CPU scaling is enabled, the benchmark real time measurements may be noisy and will incur extra overhead.
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_test          3036 ms         3036 ms            1
sha256sum out-hs.bin
588c72ff37dd0e500a19976a9630cb2c31b1dc36602989225e02b0cb1f5161d0  out-hs.bin
sha256sum out-cpp.bin
588c72ff37dd0e500a19976a9630cb2c31b1dc36602989225e02b0cb1f5161d0  out-cpp.bin
```



##### Rootfix

```
[1 of 1] Compiling Main             ( test.hs, test.o )
You are using an unsupported version of LLVM!
Currently only 9 is supported. System LLVM version: 12.0.0
We will try though...
Linking hs.out ...
clang++ -O3 test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread
rm out-hs.bin
rm out-cpp.bin
./hs.out
benchmarking rootfix ... took 9.123 s, total 56 iterations
benchmarked rootfix
time                 168.0 ms   (166.3 ms .. 171.2 ms)
                     0.999 R²   (0.998 R² .. 1.000 R²)
mean                 163.9 ms   (161.9 ms .. 166.0 ms)
std dev              3.517 ms   (2.925 ms .. 4.295 ms)

./cpp.out
2021-01-12T17:54:15+05:30
Running ./cpp.out
Run on (8 X 3400 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
  L4 Unified 131072 KiB (x1)
Load Average: 0.85, 0.87, 0.95
***WARNING*** CPU scaling is enabled, the benchmark real time measurements may be noisy and will incur extra overhead.
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_test           112 ms          112 ms            6
sha256sum out-hs.bin
30e2127773251e01fd0054421e12a31823a7cd138eebd8452bb5cbf3da0890d9  out-hs.bin
sha256sum out-cpp.bin
30e2127773251e01fd0054421e12a31823a7cd138eebd8452bb5cbf3da0890d9  out-cpp.bin
```

##### Spectral

- Insane speedup

```
[I] /home/bollu/work/mlir/lz/test/bench-vector/Spectral > make
ghc test.hs -O2 -fllvm -o hs.out
Loaded package environment from /home/bollu/.ghc/x86_64-linux-8.10.2/environments/default
[1 of 1] Compiling Main             ( test.hs, test.o )
You are using an unsupported version of LLVM!
Currently only 9 is supported. System LLVM version: 12.0.0
We will try though...
Linking hs.out ...
clang++ -O3 test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread
rm out-hs.bin
rm out-cpp.bin
./hs.out
benchmarking spectral ... took 96.37 s, total 56 iterations
benchmarked spectral
time                 1.755 s    (1.738 s .. 1.766 s)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 1.745 s    (1.721 s .. 1.757 s)
std dev              29.02 ms   (13.23 ms .. 45.18 ms)

./cpp.out
2021-01-12T18:44:43+05:30
Running ./cpp.out
Run on (8 X 3400 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 256 KiB (x4)
  L3 Unified 6144 KiB (x1)
  L4 Unified 131072 KiB (x1)
Load Average: 1.13, 0.99, 0.86
***WARNING*** CPU scaling is enabled, the benchmark real time measurements may be noisy and will incur extra overhead.
-----------------------------------------------------
Benchmark           Time             CPU   Iterations
-----------------------------------------------------
BM_test         0.000 ms        0.000 ms   1000000000
sha256sum out-hs.bin
6b8ee09cdf0882dd087640c6f59328616028ef298953fdd83c3645045f4d53a3  out-hs.bin
sha256sum out-cpp.bin
6b8ee09cdf0882dd087640c6f59328616028ef298953fdd83c3645045f4d53a3  out-cpp.bin
```

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

##### Am I using the library correctly?

- [I think so. To quote "controlling the timers"](https://github.com/google/benchmark#controlling-timers)
> Normally, the entire duration of the work loop (for (auto _ : state) {}) is
> measured.

