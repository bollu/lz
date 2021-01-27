# collection of demand analysis programs
- GHC demand wiki
```
f c p = case p 
          of (a, b) -> if c 
                       then (a, True) 
                       else (True, False)
```


- [Demand JFP draft --- 2.1 The worker-wrapper split in GHC](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/03/demand-jfp-draft.pdf)
```
f ::(Int,Int) → Int
f p = (case p of (a,b) → a) +1
```


```
let x = 42
in let y = x+y
in (y,1)
```
- Projections for demand analysis


# Projections for demand analysis

```
nil :: [a] -> [a]
nil [] = []
nil (x:xs) = error "err"
```

```
cons :: [a] -> [a]
cons [] = error "err"
cons (a:as) = a:as
```

```
length :: [a] -> a
legnth [] = 0
legnth (x:xs) = 1+length xs
```

```
before ::
before = 
```

```
doubles ::
doubles = 
```
```
append ::
append = 
```


```
reverse ::
reverse = 
```


