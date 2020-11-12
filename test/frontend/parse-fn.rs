struct SimpleInt(RawInt);
enum EitherInt { Left(RawInt), Right(Either) };

fn factorial(i: u64) -> u64 {
    return match i {
        0 => 1,
        n => n * factorial(n-1)
    };
}

// TODO: need to think more.
fn fib(i: SimpleInt) -> SimpleInt {
    return match i {
        SimpleInt(ihash) => i
    };
}

fn main_fib() -> SimpleInt {
    let x : SimpleInt = SimpleInt(6);
    return fib(6);
}

fn loop() -> SimpleInt { return loop(); }
fn k(x: SimpleInt, y: SimpleInt) -> SimpleInt { return x; }

fn main_k() -> SimpleInt {
    let x : SimpleInt = SimpleInt(1);
    let y : SimpleInt = loop();
    return k(x, y);
}

fn plus (i: SimpleInt, j: SimpleInt)  -> SimpleInt {
    let ihash : RawInt = match i { SimpleInt(ihash) => ihash };
    letbang jhash : RawInt = match j { SimpleInt(jhash) => jhash };
    return ihash - jhash;
}

fn main_plus()  -> SimpleInt {
    let i : RawInt = SimpleInt(1);
    let j : RawInt = SimpleInt(2);
    return plus(i, j);
}
