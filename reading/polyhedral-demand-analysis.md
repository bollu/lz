``hs
map :: (a -> b) -> list a -> list b
map f Nil = Nil
map f (Cons x xs) = Cons (f x ) (map f xs)
```

1. linearize the data structure. For list, we have two constructors, which map to  `Nil: x -> 2*x`, `Cons: x -> 2*x+1`
2. Write map linearized:

```cpp
map (ix: int, f : (a -> b), tags: [tag], data: [Data]) {
int ix = 1;
while(!done) {
    if (tags[ix] == Nil) { return; }
    else {
        data[ix] = f(x);

    }
}
```
