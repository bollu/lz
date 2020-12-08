// RUN: hask-opt %s
// RUN: hask-opt --lz-interpret %s
// CHECK: 42

module {
  func @makemem(%n: index, %vAt0 : i64, %vAt1: i64) -> memref<?xi64> {
    %v0 = constant 0 : index
    %v1 = constant 1 : index
    %v2 = constant 2 : index
    %mem = alloc(%n) : memref<?xi64>
    store %vAt0, %mem[%v0] : memref<?xi64>
    store %vAt1, %mem[%v1] : memref<?xi64>
    %vAt2 = addi %vAt0, %vAt1 : i64
    store %vAt2, %mem[%v2] : memref<?xi64>
    return %mem : memref<?xi64>
  }

  func @main () -> i64 {
    %n = constant 4 : index
    %v20 = constant 20 : i64
    %v22 = constant 22 : i64
    %v2 = constant 2 : index
    %mem = call @makemem(%n, %v20, %v22) : (index, i64, i64) -> memref<?xi64>
    %outv = load %mem[%v2] : memref<?xi64>
    return %outv : i64
  }
}


