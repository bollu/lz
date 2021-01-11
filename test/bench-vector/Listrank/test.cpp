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


int *pointer_jump(int *pt, int *val, int len) {
    int *npt = new int[len];
    for(int i = 0; i < len; ++i) {
        npt[i] = pt[pt[i]];
    }

    bool equal = true;
    for(int i = 0; i < len; ++i) {
        if (npt[i] != pt[i]) {
            equal = false;
            break;
        }
    }

    if (equal) {
        return val;
    } else {
        int *valAtPt = new int[len];
        for(int i = 0; i < len; ++i) { valAtPt[i] = val[pt[i]]; }
        
        int *nval = new int[len];
        for(int i = 0; i < len; ++i) { nval[i] = val[i] + valAtPt[i]; }
        return pointer_jump(npt, nval, len);
    };
}
int *test(int n) {
    int *xs = new int[n];
    xs[0] = 0;
    for(int i = 0; i < n-1; ++i) { xs[i+1] = i; }
    // debug_print_array("xs", xs, n);
    
    // vvv wat? wat wat wat?
    // val = V.zipWith (\i j -> if i == j then 0 else 1)
    //                 xs (V.enumFromTo 0 (n-1))
    int *vs = new int[n];
    for(int i = 0; i < n; ++i) {
        if (xs[i] == i) {
            vs[i] = 0;
        } else {
            vs[i] = 1;
        }
    }
    // debug_print_array("vs", vs, n);
    return pointer_jump(xs, vs, n);
}

void BM_test(benchmark::State& state) {
    int len;
    int *useSize = readArray<int>("useSize.bin", &len);
    assert(len == 1 && "expected len variable to be use size");

    for (auto _ : state) {
        test(*useSize);
    }

    int *out = test(*useSize);
    writeArray<int>("out-cpp.bin", *useSize, out);
}

BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

