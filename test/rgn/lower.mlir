func private @lean_is_exclusive(!lz.value) -> i1
func private @lean_io_mk_world() -> !lz.value

 func @main() {
      %1 = call @lean_io_mk_world() : () -> !lz.value
      %6 = call @lean_is_exclusive(%1) : (!lz.value) -> i1
      %7 = "ptr.not"(%6) : (i1) -> i8
      %8 = "rgn.val"() ( {
        "rgn.return"(%1) : (!lz.value) -> ()
      }) : () -> i42
      %9 = "rgn.val"() ( {
        %c0_i32 = constant 0 : i32
        "rgn.return"(%c0_i32) : (i32) -> ()
      }) : () -> i42
      %10 = "rgn.select"(%7, %8, %9) {case0 = 0 : i64, case1 = -42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%10) : (i42) -> ()
}