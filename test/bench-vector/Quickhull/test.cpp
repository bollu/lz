#define BENCH
#include <benchmark/benchmark.h>
#include <inttypes.h>
#include <stdlib.h>
#include <utility>
#include <vector>
#include<iostream>

using pt = std::pair<double, double>;

std::ostream &operator << (std::ostream & o, const std::pair<double, double> &p) {
  return o << "(" << p.first << " " << p.second << ")";
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


template<typename T>
void debugPrintVector(const char *name, const std::vector<T> &xs) {
  return;
  std::cerr << name;
  std::cerr << ": [";
  for(int i = 0; i < xs.size(); ++i) {
    std::cerr << xs[i];
    if (i + 1  < xs.size()) { std::cerr << " "; }
  }
  std::cerr << "]";
  std::cerr << "\n";
}


double cross(pt xy, pt xy1, pt xy2)  {
  // (x,y) (x1,y1) (x2,y2) = (x1-x)*(y2-y) - (y1-y)*(x2-x)
  return  (xy1.first - xy.first)*(xy2.second - xy.second) - (xy1.second - xy.second)*(xy2.first - xy.first);
}


template<typename T>
std::vector<T> cons(T t, std::vector<T> ts) {
  std::vector<T> out;
  out.push_back(t);
  out.insert(out.end(), ts.begin(), ts.end());
  return out;
}

template<typename T>
std::vector<T> append(std::vector<T> l, std::vector<T> r) {
  std::vector<T> out;
  for(T &t : l) { out.push_back(t); }
  for(T &t : r) { out.push_back(t); }
  return out;
}


std::vector<pt> hsplit(std::vector<pt> points, const pt p1, const pt p2) {
  if (false) {
    std::cerr << "\n====\n";
    debugPrintVector("points", points);
    std::cerr <<  "p1: " <<  p1 << "\n";
    std::cerr <<  "p2: " <<  p2 << "\n";
  }
  
  // cs     = V.map (\p -> cross p p1 p2) points
  std::vector<double> cs(points.size());
  for(int i = 0; i < (int)points.size(); ++i) {
    cs[i] = cross(points[i], p1, p2);
  }
  debugPrintVector("cs", cs);

  // packed = V.map fst
  //        $ V.filter (\t -> snd t > 0)
  //        $ V.zip points cs
  std::vector<pt> packed;
  for(int i = 0; i < (int)points.size(); ++i) {
    if (cs[i] > 0) {
      packed.push_back(points[i]);
    }
  }

  debugPrintVector("packed", packed);

  // hsplit points p1 p2
  // | V.length packed < 2 = p1 `V.cons` packed
  // | otherwise = hsplit packed p1 pm V.++ hsplit packed pm p2
  if (packed.size() < 2) {
    // TODO: make this faster. who uses `cons`?!
    std::vector<pt> consout = cons(p1, packed);
    debugPrintVector("$quickhull.cons$", consout);
    return consout;
  } else {
    // pm = points V.! V.maxIndex cs
    pt pm = points[0];
    double bestc = cs[0];
    for(int i = 1; i < points.size(); ++i) {
        if(cs[i] > bestc) {
          pm = points[i]; bestc = cs[i];
        }
    }

    // hsplit packed p1 pm V.++ hsplit packed pm p2
    std::vector<pt> l = hsplit(packed, p1, pm);
    std::vector<pt> r = hsplit(packed, pm, p2);
    debugPrintVector("l", packed);
    debugPrintVector("r", packed);
    std::vector<pt> appendout =  append(l, r);
    debugPrintVector("$quickhull.append$", appendout);
    return appendout;

  }



}
std::pair<std::vector<double>, std::vector<double>>
quickhull(std::vector<double> xs, std::vector<double> ys) {
  // imin = V.minIndex xs
  // imax = V.maxIndex xs
  // pmin   = points V.! imin
  // pmax   = points V.! imax
  // points = V.zip xs ys
  pt pmin = {xs[0], ys[0]}; pt pmax = {xs[0], ys[0]};    
  std::vector<pt> points;
  for(int i =  0; i < xs.size(); ++i) {
    pt p = { xs[i], ys[i] };
    if (p.first < pmin.first) { pmin = p;  }
    if (p.first > pmax.first) { pmax = p;  }
    points.push_back(p);
  }
  // (xs',ys') = V.unzip $ hsplit points pmin pmax V.++ hsplit points pmax pmin
  std::vector<pt> l, r;
  l = hsplit(points, pmin, pmax);
  r = hsplit(points, pmax, pmin);
  std::vector<pt> out = append(l, r);

  std::pair<std::vector<double>, std::vector<double>> outunzip;
  for(int i = 0; i < out.size(); ++i) {
    outunzip.first.push_back(out[i].first);
    outunzip.second.push_back(out[i].second);
  }
  return outunzip;
}


#define NDEBUG
#ifdef NDEBUG

void BM_test(benchmark::State &state) {
  int64_t input = 2000;

  std::vector<double> as = readVector<double>("as.bin");
  std::vector<double> bs = readVector<double>("bs.bin");
  assert(as.size() == bs.size());

  for (auto _ : state) {
    quickhull(as, bs);
  }
  std::vector<double> outxs, outys;
  debugPrintVector("as", as);
  debugPrintVector("bs", bs);
  std::tie(outxs, outys) = quickhull(as, bs);

  std::vector<double> out;
  out.insert(out.end(), outxs.begin(), outxs.end());
  out.insert(out.end(), outys.begin(), outys.end());
  debugPrintVector("out", out);
  writeVector<double>("out-cpp.bin", out);
}

BENCHMARK(BM_test)->Unit(benchmark::kMillisecond);
// Run the benchmark
BENCHMARK_MAIN();

#else //no (NDEBUG) = debug

int main(int argc, char **argv) {

  std::vector<double> as = readVector<double>("as.bin");
  std::vector<double> bs = readVector<double>("bs.bin");
  assert(as.size() == bs.size());
  debugPrintVector("as", as);
  debugPrintVector("bs", bs);

  std::vector<double> outl, outr;
  std::tie(outl, outr) = quickhull(as, bs);

  std::vector<double> out;
  out.insert(out.end(), outl.begin(), outl.end());
  out.insert(out.end(), outr.begin(), outr.end());
  debugPrintVector("outl", out);
  debugPrintVector("outr", out);
  debugPrintVector("out", out);
  writeVector<double>("out-cpp.bin", out);
  return 0;
}


#endif // benchmark
