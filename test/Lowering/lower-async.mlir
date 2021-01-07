// Think of how we can leverage the async dialect to model I/O?
// IO ()
func @printIntIO(%i: i64) -> !lz.value<!async.value<!lz.unit>> {
}

// a -> IO b
func @readInput() -> !lz.value<!async.value<i64>> {
}
func @main() {
}
