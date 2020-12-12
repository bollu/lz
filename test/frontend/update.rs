// RUN: frontend %s -interpret

// y = a*x + a
fn add(a: i64, b: i64) -> !i64 {
    return match a {
        av => return 10;
    };
}

fn mul(a: i64, b: i64) -> !i64 {
    return match a {
        av => return match b {
            bv => return av * bv;
        };
    };
}

fn id(x: i64) -> i64 { return x; }

fn main() -> !i64 {
    let a : i64 = id(10);
    let b : i64 = id(20);
    let x : i64 = id(30);
    let y : i64 = add(mul(a, x), a);
    return match y! {
        yv => return yv;
    };
}
