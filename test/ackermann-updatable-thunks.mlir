module {
  //A(0, n) = n + 1
  //A(m, 0) = A(m-1, 1)
  //A(m, n) = A(m-1, A(m, n-1))
  func @ackermann (%m: i64, %n: i64) -> i64 {
    %o = constant 1 : i64
    %z = constant 0 : i64
    %m0 = std.cmpi "eq", %m, %z : i64
    cond_br %m0, ^bb1, ^bb2
    ^bb1:
      %nincr = std.addi %n, %o : i64
      std.return %nincr : i64 
    ^bb2:
      %mdec = std.subi %m, %o : i64
      %n0 = std.cmpi "eq", %n, %z : i64
      cond_br %n0, ^bb3, ^bb4
        ^bb3:
          // rec2 = A(m-1, 1)
          %rec2 = std.call @ackermann (%mdec, %o) : (i64, i64) -> i64
          std.return %rec2 : i64
        ^bb4:
          // rec3 = (m, n-1)
          %ndec = std.subi %n, %o : i64
          %rec3 = std.call @ackermann (%m, %ndec) : (i64, i64) -> i64
          %rec4 = std.call @ackermann (%mdec, %rec3) : (i64, i64) -> i64
          std.return %rec4 : i64
  }

  // Mimic the memref API: https://mlir.llvm.org/docs/Dialects/Standard/#stdget_global_memref-getglobalmemrefop
  // globals that are thunks must be updated after evaluation.
  //  [if we dont care about the update, then we can simply represent as 
  //   ack22: () -> i64]
  // Q1: how to represent that this global should /shoulnt be updated?
  lz.global @ack22 : !lz.thunk<i64> {
    %two = constant 2 : i64
    %ack = constant @ackermann  : (i64, i64) -> i64
    %out = std.call(%ack, %two, %two) : (i64, i64) -> i64
    lz.return %out : i64
  }

  func @main () -> i64 {
    %tx = lz.getglobal @ack22() : !lz.thunk<i64>
    %ty = lz.getglobal @ack22() : !lz.thunk<i64> 
    %x = lz.force(%tx): i64
    %y = lz.force(%ty): i64

    %z = addi %x,  %y : i64
    return %z : i64
  }
}                                                                i64
