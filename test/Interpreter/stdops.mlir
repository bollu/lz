// RUN: hask-opt %s
// RUN: hask-opt --lz-interpret %s

module {
  func @makemem(%n: index, %v0 : i64, %v1: i64) -> memref<?xi64> {
    %mem = alloc(%n) : memref<?xi64>
    store %v0, %mem[0] : memref<?xi64>
    store %v1, %mem[1] : memref<?xi64>
    %v3 = addi %v0, %v1 : i64
    store %v3, %mem[2] : memref<?xi64>
    return %mem : memref<?xi64>
  }

  func @main () -> i64 {
    %n = constant 4 : index
    %v0 = constant 1 : i64
    %v1 = constant 2 : i64
    %mem = call @makemem(%n, %v0, %v1) : (index, i64, i64) -> memref<?xi64>
    %outv = load %mem[2] : memref<?xi64>
    return %outv : i64
  }
}


