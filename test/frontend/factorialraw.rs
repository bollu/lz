struct SimpleInt(i64);


fn factorialRaw(i: i64) -> i64 {
    return match i {
        0 => 1,
        n => n * factorial(n-1)
    };
}


fn main() -> SimpleInt {
    let y : i64 = 10;
    let x : i64 = match y { 0 => 1, n => 10 };
    return factorial(5);

}
