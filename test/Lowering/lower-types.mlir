// RUN: hask-opt --lz-lower %s 
// RUN: hask-opt --lz-lower --convert-scf-to-std --ptr-lower %s 
module {
  // CHECK: llvm.func @main(%arg0: !llvm.ptr<i8>) -> !llvm.i64
  func @main (%p: !lz.thunk<i64>) -> i64 {
    %x = constant 0 : i64
    return %x : i64
  }
}


