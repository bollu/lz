// RUN: ../build/bin/hask-opt %s  --lz-interpret | FileCheck %s
// CHECK: 1
module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type

  // extract e = case e of @Right e2-> case e2 of @Left v -> v
  lz.func @extract (%t: !lz.thunk<!lz.value>) -> !lz.value {
       %v = lz.force(%t) : !lz.value
       %ret = lz.case @Either %v 
           [@Right -> { ^entry(%t2: !lz.thunk<!lz.value>):
               %v2 = lz.force(%t2) : !lz.value
               %ret2 = lz.case @Either %v2
                   [@Left -> { ^entry(%t3: !lz.thunk<!lz.value>):
                       %v3 = lz.force(%t3) : !lz.value
                       lz.return(%v3):!lz.value
                   }]
              lz.return(%ret2):!lz.value
           }]
        lz.return(%ret):!lz.value
    } 

  lz.func @one () -> !lz.value { 
          %v = lz.make_i64(1)
          %boxed = lz.construct(@SimpleInt, %v:!lz.value)
          lz.return(%boxed): !lz.value
      }

  lz.func @leftOne () -> !lz.value {
        %ofn = lz.ref(@one) : !lz.fn<() -> !lz.value>
        %o = lz.ap(%ofn  : !lz.fn<() -> !lz.value>)

        %l = lz.construct(@Left, %o: !lz.thunk<!lz.value>) 
        lz.return(%l) :!lz.value
    }

  lz.func @rightLeftOne() -> !lz.value {
      %lfn = lz.ref(@leftOne): !lz.fn<() -> !lz.value>
      %l_t = lz.ap(%lfn: !lz.fn<() -> !lz.value>)

      %r = lz.construct(@Right, %l_t :!lz.thunk<!lz.value>) 
      %r_t = lz.thunkify(%r :!lz.value):!lz.thunk<!lz.value>
      lz.return(%r):!lz.value
    }

  // 1 + 2 = 3
  lz.func@main () -> !lz.value {
      %rlo = lz.ref(@rightLeftOne): !lz.fn<() -> !lz.value>
      %input = lz.ap(%rlo : !lz.fn<() -> !lz.value>)
      %extract = lz.ref(@extract) :!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>

      %extract_t = lz.ap(%extract:!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, %input)
      %extract_v = lz.force(%extract_t) :!lz.value
      lz.return(%extract_v):!lz.value

    }
}
