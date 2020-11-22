struct SimpleInt(i64);


fn factorialRaw(fr: i64) -> i64 {
    return match fr {
        0 => return 1;
        n => {
            let rec : !i64 = factorialRaw(n - 1);
            return n * rec;
        }
    };
}

// TODO: add syntactic sugar for unwraps.
fn mulSimpleInt(i: SimpleInt, j: SimpleInt) -> SimpleInt {
    return match i {
        SimpleInt(ihash) => {
            return match j {
                SimpleInt(jash) => return SimpleInt(i * j);
            };
        }
    };
}


fn factorial(fac: SimpleInt) -> SimpleInt {
    return match fac {
       SimpleInt(ihash) => 
           return match ihash {
                0 => return SimpleInt(1);
                n => {
                    let rec : !SimpleInt = factorial(ihash - 1);
                    return mulSimpleInt(n, rec);
                }
            };
    };
}

fn main() -> SimpleInt {
    let x : SimpleInt = SimpleInt(5);
    let z :!i64 =  factorial(5);
    return z;
}
