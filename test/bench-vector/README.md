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

##### closed-form-gauss

compute closed form for sum of `1...n` added to itself `n^2` times.

