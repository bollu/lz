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

int *starCheck(int *ds, int lds) {
    int *gs = new int[lds];
    // gs  = V.backpermute ds ds
    for(int i = 0; i < lds; ++i) {
        gs[i] = ds[ds[i]];
    }
    // st  = V.zipWith (==) ds gs
    int *st = new int[lds];
    for(int i = 0; i < lds; ++i) {
        st[i] = ds[i] == gs[i];
    }
    // st' = V.update st . V.filter (not . snd) $ V.zip gs st
    int *stt = new int[lds];
    for(int i = 0; i < lds; ++i) {
        stt[i] = st[i];
        if (!st[i]) { stt[gs[i]] = st[i]; }
    }

    // starCheck ds = V.backpermute st' gs
    int *out = new int[lds];
    for(int i = 0; i < lds; ++i) {
        out[i] = stt[gs[i]];
    }
    return out;

}

int *concomp(int *ds, int lds, int *es1, int *es2, int les1, int les2) {
    int *dss = new int[lds];
    int *bp_ds_es1 = new int[lds];
    int *bp_ds_es2 = new int[lds];

    int *dsss = new int[lds];
    int *bp_dss_es1 = new int[lds];
    int *bp_dss_es2 = new int[lds];
    int *star = starCheck(dsss, lds);

    // V.and (starCheck ds'') = ds''
    int istrue = true;
    for(int i = 0; i < lds; ++i) {
        if (!star[i]) { istrue = false; break; }
    }
    if(istrue) { return dsss; }
    // concomp (V.backpermute ds'' ds'') es1 es2 
    int *backpermute_dsss = new int[lds];
    for(int i = 0; i < lds; ++i) {
        backpermute_dsss[i] = dsss[dsss[i]];
    }
    return concomp(backpermute_dsss, lds, es1, es2, les1, les2);
}

int *test(int n, int *es1, int *es2, int les1, int les2) {
    // ds = V.enumFromTo 0 (n-1) V.++ V.enumFromTo 0 (n-1)
    int *ds = new int[2*n];
    for(int i = 0; i <n; ++i) { ds[i] = i; }
    for(int i = 0; i <n; ++i) { ds[n+i] = i; }

    // es1' = es1 V.++ es2
    int *es11 = new int[les1 + les2];
    for(int i = 0; i < les1; ++i) { es11[i] = es1[i]; }
    for(int i = 0; i < les2; ++i) { es11[i] = es2[les1+i]; }
    // es2' = es2 V.++ es1
    int *es22 = new int[les1 + les2];
    for(int i = 0; i < les2; ++i) { es22[i] = es2[i]; }
    for(int i = 0; i < les2; ++i) { es22[i] = es1[les2+i]; }

    // awshcc (n, es1, es2) = concomp ds es1' es2'
    return concomp(ds, 2*n, es11, es22, les1+les2, les1+les2);
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

