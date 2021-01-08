// RUN: hask-opt %s  --lz-lower 
// RUN: hask-opt %s  --lz-lower  --convert-scf-to-std --ptr-lower
func @prescanl(%f: (!lz.value, !lz.value) -> (!lz.value), 
               %seed: !lz.value, 
               %xs: memref<?x!lz.value>) -> memref<?x!lz.value> {
    %N = constant 1024 : index
    %out = alloc(%N) : memref<?x!lz.value>
    affine.for %i = 0 to %N step 1 
    iter_args(%accum = %seed) -> (!lz.value) {
      // affine.store %accum, %out[%i] : memref<?x!lz.value>
      %x = affine.load %xs[%i] : memref<?x!lz.value>
      %accum_cur = std.call_indirect %f (%x, %accum) 
        : (!lz.value, !lz.value) -> !lz.value
      affine.yield %accum_cur : !lz.value
    }
    return %out : memref<?x!lz.value>
}
