// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// RUN: hask-opt %s  --lz-worker-wrapper --lz-interpret | FileCheck %s -check-prefix='CHECK-WW'
// RUN: hask-opt %s  --lz-lower 
// RUN: hask-opt %s  --lz-lower --convert-scf-to-std --ptr-lower 
// Check that @plus works with Maybe works.
// CHECK: constructor(Just 42)
// CHECK: num_thunkify_calls(76)
// CHECK: num_force_calls(76)
// CHECK: num_construct_calls(76)

// CHECK-WW: constructor(Just 42)
// CHECK-WW: num_thunkify_calls(0)
// CHECK-WW: num_force_calls(0)
// CHECK-WW: num_construct_calls(38)

module {
  // f :: Maybe Int# -> Maybe Int#
  // f mi = case mi of
  //         Just i# ->
  //            case i# of
  //             0 -> Just 5;
  //             _ -> case f (Just(i# -# 1#)) of
  //                  Nothing -> Nothing
  //                  Just j# -> Just (j# +# 7#)
  //          Nothing -> Nothing
  //
  // gwork :: Int# -> Int#
  // gwork i# = case i# of 0 -> 5; _ -> (gwork (i# -# 1)) +# 7#
  //
  // gwrap:: Maybe -> Maybe
  // gwrap mi = case mi of
  //             Nothing -> Nothing
  //             Just i# -> Just (gwork i#)
  // f =semantics= gwrap
  func @f (%i : !lz.thunk<!lz.value>) -> !lz.value {
    %icons = lz.force(%i): !lz.value
    %reti = lz.case @Maybe %icons
      [@Nothing -> {
        %nothing = lz.construct(@Nothing)
        lz.return %nothing :!lz.value
      }]
      [@Just -> { ^entry(%ihash: i64):
        %retj = lz.caseint %ihash
          [0 -> {
            %five = constant 5: i64
            %boxed = lz.construct(@Just, %five:i64)
            lz.return %boxed : !lz.value
          }]
          [@default ->  {
            %one = constant 1: i64
            %isub = subi %ihash, %one: i64
            %boxed_isub = lz.construct(@Just, %isub: i64)
            %boxed_isub_t = lz.thunkify(%boxed_isub : !lz.value) : !lz.thunk<!lz.value>
            %f = constant @f : (!lz.thunk<!lz.value>) -> !lz.value
            %rec_t = lz.ap(%f : (!lz.thunk<!lz.value>) -> !lz.value , %boxed_isub_t)
            %rec_v = lz.force(%rec_t): !lz.value
            %out_v = lz.case @Maybe %rec_v
              [@Nothing -> { ^entry:
                %nothing = lz.construct(@Nothing)
                lz.return %nothing : !lz.value
              }]
              [@Just -> { ^entry(%jhash: i64):
                // TODO: worried about capture semantics!
                %one_inner = constant 1: i64
                %jhash_incr =  addi %jhash, %one_inner: i64
                %boxed_jash_incr = lz.construct(@Just, %jhash_incr: i64)
                lz.return %boxed_jash_incr : !lz.value
              }]
            lz.return %out_v : !lz.value
          }]
        lz.return %retj :!lz.value
      }]
    lz.return %reti : !lz.value
  }

  // 37 + 5 = 42
  func @main() -> !lz.value {
    %v = constant 37: i64
    %v_box = lz.construct(@Just, %v: i64)
    %v_thunk = lz.thunkify(%v_box: !lz.value): !lz.thunk<!lz.value>
    %f = constant @f : (!lz.thunk<!lz.value>) -> !lz.value
    %out_t = lz.ap(%f : (!lz.thunk<!lz.value>) -> !lz.value, %v_thunk)
    %out_v = lz.force(%out_t): !lz.value
    lz.return %out_v : !lz.value
  }
}

