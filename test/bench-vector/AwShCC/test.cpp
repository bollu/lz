#define BENCH
#include <benchmark/benchmark.h>
#include <inttypes.h>
#include <stdlib.h>
#include <vector>

// static const int useSize = 2000000;
// static const int useSeed = 42;
double *newArray(int len, unsigned short xsubi[3]) {
  double *xs = new double[len];
  for (int i = 0; i < len; ++i) {
    xs[i] = erand48(xsubi);
  }
  return xs;
}

template <typename T> T *readArray(const char *path, int *len) {
  FILE *fp = fopen(path, "rb");
  assert(fp && "unable to open file");

  int val;
  fread(&val, sizeof(int), 1, fp);
  // val = ntohl(val);
  // printf("|%s| : |%d|; |", path, val);
  *len = val;

  T *arr = new T[*len];
  for (int i = 0; i < val; ++i) {
    fread(arr + i, sizeof(T), 1, fp);
  }
  fclose(fp);
  return arr;
}

template <typename T> std::vector<T> readVector(const char *filename) {
  int len;
  T *out = readArray<T>(filename, &len);
  std::vector<T> arr(len);
  for (int i = 0; i < len; ++i) {
    arr[i] = out[i];
  }
  return arr;
}

template <typename T> void writeArray(const char *filename, int len, T *xs) {
  FILE *fp = fopen(filename, "wb");
  assert(fp && "unable to open file to write array");
  fwrite((void *)&len, sizeof(int), 1, fp);
  for (int i = 0; i < len; ++i) {
    fwrite(xs + i, sizeof(T), 1, fp);
  }
  fclose(fp);
}

template <typename T>
void writeVector(const char *filename, std::vector<T> &xs) {
  writeArray(filename, xs.size(), xs.data());
}

template <typename T>
std::vector<T> backpermute(std::vector<T> xs, std::vector<int> ixs) {
  std::vector<T> out;
  for (int ix : ixs) {
    out.push_back(xs[ix]);
  }
  return out;
}

// update <5,9,2,7> <(2,1),(0,3),(2,8)> = <3,9,8,7>
template <typename T>
std::vector<T> update(std::vector<T> base,
                      std::vector<std::pair<int, T>> ixsvals) {
  for (int i = 0; i < (int)ixsvals.size(); ++i) {
    base[ixsvals[i].first] = ixsvals[i].second;
  }
  return base;
}

template <typename T>
std::vector<T> update(std::vector<T> base, std::vector<int> ixs,
                      std::vector<T> newvals) {
  assert(ixs.size() == newvals.size());
  for (int i = 0; i < (int)ixs.size(); ++i) {
    base[ixs[i]] = newvals[i];
  }
}

// starCheck :: Vector Int -> Vector Bool
// starCheck ds = V.backpermute st' gs
//   where
//     gs  = V.backpermute ds ds
//     st  = V.zipWith (==) ds gs
//     st' = V.update st . V.filter (not . snd)
//                       $ V.zip gs st
std::vector<bool> starCheck(std::vector<int> ds) {
  std::vector<bool> st;
  std::vector<int> gs;
  for (int i = 0; i < (int)ds.size(); ++i) {
    gs.push_back(ds[ds[i]]);
    st.push_back(ds[i] == gs[i]);
  }

  std::vector<bool> stprime = st;
  for (int i = 0; i < (int)st.size(); ++i) {
    if (!st[i]) {
      stprime[gs[i]] = st[i];
    }
  }

  // backpermute <a,b,c,d> <0,3,2,3,1,0> = <a,d,c,d,b,a>
  // V.backpermute st' gs.
  std::vector<bool> out;
  for (int i = 0; i < (int)gs.size(); ++i) {
    out.push_back(stprime[gs[i]]);
  }
  return out;
}

bool and_(std::vector<bool> bs) {
  for (bool b : bs) {
    if (!b) {
      return false;
    }
  }
  return true;
}
// concomp :: Vector Int -> Vector Int -> Vector Int -> Vector Int
std::vector<int> concomp(std::vector<int> ds, std::vector<int> es1,
                         std::vector<int> es2) {
  std::vector<std::pair<int, int>> upd1;
  for (int i = 0; i < (int)es1.size(); ++i) {
    int di = ds[es1[i]];
    int dj = ds[es2[i]];
    int gi = ds[ds[es1[i]]];
    if (gi == di && di > dj) {
      upd1.push_back({di, dj});
    }
  }

  std::vector<int> dsprime = update(ds, upd1);
  std::vector<bool> dsstar = starCheck(dsprime);
  std::vector<std::pair<int, int>> upd2;
  for (int i = 0; i < (int)es1.size(); ++i) {
    int di = dsprime[es1[i]];
    int dj = dsprime[es2[i]];
    bool st = dsstar[es1[i]];
    if (st && di != dj) {
      upd1.push_back({di, dj});
    }
  }
  //     | V.and (starCheck ds'') = ds''
  std::vector<int> dsprimeprime = update(dsprime, upd2);
  if (and_(starCheck(dsprimeprime))) {
    return dsprimeprime;
  }
  // | otherwise              = concomp (V.backpermute ds'' ds'') es1 es2
  return concomp(backpermute(dsprimeprime, dsprimeprime), es1, es2);
}

std::vector<int> test(int n, std::vector<int> es1, std::vector<int> es2) {
  std::vector<int> ds;
  for (int i = 0; i < n; ++i) {
    ds.push_back(i);
  }
  for (int i = 0; i < n; ++i) {
    ds.push_back(i);
  }
  std::vector<int> es1prime;
  for (int e : es1) {
    es1prime.push_back(e);
  }
  for (int e : es2) {
    es1prime.push_back(e);
  }

  std::vector<int> es2prime;
  for (int e : es1) {
    es2prime.push_back(e);
  }
  for (int e : es2) {
    es2prime.push_back(e);
  }

  return concomp(ds, es2prime, es2prime);
}

void BM_test(benchmark::State &state) {
  int one;
  int *nodes = readArray<int>("nodes.bin", &one);
  assert(one == 1);
  std::vector<int> edges1 = readVector<int>("edges1.bin");
  std::vector<int> edges2 = readVector<int>("edges2.bin");

  for (auto _ : state) {
    test(*nodes, edges1, edges2);
  }

  std::vector<int> out = test(*nodes, edges1, edges2);
  writeVector<int>("out-cpp.bin", out);
}

BENCHMARK(BM_test)->Unit(benchmark::kMicrosecond);
// BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

