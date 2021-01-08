// RUN: hask-opt --lz-lower %s
func @main(%input: !lz.value) {
    %c1024 = constant 1024 : index
    %1 = affine.for %arg3 = 0 to %c1024 iter_args(%arg = %input) -> (!lz.value) {
        affine.yield %arg : !lz.value
    }
    return
}

