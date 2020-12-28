// Test lowering of ap 
// RUN: hask-opt %s --lz-lower
// RUN: hask-opt %s --lz-lower --ptr-lower
module {

  func @main(%f: (!lz.value) -> (i64), %v: !lz.value){
    %onet = lz.ap(%f : (!lz.value) -> (i64), %v)
    return
  }
}
