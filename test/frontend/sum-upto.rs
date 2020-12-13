// lazy linked list.
struct Int(i64!);
enum List {Nil(), Cons(Int, List)};

fn incr(a: Int) -> Int! {
    return match a! {
        Int(av) => return Int(av + 1);
    }
}

fn add(a: Int, b:Int) -> Int! {
    return match a! {
        Int(av) =>
        return match b! {
            Int(bv) => return Int(av + bv);
        };
    };
}

// can we "transfer demand information"?
fn gt(a: Int, b: Int) {
    return match a! {
        Int(av) =>
            return match b! {
                Int(bv) => return av > bv;
            };
    };
}

fn upto(m: Int, n: Int) -> List {
    match (gt(m, n)) {
        1 => return Nil();
        _ => return Cons(m, upto(incr(m), n))

    }
}
fn sum(l: List) -> !i64 {
    match !l {
        Nil() => return 0;
        Cons(x, xs) => add(x, sum(xs))
    }
}
fn main() -> List {
    let x : List! = upto(Int(0), Int(100));
    return sum(x);
    return x;
}
