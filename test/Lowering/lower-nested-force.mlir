// RUN: hask-opt --lz-lower %s 
// Check that we can lower a nested sequence of forces.
module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type
  // TODO: setup constructors properly.

  // plus :: SimpleInt -> SimpleInt -> SimpleInt
  // plus i j = case i of MkSimpleInt ival -> case j of MkSimpleInt jval -> MkSimpleInt (ival +# jval)
  func @plus (%icons : !lz.value, %j: !lz.thunk<!lz.value>) -> i64 {
    %reti = lz.case @SimpleInt %icons
              [@SimpleInt -> { 
                %jcons = lz.force(%j): !lz.value
                %retj = lz.case @SimpleInt %jcons
                  [@SimpleInt -> { ^entry(%jval: i64):
                    %x = std.constant 10 : i64
                    lz.return %x : i64
                  }]
                lz.return %retj: i64
              }]
    return %reti: i64
  }
}


