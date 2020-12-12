// RUN: frontend %s  -interpret 
enum IO<T> { IORet(T), IOGetInt(i64 -> IO<T>), IOPutInt(i64, IO<T>) }


fn main() -> IO<i64> {
    let ioval = IOGetInt(|i: i64| ->  {
        return IOPutInt(i + 1, IORet(i +42));
    });
    return ioval;
}
