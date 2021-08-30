
- (2 EXAMPLES) In reference counting, each heap-allocated value contains a reference count. We view this counter as a collection of tokens. The inc instruction creates a new token and dec consumes it. When a function takes an argument as an owned reference, it is responsible for consuming one of its tokens. The function may consume the owned reference not only by using the dec instruction, but also by storing it in a newly allocated heap value, returning it, or passing it to another function that takes an owned reference

- Invariant: at the end of a function, the reference counter must be bumped as many times an argument is used.
- Invariant: at the beginning of a function, every value has counter `+1`. [OWNERSHIP]

```
id x = return x -- [x: implicit (1) = 1 use]
mkpair x = inc x; return  (x, x) -- consumes twice; one increment [x: implicit(1) + explicit(1) = 2 use]
fst x y = dec y; return x -- one increment [x: implicit (+1) = +1 use] [y: implicit(1) + explicit(-1) = 0 use]
```


- Invariant: at the end of a function, the reference counter must be bumped as many times an argument is used.
- Invariant: at the beginning of a function, every value has counter `+0`. [BORROWING]

Example of difference:

```lean
isNilXsOwned xs = case xs of
 (Nil → dec xs; ret true) [implicit(1) + explicit(-1) = 0 use]
 (Cons → dec xs; ret false) [implicit(1) + explicit(-1) = 0 use]
```

```lean
isNilXsBorrowed xs = case xs of
 (Nil → ret true) [implicit(0) = 0 use]
 (Cons → ret false) [implicit(0) = 0 use]
```
