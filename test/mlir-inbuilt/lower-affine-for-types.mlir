spv.func @main(%input: !spv.ptr<i32, Function>) "None" {
    %c1024 = constant 1024 : index
    %1 = affine.for %arg3 = 0 to %c1024 iter_args(%arg = %input) -> (!spv.ptr<i32, Function>) {
        affine.yield %arg : !spv.ptr<i32, Function>
    }
    spv.Return
}

