#include <benchmark/benchmark.h>
#include <stdlib.h>
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
    for(int i = 0; i < len; ++i) {
        out[i] = state_scanr;
        state_scanr = scanl[i].ds[1] - scanl[i].ds[0]*state_scanr;
    }
}


static const int useSize = 2000000;
static const int useSeed = 42;
double *newArray(int len, unsigned short xsubi[3]) {
    double *xs= new double[len];
    for(int i = 0; i  < len;++i) {
        xs[i] = erand48(xsubi);
    }
    return xs;
}
void BM_tridiag(benchmark::State& state) {
    unsigned short xsubi[3];
    xsubi[0] = xsubi[1] = 0;
    xsubi[2] = useSeed;

    double *as = newArray(useSize, xsubi);
    double *bs = newArray(useSize, xsubi);
    double *cs = newArray(useSize, xsubi);
    double *ds = newArray(useSize, xsubi);
    double *out = new double[useSize];

    for (auto _ : state) {
        tridiag(as, bs, cs, ds, out, useSize);
    }
}

BENCHMARK(BM_tridiag)->Unit(benchmark::kMicrosecond);
// BENCHMARK(BM_tridiag)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();
