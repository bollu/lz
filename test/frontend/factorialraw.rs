struct SimpleInt(i64);


fn factorialRaw(i: i64) -> i64 {
    return match i {
        0 => return 1;
        n => {
            let rec : !i64 = factorialRaw(n - 1);
            return n * rec;
        }
    };
}


fn main() -> SimpleInt {
    let y : i64 = 10;
    let x : i64 = match y { 0 => return 1; n => return 10;  };
    let z : !i64 = factorialRaw(5);
    return z;

}
