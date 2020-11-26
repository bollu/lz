// RUN: ../../build/bin/frontend %s  -interpret | FileCheck %s
// CHECK: value: 120


fn factorialRaw(i: i64) -> i64 {
    return match i {
        0 => return 1;
        n =>  return n * factorialRaw!(n - 1);
    };
}

fn main() -> i64 {
    let z : !i64 = factorialRaw!(5);
    return z;

}
