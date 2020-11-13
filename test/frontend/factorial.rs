struct SimpleInt(i64);


fn factorialRaw(i: i64) -> i64 {
    return match i {
        0 => 1,
        n => n * factorial(n-1)
    };
}

fn factorial(i: SimpleInt) -> SimpleInt {
    let x : SimpleInt = match i {
       SimpleInt(ihash) => match ihash {
            0 => SimpleInt(1),
            n => SimpleInt(n * factorial(n - 1))
        }
    };
}

fn main() -> SimpleInt {
    let x : SimpleInt = SimpleInt(5);
    return factorial(5);

}
