// RUN: hask-opt %s  -lz-interpret | FileCheck %s
// RUN: hask-opt %s  | hask-opt -lz-interpret |  FileCheck %s
// CHECK: 
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

  func @ack44() -> i64 {
    %four = constant 4 : i64
    %ack = constant @ackermann   : (i64, i64) -> i64
    // if the thunk were updatable, this computation would be cached.
    %ackt = lz.ap(%ack : (i64, i64) -> i64, %four, %four)
    %ackv = lz.force(%ackt) : i64
    lz.return %ackv : i64
  }

  func @main () -> i64 {
    %x = std.call @ack44() : () -> i64  
    %y = std.call @ack44() : () -> i64  
    %z = addi %x,  %y : i64
    return %z : i64
  }
}
