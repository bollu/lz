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
void writeArray(const char *filename, int len, T *xs) {
    FILE *fp =  fopen(filename, "wb");
    assert(fp && "unable to open file to write array");
    fwrite((void *)&len, sizeof(int), 1, fp);
    for(int i = 0; i < len; ++i) {
        fwrite(xs + i, sizeof(T), 1, fp);
    }
    fclose(fp);
}


double *test(double *us, int len) {
    double *out = new double[len];
    for(int i = 0; i < len; ++i) {
        double sum = 0;
        for(int j = 0; j < len; ++j) {
            int n = (i + j);
            int t = n*(n+1);
            int u = t >> 1;
            int r = u + (i+1);
            double uj = us[j];
            sum += 1.0 / r * uj;
        }
        out[i] = sum;
    }
    return out;
}

#define NDEBUG
#ifdef NDEBUG

void BM_test(benchmark::State& state) {
    int len;
    double *as = readArray<double>("as.bin", &len);

    for (auto _ : state) {
        benchmark::DoNotOptimize(test(as, len));
    }

    double *out = test(as, len);
    writeArray<double>("out-cpp.bin", len, out);
}

// BENCHMARK(BM_test)->Unit(benchmark::kMicrosecond);
BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

#else

int main() {
    int len;
    double *as = readArray<double>("as.bin", &len);
    double *out = test(as, len);
    writeArray<double>("out-cpp.bin", len, out);
    return 0;
}

#endif
