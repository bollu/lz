// RUN: hask-opt %s --lz-lower --convert-scf-to-std --ptr-lower
// RUN: hask-opt %s --lz-lower --convert-scf-to-std --ptr-lower | mlir-translate --mlir-to-llvmir
// RUN: hask-opt %s --lz-worker-wrapper --lz-lower --convert-scf-to-std --ptr-lower
// RUN: hask-opt %s --lz-worker-wrapper --lz-lower --convert-scf-to-std --ptr-lower | mlir-translate --mlir-to-llvmir
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
  //1 func @f (%i : !lz.thunk<!lz.value>) -> !lz.value {
  //1   %icons = lz.force(%i): !lz.value
  //1   %reti = lz.case @Maybe %icons
  //1     [@Nothing -> {
  //1       %nothing = lz.construct(@Nothing)
  //1       lz.return %nothing :!lz.value
  //1     }]
  //1     [@Just -> { ^entry(%ihash: i64):
  //1       %retj = lz.caseint %ihash
  //1         [0 -> {
  //1           %five = constant 5: i64
  //1           %boxed = lz.construct(@Just, %five:i64)
  //1           lz.return %boxed : !lz.value
  //1         }]
  //1         [@default ->  {
  //1           %one = constant 1: i64
  //1           %isub = subi %ihash, %one: i64
  //1           %boxed_isub = lz.construct(@Just, %isub: i64)
  //1           %boxed_isub_t = lz.thunkify(%boxed_isub : !lz.value)
  //1           %f = constant @f : (!lz.thunk<!lz.value>) -> !lz.value
  //1           %rec_t = lz.ap(%f : (!lz.thunk<!lz.value>) -> !lz.value , %boxed_isub_t)
  //1           %rec_v = lz.force(%rec_t): !lz.value
  //1           %out_v = lz.case @Maybe %rec_v
  //1             [@Nothing -> { ^entry:
  //1               %nothing = lz.construct(@Nothing)
  //1               lz.return %nothing : !lz.value
  //1             }]
  //1             [@Just -> { ^entry(%jhash: i64):
  //1               // TODO: worried about capture semantics!
  //1               %one_inner = constant 1: i64
  //1               %jhash_incr =  addi %jhash, %one_inner: i64
  //1               %boxed_jash_incr = lz.construct(@Just, %jhash_incr: i64)
  //1               lz.return %boxed_jash_incr : !lz.value
  //1             }]
  //1           lz.return %out_v : !lz.value
  //1         }]
  //1       lz.return %retj :!lz.value
  //1     }]
  //1   return %reti : !lz.value
  //1 }

  func private @printConstructor(%x: !lz.value) -> ()

  // 37 + 5 = 42
  func @main() -> !lz.value {
    // %v = constant 37: i64
    %v_box = lz.construct(@Box) // : !lz.value
    // %v_thunk = lz.thunkify(%v_box: !lz.value)
    // %f = constant @f : (!lz.thunk<!lz.value>) -> !lz.value
    // %out_t = lz.ap(%f : (!lz.thunk<!lz.value>) -> !lz.value, %v_thunk)
    // %out_v = lz.force(%out_t): !lz.value
    call @printConstructor(%v_box) : (!lz.value) -> ()
    // return %out_v : !lz.value
    return %v_box : !lz.value
  }
}

