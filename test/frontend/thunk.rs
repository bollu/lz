struct SimpleInt(i64);


// fn factorialRaw(i: i64) -> i64 {
//     return match i {
//         0 => 1,
//         n => n * factorial(n-1)
//     };
// }
// 
// fn factorial(i: SimpleInt) -> SimpleInt {
//     let x : SimpleInt = match i {
//        SimpleInt(ihash) => match ihash {
//             0 => SimpleInt(1),
//             n => SimpleInt(n * factorial(n - 1))
//         }
//     }
// }

fn prodcurry(n: i64) -> (i64 -> i64){
    letbang x = lambda (int m) {
        return m * n;
    }

    return x;
}

fn main() -> i64 {
    letbang y : i64 -> i64 = prodcurry(5);
    letbang z : i64 = y(6);
    return z;

