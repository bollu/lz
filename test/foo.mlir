module {
    func @main () -> i32 {
        %x = constant 1 : i32
        // return %x : i32
        lz.return %x : i32
    }
}
