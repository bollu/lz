struct SimpleInt(RawInt);
enum EitherInt { Left(RawInt), Right(Either) };

fn factorial(i: u64) -> u64 {
    return match i {
        0 => 1,
        n => n * factorial(n-1)
    };
}

fn fib(i: SimpleInt) -> SimpleInt {
    return match i {
        SimpleInt(ihash) -> match ihash {
            0 => 0,
            1 => 1,
            n => return fib(n-1) + fib(n-2)
        }
    }
}

fn main_fib() {
    let x = SimpleInt(6);
    return fib(6).0;
}

fn loop<T>() -> T { return loop(); }
fn k<T>(T x, T y) { return x; }

fn main_k() {
    let x = SimpleInt(1);
    let y : SimpleInt = loop();
    return k(x, y).0;
}

fn plus (i: SimpleInt, j: SimpleInt) {
    let SimpleInt(ihash) = i; // will force i. In a lazy language, pattern-match is 'side effecting' :]
    let jhash = j; // will force j. In a lazy language, accessor is 'side-effecting' :]
    return ihash + jhash;
}

fn main_plus() {
    let i = SimpleInt(1);
    let j = SimpleInt(2);
    return plus(i, j);
}
