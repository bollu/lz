// RUN: hask-opt %s  --lz-lower-to-llvm 
module {
  llvm.func @mkVoidPtr() -> !llvm.ptr<i8>
  llvm.func @main() -> !llvm.i64 {
    %3 = llvm.call @mkVoidPtr() : () -> !llvm.ptr<i8>
    llvm.return %3 : !llvm.ptr<i8>
  }
}
