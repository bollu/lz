#define BENCH
#include <inttypes.h>
#include <benchmark/benchmark.h>
#include <stdlib.h>

// static const int useSize = 2000000;
// static const int useSeed = 42;
double *newArray(int len, unsigned short xsubi[3]) {
    double *xs= new double[len];
    for(int i = 0; i  < len;++i) {
        xs[i] = erand48(xsubi);
    }
    return xs;
}

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
void writeArray(int len, T *xs, FILE *fp) {
    fwrite((void *)&len, sizeof(int), 1, fp);
    for(int i = 0; i < len; ++i) {
        fwrite(xs + i, sizeof(T), 1, fp);
    }
}



int64_t go3(int64_t accum, int64_t i) {
    if (i == 0) { return accum; }
    else { return go3(accum+i, i -1); }
}

int64_t go2(int64_t accum, int64_t i) {
    if (i == 0) { return accum; }
    else { return go2(accum+ go3(0, i), i -1); }
}

int64_t go1(int64_t accum, int64_t i) {
    if (i == 0) { return accum; }
    else { return go1(accum+ go2(0, i), i -1); }
}

int64_t test(int64_t d) { return go1(0, d); }

void BM_test(benchmark::State& state) {
    int64_t input = 2000;

    for (auto _ : state) {
        test(input);
    }

    FILE *fp = fopen("out-cpp.bin", "wb");
    assert(fp);
    int64_t out = test(input);
    writeArray<int64_t>(1, &out, fp);
    fclose(fp);
}

BENCHMARK(BM_test)->Unit(benchmark::kMicrosecond);
// BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

