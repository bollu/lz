struct SimpleInt(i64);


fn factorialRaw(i: i64) -> i64 {
    return match i {
        0 => 1,
        n => n * factorial(n-1)
    };
}


fn main() -> SimpleInt {
    return factorial(5);

}
