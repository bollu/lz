// RUN: hask-opt %s --lz-lower --convert-scf-to-std --ptr-lower
// RUN: hask-opt %s --lz-lower --convert-scf-to-std --ptr-lower | mlir-translate --mlir-to-llvmir
// RUN: hask-opt %s --lz-worker-wrapper --lz-lower --convert-scf-to-std --ptr-lower
// RUN: hask-opt %s --lz-worker-wrapper --lz-lower --convert-scf-to-std --ptr-lower | mlir-translate --mlir-to-llvmir
// RUN: run-optimized.sh < %s | FileCheck %s
// CHECK: Just(42)
// XFAIL: *
// This must fail because we try to use run-optimised.sh

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
            %boxed_isub_t = lz.thunkify(%boxed_isub : !lz.value)
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
    return %reti : !lz.value
  }

  func private @printConstructor(%x: !lz.value, %s: !ptr.char) -> ()
  // 37 + 5 = 42
  func @main() -> i64 {
    %v = constant 37: i64
    %v_box = lz.construct(@Just, %v: i64)
    %v_thunk = lz.thunkify(%v_box: !lz.value)
    %f = constant @f : (!lz.thunk<!lz.value>) -> !lz.value
    %out_t = lz.ap(%f : (!lz.thunk<!lz.value>) -> !lz.value, %v_thunk)
    %out_v = lz.force(%out_t): !lz.value
    %fmtstr = ptr.string "(i)"
    call @printConstructor(%out_v, %fmtstr) : (!lz.value, !ptr.char) -> ()
    %zero = constant 0 : i64
    return %zero : i64
  }
}

