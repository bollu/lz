func @prescanl(%f: (!lz.value) -> (!lz.value), %seed: !lz.value) {
    %N = constant 1024 : index
    affine.for %i = 0 to %N step 1 iter_args(%accum = %seed) -> (!lz.value) {
      %accum_cur = std.call_indirect %f (%accum) : (!lz.value) -> !lz.value
      affine.yield %accum_cur : !lz.value
    }
    return 
}

