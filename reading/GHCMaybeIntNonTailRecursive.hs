{-# LANGUAGE MagicHash #-}
{-# LANGUAGE BangPatterns #-}
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
