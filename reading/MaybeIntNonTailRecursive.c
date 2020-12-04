#include <stdio.h>
/*
{-# LANGUAGE MagicHash #-}
module GHCMaybeIntNonTailRecursive(main) where
import GHC.Int
import GHC.Prim
data MaybeHash = JustHash Int# | NothingHash deriving(Show)

f :: MaybeHash -> MaybeHash
f mi = case mi of
        JustHash i# -> 
               case i# of
                 0# -> JustHash 5#
                 _ -> case f (JustHash (i# -# 1#)) of
                      NothingHash -> NothingHash
                      JustHash j# -> JustHash (j# +# 7#)
        NothingHash -> NothingHash

main :: IO ()
main = print (f (JustHash 100#))
*/

typedef struct { enum {Just, Nothing } tag; int val; } MaybeHash;
MaybeHash nothing() { MaybeHash m; m.tag = Nothing; m.val = 42; return m; }
MaybeHash just(int i) { MaybeHash m; m.tag = Just; m.val = i; return m; }
// f[tag, justVal] 
// f[tag, justVal] =defn= { (0, 0) : tag = 0 }
//                 =defn= { 7 + f (justVal - 1), 1 : tag = 1 }
// linalg.genericOp<>
// isl_map_power()
MaybeHash f(MaybeHash mi) {
    if (mi.tag == Just) {
        if (mi.val == 0) { return just(5);  }
        else {
            MaybeHash rec = f(just(mi.val - 1));;
            if (rec.tag == Nothing) { return nothing(); }
            else { return just(rec.val + 7); }
        }
    } else { return nothing(); }
}

// 7 * 5 = 5
int main() { 
    MaybeHash mi = f(just(5));
    printf("tag: %d | value: %d\n", mi.tag, mi.val); 
    return 0;
}
