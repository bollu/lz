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
  
  // a*x + y
  func @axpy(%at: !lz.thunk<i64>, %xt: !lz.thunk<i64>, %yt: !lz.thunk<i64>) -> i64 {
    %a = lz.force(%at): i64
    %x = lz.force(%xt): i64
    %y = lz.force(%yt): i64

    %ax = muli %a, %x : i64
    %axpy = addi %ax, %y : i64
    lz.return %axpy : i64
  }


  func @main () -> i64 {
    %four = constant  4  : i64
    %three = constant 3 : i64
    %two = constant   2   : i64
    %ackermann = constant @ackermann : (i64, i64) -> i64

    // | Q1: how to represent that this thunk is updatable?
    %ack44 = lz.ap(%ackermann : (i64, i64) -> i64, %two, %two)
    %ack33 = lz.ap(%ackermann : (i64, i64) -> i64, %two, %three)
    %ack22 = lz.ap(%ackermann : (i64, i64) -> i64, %two, %four)

    // | Q2. can prove that %ack44, %ack33, %ack22 are NOT use more than once!
    // | we dont need to know what axpy does.
    // | Q3. How to represent the fact that the thunks created above SHOULD NOT
    //       be updated
    %out = call @axpy (%ack44, %ack33, %ack22) 
        : (!lz.thunk<i64>, !lz.thunk<i64>, !lz.thunk<i64>) -> i64
    return %out : i64
  }
}
