#define BENCH
#include <inttypes.h>
#include <benchmark/benchmark.h>
#include <stdlib.h>
#include <vector>

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

std::vector<int> shortcut_all(std::vector<int> p) {
    std::vector<int> pp(p.size());
    bool equal = true;
    for(int i = 0; i < p.size(); ++i) {
        if(p[i] != pp[i]) { equal = false; }
        pp[i] = p[p[i]];
    }
    if (equal) { return p; }
    else { return shortcut_all(pp); }
}

std::vector<int> compress(std::vector<int>p, std::vector<std::pair<int, int>> es) {
    
}

std::vector<int> concomp(std::vector<std::pair<int, int>> es, int n) {
    if (es.size() == 0) {
        std::vector<int> v(n);
        for(int i = 0; i < n; ++i) { v.push_back(i); }
        return v;
    } else {
        std::vector<int> out(n);
        for(int i = 0; i < n; ++i) {
            out[i] = ins[ins[i]];
        }
        return out;
    }
}

std::vector<int> test(int n, std::vector<int> es1, std::vector<int> es2) {

}

void BM_test(benchmark::State& state) {
    int one;
    int *nodes = readArray<int>("nodes.bin",  &one);
    assert(one == 1);
    int les1, les2;
    int *edges1 = readArray<int>("edges1.bin", &les1);
    int *edges2 = readArray<int>("edges2.bin", &les2);

    for (auto _ : state) {
        test(*nodes, edges1, edges2, les1, les2);
    }

    int *out = test(*nodes, edges1, edges2, les1, les2);
    writeArray<int>("out-cpp.bin", *nodes, out);
}

BENCHMARK(BM_test)->Unit(benchmark::kMicrosecond);
// BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

