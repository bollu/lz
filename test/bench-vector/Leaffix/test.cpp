#define BENCH
#include <inttypes.h>
#include <benchmark/benchmark.h>
#include <stdlib.h>
#include <iostream>

template<typename T>
T *readArray(const char *path, int *len) {
    FILE *fp = fopen(path, "rb");
    assert(fp && "unable to open file");

    int val;
    fread(&val, sizeof(int), 1, fp);
    // val = ntohl(val);
    // printf("|%s| : |%d|; |", path, val); 
    *len = val;

    T *arr = new T[*len];
    for(int i = 0; i < val; ++i) {
        fread(arr+i, sizeof(T), 1, fp);
    }
    fclose(fp);
    return arr;
}

template<typename T>
void writeArray(const char *filename, int len, T *xs) {
    FILE *fp =  fopen(filename, "wb");
    assert(fp && "unable to open file to write array");
    fwrite((void *)&len, sizeof(int), 1, fp);
    for(int i = 0; i < len; ++i) {
        fwrite(xs + i, sizeof(T), 1, fp);
    }
    fclose(fp);
}

template<typename T>
void debug_print_array(const char *name, T *xs, int len) {
    std::cerr << name << " [";
    for(int i = 0; i < len; ++i) {
        std::cerr << xs[i];
        if (i + 1 < len) { std::cerr << " "; }
    }
    std::cerr << "]\n";
}

int *test(const int * __restrict__ ls, const int * __restrict__ rs, int len) {
    int *vs = new int[len*2];
    for(int  i = 0; i < len*2; ++i) { vs[i] = 0; }

    // update_: https://hackage.haskell.org/package/vector-0.12.1.2/docs/Data-Vector-Primitive.html#v:update_
    // update(src, ixs, vs) = for(i) { src[ixs[i]] = vs[i]; }
    // zs   = V.replicate (V.length ls * 2) 0
    // vs   = V.update_ zs ls xs
    for(int i = 0; i < len; ++i) { vs[ls[i]] = 1; }
    // debug_print_array("vs", vs, len*2);

    // sums = V.prescanl' (+) 0 vs
    int *sums = new int[2*len];
    int sum = 0;
    for(int i = 0; i < 2*len; ++i) {
        sums[i] = sum;
        sum += vs[i];
    }
    // debug_print_array("sums", sums, len*2);

    // backpermute: 
    // https://hackage.haskell.org/package/vector-0.12.1.2/docs/Data-Vector-Primitive.html#v:backpermute
    // V.zipWith (-) (V.backpermute sums ls) (V.backpermute sums rs)
    int *out = new int[len];
    for(int i = 0; i < len; ++i) {
        out[i] = sums[ls[i]] - sums[rs[i]];
    }
    // debug_print_array("out", out, len);
    return out;
}

void BM_test(benchmark::State& state) {
    int lenleft;
    int *lparens = readArray<int>("lparens.bin", &lenleft);
    int lenright; 
    int *rparens = readArray<int>("rparens.bin", &lenright);
    assert(lenleft == lenright);


    for (auto _ : state) {
        test(lparens, rparens, lenleft);
    }

    int *out = test(lparens, rparens, lenleft);
    writeArray<int>("out-cpp.bin", lenleft, out);
}

BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

