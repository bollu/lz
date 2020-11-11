// RUN: ../build/bin/hask-opt %s  -interpret | FileCheck %s
// RUN: ../build/bin/hask-opt %s  -interpret -worker-wrapper | FileCheck %s -check-prefix='CHECK-WW'
// RUN: ../build/bin/hask-opt %s -lower-std -lower-llvm | FileCheck %s || true
// RUN: ../build/bin/hask-opt %s  | ../build/bin/hask-opt -lower-std -lower-llvm |  FileCheck %s || true
// Check that @plus works with Maybe works.
// CHECK: constructor(Just 42)
// CHECK: num_thunkify_calls(38)
// CHECK: num_force_calls(76)
// CHECK: num_construct_calls(76)

// CHECK-WW: constructor(Just 42)
// CHECK-WW: num_thunkify_calls(0)
// CHECK-WW: num_force_calls(0)
// CHECK-WW: num_construct_calls(38)

module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type
  // TODO: setup constructors properly.

  // f :: Maybe -> Maybe
  // f i = case i of Maybe i# ->
  //        case i# of 0 -> Maybe 5;
  //        _ -> case f ( Maybe(i# -# 1#)) of
  //              Nothing -> Nothing
  //              Just j# -> Just (j# +# 1#)
  lz.func @f (%i : !lz.thunk<!lz.value>) -> !lz.value {
      %icons = lz.force(%i): !lz.value
      %reti = lz.case @Maybe %icons 
           [@Nothing -> {
              %nothing = lz.construct(@Nothing)
              lz.return (%nothing):!lz.value
           }
           [@Just -> { ^entry(%ihash: !lz.value):
              %retj = lz.caseint %ihash
                  [0 -> {
                        %five = lz.make_i64(5)
                        %boxed = lz.construct(@Just, %five:!lz.value)
                        lz.return(%boxed) : !lz.value
                  }]
                  [@default ->  {
                        %one = lz.make_i64(1)
                        %isub = lz.primop_sub(%ihash, %one)
                        %boxed_isub = lz.construct(@Just, %isub: !lz.value)
                        %boxed_isub_t = lz.thunkify(%boxed_isub : !lz.value) : !lz.thunk<!lz.value>
                        %f = lz.ref(@f): !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
                        %rec_t = lz.ap(%f : !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value> , %boxed_isub_t)
                        %rec_v = lz.force(%rec_t): !lz.value
			%out_v = lz.case @Maybe %rec_v 
			       [@Nothing -> { ^entry:
				  %nothing = lz.construct(@Nothing)
				  lz.return (%nothing):!lz.value
			       }]

			       [@Just -> { ^entry(%jhash: !lz.value):
			       	  // TODO: worried about capture semantics!
				  %one_inner = lz.make_i64(1)
			          %jhash_incr =  lz.primop_add(%jhash, %one_inner)
				  %boxed_jash_incr = lz.construct(@Just, %jhash_incr: !lz.value)
				  lz.return(%boxed_jash_incr):!lz.value
			       }]
                        lz.return(%out_v): !lz.value
                  }]
              lz.return(%retj):!lz.value
           }]
      lz.return(%reti): !lz.value
    }

  // 37 + 5 = 42
  lz.func@main () -> !lz.value {
      %v = lz.make_i64(37)
      %v_box = lz.construct(@Just, %v:!lz.value)
      %v_thunk = lz.thunkify(%v_box: !lz.value): !lz.thunk<!lz.value>
      %f = lz.ref(@f): !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
      %out_t = lz.ap(%f : !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, %v_thunk)
      %out_v = lz.force(%out_t): !lz.value
      lz.return(%out_v) : !lz.value
    }
}

