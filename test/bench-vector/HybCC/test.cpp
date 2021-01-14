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

std::vector<int> shortcut_all(std::vector<int> p) {
  std::vector<int> pp(p.size());
  bool equal = true;
  for (int i = 0; i < (int)p.size(); ++i) {
    if (p[i] != pp[i]) {
      equal = false;
    }
    pp[i] = p[p[i]];
  }
  if (equal) {
    return p;
  } else {
    return shortcut_all(pp);
  }
}

std::vector<int> enumerate(std::vector<bool> bs) {
  std::vector<int> xs;
  int sum = 0;
  for (int i = 0; i < (int)bs.size(); ++i) {
    xs.push_back(sum);
    sum += bs[i] ? 1 : 0;
  }
  return xs;
}

std::vector<bool> compute_roots(std::vector<int> p) {
  std::vector<bool> isroot;
  for (int i = 0; i < (int)p.size(); ++i) {
    isroot.push_back(p[i] == i);
  }
  return isroot;
}

std::vector<int> pack_index(std::vector<bool> bs) {
  std::vector<int> out;
  for (int i = 0; i < (int)bs.size(); ++i) {
    if (bs[i]) {
      out.push_back(i);
    }
  }
  return out;
}


std::pair<std::vector<std::pair<int, int>>, std::vector<int>>
compress(std::vector<int> p, std::vector<std::pair<int, int>> es) {
  std::vector<int> e1;
  std::vector<int> e2;
  for (int i = 0; i < (int)es.size(); ++i) {
    e1.push_back(es[i].first);
    e2.push_back(es[i].second);
  }
  std::vector<std::pair<int, int>> es_permute;
  for (int i = 0; i < (int)es.size(); ++i) {
    es_permute.push_back({p[e1[i]], p[e2[i]]});
  }
  std::vector<std::pair<int, int>> esprime;
  for (int i = 0; i < (int)es_permute.size(); ++i) {
    const int x = es_permute[i].first;
    const int y = es_permute[i].second;
    if (x != y) {
      if (x > y) {
        esprime.push_back({y, x});
      } else {
        es_permute.push_back({x, y});
      }
    }
  }
  std::vector<bool> roots = compute_roots(p);
  std::vector<int> labels = enumerate(roots);
  std::vector<int> e1prime, e2prime;
  for (int i = 0; i < (int)es.size(); ++i) {
    e1prime.push_back(esprime[i].first);
    e2prime.push_back(esprime[i].second);
  }

  // new_es = V.zip (V.backpermute labels e1') (V.backpermute labels e2')
  std::vector<std::pair<int, int>> new_es;
  for (int i = 0; i < (int)esprime.size(); ++i) {
    int l = labels[e1prime[i]];
    int r = labels[e2prime[i]];
    new_es.push_back({l, r});
  }
  return {new_es, pack_index(roots)};
}

// update <5,9,2,7> <(2,1),(0,3),(2,8)> = <3,9,8,7>
template<typename T>
std::vector<T> update(std::vector<T> xs, std::vector<std::pair<int, T>> upds) {
  for(std::pair<int, T> upd : upds) {
    xs[upd.first] = upd.second;
  }
  return xs;
}

// generate { lo <= i <= hi}
std::vector<int> enumFromTo(int lo, int hi) {
  std::vector<int> xs;
    for(int i = lo; i <= (int)hi; ++i) { xs.push_back(i); }
    return xs;
}


std::vector<int> concomp(std::vector<std::pair<int, int>> es, int n) {
  // | V.null es = V.enumFromTo 0 (n-1)
  if (es.size() == 0) {
    std::vector<int> v(n);
    for (int i = 0; i < n; ++i) {
      v.push_back(i);
    }
    return v;
  } else {
    // p = shortcut_all $ V.update (V.enumFromTo 0 (n-1)) es
    // update <5,9,2,7> <(2,1),(0,3),(2,8)> = <3,9,8,7>
    std::vector<int> p = enumFromTo(0, n - 1);
    p = update(p, es);


    // (es',i) = compress p es
    std::vector<std::pair<int, int>> esprime;
    std::vector<int> i;
    std::tie(esprime, i) = compress(p, es);
    // r = concomp es' (V.length i)
    std::vector<int> r = concomp(esprime, n);
    // ins = V.update_ p i $ V.backpermute i r
    // update_ <5,9,2,7>  <2,0,2> <1,3,8> = <3,9,8,7>
    // backpermute <a,b,c,d> <0,3,2,3,1,0> = <a,d,c,d,b,a>
    std::vector<int> ins = p;
    std::vector<int> permute_i_r;
    for (int j = 0; j < (int)r.size(); ++j) {
      permute_i_r.push_back(i[r[j]]);
    }
    for (int j = 0; j < (int)i.size(); ++j) {
      ins[i[j]] = permute_i_r[j];
    } // WTF is this doing?

    // | otherwise = V.backpermute ins ins
    std::vector<int> out(n);
    for (int j = 0; j < n; ++j) {
      out[j] = ins[ins[j]];
    }
    return out;
  }
}

std::vector<int> test(int n, std::vector<int> es1, std::vector<int> es2) {
  std::vector<std::pair<int, int>> es;
  for (int i = 0; i < (int)es1.size(); ++i) {
    es.push_back({es1[i], es2[i]});
  }
  // return concomp(es, n);
  return {};
}

void BM_test(benchmark::State &state) {
  int one;
  int *nodes = readArray<int>("nodes.bin", &one);
  assert(one == 1);
  std::vector<int> e1 = readVector<int>("edges1.bin");
  std::vector<int> e2 = readVector<int>("edges2.bin");

  for (auto _ : state) {
    test(*nodes, e1, e2);
  }

  std::vector<int> out = test(*nodes, e1, e2);
  writeVector<int>("out-cpp.bin", out);
}

BENCHMARK(BM_test)->Unit(benchmark::kMicrosecond);
// BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

