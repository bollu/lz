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

##### FindIndexR
##### HybCC
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


