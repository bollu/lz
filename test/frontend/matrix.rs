// RUN: ../../build/bin/frontend %s -interpret

struct MatrixSequence(i64, i64);
fn reduce1d(m: !MatrixSequence) -> !i64 {
    return 42;
}

fn main() -> !i64 {
    let m : !MatrixSequence  = MatrixSequence(0, 4040);
    let s : !i64 = reduce1d!(m);
    return s;
}
