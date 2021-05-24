// RUN: hask-opt %s --lean-lower | hask-opt
// Check what to see that caseIntRet lowers correctly

module {
    func @foo() -> !lz.value {
      // %0 = "lz.int"() {value = 0 : i64} : () -> !lz.value
      %0 = constant 3 : i64
      "lz.caseIntRet"(%0) ( {
        %2 = "lz.int"() {value = 1 : i64} : () -> !lz.value
        lz.return %2 : !lz.value
      },  {
        %2 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
        lz.return %2 : !lz.value
      }) {alt0 = 0 : i64, alt1 = 1 : i64} : (i64) -> ()
    }
}

