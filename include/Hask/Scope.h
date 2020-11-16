#pragma once
#include <map>
#include <stdio.h>

template <typename K, typename V> class Scope {
public:
  using MapTy = std::map<K, V>;
  using iterator = typename MapTy::iterator;
  using const_iterator = typename MapTy::const_iterator;

private:
  MapTy m;

public:
  Scope() {};

  void insert(K k, V v) {
      m.insert({k, v});
  }
  void replace(K k, V v) {
      assert(m.find(k) != m.end());
      m[k] = v;
  }
  V lookupExisting(K k) {
    printf("%s:%d\n", __FILE__, __LINE__);
    auto it = m.find(k);
    printf("%s:%d\n", __FILE__, __LINE__);
    assert(it != m.end());
    if (it == m.end()) { printf("it was not found"); exit(1); }
    printf("%s:%d\n", __FILE__, __LINE__);
    return it->second;
  }

  iterator end() { return m.end(); }
  const_iterator end() const { return m.end(); }

};


