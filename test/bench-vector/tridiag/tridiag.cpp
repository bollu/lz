#define BENCH
#include <inttypes.h>
#include <benchmark/benchmark.h>
#include <stdlib.h>
#include <arpa/inet.h>

typedef struct { double ds[2]; } pair;
typedef struct { double ds[4]; } quad;

void tridiag(const double *__restrict__ as, 
        const double * __restrict__ bs, 
        const double *__restrict__ cs, 
        const double * __restrict__ ds, 
        double * __restrict__ out, 
        const int len) {
    pair *scanl = new pair[len];
    // state of prescanl
    double state_scanl[2];
    for(int i = 0; i < len; ++i) {
        // c' = stated
        // d' = stated
        scanl[i].ds[0] = state_scanl[0];
        scanl[i].ds[1] = state_scanl[1];

        double id = 1/ (bs[i] - state_scanl[0]*as[i]);
        double newd[2];
        newd[0] =  cs[i] * id; 
        newd[1] =  (ds[i] - state_scanl[1] * as[i]) * id;
        state_scanl[0] = newd[0];
        state_scanl[1] = newd[1];
    }

    double state_scanr = 0;
    for(int i = len-1; i >=0; i--) {
        out[i] = state_scanr;
        state_scanr = scanl[i].ds[1] - scanl[i].ds[0]*state_scanr;
    }
}


// static const int useSize = 2000000;
// static const int useSeed = 42;
double *newArray(int len, unsigned short xsubi[3]) {
    double *xs= new double[len];
    for(int i = 0; i  < len;++i) {
        xs[i] = erand48(xsubi);
    }
    return xs;
}

double *readArray(const char *path, int *len) {
    FILE *fp = fopen(path, "rb");
    assert(fp && "unable to open file");

    int val;
    fread(&val, sizeof(int), 1, fp);
    // val = ntohl(val);
    // printf("|%s| : |%d|; |", path, val); 
    *len = val;

    double *arr = new double[*len];
    for(int i = 0; i < val; ++i) {
        double d;
        fread(&d, sizeof(double), 1, fp);
        arr[i] = d;
        // printf("%lf ", d);
    }
    // printf("|\n");
    fclose(fp);
    return arr;
}

void writeArray(int len, double *xs, FILE *fp) {
    fwrite((void *)&len, sizeof(int), 1, fp);
    for(int i = 0; i < len; ++i) {
        fwrite(xs + i, sizeof(double), 1, fp);
    }
}

#ifdef BENCH

void BM_tridiag(benchmark::State& state) {
    int lenas = 0;
    double *as = readArray("tridiag-as.bin", &lenas);

    int lenbs = 0;
    double *bs = readArray("tridiag-bs.bin", &lenbs);
    assert(lenbs == lenas);


    int lencs = 0;
    double *cs = readArray("tridiag-cs.bin", &lencs);
    assert(lencs == lenas);

    int lends = 0;
    double *ds = readArray("tridiag-ds.bin", &lends);
    assert(lends == lenas);

    double *out  = new double[lenas];

    for (auto _ : state) {
        tridiag(as, bs, cs, ds, out, lenas);
    }

    FILE *fp = fopen("tridiag-out-cpp.bin", "wb");
    tridiag(as, bs, cs, ds, out, lenas);
    writeArray(lenas, out, fp);
    fclose(fp);
}

// BENCHMARK(BM_tridiag)->Unit(benchmark::kMicrosecond);
BENCHMARK(BM_tridiag)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

#else

int main() {
    int lenas = 0;
    double *as = readArray("tridiag-as.bin", &lenas);

    int lenbs = 0;
    double *bs = readArray("tridiag-bs.bin", &lenbs);
    assert(lenbs == lenas);


    int lencs = 0;
    double *cs = readArray("tridiag-cs.bin", &lencs);
    assert(lencs == lenas);

    int lends = 0;
    double *ds = readArray("tridiag-ds.bin", &lends);
    assert(lends == lenas);

    double *out  = new double[lenas];

    tridiag(as, bs, cs, ds, out, lenas);

    FILE *fp = fopen("tridiag-out-cpp.bin", "wb");
    writeArray(lenas, out, fp);
    fclose(fp);
}

#endif
