struct SimpleInt(i64);


fn factorialRaw(fr: !i64) -> !i64 {
    return match fr {
        0 => return 1;
        n => {
            let rec : !i64 = factorialRaw!(n - 1);
            return n * rec;
        }
    };
}

// TODO: add syntactic sugar for unwraps.
fn mulSimpleInt(i: SimpleInt, j: SimpleInt) -> SimpleInt {
    return match i {
        SimpleInt(ihash) => {
            return match j {
                SimpleInt(jhash) => return SimpleInt(ihash * jhash);
            };
        }
    };
}

fn minus(a: SimpleInt, b:SimpleInt) -> SimpleInt {
    return match a {
        SimpleInt(ahash) =>
        return match b {
            SimpleInt(bhash) => return SimpleInt(ahash - bhash);
        };
    };
}


fn factorial(fac: SimpleInt) -> SimpleInt {
    return match fac {
       SimpleInt(ihash) => 
           return match ihash {
                0 => return SimpleInt(1);
                n => {
                    let n_minus_1 : !i64 = n - 1;
                    return fac;
                }
            };
    };
}

fn main() -> !i64 {
    let five : !SimpleInt = SimpleInt(5);
    let z : SimpleInt =  factorial(five);
    return match z {
        SimpleInt(zhash) => return zhash;
    };
}
