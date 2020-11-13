#pragma once
#include <map>


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
  V &lookupExisting(K k) {
    auto it = m.find(k);
    assert(it != m.end());
    return it->second;
  }

  iterator end() { return m.end(); }
  const_iterator end() const { return m.end(); }

};


