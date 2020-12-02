// RUN: frontend %s  -interpret | FileCheck %s
// CHECK: value: constructor(Just 42)
enum MaybeInt { Just(!i64), Nothing() };

fn f(m: MaybeInt) -> MaybeInt {
    return match m {
        Just(i) => 
            return match i {
                0 => return f!(Nothing());
                _ => return f!(Just(i - 1));
            };
        Nothing => return Just(42);
    };
}

fn main() -> MaybeInt {
    return f!(Just(10));
}
