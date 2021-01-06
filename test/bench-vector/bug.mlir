// MLIR crashes due to the use of %lhs before its definition.
func @main(%lb: index, %ub: index, %step: index, %buffer:memref<100xf32>) {
    %init = constant 0.0 : f32
    scf.parallel (%iv) = (%lb) to (%ub) step (%step) init (%init) -> f32 {
        %elem_to_reduce = load %buffer[%iv] : memref<100xf32>
            scf.reduce(%lhs) : f32 {
                ^bb0(%lhs : f32, %rhs: f32):
                    %res = addf %lhs, %rhs : f32
                     scf.reduce.return %res : f32
            }
    }
    return
}
