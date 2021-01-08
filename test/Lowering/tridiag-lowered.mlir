module  {
  func @prescanl(%arg0: (!ptr.void) -> !ptr.void, %arg1: !ptr.void) {
    %c1024 = constant 1024 : index
    %0 = affine.for %arg2 = 0 to 1024 iter_args(%arg3 = %arg1) -> (!ptr.void) {
      %1 = call_indirect %arg0(%arg3) : (!ptr.void) -> !ptr.void
      affine.yield %arg1 : !ptr.void
    }
    return
  }
}

