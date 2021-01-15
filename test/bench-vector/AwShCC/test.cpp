#define BENCH
#include <benchmark/benchmark.h>
#include <inttypes.h>
#include <iostream>
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
  if (!fp) {
    std::cerr << "unable to open |" << path << "|\n";
  }
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
// backpermute <a,b,c,d> <0,3,2,3,1,0> = <a,d,c,d,b,a>
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
  return base;
}

// starCheck :: Vector Int -> Vector Bool
// starCheck ds = V.backpermute st' gs
//   where
//     gs  = V.backpermute ds ds
//     st  = V.zipWith (==) ds gs
//     st' = V.update st . V.filter (not . snd)
//                       $ V.zip gs st
std::vector<bool> starCheck(std::vector<int> ds) {
  std::vector<int> gs = backpermute(ds, ds);
  std::vector<bool> st;
  for (int i = 0; i < (int)ds.size(); ++i) {
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
  return backpermute(stprime, gs);
}

bool and_(std::vector<bool> bs) {
  for (bool b : bs) {
    if (!b) {
      return false;
    }
  }
  return true;
}

template<class T, class U>
std::ostream & operator << (std::ostream &o, std::pair<T, U> p) {
 return o << "(" << p.first << ", " << p.second << ")";
}

template<typename T>
void printVector(std::string s, const std::vector<T> &ts) {
    std::cerr << s << ": ";
    std::cerr << "[";
    for(auto t : ts) { std::cerr << t << " "; }
    std::cerr << "]\n";
}

// concomp :: Vector Int -> Vector Int -> Vector Int -> Vector Int
std::vector<int> concomp(std::vector<int> ds, std::vector<int> es1,
                         std::vector<int> es2) {
  // printVector("ds", ds);
  // printVector("es1", es1);
  // printVector("es2", es2);
  // ds'  = V.update ds
  //      . V.map (\(di, dj, gi) -> (di, dj))
  //      . V.filter (\(di, dj, gi) -> gi == di && di > dj)
  //      $ V.zip3 (V.backpermute ds es1)
  //               (V.backpermute ds es2)
  //               (V.backpermute ds (V.backpermute ds es1))
  //               ----
  std::vector<std::pair<int, int>> upd1;
  std::vector<int> ds_back_es1 = backpermute(ds, es1);
  std::vector<int> ds_back_es2 = backpermute(ds, es2);
  std::vector<int> ds_back_ds_back_es1 = backpermute(ds, ds_back_es1);

  for (int i = 0; i < (int)es1.size(); ++i) {
    int di = ds_back_es1[i];
    int dj = ds_back_es2[i];
    int gi = ds_back_ds_back_es1[i];
    if (gi == di && di > dj) {
      upd1.push_back({di, dj});
    }
  }
  // printVector("upd1", upd1);
  std::vector<int> dsprime = update(ds, upd1);
  // printVector("ds'", dsprime);

  // ds'' = V.update ds'
  //      . V.map (\(di, dj, st) -> (di, dj))
  //      . V.filter (\(di, dj, st) -> st && di /= dj)
  //      $ V.zip3 (V.backpermute ds' es1)
  //               (V.backpermute ds' es2)
  //               (V.backpermute (starCheck ds') es1)
  // ---
  //               (V.backpermute (starCheck ds') es1)
  std::vector<bool> dsstar = starCheck(dsprime);
  std::vector<std::pair<int, int>> upd2;
  for (int i = 0; i < (int)es1.size(); ++i) {
    int di = dsprime[es1[i]];
    int dj = dsprime[es2[i]];
    bool st = dsstar[es1[i]];
    if (st && di != dj) {
      upd2.push_back({di, dj});
    }
  }
  // | V.and (starCheck ds'') = ds''
  std::vector<int> dsprimeprime = update(dsprime, upd2);
  if (and_(starCheck(dsprimeprime))) {
    return dsprimeprime;
  } else {
    // | otherwise = concomp (V.backpermute ds'' ds'') es1 es2
    return concomp(backpermute(dsprimeprime, dsprimeprime), es1, es2);
  }
}

std::vector<int> test(int n, std::vector<int> es1, std::vector<int> es2) {
  // ds = V.enumFromTo 0 (n-1) V.++ V.enumFromTo 0 (n-1)
  std::vector<int> ds;
  for (int i = 0; i < n; ++i) {
    ds.push_back(i);
  }
  for (int i = 0; i < n; ++i) {
    ds.push_back(i);
  }
  // es1' = es1 V.++ es2
  std::vector<int> es1prime;
  for (int e : es1) {
    es1prime.push_back(e);
  }
  for (int e : es2) {
    es1prime.push_back(e);
  }

  // es2' = es2 V.++ es1
  std::vector<int> es2prime;
  for (int e : es2) {
    es2prime.push_back(e);
  }
  for (int e : es1) {
    es2prime.push_back(e);
  }

  return concomp(ds, es1prime, es2prime);
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

// BENCHMARK(BM_test)->Unit(benchmark::kMicrosecond);
BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

