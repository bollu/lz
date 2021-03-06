# Core-MLIR

# Points
- Experience report on writing a LEAN backend.
- inline C string is a huge pain.
- Optimisations that you'd be interested to implement?
- Upstreaming?
- Help formalizing the document?


# Notes on GHC

- smallest size is `32` bit word. Can't pack stuff!
- GHC plugin that strictifies/unboxes most things and prints out the new
  file.
- IORefs are bad
- Example GHC perf slide because of laziness: https://gitlab.haskell.org/ghc/ghc/-/issues/19102#note_319557
- [Novel GC algorithm for pure funcitonal languages](https://www.reddit.com/r/haskell/comments/knzfhn/novel_garbage_collection_technique_for_immutable/)
- [supercompiler by evaluation](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/07/supercomp-by-eval.pdf)
- [GHC grin has benchmark suite](https://github.com/grin-compiler/ghc-grin/tree/master/ghc-grin-benchmark/boquist-grin-bench)
- [`fast-math` haskell library has some RULES limitations](https://github.com/liyang/fast-math/)
- [Another example where fusion is bad for `Text`](https://github.com/haskell/text/pull/348)

# Thoughts on writing a new LEAN backend
- Why only `closureMaxArgs` for `app` and not `pap`?
- Also, I should generate `llvm.switch` for efficiency.
- Similary, I should check that me calling the intrinsics such as `lean_nat_sub`
  does not impact my performance!
- I should tag the values in the `library.ll` to be `alwaysinline` for performance.
- I should generate `llvm.musttail`.
- Please don't use things like function overloading (looking at you `lean_inc`).
- The existence of `extern C inline` within the compiler / prelude makes stuff very complicated. Eg.
  the fact that adding `uint` is implemented using `[extern c inline "#1 + #2]` makes it complex to use,
  since I can't lower this to MLIR (or any other lowering mechanism, really). I am concerned this feature will lead to 
  a lock-in into C(++) syntax.
- One massive quality of life improvement would be if lambdapure printed in MLIR syntax.
  That way, it's unambiguous about semantics! and can potentially eventually round-trip
  through the compiler!
- It's both too high and too low level. `case` of `int` in lambdapure generates
  as calls to runtime `lean_dec_eq` + a boolean `int` case on return value,
  while `case` of objects is represented as a real `case.`
- Initialization machinery is confusing. I still don't understand the
  invariants around why certain things are initialized the way they are.
- Quite minimal and pleasant to work with, all said and done.
- Can tell LLVM about tail calls instead of hand rolling a tail call.
- Can maybe use TBAA to teach LLVM about different object types, instead of erasing all info
  at the lambdapure level. 
- Can potentially use the objective-c machinery + [LLVM GC](https://llvm.org/docs/GarbageCollection.html) to implement correct
  refcounting.
- `jmp` encodes nicely in MLIR thanks to nested regions.
- LEAN4 APIS: foldable/traversable/divisible/decidable?
- I saw the [bachelor thesis on snake lemma](https://pp.ipd.kit.edu/thesis.php?id=313) (I wanted the snake lemma recently...). 
  [How is homology computed? Can we make it faster?](https://pastel.archives-ouvertes.fr/pastel-00605836/document)
  (sparse linear algebra).
- Which optimisation to do at LEAN level?
- Can we leverage proofs at the LEAN level?
- Interactive compliation: write tactics to prove properties about code.

# Log:  [newest] to [oldest]

# Jul 20

For a while, I thought I neeeded by own pass. It doesn't look like it, maybe I can just
generate slightly different IR and get away with it:


```
%struct.lean_object = type { i64 }
define %struct.lean_object* @cant_inline_1(i8* %0, i32 %1, i32 %2) alwaysinline {
    unreachable
}

define %struct.lean_object* @cant_inline_2(i8* %0, i64 %1, i64 %2) alwaysinline {
    unreachable
}

define %struct.lean_object* @cant_inline_3(%struct.lean_object* %0, i64 %1, i64 %2) alwaysinline {
    unreachable
}

define i1 @main (i8* %in) {
  ;; %out = tail call i8* bitcast (%struct.lean_object* (i8*, i32, i32)* @cant_inline_1 to i8* (i8*, i64, i64)*)(i8* %in, i64 3, i64 0)
   %out2 = tail call i8* bitcast (%struct.lean_object* (i8*, i64, i64)* @cant_inline_2 to i8* (i8*, i64, i64)*)(i8* %in, i64 3, i64 0)
  %out3 = tail call i8* bitcast (%struct.lean_object* (%struct.lean_object*, i64, i64)* @cant_inline_3 to i8* (i8*, i64, i64)*)(i8* %in, i64 3, i64 0)
  ret i1 1
}

```

In this program, only `cant_inline_1` fails due to the need to sign truncate the calls of an `i32` function pretending
to be `i64`.


# Jul 15

```
23.77%  exe.out  exe.out           [.] lean_del
```

`lean_del` comes from the lean runtime, so I'm now writing scripts to extract out the runtime
functions.

After folding in `runtime`, we don't have `lean_del` as topmost for `binarytrees`.
Rather we have `lean_ctor_get`, which is strange since it comes from `lean.h` that's
already in `include.ll`. But we still have calls like:

```llvm
%140 = tail call i8* 
  bitcast (%struct.lean_object* (%struct.lean_object*, i32)* 
   @lean_ctor_get to i8* (i8*, i64)*)(i8* nonnull %5, i 64 1), !dbg !439
```

floating around which I find mysterious, since  wrote a pass to get rid of exactly
this type of thing! I need to debug more to find out what's happening.

# Jul 14

- Perf report on `binarytrees.lean`, the file that shows a large delta.
- It seems like we don't correctly inline some functions like `lean_del`?

```
# Report, OURS (MLIR/LLVM backend)
  23.77%  exe.out  exe.out           [.] lean_del                   
  13.06%  exe.out  exe.out           [.] l_check                    
  11.77%  exe.out  exe.out           [.] lean_ctor_get              
  10.32%  exe.out  exe.out           [.] lean_free_small            
   9.37%  exe.out  exe.out           [.] lean_alloc_ctor            
   9.28%  exe.out  exe.out           [.] lean_obj_tag               
   8.88%  exe.out  exe.out           [.] l_make_x27                 
   4.38%  exe.out  exe.out           [.] lean_alloc_small           
   4.04%  exe.out  exe.out           [.] lean_ctor_set              
   1.11%  exe.out  [kernel.vmlinux]  [k] irqentry_exit_to_user_mode 
   0.80%  exe.out  exe.out           [.] lean_mark_persistent       
   0.55%  exe.out  ld-2.33.so        [.] strcmp                     
   0.54%  exe.out  exe.out           [.] lean::allocator::alloc_page
   0.50%  exe.out  [kernel.vmlinux]  [k] clear_page_erms            
   0.42%  exe.out  exe.out           [.] lean::mix                  
   0.29%  exe.out  [kernel.vmlinux]  [k] do_user_addr_fault         
   0.18%  exe.out  exe.out           [.] l_depth___lambda__1        
   0.18%  exe.out  [kernel.vmlinux]  [k] unmap_page_range           
   0.18%  exe.out  [kernel.vmlinux]  [k] error_entry                
   0.18%  exe.out  [kernel.vmlinux]  [k] __free_one_page            
   0.18%  exe.out  [kernel.vmlinux]  [k] __mod_memcg_lruvec_state   
   0.02%  perf     [kernel.vmlinux]  [k] strrchr                    
   0.00%  perf     [kernel.vmlinux]  [k] intel_pmu_handle_irq       
   0.00%  perf     [kernel.vmlinux]  [k] native_write_msr
```

- Versus theirs:

```
  20.75%  exe-ref.out  exe-ref.out       [.] l_check                    
  18.29%  exe-ref.out  exe-ref.out       [.] lean_free_small            
  11.67%  exe-ref.out  exe-ref.out       [.] l_make_x27.part.0          
   7.74%  exe-ref.out  exe-ref.out       [.] lean_alloc_small           
   2.13%  exe-ref.out  ld-2.33.so        [.] do_lookup_x                
   1.16%  exe-ref.out  exe-ref.out       [.] lean_mark_persistent       
   0.84%  exe-ref.out  [kernel.vmlinux]  [k] try_charge                 
   0.77%  exe-ref.out  [kernel.vmlinux]  [k] sync_regs                  
   0.70%  exe-ref.out  [kernel.vmlinux]  [k] filemap_map_pages          
   0.65%  exe-ref.out  [kernel.vmlinux]  [k] get_page_from_freelist     
   0.60%  exe-ref.out  [kernel.vmlinux]  [k] unmap_page_range           
   0.52%  exe-ref.out  [kernel.vmlinux]  [k] memcg_slab_post_alloc_hook 
   0.47%  exe-ref.out  [kernel.vmlinux]  [k] page_mapping               
   0.30%  exe-ref.out  [kernel.vmlinux]  [k] __free_one_page            
   0.29%  exe-ref.out  exe-ref.out       [.] lean::allocator::alloc_page
   0.22%  exe-ref.out  exe-ref.out       [.] l_depth___lambda__1___boxed
   0.03%  perf         [kernel.vmlinux]  [k] strlen                     
   0.00%  perf         [kernel.vmlinux]  [k] intel_pmu_handle_irq       
   0.00%  perf         [kernel.vmlinux]  [k] native_write_msr           
```


# Jun 25

```
; not converted to the right call?
%4 = call i64 bitcast (i32 (%struct.lean_object*)* @lean_obj_tag to i64 (i8*)*)(i8* %0), !dbg !13
```

Calls like the above are not inlined for whatever reason. Unsure why.


# June 18

# June 12
- MLIR: try to use last stable release, and find the delta.


# June 11


```
The following tests FAILED:
        568 - leancomptest_closure_bug1.lean (Failed)
        569 - leancomptest_closure_bug2.lean (Failed)
        570 - leancomptest_closure_bug3.lean (Failed)
        576 - leancomptest_expr.lean (Failed)
        585 - leancomptest_phashmap3.lean (Failed)
        642 - leanplugintest_SnakeLinter.lean (Failed)
```


# June 8

- Scheme's design of laziness is very nice. they have force, delay, and clean semantics for what all of these mean.
  Part of R5RS. Also, their thunks can have side effects.

# June 3

- CMake settings for test files:

```
# src/shell/CMakeLists.txt
# also look at tests/test_single.sh
file(GLOB LEANT0TESTS "${LEAN_SOURCE_DIR}/../tests/lean/trust0/*.lean")
FOREACH(T ${LEANT0TESTS})
  GET_FILENAME_COMPONENT(T_NAME ${T} NAME)
  add_test(NAME "leant0test_${T_NAME}"
           WORKING_DIRECTORY "${LEAN_SOURCE_DIR}/../tests/lean/trust0"
           COMMAND bash -c "PATH=${LEAN_BIN}:$PATH ./test_single.sh ${T_NAME}")
ENDFOREACH(T)
```

```
# https://cmake.org/cmake/help/latest/manual/cmake-generator-expressions.7.html#manual:cmake-generator-expressions(7)
$<TARGET_OBJECTS:objLib>
List of objects resulting from build of objLib.
```



This is used to link against `runtime`, `kernel`, etc.

```
if(LEANCPP)
  add_library(leancpp STATIC IMPORTED)
  set_target_properties(leancpp PROPERTIES
    IMPORTED_LOCATION "${CMAKE_BINARY_DIR}/lib/lean/libleancpp.a")
  add_custom_target(copy-leancpp
    COMMAND cmake -E copy_if_different "${LEANCPP}" "${CMAKE_BINARY_DIR}/lib/lean/libleancpp.a")
  add_dependencies(leancpp copy-leancpp)
else()
  add_subdirectory(runtime)
  set(LEAN_OBJS ${LEAN_OBJS} $<TARGET_OBJECTS:runtime>)
  add_subdirectory(util)
  set(LEAN_OBJS ${LEAN_OBJS} $<TARGET_OBJECTS:util>)
  add_subdirectory(kernel)
  set(LEAN_OBJS ${LEAN_OBJS} $<TARGET_OBJECTS:kernel>)
  add_subdirectory(library)
  set(LEAN_OBJS ${LEAN_OBJS} $<TARGET_OBJECTS:library>)
  add_subdirectory(library/constructions)
  set(LEAN_OBJS ${LEAN_OBJS} $<TARGET_OBJECTS:constructions>)
  add_subdirectory(library/compiler)
  set(LEAN_OBJS ${LEAN_OBJS} $<TARGET_OBJECTS:compiler>)
  add_subdirectory(initialize)
  set(LEAN_OBJS ${LEAN_OBJS} $<TARGET_OBJECTS:initialize>)
  if(${STAGE} EQUAL 0)
    add_subdirectory(../stdlib stdlib)
    set(LEAN_OBJS ${LEAN_OBJS} $<TARGET_OBJECTS:stage0>)
  endif()
```

Running `filter.lean` with large enough program sizes causes the C++ backend
to stack overflow:

```
def main : IO Unit := let l := length (filter (make 80000)); IO.println (toString l)
```

- Test for stack overflow: `leancomptest_StackOverflow.lean`


# June 2

Why does the backend have BOTH things like `insertReset/insertReuse` which
emit calls to `lean_ctor_set_tag` as well as PRIMITIVES like `setTg`
which emit calls to `lean_ctor_set_tag`? This seems very schiozophrenic to me.

A call to `ensureHasDefault` (my lean commit `e20ee48959078cb40aa19ee4ffd22a65fd6b0195`)
changed the CORRECTNESS of the compliation. This seems dodgy at best?!


```lean
-- | pretty sure emitDec is broken, there is no variant of lean_dec
-- that can take more than 1 arg.
def emitDec (x : VarId) (n : Nat) (checkRef : Bool) : M Unit := do
  emit (if checkRef then "lean_dec" else "lean_dec_ref");
  emit "("; emit x;
  if n != 1 then emit ", "; emit n
  emitLn ");"
```


- In all of `render.lean`, there is no telltale sign of either reset or reuse.
  I could find no calls to reuse's `lean_ctor_set_tag` and reset's `lean_ctor_release`.
  So the crash must be from something else.

- I changed `sext` to `zext` because `zext` extends true into `1`, while `sext` extends true into `-1`.

- I also tried to see if sharing was the problem, so I forced LEAN to consider everything as shared all the time.
  This still only allows `render.lean` to crash `x(`.



```lean
-- | Code to force everything to be considered as sharing.
-- | when writing into a variable sign-extend boolean i1s into i8s.
-- This is SUCH a clusterfuck.
def emitIsShared (z : VarId) (x : VarId) : M Unit := do
  emitLhs z; emit " std.constant 1 : i8"; -- nothing is ever exclusive!
  -- let excl <- gensym "exclusive";
  -- emit $ "%" ++ excl ++ " = call @lean_is_exclusive(%" ++ (toString x) ++ ")";
  -- emitLn $ " : (!lz.value) -> i1";
  -- emitLhs z; emit $ (escape "ptr.not") ++ "(%" ++ excl ++ ")";
  -- emitLn $ " : (i1) -> i8"
```


- Disable `dec` (decrement) fixes the crash in `render.lean`. Of course, this is a disgusting hack!

```
-- | Hack to fix crash in `render.lean`.
def emitDec (x : VarId) (n : Nat) (checkRef : Bool) : M Unit := do
  -- if n != 1 then panicM "there is no lean_dec for more than 1 parameter"
  -- let nv <- emitI64 "n" n;
  -- emit $ "call " ++ (if checkRef then "@lean_dec" else "@lean_dec_ref");
  -- emit "(%"; emit x; emitLn ") : (!lz.value) -> ()"
  return ()
```

- I wanted to get a sense of our backend v/s the LEAN backend. For one, we can tolerate larger problem sizes.
  For example, set `n=15` on `const_fold.lean`. This program allows us to succeed, while the C backend fails.
- We are also much faster. For example, on `qsort.lean` with `n=100`:

```
/home/bollu/work/lz/test/lambdapure/compile/bench$ time ./exe.out    
./exe.out  0.64s user 0.01s system 99% cpu 0.652 total
/home/bollu/work/lz/test/lambdapure/compile/bench$ time ./exe-ref.out
./exe-ref.out  0.87s user 0.01s system 99% cpu 0.880 total
```
- We need to control `musttail`, which I've addded as a `TODO`.


# May 28

Some kind of miscompile of case statements from `render.lean`. I generate
an empty `case:`

```
"lz.caseRet"(%2) ( {
},  {
}) : (!lz.value) -> ()
```

The larger context is from the function `l_IO_randFloat`:

```
caseop parent:
func @l_IO_randFloat(%arg0: f64, %arg1: f64, %arg2: !lz.value) -> !lz.value {
  %c0_i64 = constant 0 : i64
  %0 = call @lean_box(%c0_i64) : (i64) -> !lz.value
  %1 = "ptr.loadglobal"() {value = @l_IO_stdGenRef} : () -> !lz.value
  %2 = call @lean_st_ref_get(%1, %arg2) : (!lz.value, !lz.value) -> !lz.value
  %3 = call @lean_obj_tag(%2) : (!lz.value) -> i64
  %c0_i64_0 = constant 0 : i64
  %4 = cmpi eq, %3, %c0_i64_0 : i64
  cond_br %4, ^bb1, ^bb2
  "lz.caseRet"(%2) ( {
  },  {
  }) : (!lz.value) -> ()
^bb1:  // pred: ^bb0
  %5 = "lz.project"(%2) {value = 0 : i64} : (!lz.value) -> !lz.value
  %6 = "lz.project"(%2) {value = 1 : i64} : (!lz.value) -> !lz.value
  %7 = call @l_randomFloat___at_IO_randFloat___spec__1(%5) : (!lz.value) -> !lz.value
  "lz.caseRet"(%7) ( {
    %10 = "lz.project"(%7) {value = 0 : i64} : (!lz.value) -> !lz.value
    %11 = "lz.project"(%7) {value = 1 : i64} : (!lz.value) -> !lz.value
    %12 = call @lean_st_ref_set(%1, %11, %6) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    "lz.caseRet"(%12) ( {
      %13 = "lz.project"(%12) {value = 1 : i64} : (!lz.value) -> !lz.value
      %14 = call @lean_float_sub(%arg1, %arg0) : (f64, f64) -> f64
      %15 = call @lean_unbox_float(%10) : (!lz.value) -> f64
      %16 = call @lean_float_mul(%14, %15) : (f64, f64) -> f64
      %17 = call @lean_float_add(%arg0, %16) : (f64, f64) -> f64
      %18 = call @lean_box_float(%17) : (f64) -> !lz.value
      %19 = "lz.construct"(%18, %13) {dataconstructor = @"0", size = 2 : i64} : (!lz.value, !lz.value) -> !lz.value
      lz.return %19 : !lz.value
    },  {
    }) : (!lz.value) -> ()
  }) : (!lz.value) -> ()
^bb2:  // pred: ^bb0
  %8 = call @lean_obj_tag(%2) : (!lz.value) -> i64
  %c1_i64 = constant 1 : i64
  %9 = cmpi eq, %8, %c1_i64 : i64
}
```

The offending function, with comments:

```
// ERR: emitDeclAux (l_IO_randFloat) | isExtern?false
// ERR: emitDeclAux Decl.fdecl (l_IO_randFloat)
func @"l_IO_randFloat"(%x_1: f64, %x_2: f64, %x_3: !lz.value) -> !lz.value{
%c0_irr = std.constant 0 : i64
%irrelevant = call @lean_box(%c0_irr) : (i64) -> (!lz.value)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.fap
%x_4 = "ptr.loadglobal"(){value=@"l_IO_stdGenRef"} : () -> !lz.value// <== ERR: emitFullApp (pointer)

//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.fap
%x_5 = call @"lean_st_ref_get"(%x_4, %x_3) : (!lz.value,!lz.value) -> (!lz.value) // <== ERR: emitSimpleExternalCall // <== ys: [x_4, x_3]| tys: 
// ^^ ERR: ExternEntry.standard
// ^^^ ERR: emitFullApp (Decl.extern)
// ERR: FnBody.case
"lz.caseRet"(%x_5)({
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.proj
%x_6 = "lz.project"(%x_5){value=0}:(!lz.value)  -> (!lz.value)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.proj
%x_7 = "lz.project"(%x_5){value=1}:(!lz.value)  -> (!lz.value)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.fap
%x_8 = call @"l_randomFloat___at_IO_randFloat___spec__1"(%x_6):(!lz.value)->(!lz.value)// <== ERR: emitFullApp (fncall)

// ERR: FnBody.case
"lz.caseRet"(%x_8)({
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.proj
%x_9 = "lz.project"(%x_8){value=0}:(!lz.value)  -> (!lz.value)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.proj
%x_10 = "lz.project"(%x_8){value=1}:(!lz.value)  -> (!lz.value)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.fap
%x_11 = call @"lean_st_ref_set"(%x_4, %x_10, %x_7) : (!lz.value,!lz.value,!lz.value) -> (!lz.value) // <== ERR: emitSimpleExternalCall // <== ys: [x_4, x_10, x_7]| tys: 
// ^^ ERR: ExternEntry.standard
// ^^^ ERR: emitFullApp (Decl.extern)
// ERR: FnBody.case
"lz.caseRet"(%x_11)({
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.proj
%x_12 = "lz.project"(%x_11){value=1}:(!lz.value)  -> (!lz.value)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.fap
%x_13 = call @"lean_float_sub"(%x_2, %x_1) : (f64,f64) -> (f64) // <== ERR: emitSimpleExternalCall // <== ys: [x_2, x_1]| tys: 
// ^^ ERR: ExternEntry.standard
// ^^^ ERR: emitFullApp (Decl.extern)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.unbox
%x_14 = call @lean_unbox_float(%x_9) : (!lz.value) -> (f64)
//^UNBOX type: (f64)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.fap
%x_15 = call @"lean_float_mul"(%x_13, %x_14) : (f64,f64) -> (f64) // <== ERR: emitSimpleExternalCall // <== ys: [x_13, x_14]| tys: 
// ^^ ERR: ExternEntry.standard
// ^^^ ERR: emitFullApp (Decl.extern)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.fap
%x_16 = call @"lean_float_add"(%x_1, %x_15) : (f64,f64) -> (f64) // <== ERR: emitSimpleExternalCall // <== ys: [x_1, x_15]| tys: 
// ^^ ERR: ExternEntry.standard
// ^^^ ERR: emitFullApp (Decl.extern)
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.box
%x_17 = call @lean_box_float(%x_16) : (f64) -> (!lz.value) // ERR: xType: float
//ERR: fnBody.vdecl (non-tail) call
%x_18 = "lz.construct"(%x_17, %x_12){dataconstructor = @"0", size=2} : (!lz.value, !lz.value) -> (!lz.value)
//ERR: FnBody.ret
lz.return %x_18 : !lz.value
}
, {
// ERR: FnBody.unreachable
}
)
 : (!lz.value) -> ()
}
)
 : (!lz.value) -> ()
}
, {
// ERR: FnBody.unreachable
}
)
 : (!lz.value) -> ()
}
```

At least some of the problem is caused by `// ERR: FnBody.unreachable`. Let me teach LEAN how to generate
an unreachable.

```
Writing to out.ppm
./exe-ref.out  532.94s user 8.26s system 712% cpu 1:15.99 total
```

```
line 133 of 133
Writing to out.ppm
./exe.out  514.85s user 7.02s system 746% cpu 1:09.91 total
/home/bollu/work/lz/test/lambdapure/compile$ 
```


Next step, turn on all the passes in the LEAN compiler. This will force me to implement `reset/reuse` etc.
Current status before I turn on more passes:

```
/home/bollu/work/lz/test/lambdapure/compile$ llvm-lit -j1 .
-- Testing: 28 tests, 1 workers --

PASS: HASK_OPT :: lambdapure/compile/bench/deriv.lean (1 of 28)
PASS: HASK_OPT :: lambdapure/compile/bench/qsort.lean (2 of 28)
PASS: HASK_OPT :: lambdapure/compile/bench/unionfind.lean (3 of 28)
PASS: HASK_OPT :: lambdapure/compile/bench/rbmap_checkpoint.lean (4 of 28)
PASS: HASK_OPT :: lambdapure/compile/render.lean (5 of 28)
PASS: HASK_OPT :: lambdapure/compile/pap.lean (6 of 28)
PASS: HASK_OPT :: lambdapure/compile/bench/const_fold.lean (7 of 28)
PASS: HASK_OPT :: lambdapure/compile/jmp.lean (8 of 28)
PASS: HASK_OPT :: lambdapure/compile/ctor.lean (9 of 28)
PASS: HASK_OPT :: lambdapure/compile/loop.lean (10 of 28)
PASS: HASK_OPT :: lambdapure/compile/bench/binarytrees-int.lean (11 of 28)
PASS: HASK_OPT :: lambdapure/compile/bench/binarytrees.lean (12 of 28)
PASS: HASK_OPT :: lambdapure/compile/case.lean (13 of 28)
PASS: HASK_OPT :: lambdapure/compile/main-print.lean (14 of 28)
PASS: HASK_OPT :: lambdapure/compile/ctor-simple.lean (15 of 28)
PASS: HASK_OPT :: lambdapure/compile/bench/filter.lean (16 of 28)
PASS: HASK_OPT :: lambdapure/compile/mutualrec.lean (17 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/exe.mlir (18 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/rbmap3.lean (19 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/map-destruct.mlir (20 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/rbmap2.lean (21 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/map-ref.mlir (22 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/rbmap4.lean (23 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/rbmap500k.lean (24 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/lambdapure.mlir (25 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/map-runtime.mlir (26 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/exe.mlir (27 of 28)
UNRESOLVED: HASK_OPT :: lambdapure/compile/bench/loop.mlir (28 of 28)
********************
Unresolved Tests (11):
  HASK_OPT :: lambdapure/compile/bench/exe.mlir
  HASK_OPT :: lambdapure/compile/bench/lambdapure.mlir
  HASK_OPT :: lambdapure/compile/bench/loop.mlir
  HASK_OPT :: lambdapure/compile/bench/map-destruct.mlir
  HASK_OPT :: lambdapure/compile/bench/map-ref.mlir
  HASK_OPT :: lambdapure/compile/bench/map-runtime.mlir
  HASK_OPT :: lambdapure/compile/bench/rbmap2.lean
  HASK_OPT :: lambdapure/compile/bench/rbmap3.lean
  HASK_OPT :: lambdapure/compile/bench/rbmap4.lean
  HASK_OPT :: lambdapure/compile/bench/rbmap500k.lean
  HASK_OPT :: lambdapure/compile/exe.mlir


Testing Time: 47.74s
  Passed    : 17
  Unresolved: 11
```

#### debugging `lz.jmp` crash

`simpCase` causes `lz.jmp` to crash. Diff between `nocrash.mlir` and `crash.mlir`


```
58,63d57
<           %3 = "lz.papExtend"(%arg3, %arg0) : (!lz.value, !lz.value) -> !lz.value
<           lz.return %3 : !lz.value
<         },  {
<           %3 = "lz.papExtend"(%arg3, %arg0) : (!lz.value, !lz.value) -> !lz.value
<           lz.return %3 : !lz.value
<         },  {
66a61,63
>         },  {
>           %3 = "lz.papExtend"(%arg3, %arg0) : (!lz.value, !lz.value) -> !lz.value
>           lz.return %3 : !lz.value
70,75d66
<           %3 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
<           "lz.jump"(%3) {value = 12 : i64} : (!lz.value) -> ()
<         },  {
<           %3 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
<           "lz.jump"(%3) {value = 12 : i64} : (!lz.value) -> ()
<         },  {
77,78c68,69
<             %3 = "lz.project"(%1) {value = 0 : i64} : (!lz.value) -> !lz.value
<             %4 = "lz.papExtend"(%arg2, %3, %2) : (!lz.value, !lz.value, !lz.value) -> !lz.value
---
>             %3 = "lz.project"(%2) {value = 0 : i64} : (!lz.value) -> !lz.value
>             %4 = "lz.papExtend"(%arg1, %1, %3) : (!lz.value, !lz.value, !lz.value) -> !lz.value
84,87d74
<           },  {
<             %3 = "lz.project"(%2) {value = 0 : i64} : (!lz.value) -> !lz.value
<             %4 = "lz.papExtend"(%arg1, %1, %3) : (!lz.value, !lz.value, !lz.value) -> !lz.value
<             lz.return %4 : !lz.value
88a76,78
>         },  {
>           %3 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
>           "lz.jump"(%3) {value = 11 : i64} : (!lz.value) -> ()
94,96d83
<     },  {
<       %1 = "lz.papExtend"(%arg3, %arg0) : (!lz.value, !lz.value) -> !lz.value
<       lz.return %1 : !lz.value
135c122
<           %3 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__1} : () -> !lz.value
---
>           %3 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__2} : () -> !lz.value
140,142d126
<         },  {
<           %3 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__2} : () -> !lz.value
<           lz.return %3 : !lz.value
146,151d129
<           %3 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
<           "lz.jump"(%3) {value = 8 : i64} : (!lz.value) -> ()
<         },  {
<           %3 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
<           "lz.jump"(%3) {value = 8 : i64} : (!lz.value) -> ()
<         },  {
153c131
<             %3 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__3} : () -> !lz.value
---
>             %3 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__2} : () -> !lz.value
158,160d135
<           },  {
<             %3 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__2} : () -> !lz.value
<             lz.return %3 : !lz.value
161a137,139
>         },  {
>           %3 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
>           "lz.jump"(%3) {value = 7 : i64} : (!lz.value) -> ()
167,169d144
<     },  {
<       %1 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__1} : () -> !lz.value
<       lz.return %1 : !lz.value
176,181d150
<       %1 = "lz.papExtend"(%arg2, %arg0) : (!lz.value, !lz.value) -> !lz.value
<       lz.return %1 : !lz.value
<     },  {
<       %1 = "lz.papExtend"(%arg2, %arg0) : (!lz.value, !lz.value) -> !lz.value
<       lz.return %1 : !lz.value
<     },  {
184a154,156
>     },  {
>       %1 = "lz.papExtend"(%arg2, %arg0) : (!lz.value, !lz.value) -> !lz.value
>       lz.return %1 : !lz.value
197c169
<       %1 = "lz.int"() {value = 420 : i64} : () -> !lz.value
---
>       %1 = "lz.project"(%arg0) {value = 0 : i64} : (!lz.value) -> !lz.value
201,203d172
<       lz.return %1 : !lz.value
<     },  {
<       %1 = "lz.project"(%arg0) {value = 0 : i64} : (!lz.value) -> !lz.value
```

This is caused by the pass `simpCase.lean` which shuffles around case branches.
This now exposes the compiler to more complex code. For example, without
optimisation, I can assume that the case alternatives are in order, such as `0, 1, 2`.
After `simplifyCase`, this is no longer the case, it could have been
transformed into 2, default since the cases for 0 and 1 do the same thing. This
needs me to change lowering.

#### Turning on non-risky passes

To turn on: reset/reuse, borrow, RC.

```
private def compileAux (decls : Array Decl) : CompilerM Unit := do
  -- log (LogEntry.message "// compileAux")
  -- logDecls `init decls
  -- logPreamble (LogEntry.message mlirPreamble)
  -- logDeclsUnconditional decls
  checkDecls decls
  let decls ← elimDeadBranches decls
  logDecls `elim_dead_branches decls
  let decls := decls.map Decl.pushProj
  logDecls `push_proj decls
  -- let decls := decls.map Decl.insertResetReuse
  -- logDecls `reset_reuse decls
  let decls := decls.map Decl.elimDead
  logDecls `elim_dead decls
  let decls := decls.map Decl.simpCase
  logDecls `simp_case decls
  let decls := decls.map Decl.normalizeIds
  -- logDeclsUnconditional decls

  -- let decls ← inferBorrow decls
  -- logDecls `borrow decls
  let decls ← explicitBoxing decls
  logDecls `boxing decls
  -- let decls ← explicitRC decls
  -- logDecls `rc decls
  -- let decls := decls.map Decl.expandResetReuse
  -- logDecls `expand_reset_reuse decls
  let decls := decls.map Decl.pushProj
  logDecls `push_proj decls
  let decls ← updateSorryDep decls
  logDecls `result decls
  checkDecls decls
  addDecls decls
```

Failing tests:

```
HASK_OPT :: lambdapure/compile/bench/deriv.lean
HASK_OPT :: lambdapure/compile/jmp.lean
```


# May 27

Continuing my debugging saga of getting `USize` and its equalities to work:


For whatever reason, it needs the option `bootstrap.genMatcherCode`:

```
set_option bootstrap.genMatcherCode false in
-- @[extern c inline "#1 == #2"]
@[extern c "lean_uint64_eq"]
def UInt64.decEq (a b : UInt64) : Decidable (Eq a b) :=
  match a, b with
  | ⟨n⟩, ⟨m⟩ =>
    dite (Eq n m) (fun h => isTrue (h ▸ rfl)) (fun h => isFalse (fun h' => UInt64.noConfusion h' (fun h' => absurd h' h)))
```

which is documented in `Meta/Match.lean`

```
stage0/src/Lean/Meta/Match/Match.lean
571:register_builtin_option bootstrap.genMatcherCode : Bool := {
583:  let compile := bootstrap.genMatcherCode.get (← getOptions)
```

On implementing new primops, `stage1` fails compiling because of mismatch, `stage2` fails compiling because of incorrect return type?!
Apparently one should return `uint8_t`, not `bool` (as I did when I wrote the include).

```
../build/stage1/lib/temp/Init/Prelude.c:53:9: error: conflicting types for ‘lean_uint64_eq’
   53 | uint8_t lean_uint64_eq(uint64_t, uint64_t);
      |         ^~~~~~~~~~~~~~
In file included from ../build/stage1/lib/temp/Init/Prelude.c:4:
/home/bollu/work/lean4/build/stage1/bin/../include/lean/lean.h:1316:20: note: previous definition of ‘lean_uint64_eq’ was here
 1316 | static inline bool lean_uint64_eq(uint64_t a, uint64_t b) {
      |                    ^~~~~~~~~~~~~~
../build/stage1/lib/temp/Init/Prelude.c:67:9: error: conflicting types for ‘lean_uint8_eq’
   67 | uint8_t lean_uint8_eq(uint8_t, uint8_t);
      |         ^~~~~~~~~~~~~
In file included from ../build/stage1/lib/temp/Init/Prelude.c:4:
/home/bollu/work/lean4/build/stage1/bin/../include/lean/lean.h:1325:20: note: previous definition of ‘lean_uint8_eq’ was here
 1325 | static inline bool lean_uint8_eq(uint8_t a, uint8_t b) {
      |                    ^~~~~~~~~~~~~
../build/stage1/lib/temp/Init/Prelude.c:77:9: error: conflicting types for ‘lean_usize_eq’
   77 | uint8_t lean_usize_eq(size_t, size_t);
      |         ^~~~~~~~~~~~~
In file included from ../build/stage1/lib/temp/Init/Prelude.c:4:
/home/bollu/work/lean4/build/stage1/bin/../include/lean/lean.h:1313:20: note: previous definition of ‘lean_usize_eq’ was here
 1313 | static inline bool lean_usize_eq(size_t a, size_t b) {
      |                    ^~~~~~~~~~~~~
../build/stage1/lib/temp/Init/Prelude.c:544:9: error: conflicting types for ‘lean_uint32_eq’
  544 | uint8_t lean_uint32_eq(uint32_t, uint32_t);
      |         ^~~~~~~~~~~~~~
In file included from ../build/stage1/lib/temp/Init/Prelude.c:4:
/home/bollu/work/lean4/build/stage1/bin/../include/lean/lean.h:1319:20: note: previous definition of ‘lean_uint32_eq’ was here
 1319 | static inline bool lean_uint32_eq(uint32_t a, uint32_t b) {
      |                    ^~~~~~~~~~~~~~
../build/stage1/lib/temp/Init/Prelude.c:732:9: error: conflicting types for ‘lean_uint16_eq’
  732 | uint8_t lean_uint16_eq(uint16_t, uint16_t);
      |         ^~~~~~~~~~~~~~
In file included from ../build/stage1/lib/temp/Init/Prelude.c:4:
/home/bollu/work/lean4/build/stage1/bin/../include/lean/lean.h:1322:20: note: previous definition of ‘lean_uint16_eq’ was here
 1322 | static inline bool lean_uint16_eq(uint16_t a, uint16_t b) {
      |                    ^~~~~~~~~~~~~~
```

The document at `lean4/doc/make/index.md` was very helpful since it talks about the entire build process.


There is something funky about external calls. In particular, I added a TODO where the previous code
would emit incorrect code, while the new does not (see the `TODO: understand why the line does not work`).

```lean
-- | ps: description of formal parameters to the function f.
def emitSimpleExternalCall (f : String) (ps : Array Param) (ys : Array Arg)
  (tys: HashMap VarId IRType) (retty: IRType) : M Unit := do
  -- let fname <- toCName f; -- added by bollu
  let fname := f;
  emit "call "; emit "@"; emit (escape fname)
  -- We must remove irrelevant arguments to extern calls
  let psys := (ps.zip ys).filter (fun py => not (py.fst.ty.isIrrelevant))
  let ys := Array.map Prod.snd psys

  emit "("
  -- We must remove irrelevant arguments to extern calls.
  ys.size.forM (fun i => do
         if i > 0 then emit ", ";
         emitArg ys[i])
  emit ")"
  -- TODO: understand why the line
  --    emit " : ("; emitArgsOnlyTys ys tys; emit ")";
  -- does not work!!!!
  emit " : ("; 
  psys.size.forM (fun i => do
    if i > 0 then emit ","
    emit (toCType psys[i].fst.ty);
  )
  emit ")";

  emit " -> "; emit "(";  emit (toCType retty);  emit ")";
  emit " // <== ERR: emitSimpleExternalCall";
  emit $ " // <== ys: " ++ toString (toStringArgs ys) ++ "| tys: ";
  emit "\n"
  pure ()
```

My implementation of adding types at the beginning of  function was broken.
Fixing that allows us to codegen `binarytrees.lean`.

One of the big hacks of the day is:

```
/home/bollu/work/lean4/lean4-mode$ cp ~/work/lean4/src/include/lean/lean.h ~/work/lean4/build/stage0/include/lean/lean.h
/home/bollu/work/lean4/lean4-mode$ cp ~/work/lean4/src/include/lean/lean.h ~/work/lean4/build/stage1/include/lean/lean.h
```

Ie, I edit the prelude files and force-copy them into the build system. I'm not too sure if this is necessary,
or even correct, but it works once, and I'm too scared to modify the ritual since.

# May 26:


We get code generated like:

```
//ERR: fnBody.vdecl (non-tail) call
// ERR: Expr.fap
%x_8 = x_6 + x_7;
//^^ ERR: ExternEntry.inline [pat: #1 + #2]
// ^^^ ERR: emitFullApp (Decl.extern)
```

because the pattern compiles directly to `a + b`, not some kind of function call `x(`



```
| some (ExternEntry.inline _ pat)     => do 
       emit (expandExternPattern pat (toStringArgs ys)); emitLn ";"
       emitLn $ "//^^ ERR: ExternEntry.inline [pat: " ++ pat ++ "]"; 
```

This expand pattern thing expands into a pattern that's in C-like syntax. It carries
no semantic information for me to generate an actual function call x(. Can I find out
where this pattern comes from? Looking for the pattern `#1 + #2` gives:

```
/home/bollu/work/lean4$ ag -F "#1 + #2"        
stage0/src/Lean/Compiler/ExternAttr.lean
27:- `@[extern cpp inline "#1 + #2"]`
28:   encoding: ```.entries = [inline `cpp "#1 + #2"]```

stage0/src/Init/Data/UInt.lean
17:@[extern c inline "#1 + #2"]
82:@[extern c inline "#1 + #2"]
148:@[extern c inline "#1 + #2"]
200:@[extern c inline "#1 + #2"]
279:@[extern c inline "#1 + #2"]

stage0/src/Init/Data/Float.lean
35:@[extern c inline "#1 + #2"]  constant Float.add : Float → Float → Float

src/Lean/Compiler/ExternAttr.lean
27:- `@[extern cpp inline "#1 + #2"]`
28:   encoding: ```.entries = [inline `cpp "#1 + #2"]```

src/Init/Data/Float.lean
35:@[extern c inline "#1 + #2"]  constant Float.add : Float → Float → Float

src/Init/Data/UInt.lean
17:@[extern c inline "#1 + #2"]
82:@[extern c inline "#1 + #2"]
148:@[extern c inline "#1 + #2"]
200:@[extern c inline "#1 + #2"]
279:@[extern c inline "#1 + #2"]
```

To get a sense of how much this is going to screw me, I looked for all
instances of `extern c inline`: (I deleted the entries from `stage0`, because
those are double):

```
tmp/PreludeNew.lean:@[extern c inline "lean_nat_sub(#1, lean_box(1))"]
tmp/PreludeNew.lean:@[extern c inline "#1 == #2"]
tmp/PreludeNew.lean:@[extern c inline "#1 == #2"]
tmp/PreludeNew.lean:@[extern c inline "#1 == #2"]
tmp/PreludeNew.lean:@[extern c inline "#1 == #2"]
tmp/PreludeNew.lean:@[extern c inline "#1 == #2"]
tmp/PreludeNew.lean:@[extern c inline "#3"]
tests/compiler/lazylist.lean:@[extern c inline "#2"]
src/Lean/Expr.lean:@[extern c inline "(uint8_t)((#1 << 24) >> 61)"]
src/Lean/Expr.lean:@[extern c inline "(uint64_t)#1"]
src/Lean/Util/Path.lean:@[extern c inline "LEAN_IS_STAGE0"]
src/Lean/Compiler/IR/Checker.lean:@[extern c inline "lean_box(LEAN_MAX_CTOR_FIELDS)"]
src/Lean/Compiler/IR/Checker.lean:@[extern c inline "lean_box(LEAN_MAX_CTOR_SCALARS_SIZE)"]
src/Lean/Compiler/IR/Checker.lean:@[extern c inline "lean_box(sizeof(size_t))"]
src/Init/Core.lean:@[extern c inline "#1 || #2"] def strictOr  (b₁ b₂ : Bool) := b₁ || b₂
src/Init/Core.lean:@[extern c inline "#1 && #2"] def strictAnd (b₁ b₂ : Bool) := b₁ && b₂
src/Init/Prelude.lean:@[extern c inline "lean_nat_sub(#1, lean_box(1))"]
src/Init/Prelude.lean:@[extern c inline "#1 == #2"]
src/Init/Prelude.lean:@[extern c inline "#1 == #2"]
src/Init/Prelude.lean:@[extern c inline "#1 == #2"]
src/Init/Prelude.lean:@[extern c inline "#1 < #2"]
src/Init/Prelude.lean:@[extern c inline "#1 <= #2"]
src/Init/Prelude.lean:@[extern c inline "#1 == #2"]
src/Init/Prelude.lean:@[extern c inline "#1 == #2"]
src/Init/Prelude.lean:@[extern c inline "#3"]
src/Init/Data/Float.lean:@[extern c inline "#1 + #2"]  constant Float.add : Float → Float → Float
src/Init/Data/Float.lean:@[extern c inline "#1 - #2"]  constant Float.sub : Float → Float → Float
src/Init/Data/Float.lean:@[extern c inline "#1 * #2"]  constant Float.mul : Float → Float → Float
src/Init/Data/Float.lean:@[extern c inline "#1 / #2"]  constant Float.div : Float → Float → Float
src/Init/Data/Float.lean:@[extern c inline "(- #1)"]   constant Float.neg : Float → Float
src/Init/Data/Float.lean:@[extern c inline "#1 == #2"] constant Float.beq (a b : Float) : Bool
src/Init/Data/Float.lean:@[extern c inline "#1 < #2"]   constant Float.decLt (a b : Float) : Decidable (a < b) :=
src/Init/Data/Float.lean:@[extern c inline "#1 <= #2"] constant Float.decLe (a b : Float) : Decidable (a ≤ b) :=
src/Init/Data/Float.lean:@[extern c inline "(uint8_t)#1"] constant Float.toUInt8 : Float → UInt8
src/Init/Data/Float.lean:@[extern c inline "(uint16_t)#1"] constant Float.toUInt16 : Float → UInt16
src/Init/Data/Float.lean:@[extern c inline "(uint32_t)#1"] constant Float.toUInt32 : Float → UInt32
src/Init/Data/Float.lean:@[extern c inline "(uint64_t)#1"] constant Float.toUInt64 : Float → UInt64
src/Init/Data/Float.lean:@[extern c inline "(size_t)#1"] constant Float.toUSize : Float → USize
src/Init/Data/UInt.lean:@[extern c inline "#1 + #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 - #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 * #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? 0 : #1 / #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? #1 : #1 % #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 & #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 | #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 ^ #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 << #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 >> #2"]
src/Init/Data/UInt.lean:@[extern c inline "~ #1"]
src/Init/Data/UInt.lean:@[extern c inline "#1 < #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 <= #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 + #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 - #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 * #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? 0 : #1 / #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? #1 : #1 % #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 & #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 | #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 ^ #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 << #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 >> #2"]
src/Init/Data/UInt.lean:@[extern c inline "~ #1"]
src/Init/Data/UInt.lean:@[extern c inline "#1 < #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 <= #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 + #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 - #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 * #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? 0 : #1 / #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? #1 : #1 % #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 & #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 | #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 ^ #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 << #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 >> #2"]
src/Init/Data/UInt.lean:@[extern c inline "((uint8_t)#1)"]
src/Init/Data/UInt.lean:@[extern c inline "((uint16_t)#1)"]
src/Init/Data/UInt.lean:@[extern c inline "((uint32_t)#1)"]
src/Init/Data/UInt.lean:@[extern c inline "~ #1"]
src/Init/Data/UInt.lean:@[extern c inline "#1 + #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 - #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 * #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? 0 : #1 / #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? #1 : #1 % #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 & #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 | #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 ^ #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 << #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 >> #2"]
src/Init/Data/UInt.lean:@[extern c inline "((uint8_t)#1)"]
src/Init/Data/UInt.lean:@[extern c inline "((uint16_t)#1)"]
src/Init/Data/UInt.lean:@[extern c inline "((uint32_t)#1)"]
src/Init/Data/UInt.lean:@[extern c inline "((uint64_t)#1)"]
src/Init/Data/UInt.lean:@[extern c inline "~ #1"]
src/Init/Data/UInt.lean:@[extern c inline "(uint64_t)#1"]
src/Init/Data/UInt.lean:@[extern c inline "#1 < #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 <= #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 + #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 - #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 * #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? 0 : #1 / #2"]
src/Init/Data/UInt.lean:@[extern c inline "#2 == 0 ? #1 : #1 % #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 & #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 | #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 ^ #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 << #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 >> #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1"]
src/Init/Data/UInt.lean:@[extern c inline "((size_t)#1)"]
src/Init/Data/UInt.lean:@[extern c inline "(uint32_t)#1"]
src/Init/Data/UInt.lean:@[extern c inline "~ #1"]
src/Init/Data/UInt.lean:@[extern c inline "#1 < #2"]
src/Init/Data/UInt.lean:@[extern c inline "#1 <= #2"]
src/Init/Meta.lean:@[extern c inline "lean_box(LEAN_VERSION_MAJOR)"]
src/Init/Meta.lean:@[extern c inline "lean_box(LEAN_VERSION_MINOR)"]
src/Init/Meta.lean:@[extern c inline "lean_box(LEAN_VERSION_PATCH)"]
src/Init/Meta.lean:-- @[extern c inline "lean_mk_string(LEAN_GITHASH)"]
src/Init/Meta.lean:@[extern c inline "LEAN_VERSION_IS_RELEASE"]
src/Init/Meta.lean:@[extern c inline "lean_mk_string(LEAN_SPECIAL_VERSION_DESC)"]
src/Init/Fix.lean:@[extern c inline "lean_fixpoint(#4, #5)"]
src/Init/Fix.lean:@[extern c inline "lean_fixpoint2(#5, #6, #7)"]
src/Init/Fix.lean:@[extern c inline "lean_fixpoint3(#6, #7, #8, #9)"]
src/Init/Fix.lean:@[extern c inline "lean_fixpoint4(#7, #8, #9, #10, #11)"]
src/Init/Fix.lean:@[extern c inline "lean_fixpoint5(#8, #9, #10, #11, #12, #13)"]
src/Init/Fix.lean:@[extern c inline "lean_fixpoint6(#9, #10, #11, #12, #13, #14, #15)"]
```

Oh god damn, I can't just directly change a line such as:

```
src/Init/Data/UInt.lean:@[extern c inline "#1 + #2"]
```

into:

```
src/Init/Data/UInt.lean:@[extern c inline "add #1, #2"]
```

because the code is *self-hosting*. So if I try to compile stuff using the MLIR backend,
I need to compile LEAN using the MLIR backend x(
One way to "solve" this is to convert `Uint32` to `Int` (The example comes from `test/lambdapure/compile/bench/deriv.lean`):


```diff
-def count : Expr → UInt32
+def count : Expr → Int
| Val _   => 1
| Var _   => 1
| Add f g   => count f + count g
| Mul f g   => count f + count g
| Pow f g   => count f + count g
| Ln f      => count f
```

I'm now trying to hack into the compiler, and change the meaning `Uint` to be an external call:

```diff
--- a/src/Init/Data/UInt.lean
+++ b/src/Init/Data/UInt.lean
@@ -14,8 +14,11 @@ def UInt8.ofNat (n : @& Nat) : UInt8 := ⟨Fin.ofNat n⟩
 abbrev Nat.toUInt8 := UInt8.ofNat
 @[extern "lean_uint8_to_nat"]
 def UInt8.toNat (n : UInt8) : Nat := n.val.val
-@[extern c inline "#1 + #2"]
+-- @[extern c inline "#1 + #2"]
+-- @[extern c inline "add #1, #2"]
+@[extern "lean_uint8_add"]
 def UInt8.add (a b : UInt8) : UInt8 := ⟨a.val + b.val⟩
+
 @[extern c inline "#1 - #2"]
 def UInt8.sub (a b : UInt8) : UInt8 := ⟨a.val - b.val⟩
 @[extern c inline "#1 * #2"]
@@ -145,7 +148,8 @@ def UInt32.ofNat (n : @& Nat) : UInt32 := ⟨Fin.ofNat n⟩
 @[extern "lean_uint32_of_nat"]
 def UInt32.ofNat' (n : Nat) (h : n < UInt32.size) : UInt32 := ⟨⟨n, h⟩⟩
 abbrev Nat.toUInt32 := UInt32.ofNat
-@[extern c inline "#1 + #2"]
+@[extern "lean_uint32_add"]
+-- @[extern c inline "#1 + #2"]
```

This hack works, and I now generate the "expected" MLIR code. I'm surprised that the compiler
still self-hosts; I expected linker errors for missing reference to `lean_uint32_add`.
It seems like the lean compiler does not in fact use `uint32` all that much.

Remember, if you builds run slower than real LEAN, it's probably because you're encoding equality of `UIntN`
is some extremely stupid way!

```
-- set_option bootstrap.genMatcherCode false in
-- @[extern c inline "#1 == #2"]
```

what is `genMatcherCode`? Will be interesting to find out


# May 23:

should `caseRet` be a terminator? If it is a terminator, how should it lower? if it lowers to a `scf.if`,
what instruction should it keep "after" its insertion? should it emit a `std.return` or a `scf.yield`?
this would depend on the parent (!) 


What is the return type of a `lz.caseRet`? So far, I was doing weird
shit like looking at the case branch. Maybe it's possible to do this in some
other way?

[WIP] give up on SCF.if

The `SCF.if` by default inserts a `scf.yield` which is first of all
annoying.

Furthermore, the problem is that `scf.if` creates a region from which
we need to region values from. This complicates basically everything
about generating code, because I can't generate code with the semantics:

```
int foo(int x) {
    if (x == 1) { return -1; }
    if (x == 2) { return -2; }
    return -42;
}
```

because `return` can only return from a *region*, not escape out of an enclosing region. We would
need this power to be able to useful things.

I'm gonna say fuck this and just directly generate BBs.

Seriously, LLVM is JUST BETTER!


Is `replaceOpWithNewOp<NewOpTy>(oldOp ...)` supposed to trigger a `isDynamicallyLegal(NewOpTy)`?
It doesn't seem to for me, and I don't know if this me doing something wrong.


There is a failure mode where:

- We are working on some op (say, `LzJoinPoint`)
- This op needs to replace its children (say, `LzJump(lz.construct(..))`)
- `LzJump` is rewritten into a STANDARD op (say, `BranchOp`)
- The ARGUMENT for `BranchOp` is a value `lz.construct(..)` of  illegal type (say, `!lz.value`)
- This type WILL BE FIXED LATER ON! at the end of lowering.
- However, the act of creating a `BranchOp` causes legalization to fail, saying that the type `!lz.value` is illegal.
- What we need is for `BranchOp` to attempt to legalize `lz.construct(..)`
- We can't let `LzJumpOp` be processed in a separate pass, because once `LzJoinPoint` is lowered, `LzJump` does not know
  where to JUMP TO!
- MLIR needs to recognize that sometimes, having a TYPE MISMATCH is not AN ERROR, but is a STAGE of LOWERING.
  Other passes like async seem to emit a `bitcast` and then assume (?) that the bitcast lowers correctly.
- More importantly, MLIR needs to recognize that during lowering, someone might want to generate more illegal
  ops that can be legalized.


God damn it, I can't even directly generate a new BB `^jpblock` for a join point and a `br ^jpblock`, because the
branch instruction may need to jump  outside a region x(


```llvm
func @foo() {
    ^jp12(...):
    ...
    case %x 
    1 -> {
    %foo = ...;
    br ^jp12(...); // ERROR! can't jump to join point that is outside the region.
    }]
}
```

- Observation 1: Okay, screw this, I'm going to disable join points as tobias suggested, and just deal with code bloat.
- Observation 2: model nested case/multi-dimensional case directly within MLIR.

We also lose out on our `case`s. Before, I could generate a `case` as:

```
%x = case v of alt0 -> { y0 }, alt1 -> { y1 }, alt2 -> { y2 }
%user = foo %x
```

when we lower this, we generate sth like:

```
^entry:
  switch v bb0 bb1 bb2

^bb0: br ^landingpad(y0)
^bb1: br ^landingpad(y1)
^bb2: br ^landingpad(y2)

^landingpad(%x):
  %user = foo %x
```

where we have a landing pad. Now imagine we have a case with a `jmp` inside it:


```
joinpoint @jp { ... }
{
    %wrench = jmp @jp
    %x = case v of alt0 -> { y0 }, alt1 -> { y1 }, alt2 -> { jmp @jp }
    %user = foo %x
}
```

This code doesn't make sense, since we're saying "continue executing code from `@jp` at both `%wrench`
and at `%x`. When we lower this, there is no way to get clean control flow, because the control flow of `case`
is no longer CONTAINED WITHIN `case`! we can't always convert a `lz.caseRet` [which is a terminator/continuation]
into a `lz.case` which returns a value, because of these jumps. IDK what this is actually called.

# May 20th, list of jumps:

- occruences of `mkJmp` in `src/`:
```
Lean/Compiler/IR/Basic.lean
288:@[export lean_ir_mk_jmp] def mkJmp (j : JoinPointId) (ys : Array Arg) : FnBody := FnBody.jmp j ys

Lean/Elab/Do.lean
302:def mkJmp (ref : Syntax) (rs : NameSet) (val : Syntax) (mkJPBody : Syntax → MacroM Code) : StateRefT (Array JPDecl) TermElabM Code := do
325:  | rs, Code.«return» ref val      => mkJmp ref rs val (fun y => pure $ Code.«return» ref y)
330:      mkJmp ref rs y (fun yFresh => do pure $ Code.action (← `(Pure.pure $yFresh)))
978:def mkJmp (ref : Syntax) (j : Name) (args : Array Syntax) : Syntax :=
987:  | Code.jmp ref j args     => pure $ mkJmp ref j args
/home/bollu/work/lean4/src$ ag "lean_ir_mk_jmp"
Lean/Compiler/IR/Basic.lean
288:@[export lean_ir_mk_jmp] def mkJmp (j : JoinPointId) (ys : Array Arg) : FnBody := FnBody.jmp j ys

library/compiler/ir.cpp
39:extern "C" object * lean_ir_mk_jmp(object * j, object * ys);
87:    return fn_body(lean_ir_mk_jmp(j.to_obj_arg(), to_array(ys)));
```

- occruences of `jmp` in `src/`
```
Lean/Compiler/IR/OldFormatMLIR.lean:--   | FnBody.jmp j ys            => "jmp " ++ format j ++ formatArray ys
Lean/Compiler/IR/OldFormatMLIR.lean:--     | FnBody.jmp j ys            => (escape "lz.jump") ++ "("  ++ formatArray ys ++ ")"
Lean/Compiler/IR/ResetReuse.lean:       then it must also live in `b` since `j` is reachable from `b` with a `jmp`.
Lean/Compiler/IR/ResetReuse.lean:           since `instr` is not a `FnBody.jmp` (it is not a terminal) nor it is a `FnBody.jdecl`. -/
Lean/Compiler/IR/RC.lean:  | b@(FnBody.jmp j xs), ctx =>
Lean/Compiler/IR/EmitC.lean:  | FnBody.jmp j xs            => emitJmp j xs
Lean/Compiler/IR/Checker.lean:  | FnBody.jmp j ys         => checkJP j *> checkArgs ys
Lean/Compiler/IR/FreeVars.lean:  | FnBody.jmp j ys         => collectJP j >> collectArgs ys
Lean/Compiler/IR/FreeVars.lean:  | FnBody.jmp j ys         => collectJP j >> collectArgs ys
Lean/Compiler/IR/FreeVars.lean:  | FnBody.jmp j ys         => visitJP w j || visitArgs w ys
Lean/Compiler/IR/NormIds.lean:  | FnBody.jmp j ys        => return FnBody.jmp (← normJP j) (← normArgs ys)
Lean/Compiler/IR/NormIds.lean:  | FnBody.jmp j ys              => FnBody.jmp j (mapArgs f ys)
Lean/Compiler/IR/Boxing.lean:  | FnBody.jmp j ys          => do
Lean/Compiler/IR/Boxing.lean:    castArgsIfNeeded ys ps fun ys => pure $ FnBody.jmp j ys
Lean/Compiler/IR/Format.lean:  | FnBody.jmp j ys            => "jmp " ++ format j ++ formatArray ys
Lean/Compiler/IR/Format.lean:    | FnBody.jmp j ys            => "jmp " ++ format j ++ formatArray ys
Lean/Compiler/IR/LiveVars.lean:   jmp block_1 x
Lean/Compiler/IR/LiveVars.lean:  | FnBody.jmp j ys         => visitArgs w ys <||> do
Lean/Compiler/IR/LiveVars.lean:   `FnBody.jmp j ys` and `j` is not local. -/
Lean/Compiler/IR/LiveVars.lean:  | FnBody.jmp j xs,         m => collectJP m j ∘ collectArgs xs
Lean/Compiler/IR/EmitMLIR.lean:  | FnBody.jmp j xs            => do
Lean/Compiler/IR/EmitMLIR.lean:      emitLn "// ERR: FnBody.jmp"
Lean/Compiler/IR/Basic.lean:  | jmp (j : JoinPointId) (ys : Array Arg)
Lean/Compiler/IR/Basic.lean:@[export lean_ir_mk_jmp] def mkJmp (j : JoinPointId) (ys : Array Arg) : FnBody := FnBody.jmp j ys
Lean/Compiler/IR/Basic.lean:  | FnBody.jmp _ _       => true
Lean/Compiler/IR/Basic.lean:  | ρ, FnBody.jmp j₁ ys₁,             FnBody.jmp j₂ ys₂             => j₁ == j₂ && aeqv ρ ys₁ ys₂
Lean/Compiler/IR/ElimDeadBranches.lean:  | FnBody.jmp j xs => do
Lean/Compiler/IR/Borrow.lean:  | FnBody.jmp j ys      => do
library/compiler/ir.cpp:extern "C" object * lean_ir_mk_jmp(object * j, object * ys);
library/compiler/ir.cpp:fn_body mk_jmp(jp_id const & j, buffer<arg> const & ys) {
library/compiler/ir.cpp:    return fn_body(lean_ir_mk_jmp(j.to_obj_arg(), to_array(ys)));
library/compiler/ir.cpp:    static bool is_jmp(expr const & e) {
library/compiler/ir.cpp:        return is_llnf_jmp(get_app_fn(e));
library/compiler/ir.cpp:    ir::fn_body visit_jmp(expr const & e) {
library/compiler/ir.cpp:        return ir::mk_jmp(to_jp_id(jp), ir_args);
library/compiler/ir.cpp:        } else if (is_jmp(e)) {
library/compiler/ir.cpp:            return visit_jmp(e);
library/compiler/llnf.cpp:static expr * g_jmp         = nullptr;
library/compiler/llnf.cpp:/* The `_jmp` instruction is a "jump" to a join point. */
library/compiler/llnf.cpp:expr mk_llnf_jmp() { return *g_jmp; }
library/compiler/llnf.cpp:bool is_llnf_jmp(expr const & e) { return e == *g_jmp; }
library/compiler/llnf.cpp:        is_llnf_jmp(e)     ||
library/compiler/llnf.cpp:                return mk_app(mk_app(mk_llnf_jmp(), fn), args);
library/compiler/llnf.cpp:    g_jmp       = new expr(mk_constant("_jmp"));
library/compiler/llnf.cpp:    mark_persistent(g_jmp->raw());
library/compiler/llnf.cpp:    delete g_jmp;
library/compiler/cse.cpp:    expr replace_target(expr const & e, expr const & target, expr const & jmp) {
library/compiler/cse.cpp:                    return some_expr(jmp);
library/compiler/cse.cpp:        buffer<pair<expr, expr>> target_jmp_pairs;
library/compiler/cse.cpp:                expr jmp         = mk_app(new_fvar, unit_mk);
library/compiler/cse.cpp:                            target_jmp_pairs.emplace_back(target, jmp);
library/compiler/cse.cpp:                body = replace_target(body, target, jmp);
library/compiler/cse.cpp:        if (is_let && !target_jmp_pairs.empty()) {
library/compiler/cse.cpp:                    for (pair<expr, expr> const & p : target_jmp_pairs) {
library/compiler/llnf.h:bool is_llnf_jmp(expr const & e);
library/compiler/ir_interpreter.cpp:jp_id const & fn_body_jmp_jp(fn_body const & b) { lean_assert(fn_body_tag(b) == fn_body_kind::Jmp); return cnstr_get_ref_t<jp_id>(b, 0); }
library/compiler/ir_interpreter.cpp:array_ref<arg> const & fn_body_jmp_args(fn_body const & b) { lean_assert(fn_body_tag(b) == fn_body_kind::Jmp); return cnstr_get_ref_t<array_ref<arg>>(b, 1); }
library/compiler/ir_interpreter.cpp:                    fn_body const & jp = *m_jp_stack[get_frame().m_jp_bp + fn_body_jmp_jp(b).get_small_value()];
library/compiler/ir_interpreter.cpp:                    lean_assert(fn_body_jdecl_params(jp).size() == fn_body_jmp_args(b).size());
library/compiler/ir_interpreter.cpp:                        var(param_var(fn_body_jdecl_params(jp)[i])) = eval_arg(fn_body_jmp_args(b)[i]);
Lean/Elab/Do.lean:  - `jmp`       a goto to a join-point
Lean/Elab/Do.lean:  - For every `jmp ref j as` in `C`, there is a `joinpoint j ps b k` and `jmp ref j as` is in `k`, and
Lean/Elab/Do.lean:  | jmp          (ref : Syntax) (jpName : Name) (args : Array Syntax)
Lean/Elab/Do.lean:    | Code.jmp _ j xs             => m!"jmp {j.simpMacroScopes} {xs.toList}"
Lean/Elab/Do.lean:    | Code.jmp _ _ _          => false
Lean/Elab/Do.lean:/- Convert `action _ e` instructions in `c` into `let y ← e; jmp _ jp (xs y)`. -/
Lean/Elab/Do.lean:      let jmpArgs := xs.map $ mkIdentFrom ref
Lean/Elab/Do.lean:      let jmpArgs := jmpArgs.push y
Lean/Elab/Do.lean:      pure $ Code.jmp ref jp jmpArgs
Lean/Elab/Do.lean:    return Code.jmp ref jp #[unit]
Lean/Elab/Do.lean:    return Code.jmp ref jp (xs.map $ mkIdentFrom ref)
Lean/Elab/Do.lean:  pure $ Code.jmp ref jp args
Lean/Elab/Do.lean:  | rs, c@(Code.jmp _ _ _)         => pure c
Lean/Elab/Do.lean:jmp jp x
Lean/Elab/Do.lean:jmp jp x
Lean/Elab/Do.lean:jmp jp y x
Lean/Elab/Do.lean:   and replace the `return _ y` with `jmp us y`
Lean/Elab/Do.lean:   and replace the `break` with `jmp us`.
Lean/Elab/Do.lean:  | Code.jmp ref j args     => pure $ mkJmp ref j args
```

# May 19th

```
src/shell/lean
add_executable(lean lean.cpp)
```

which calls `run_new_frontend`. This gets a `pair_ref<environment, object_ref>`.,
which is then passed to `cout << lean::ir::emit_c(env, *main_module_name).data();`
So the call to the type checker must happen somewhere in the fronend after elaboration.
Where? Also, there is a `src/Lean/Meta/{Basic.lean,InferType.lean}` that seems to contain
everything needed to implement NbE / type checking / inference. So I don't really understand
where the LEAN kernel interfaces. I found a part of the link by looking for `is_def_eq` as
it is part of the public facing API of the type checker:

```
Lean/Environment.lean
namespace Kernel
/- Kernel API -/

/--
  Kernel isDefEq predicate. We use it mainly for debugging purposes.
  Recall that the Kernel type checker does not support metavariables.
  When implementing automation, consider using the `MetaM` methods. -/
@[extern "lean_kernel_is_def_eq"]
constant isDefEq (env : Environment) (lctx : LocalContext) (a b : Expr) : Bool

/--
  Kernel WHNF function. We use it mainly for debugging purposes.
  Recall that the Kernel type checker does not support metavariables.
  When implementing automation, consider using the `MetaM` methods. -/
@[extern "lean_kernel_whnf"]
constant whnf (env : Environment) (lctx : LocalContext) (a : Expr) : Expr

end Kernel
```
Grepping for uses of `lean_kernel_` gave me just this:

```
/home/bollu/work/lean4/src$ ag "lean_kernel_"
Lean/Environment.lean
689:@[extern "lean_kernel_is_def_eq"]
696:@[extern "lean_kernel_whnf"]

kernel/type_checker.cpp
1019:extern "C" uint8 lean_kernel_is_def_eq(lean_object * env, lean_object * lctx, lean_object * a, lean_object * b) {
1023:extern "C" lean_object * lean_kernel_whnf(lean_object * env, lean_object * lctx, lean_object * a) {
```


I now remember my mental model that I had forgotten:
Join points are awkward since we can `jmp` from anywhere, including a `case`. So LEAN can generate
code that looks like:

```llvm
joinpoint {
  // stuff that runs after a jmp
}, {
 // stuff that runs first

 %out = case x of 
   [@Foo -> {
        ...
        jmp
   }]
   [@Bar -> {
        ...
        return 42 (?)
   }]
}
```

This makes CFG generation SUPER awkward, since we generally generate a `case`
as a ladder of `if-then-else` [due to the lack of `mlir.llvm.switch` in MLIR].
So now, we need to generate the equivalent of:


```cpp
out = undef;
if (x.tag == FOO) {
  goto jp; // joinpoint
} else if (x.tag == BAR) {
  ...
  out = 42
}


jp:
 ...
```

I'm now double-checking that my mental model indeed matches reality, because
this seems very convoluted.

This is generated by running my version of `lean` () against `./test/lambdapure/simple/jmp.lean`

```llvm
// -- before converting `caseRet` -> `case`.
"lz.joinpoint"() ( { // :AFTER JUMP CODE.
^bb0(%arg4: !lz.value):  // no predecessors
  "lz.caseRet"(%1) ( {
    %2 = "lz.papExtend"(%arg3, %arg0) : (!lz.value, !lz.value) -> !lz.value
    lz.return %2 : !lz.value
  },  {
    %2 = "lz.papExtend"(%arg3, %arg0) : (!lz.value, !lz.value) -> !lz.value
    lz.return %2 : !lz.value
  },  {
    %2 = "lz.project"(%1) {value = 0 : i64} : (!lz.value) -> !lz.value
    %3 = "lz.papExtend"(%arg1, %0, %2) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %3 : !lz.value
  }) : (!lz.value) -> ()
},  {
// BEFORE JUMP CODE.
// For one, I'm unsure if my encoding of "jump" as "jump to enclosing join-point"
// is even correct, because in the LEAN encoding, join points carry labels, so maybe it's
// possible to have nested join-points that one can jump out of. I'll have to re-read
// the GHC paper to be sure...

  "lz.caseRet"(%0) ( {
    %2 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
    "lz.jump"(%2) {value = 12 : i64} : (!lz.value) -> () // <- JUMP out of case
  },  {
    %2 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
    "lz.jump"(%2) {value = 12 : i64} : (!lz.value) -> () // <- JUMP out of case
  },
```


The problem with the code above is that I can't assume that the correct way to
codegen a `case` is to (1) produce a switch-case (2) set "output" variable to
value (3) merge control flow back into landingpad BB.

```llvm
// after converting `caseRet` into `case:
"lz.joinpoint"() ( {
^bb0(%arg1: !lz.value):  // no predecessors
  %3 = "lz.case"(%2) ( {
    %4 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__1} : () -> !lz.value
    lz.return %4 : !lz.value
  },  {
    %4 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__1} : () -> !lz.value
    lz.return %4 : !lz.value
  },  {
    %4 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__2} : () -> !lz.value
    lz.return %4 : !lz.value
  }) {alt0 = @"0", alt1 = @"1", alt2 = @"2"} : (!lz.value) -> !lz.value
  lz.return %3 : !lz.value
},  {
  %3 = "lz.case"(%1) ( {
    %4 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
    // vvv case is supposed to end with a `ret`, not a `jump`.
    "lz.jump"(%4) {value = 8 : i64} : (!lz.value) -> () // <- DOES NOT MAKE SENSE
  },  {
    %4 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
    // vvv case is supposed to end with a `ret`, not a `jump`.
    "lz.jump"(%4) {value = 8 : i64} : (!lz.value) -> () // <- DOES NOT MAKE SENSE
  },  {
    %4 = "lz.case"(%2) ( {
      %5 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__3} : () -> !lz.value
      lz.return %5 : !lz.value
    },  {
      %5 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__3} : () -> !lz.value
      lz.return %5 : !lz.value
    },  {
      %5 = "ptr.loadglobal"() {value = @l_Expr_eval___closed__2} : () -> !lz.value
      lz.return %5 : !lz.value
    }) {alt0 = @"0", alt1 = @"1", alt2 = @"2"} : (!lz.value) -> !lz.value
    lz.return %4 : !lz.value
  }) {alt0 = @"0", alt1 = @"1", alt2 = @"2"} : (!lz.value) -> !lz.value
  lz.return %3 : !lz.value
}) : () -> ()
```

See that the above does not make sense. I need to either change a `jump` into
an instruction that generates into a `call` or something. However, then I don't
understand how to deal with local variables/scoping. For example,
this is generated from `./test/lambdapure/bench/const_fold.lean`, the first
`joinpoint` use:

```
%1 = "lz.project"(%arg1) {value = 0 : i64} : (!lz.value) -> !lz.value
%2 = "lz.project"(%arg1) {value = 1 : i64} : (!lz.value) -> !lz.value
"lz.joinpoint"() ( {
^bb0(%arg6: !lz.value):  // no predecessors
  // vvvvUSE of %2 inside the joinpoint BB. vvvv
  "lz.caseRet"(%2) ( { 
    %3 = "lz.papExtend"(%arg5, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %3 : !lz.value
  },  {
    %3 = "lz.project"(%2) {value = 0 : i64} : (!lz.value) -> !lz.value
    %4 = "lz.papExtend"(%arg3, %0, %1, %3) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %4 : !lz.value
  },  {
    %3 = "lz.papExtend"(%arg5, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %3 : !lz.value
  },  {
    %3 = "lz.papExtend"(%arg5, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %3 : !lz.value
  }) : (!lz.value) -> ()
},  {
  ...
}
```

I think the simplest way to proceed is to assume that case does not need to return a value,
and simply generate code as nested cases. This makes me somewhat disgruntled, since we 
essentially lose all SSA niceness. We are like, encoding the continuation-style directly
using nested regions or whatever?


# May 4

- Experimenting with LLVM, [trying to understand what example of mutual recursion is useful](https://gist.github.com/bollu/1da616fb3cd13501f1fdb3c44d4370be#file-main-o3-ll-L97-L109).
- Pinged Leo asking for a file that shows off the example he had in mind, so I don't solve a problem
  that's orthogonal to what the LEAN folks have.
- It's a little unclear to me what to work on next. I *think* in terms of
  completing the paper, it would be useful to either have an example where (1) we
  do something non-trivial to LEAN IR by lowering carefully, or (2) embed a DSL
  into Lean for things like `affine.for`. The latter is annoying due to LEANisms.
  I had tried generating combinators on the LEAN level. So a program like this:

```lean
inductive Vec : Type
| VecNum (l: Nat) (i: Nat): Vec
| VecAdd (v: Vec) (w: Vec) : Vec
| VecSum (v: Vec): Vec
open Vec

-- | consume all values so the optimiser doesn't remove everything.
def runvec : Vec -> IO Unit
| VecNum _ _ => IO.print "vecnum"
| VecAdd x y => runvec x *> runvec y
| VecSum v => runvec v

def vecnum (l: Nat) (i: Nat): Vec := (VecNum l i)
def vecadd (v: Vec) (w: Vec): Vec := (VecAdd v w)
def vecsum (v: Vec) : Vec := (VecSum v)

def main (xs: List String) : IO Unit := do
  runvec (vecsum (vecadd (vecnum 10 41) (vecnum 10 1)))
```

This generates lambdapure where all the "computation" of building these
combinators happens in the init functions, and main simply prints the _already
computed_ initialized data. This is a problem, since the "building the
combinators" (which LEAN decides to precompute) is in fact that real
(description of) the computation! For reference, the lambdapure is:

```
def main._closed_1 : obj :=
  let x_1 : obj := 10;
  let x_2 : obj := 41;
  let x_3 : obj := ctor_0[Vec.VecNum] x_1 x_2;
  ret x_3
def main._closed_2 : obj :=
  let x_1 : obj := 10;
  let x_2 : obj := 1;
  let x_3 : obj := ctor_0[Vec.VecNum] x_1 x_2;
  ret x_3
def main._closed_3 : obj :=
  let x_1 : obj := main._closed_1;
  let x_2 : obj := main._closed_2;
  let x_3 : obj := ctor_1[Vec.VecAdd] x_1 x_2;
  ret x_3
def main._closed_4 : obj :=
  let x_1 : obj := main._closed_3;
  let x_2 : obj := ctor_2[Vec.VecSum] x_1;
  ret x_2
def main (x_1 : obj) (x_2 : obj) : obj :=
  let x_3 : obj := main._closed_4;
  let x_4 : obj := runvec x_3 x_2;
  ret x_4// Lean compiler output
```

which on lowering naively, becomes something like:


```cpp
lean_object* _lean_main(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; lean_object* x_4;
x_3 = l_main___closed__4;
x_4 = l_runvec(x_3, x_2);
return x_4;
}
}
```


So the interesting part of "build the combinator" (which for us, is the real
description of the computation itself) is relegated to initialization. 

I asked Leo if there
an easy way to generate the code differently, where LEAN emits actual calls for
the combinators. He replied tersely, saying that

> you can disable the extraction of closed terms using the option.

```
set_option compiler.extract_closed false
```

This comment was perfect; If I enable the option, I generate the following MLIR:

```llvm
  func @main_lean_custom_entrypoint_hack(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %0 = "lz.int"() {value = 10 : i64} : () -> !lz.value
    %1 = "lz.int"() {value = 41 : i64} : () -> !lz.value
    %2 = "lz.construct"(%0, %1) {dataconstructor = @"0", name = "Vec.VecNum", size = 2 : i64} : (!lz.value, !lz.value) -> !lz.value
    %3 = "lz.int"() {value = 1 : i64} : () -> !lz.value
    %4 = "lz.construct"(%0, %3) {dataconstructor = @"0", name = "Vec.VecNum", size = 2 : i64} : (!lz.value, !lz.value) -> !lz.value
    %5 = "lz.construct"(%2, %4) {dataconstructor = @"1", name = "Vec.VecAdd", size = 2 : i64} : (!lz.value, !lz.value) -> !lz.value
    %6 = "lz.construct"(%5) {dataconstructor = @"2", name = "Vec.VecSum", size = 1 : i64} : (!lz.value) -> !lz.value
    %7 = call @l_runvec(%6, %arg1) : (!lz.value, !lz.value) -> !lz.value
    lz.return %7 : !lz.value
  }
```

where we can clearly see that the data structure representing the computation is built, followed up by a call to `l_runvec.`
This is IR that I can optimize!


Also, I've been reading through the LEAN sources. It seems their parsing framework is very extensible. In particular,
[`src/Parser/Basic.lean](https://github.com/leanprover/lean4/blob/master/src/Lean/Parser/Basic.lean#L34-L41) says:


> * flexibility: Lean's grammar is complex and includes indentation and other whitespace sensitivity. It should be
>   possible to introduce such custom "tweaks" locally without having to adjust the fundamental parsing approach.
> * extensibility: Lean's grammar can be extended on the fly within a Lean file, and with Lean 4 we want to extend this
>   to cover embedding domain-specific languages that may look nothing like Lean, down to using a separate set of tokens.


> Given these constraints, we decided to implement a combinatoric, non-monadic,
> lexer-less, memoizing recursive-descent parser. Using combinators instead of
> some more formal and introspectible grammar representation ensures ultimate
> flexibility as well as efficient extensibility: there is (almost) no
> pre-processing necessary when extending the grammar with a new parser.


Their `do`-notation as well as all function call related features such as implicit arguments are implemented
directly in the elaborator. I almost wonder if it's possible to embed generic MLIR into LEAN directly, since the MLIR
grammar is quite straightforward.

# May 3

- Lean has a `#if defined(LEAN_LLVM)`. What for? How do I make it better? `:)`.

- Who calls the type checker? Start at `shell/lean.cpp`. No leads
- Look for `infer_type`. Find it in `library/compiler/lcnf.cpp`. Now find users of `to_lcnf` (lambda-core-normal-form)?

```
/home/bollu/work/lean4/src$ ag "to_lcnf"
library/compiler/compiler.cpp
202:    ds = apply(to_lcnf, env, ds);
```

```
library/compiler/compiler.cpp
162 environment compile(environment const & env, options const & opts, names cs) {
202    ds = apply(to_lcnf, env, ds);
203    ds = apply(find_jp, env, ds);
```


and `compile` is called at:


```
library/compiler/compiler.cpp
extern "C" object * lean_compile_decl(object * env, object * opts, object * decl) {
    return catch_kernel_exceptions<environment>([&]() {
            return compile(environment(env), options(opts, true), get_decl_names_for_code_gen(declaration(decl, true)));
        });
}
```

I am completely unsure as to how this relates to the actual `shell`?

It's also in the header:

```
library/compiler/compiler.h
environment compile(environment const & env, options const & opts, names cs);
inline environment compile(environment const & env, options const & opts, name const & c) {
    return compile(env, opts, names(c));
}
```

so maybe shell calls it?

```
shell/lean.cpp

contents = read_file(mod_fn);
main_module_name = module_name_of_file(mod_fn, root_dir, /* optional */ !olean_fn && !c_output);

if (!main_module_name)
    main_module_name = name("_stdin");
pair_ref<environment, object_ref> r = run_new_frontend(contents, opts, mod_fn, *main_module_name);

if (run && ok) {
    uint32 ret = ir::run_main(env, opts, argc - optind, argv + optind);
    // environment_free_regions(std::move(env));
    return ret;
}
```

- `run_new_frontent` calls into `Lean/Elab/Frontend.lean`, the entrypoint for frontend related shenanigans.

```
shell/lean.cpp
326:extern "C" object * lean_run_frontend(object * input, object * opts, object * filename, object * main_module_name, object * w);
329:        lean_run_frontend(mk_string(input), opts.to_obj_arg(), mk_string(file_name), main_module_name.to_obj_arg(), io_mk_world()));

Lean/Elab/Frontend.lean
91:@[export lean_run_frontend]
```

Righto, so shell calls `lean_run_frontend` which somehow magically calls `compile`. Let's see the exports!


```
/home/bollu/work/lean4$ ag "lean_compile_decl"
...
stage0/src/Lean/Environment.lean
132:@[extern "lean_compile_decl"]

src/Lean/Environment.lean
133:@[extern "lean_compile_decl"]

src/library/compiler/compiler.cpp
261:extern "C" object * lean_compile_decl(object * env, object * opts, object * decl) {

stage0/src/library/compiler/compiler.cpp
262:extern "C" object * lean_compile_decl(object * env, object * opts, object * decl) {

```

Look at what this `lean_compile_decl` looks like in `src/Lean/Environment.lean`:

```
src/lean/Environment.lean
namespace Environment

/- Type check given declaration and add it to the environment -/
@[extern "lean_add_decl"]
constant addDecl (env : Environment) (decl : @& Declaration) : Except KernelException Environment

/- Compile the given declaration, it assumes the declaration has already been added to the environment using `addDecl`. -/
@[extern "lean_compile_decl"]
constant compileDecl (env : Environment) (opt : @& Options) (decl : @& Declaration) : Except KernelException Environment
```

Great, now let's go see who calls compileDecl.

```
/home/bollu/work/lean4/src$ ag "compileDecl" --type-add "lean:*.lean" -t lean
Lean/Environment.lean
134:constant compileDecl (env : Environment) (opt : @& Options) (decl : @& Declaration) : Except KernelException Environment
138:  compileDecl env opt decl

Lean/MonadEnv.lean
133:def compileDecl [Monad m] [MonadEnv m] [MonadError m] [MonadOptions m] (decl : Declaration) : m Unit := do
134:  match (← getEnv).compileDecl (← getOptions) decl with
142:  compileDecl decl

Lean/Elab/Declaration.lean
86:        compileDecl decl

Lean/Elab/BuiltinNotation.lean
101:  compileDecl decl

Lean/Elab/PreDefinition/Basic.lean
113:      compileDecl decl
134:    compileDecl decl

Lean/Elab/Binders.lean
71:    compileDecl decl

Lean/Meta/Match/Match.lean
600:      compileDecl decl

Lean/Meta/Closure.lean
364:    compileDecl decl
```

So it seems like the users are in `Lean/Elab` (sensible) and `Lean/Meta` (unsure what this is).

Here's what `Lean/Meta/Basic.lean` says:

```
src/Lean/Meta/Basic.lean
/-
This module provides four (mutually dependent) goodies that are needed for building the elaborator and tactic frameworks.
1- Weak head normal form computation with support for metavariables and transparency modes.
2- Definitionally equality checking with support for metavariables (aka unification modulo definitional equality).
3- Type inference.
4- Type class resolution.

They are packed into the MetaM monad.
-/
```

# April 12

Try and use passes:
```
  --mlir-pretty-debuginfo                               - Print pretty debug info in MLIR output
  --mlir-print-debug-counter                            - Print out debug counter information after all counters have been accumulated
  --mlir-print-debuginfo                                - Print debug info in MLIR output
```



# April 4

- Measure how much "flattening the IR" by lifting stuff out of case improves cyclomatic complexity


# April 2

Quick update: I can now roundtrip the simplest of LEAN programs using the LEAN
runtime. We generate MLIR (`lz`, though not a lot of it because the example has
no, say, data constructors), lower to `mlir-llvm`, convert to `llvm`, then link
against the LEAN runtime + [eldritch horrors](https://github.com/bollu/lz/blob/master/lean-linking-incantations/lean-shell.c)
to produce an executable. 

1. We have a [`lean-linking-incantations/library/library.c/o`](https://github.com/bollu/lz/blob/master/lean-linking-incantations/lib-includes/library.c).
   This has separate copy of [`include/lean/lean.h`](https://github.com/bollu/lz/blob/master/lean-linking-incantations/lib-includes/lean/lean.h)
  **which has be un-`static`d** so we still have symbols in the object files.
  Compare the ORIGINAL [`include/lean/lean.h`](https://github.com/leanprover/lean4/blob/master/stage0/src/include/lean/lean.h#L553-L562)
  where all declarations are `static`, and thus won't be present in the final `lean-shell.o` we build.
1. We have a 
  [`lean_shell.c/o`](https://github.com/bollu/lz/blob/master/lean-linking-incantations/lean-shell.c)
  that contains the `main()`, along with the LEAN C preamble that does not change across files.
  This is compiled into a `lean-shell.o`. 
1. This `lean-shell.o` defines two entrypoints:
  `main_lean_custom_entrypoint_hack(lean_io_mk_world())`, and
  `init_lean_custom_entrypoint_hack(lean_io_mk_world())`.
   `init_...` is used to perform initialisation of constants, 
   while `main_...` is the entrypoint.
1. We generate MLIR which that does the "obvious" things; 
  (1) Defines forward declarations for all the LEAN runtime functions that it uses, 
  (2) generates a `init_lean_custom....` and dumps all initialization code there, 
  (3) generates a `main_lean_custom...` and dumps all the runtime code there. 
1. From this point, we are up and running. 
   We generate MLIR, convert to `mlir-llvm`,
   translate our way to `llvm`, use `llc` to generate an object file.
   We link this object file against the lean runtime plus our wrapper entry
   point from `lean-shell.o`. This produces an executable that runs :) 

```
// lz: a4f28b4
$ /home/bollu/work/lz/test/lambdapure/simple$ cat run-lean.sh
#!/usr/bin/env bash

set -e
set -o xtrace

lean $1 -c exe.c 2>&1 | \
        hask-opt | tee exe.mlir | \
        hask-opt --lean-lower --ptr-lower | \
        mlir-translate --mlir-to-llvmir | tee exe.ll  | llc -filetype=obj -o exe.o

c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/include \
    exe.o \
    /home/bollu/work/lz/lean-linking-incantations/lean-shell.o \
    /home/bollu/work/lz/lean-linking-incantations/lib-includes/library.o  \
    -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
    -L/home/bollu/work/lean4/build/stage1/lib/lean -lgmp -ldl -pthread \
    -Wno-unused-command-line-argument -o exe.out
./exe.out
```

We can run the simplest lean program:

```
// main-print.lean
set_option trace.compiler.ir.init true
def main (xs: List String) : IO Unit := IO.println (7.9)
```

to produce the output:

```
/home/bollu/work/lz/test/lambdapure/simple$ ./run-lean.sh main-print.lean 2>/dev/null
7.900000
```

So, this is good, since we have a solid foundation of talking to the runtime
that I can now easily extend. I don't need anything special now, I should be
able to mechanically translate all of the rest of the LEAN ops into vanilla
MLIR. The risky part of the process seems to work.


- Teach `LEAN` to work with out-of-order definitions?

# April 1

- I understand the problem. The definitions in `lean/lean.h` are all defined IN THE HEADER FILE,
  so I need to recompile this into a shared object which I need to link in. call it `libleanheader` or something.
  It makes sense why they do this (inlined code for performance). Not sure if it's worth the trouble.
  Will need to see if LEAN optimises out `Nat.sub(x, x)` or not!


# March 30

I do need to know the differences between types at the LLVM level.
So for example, if there is code

```
%c0 = lz.int(0): () -> !lz.value
%out = std.call @Nat.decEq(%c0, %c0) : (!lz.value, !lz.value) -> !lz.value
```

on lowering, I do need the `lz.int(0)` to become an `llvm.i64`. But then
at the call site `@Nat.decEq`, I don't know what type it should be!
This is quite untenable.

Will learn how to retain type info from lambdapure -> MLIR

# March 29

- Fixup the `run-optimised.sh` code.  
- `affine-loop-fusion` stopped working??

```
$ hask-opt lower-lz-and-affine.mlir --lz-worker-wrapper --affine-loop-fusion

func @main() -> i64 {
  %c1024 = constant 1024 : index
  %c0_i64 = constant 0 : i64
  %0 = memref.alloc(%c1024) : memref<?xi64>
  affine.for %arg0 = 0 to 1024 {
    %2 = index_cast %arg0 : index to i64
    affine.store %2, %0[%arg0] : memref<?xi64>
  }
  %1 = affine.for %arg0 = 0 to 1024 iter_args(%arg1 = %c0_i64) -> (i64) {
    %2 = affine.load %0[%arg0] : memref<?xi64>
    %3 = addi %arg1, %2 : i64
    affine.yield %3 : i64
  }
  call @printInt(%1) : (i64) -> ()
  return %c0_i64 : i64
}
```

I don't understand why this is not optimised away. Makes no sense.

#### Why tests in `lambdapure/bench` break now:

```
********************
Failed Tests (4):
  HASK_OPT :: lambdapure/bench/const_fold.lean
  HASK_OPT :: lambdapure/bench/deriv.lean
  HASK_OPT :: lambdapure/bench/qsort.lean
  HASK_OPT :: lambdapure/bench/rbmap_checkpoint.lean


Testing Time: 2.38s
  Passed    : 4
  Unresolved: 9
  Failed    : 4
```

##### `const_fold.lean`:
```
<stdin>:163:55: error: duplicate key 'alt3' in dictionary attribute
    "lz.return"(%x_8): (!lz.value) -> ()}){alt3=@"3", alt3=@default}:(!lz.value)->()
```

##### `deriv.lean`:

```
--
<stdin>:1939:78: error: duplicate key 'alt5' in dictionary attribute
    "lz.return"(%x_10): (!lz.value) -> ()}){alt0=@"0", alt1=@"1", alt5=@"5", alt5=@default}:(!lz.value)->()
```

##### `qsort.lean`:  
```
--interpreting function:|UInt32.ofNat|--
<stdin>:16:1: error: incorrect number of arguments to region. Given: |1|.Expected: |0| 

func private@"UInt32.ofNat"(!lz.value)->(!lz.value)
^
hask-opt: ../hask-opt/Interpreter.cpp:941: llvm::Optional<InterpValue> Interpreter::interpretRegion(mlir::Region&, llvm::ArrayRef<InterpValue>, Env): Assertion `false && "unable to interpret region"' failed.
```

##### `rbmap_checkpoint.lean`:

```
<stdin>:72:12: error: unregistered operation 'lz.sproj' found in dialect ('lz') that does not allow unknown operations
    %x_6 = "lz.sproj"(%x_1){ix=3, offset=0}:(!lz.value)->(!lz.value)
           ^
```

##### `render.lean`

```
<stdin>:1008:3: error: unregistered operation 'lz.sset' found in dialect ('lz') that does not allow unknown operations
  "lz.sset"(%x_71,%x_70){ix=7, offset=0}:(!lz.value, !lz.value)->()
  ^
```

# March 26

```
analyzing constructor: |
analyzing constructor: |%%51 =  = ""lzl.zc.ocnonssttrruucctt"("()) { {dataconstructordataconstructor =  = @"@"00""}} :  : (() -> ) -> !!lzlz.value.value|
```

- Something really funky is going on, either with memory or parallelism!.

# March 25
- Need to fix `lambdapure/simple/jmp.lean` that makes use of default alternative case.
- `ClosedTermCache` keeps tracks of names.

terms for render.lean

```

func private@"Float.add"(!lz.value, !lz.value)->(!lz.value)
func private@"Float.div"(!lz.value, !lz.value)->(!lz.value)
func private@"Nat.decLe"(!lz.value, !lz.value)->(!lz.value)
func private@"IO.Prim.Handle.putStr"(!lz.value, !lz.value, !lz.value)->(!lz.value)
func private@"IO.Prim.fopenFlags"(!lz.value, !lz.value)->(!lz.value)
func private@"IO.Prim.Handle.mk"(!lz.value, !lz.value, !lz.value)->(!lz.value)
func private@"USize.decLt"(!lz.value, !lz.value)->(!lz.value)
```

- Move the code gen to be after some simplifications:

```
private def compileAux (decls : Array Decl) : CompilerM Unit := do
  log (LogEntry.message "// compileAux")
  -- logDecls `init decls
  logPreamble (LogEntry.message mlirPreamble)
  -- logDeclsUnconditional decls
  checkDecls decls
  let decls ← elimDeadBranches decls
  logDecls `elim_dead_branches decls
  let decls := decls.map Decl.pushProj
  logDecls `push_proj decls
  --vvvvvv DISABLE THIS
  -- let decls := decls.map Decl.insertResetReuse
  -- logDecls `reset_reuse decls
  let decls := decls.map Decl.elimDead
  logDecls `elim_dead decls
  let decls := decls.map Decl.simpCase
  logDecls `simp_case decls
  let decls := decls.map Decl.normalizeIds
  logDeclsUnconditional decls <- CODEGEN HERE 
```

# March 24

- Got simple examples to work.
- TODO: get `render.lean` to work!
- Next: immutable beans tomorrow.


# March 23: Lean compiler entrypoint

```
src/shell/lean.cpp
int main() { ...
```

```
/home/bollu/work/lean4/src$ ag initialize_compiler
library/compiler/compiler.cpp
267:void initialize_compiler() {
```

```
/home/bollu/work/lean4/src$ vim library/compiler/extern_attribute.cpp 
/home/bollu/work/lean4/src$ ag "lean_get_extern_attr_data"
Lean/Compiler/ExternAttr.lean
75:@[export lean_get_extern_attr_data]

library/compiler/extern_attribute.cpp
22:extern "C" object* lean_get_extern_attr_data(object* env, object* n);
25:    return to_optional<extern_attr_data_value>(lean_get_extern_attr_data(env.to_obj_arg(), fn.to_obj_arg()));
```

# March 19th

MLIR strangeness of the day: Walking over uses of an argument does not give me the first use!

```
/home/bollu/work/lz/test/lambdapure/simple$ hask-opt error.mlir --lz-lazify
forcifying user: |%6 = call @Nat_dot_decEq(%arg0, %4) : (!lz.thunk<!lz.value>, !lz.value) -> !lz.value
        after: |%6 = call @Nat_dot_decEq(%5, %4) : (!lz.value, !lz.value) -> !lz.value

vvvvv:module:vvvvv
module  {
  func private @Nat_dot_sub(!lz.value, !lz.value) -> !lz.value
  func private @Nat_dot_decEq(!lz.value, !lz.value) -> !lz.value
  func @ackermann_dot_match_1_dot__rarg(%arg0: !lz.thunk<!lz.value>) {
    %0 = "lz.int"() {value = 0 : i64} : () -> !lz.value
    %1 = call @Nat_dot_decEq(%arg0, %0) : (!lz.thunk<!lz.value>, !lz.value) -> !lz.value
    %2 = "lz.tagget"(%1) : (!lz.value) -> i64
    %3 = "lz.case"(%2) ( {
      %4 = "lz.int"() {value = 1 : i64} : () -> !lz.value
      %5 = "lz.force"(%arg0) : (!lz.thunk<!lz.value>) -> !lz.value
      %6 = call @Nat_dot_decEq(%5, %4) : (!lz.value, !lz.value) -> !lz.value
      lz.return %6 : !lz.value
    }) {alt0 = @"0"} : (i64) -> !lz.value
    return %3 : !lz.value
  }
}

^^^^^^
error.mlir:6:10: error: 'std.call' op operand type mismatch: expected operand
type '!lz.value', but provided '!lz.thunk<!lz.value>' for operand number 0
    %1 = call @Nat_dot_decEq(%arg0, %0) : (!lz.value, !lz.value) -> !lz.value
         ^
error.mlir:6:10: note: see current operation:
%1 = "std.call"(%arg0, %0) {callee = @Nat_dot_decEq} : (!lz.thunk<!lz.value>, !lz.value) -> !lz.value
```

- See that it never gave me `forcifying user: |%1 = ...|` even though it clearly uses `%arg0`! What's going on?!
- Fix worker/wrapper bugs so that I can worker/wrapper the example code at "ackermann-ought-to-be-output.mlir"
   



# March 18th

- So (1) I was lowering indirect calls to `lz.ap` that is completely wrong, because it doesn't
  actually makes the call, just creates a thunk. The "problem" is that since the dialect is type erased,
  I need to use an `lz.ap` :(. So I guess I do need to revive the `lz.apeager` after all.
  I can't use `std.indirectcall` because it needs me to typecast the `func : !lz.value`
  into `func: (!lz.value, !lz.value) -> !lz.value` which is just as stupid. Matt avoided
  this by having only one type in his dialect, and a separate `ApEagerOp` as I am cornered
  into doing.
- Note to self: DO NOT BUY INTO MLIR DESIGN PRINCIPLES. Just do whatever is convenient, as attempting
  to appease MLIR is simply pain.
- Can't believe I burned half an hour on this; the correct way to use pass options is to say
  `--lz-interpret='qwerty=foo'` where `qwerty` is the option declared in `lz-interpret`.
- I need to fix the lexer and parser eventually. Some programs can't be run because they don't lex properly.
- [ ] `binarytrees.lean` needs `Task` to be implement to be able to run. Will look into this later, maybe use `async` 
  dialect? unclear!
- `deriv.lean` needs the parser to be fixed? (`let x_18 : obj := prec(_)._closed_3;`)  
- `qsort.lean` needs the parser to be fixed (`let x_1 : obj := "term↑__1";`) Can't parse uparrow (`↑`) right now.
- `rbmap_checkpointlean` uses a new kind of projection: `let x_6 : u8 := sproj[3, 0] x_1;` I don't know the semantics
   of this, sadly.
  
- `unionfind.lean` needs me to implement `String_dot_instInhabitedString`


- From the file `loop.lean`:

```
def mkRandomArray : Nat -> Array Nat -> Array Nat
...
| i+1, as => mkRandomArray i (as.push (i+1))
```

generates the MLIR:


```mlir
func @mkRandomArray(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
  ...
  %7 = "lz.erasedvalue"() : () -> !lz.value -- | what is this a proof *of*?
  %8 = call @Array_dot_push(%7, %arg1, %6) : (!lz.value, !lz.value, !lz.value) -> !lz.value
```

So the call to `push` generates an erased value. This means I shouldn't *crash* on erased
values. I should, well, *erase* them when I code generate useful code. Strange.


Similarly for `get`:

```
func @sumAux(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
  ...
  %5 = call @Nat_dot_sub(%arg0, %4) : (!lz.value, !lz.value) -> !lz.value
  %6 = call @instInhabitedNat() : () -> !lz.value
  %7 = "lz.erasedvalue"() : () -> !lz.value
  %8 = call @Array_dot_get_bang_(%7, %6, %arg1, %5) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
```

The first two arguments `%7, %6` are proof terms of stuff being inhabited. The `%arg1` is the array, and `%5`
is the index.

#### Parser bug

I'm a little depressed. The lexer/parser do something incorrect. They generate the AST:

```
test (object -> object -> -> object) x_1 x_2 

  Let object x_3 = 2
  Let int x_4 = Call Nat_dot_decLt x_1 x_3
  Case  on x_4 : 
      Let object x_5 = Call mkNodes x_1 x_2
      Case  on x_5 : 
          Let object x_6 = Proj[0] x_5

          Let object x_7 = Proj[1] x_5

          Case  on x_6 : 
              Let object x_8 = Proj[0] x_6

              Let object x_9 = Ctor 0 x_8
              Let object x_10 = Ctor 0 x_9 x_7
              return x_10

                Let object x_11 = 50000
                Let object x_12 = Call mergePack x_11 x_7
                Case  on x_12 : 
                    Let object x_13 = Proj[0] x_12

                    Let object x_14 = Proj[1] x_12

                    Case  on x_13 : 
                        Let object x_15 = Proj[0] x_13

                        Let object x_16 = Ctor 0 x_15
                        Let object x_17 = Ctor 0 x_16 x_14
                        return x_17

                          Let object x_18 = 10000
                          Let object x_19 = Call mergePack x_18 x_14
                          Case  on x_19 : 
                              Let object x_20 = Proj[0] x_19

                              Let object x_21 = Proj[1] x_19

                              Case  on x_20 : 
                                  Let object x_22 = Proj[0] x_20

                                  Let object x_23 = Ctor 0 x_22
                                  Let object x_24 = Ctor 0 x_23 x_21
                                  return x_24

                                    Let object x_25 = 5000
                                    Let object x_26 = Call mergePack x_25 x_21
                                    Case  on x_26 : 
                                        Let object x_27 = Proj[0] x_26

                                        Let object x_28 = Proj[1] x_26

                                        Case  on x_27 : 
                                            Let object x_29 = Proj[0] x_27

                                            Let object x_30 = Ctor 0 x_29
                                            Let object x_31 = Ctor 0 x_30 x_28
                                            return x_31

                                              Let object x_32 = 1000
                                              Let object x_33 = Call mergePack x_32 x_28
                                              Case  on x_33 : 
                                                  Let object x_34 = Proj[0] x_33

                                                  Let object x_35 = Proj[1] x_33

                                                  Case  on x_34 : 
                                                      Let object x_36 = Proj[0] x_34

                                                      Let object x_37 = Ctor 0 x_36
                                                      Let object x_38 = Ctor 0 x_37 x_35
                                                      return x_38

                                                        Let object x_39 = Call numEqs x_35
                                                        return x_39

                                                          Let object x_40 = Call test_dot__closed_2
                                                          Let object x_41 = Ctor 0 x_40 x_2
                                                          return x_41

```

which has no matching "case or" branches (these are only the happy paths).
The real AST is:

```
def test (x_1 : obj) (x_2 : obj) : obj :=
  let x_3 : obj := 2;
  let x_4 : u8 := Nat.decLt x_1 x_3;
  case x_4 : obj of
  Bool.false →
    let x_5 : obj := mkNodes x_1 x_2;
    case x_5 : obj of
    Prod.mk →
      let x_6 : obj := proj[0] x_5;
      let x_7 : obj := proj[1] x_5;
      case x_6 : obj of
      Except.error →
        let x_8 : obj := proj[0] x_6;
        let x_9 : obj := ctor_0[Except.error] x_8;
        let x_10 : obj := ctor_0[Prod.mk] x_9 x_7;
        ret x_10
      Except.ok →
        let x_11 : obj := 50000;
        let x_12 : obj := mergePack x_11 x_7;
        case x_12 : obj of
        Prod.mk →
          let x_13 : obj := proj[0] x_12;
          let x_14 : obj := proj[1] x_12;
          case x_13 : obj of
          Except.error →
            let x_15 : obj := proj[0] x_13;
            let x_16 : obj := ctor_0[Except.error] x_15;
            let x_17 : obj := ctor_0[Prod.mk] x_16 x_14;
            ret x_17
          Except.ok →
            let x_18 : obj := 10000;
            let x_19 : obj := mergePack x_18 x_14;
            case x_19 : obj of
            Prod.mk →
              let x_20 : obj := proj[0] x_19;
              let x_21 : obj := proj[1] x_19;
              case x_20 : obj of
              Except.error →
                let x_22 : obj := proj[0] x_20;
                let x_23 : obj := ctor_0[Except.error] x_22;
                let x_24 : obj := ctor_0[Prod.mk] x_23 x_21;
                ret x_24
              Except.ok →
                let x_25 : obj := 5000;
                let x_26 : obj := mergePack x_25 x_21;
                case x_26 : obj of
                Prod.mk →
                  let x_27 : obj := proj[0] x_26;
                  let x_28 : obj := proj[1] x_26;
                  case x_27 : obj of
                  Except.error →
                    let x_29 : obj := proj[0] x_27;
                    let x_30 : obj := ctor_0[Except.error] x_29;
                    let x_31 : obj := ctor_0[Prod.mk] x_30 x_28;
                    ret x_31
                  Except.ok →
                    let x_32 : obj := 1000;
                    let x_33 : obj := mergePack x_32 x_28;
                    case x_33 : obj of
                    Prod.mk →
                      let x_34 : obj := proj[0] x_33;
                      let x_35 : obj := proj[1] x_33;
                      case x_34 : obj of
                      Except.error →
                        let x_36 : obj := proj[0] x_34;
                        let x_37 : obj := ctor_0[Except.error] x_36;
                        let x_38 : obj := ctor_0[Prod.mk] x_37 x_35;
                        ret x_38
                      Except.ok →
                        let x_39 : obj := numEqs x_35;
                        ret x_39
  Bool.true →
    let x_40 : obj := test._closed_2;
    let x_41 : obj := ctor_0[Prod.mk] x_40 x_2;
    ret x_41
```

That is, it has both a `Bool.false -> ` branch and a `Bool.true ->` branch (which
is missing). The real code is:

```
def test (x_1 : obj) (x_2 : obj) : obj :=
  let x_3 : obj := 2;
  let x_4 : u8 := Nat.decLt x_1 x_3;
  case x_4 : obj of
  Bool.false →
    let x_5 : obj := mkNodes x_1 x_2;
    case x_5 : obj of
    ...
  Bool.true → <= MISSING
    let x_40 : obj := test._closed_2;
    let x_41 : obj := ctor_0[Prod.mk] x_40 x_2;
    ret x_41
```



# March 16th

```
// interesting: semantics of jump is determined by "enclosing block",
// something that regions help make precise!
if (auto jumpop = dyn_cast<standalone::HaskJumpOp>(op)) { }
```

- Wow WTF, I have no idea how to generate a `lz.pap` in a "real function".
  It seems to only show up in proof erased terms?!

# March 15th

```
-- encoding of OK
let x_4 : obj := ctor_0[EStateM.Result.ok] x_3 x_2;
```

- Todo for tomorrow: get larger problem sizes working in `const_fold.lean`.
- Add support for arrays in `quicksort.lean`.
- Add checks for `IncOp/DecOp` by interpreting the immutable beans rewrites.


# March 12th

- `const_fold.lean` fails by `prec(_).`
- `deriv.lean` fails by `let x_18 : obj := prec(_)._closed_3;`
- `qsort.lean` fails at  ` let x_1 : obj := "term↑__1"`. It dies at the "up arrow".
   Need to make lexer robust.
- `rbmap_checkpoint.lean` fails at `error: expected command, but found term;
  this error may be due to parsing precedence levels, consider parenthesizing
  the term` (that is, the file is corrupt?)
- Get `unionfind.lean` running
- Generate `.c` using `lean --c=foo.c`



# Match 11th, 2021

- Another use case a `%x = mlir.sese { ... }` instruction. You can't have a child region
  jump to a BB of its parent. What you can have is a `regioncall %x` instruction to "call"
  the region `%x`

We pass more tests now:

```
********************
Failed Tests (4):
  HASK_OPT :: lambdapure/bench/const_fold.lean
  HASK_OPT :: lambdapure/bench/deriv.lean
  HASK_OPT :: lambdapure/bench/qsort.lean
  HASK_OPT :: lambdapure/bench/rbmap_checkpoint.lean


Testing Time: 5.72s
  Passed    : 13
```

- Tomorrow: bring the interpreter online, for both the "regular ops", and the `Inc/Dec`
  reference counting ops.

# March 9th, 2021
- Formatting is defined in `Lean/Compiler/IR/Format.lean`:

```
Lean/Compiler/IR/Format.lean

private def formatExpr : Expr → Format
  | Expr.ctor i ys      => format i ++ formatArray ys
  | Expr.reset n x      => "reset[" ++ format n ++ "] " ++ format x
  | Expr.reuse x i u ys => "reuse" ++ (if u then "!" else "") ++ " " ++ format x ++ " in " ++ format i ++ formatArray ys
  | Expr.proj i x       => "proj[" ++ format i ++ "] " ++ format x
  | Expr.uproj i x      => "uproj[" ++ format i ++ "] " ++ format x
  | Expr.sproj n o x    => "sproj[" ++ format n ++ ", " ++ format o ++ "] " ++ format x
  | Expr.fap c ys       => format c ++ formatArray ys
  | Expr.pap c ys       => "pap " ++ format c ++ formatArray ys
  | Expr.ap x ys        => "app " ++ format x ++ formatArray ys
  | Expr.box _ x        => "box " ++ format x
  | Expr.unbox x        => "unbox " ++ format x
  | Expr.lit v          => format v
  | Expr.isShared x     => "isShared " ++ format x
  | Expr.isTaggedPtr x  => "isTaggedPtr " ++ format x
```

- How `logDecls` works: it creates a `step` that is `format`d. Look for `format` of a `Decl`

```
inductive LogEntry where
  | step (cls : Name) (decls : Array Decl)
  | message (msg : Format)

namespace LogEntry
protected def fmt : LogEntry → Format
  | step cls decls => Format.bracket "[" (format cls) "]" ++ decls.foldl (fun fmt decl => fmt ++ Format.line ++ format decl) Format.nil
  | message msg    => msg
```

- Where logging is used: `Lean/Compiler/IR.lean`

```
Lean/Compiler/IR.lean
28:  logDecls `init decls
```

- Where logging is defined: `CompilerM.lean`:
```
Lean/Compiler/IR/CompilerM.lean:

def tracePrefixOptionName := `trace.compiler.ir

private def isLogEnabledFor (opts : Options) (optName : Name) : Bool :=
  match opts.find optName with
  | some (DataValue.ofBool v) => v
  | other => opts.getBool tracePrefixOptionName

private def logDeclsAux (optName : Name) (cls : Name) (decls : Array Decl) : CompilerM Unit := do
  let opts ← read
  if isLogEnabledFor opts optName then
    log (LogEntry.step cls decls)
```

- `src/Lean/Compiler/IR/EmitC.lean`

I believe the `(_).closed_3` comes from cached closed terms:

- `/home/bollu/work/lean4/src$ git grep "get_closed_term_name"`
- `library/compiler/closed_term_cache.cpp:extern "C" object * lean_get_closed_term_name(object * env, object * e);`
- `library/compiler/closed_term_cache.cpp:    return to_optional<name>(lean_get_closed_term_name(env.to_obj_arg(), e.to_obj_arg()));`
- `library/compiler/closed_term_cache.h:optional<name> get_closed_term_name(environment const & env, expr const & e);`
- `library/compiler/extract_closed.cpp:        if (optional<name> c = get_closed_term_name(m_env, e)) {`
- `library/compiler/lambda_lifting.cpp:        if (optional<name> opt_new_fn = get_closed_term_name(m_env, e)) {`


# March 5th, 2021

Need to add support for join points:

```
block_14 (x_24 : obj) :=
  case x_13 : obj of
  Expr.Var →
    let x_25 : obj := app x_6 x_1 x_2;
    ret x_25
  Expr.Val →
    let x_26 : obj := proj[0] x_13;
    let x_27 : obj := app x_4 x_8 x_12 x_26;
    ret x_27
  Expr.Add →
    let x_28 : obj := app x_6 x_1 x_2;
    ret x_28
  Expr.Mul →
    let x_29 : obj := app x_6 x_1 x_2;
    ret x_29;
case x_12 : obj of
Expr.Var →
  let x_15 : obj := ctor_0[PUnit.unit];
  jmp block_14 x_15
```


###### `deriv.lean`

```
let x_18 : obj := prec(_)._closed_3;
```

WTF, so it seems like the 'name' of a thing on the RHS can have whatever the fuck? what is the actual
grammar for lambdapure?

##### `qsort.lean`:

```
def term↑__1._closed_1 : obj :=
  let x_1 : obj := "term↑__1";
  ret x_1
```

ROFLmao, OK, I need unicode support, or at least a grammar to consult if I
am going to continue using `char*`.

# March 1, 2021

```cpp
if (desUpdates) {
pm.addNestedPass<mlir::FuncOp >(mlir::lambdapure::createDestructiveUpdatePattern());
}
if (refCount) {
pm.addNestedPass<mlir::FuncOp >(mlir::lambdapure::createReferenceRewriterPattern());;
}
if (runtimeLowering) {
pm.addPass(mlir::lambdapure::createLambdapureToLeanLowering());
}
```

So, this is the order we need to run these passes in. First destructive
updates, then reference rewriter.


# Feb 19 2021

- Fix lexer/parser to be able to parse input LEAN file.
- Pull lowering to c++ pass into `mlir-translate`.
- Generate code correctly (?) from lowering.
# Feb 17, 2021

- Cool, seems like I have lambdapure working. LEAN program:

```
set_option trace.compiler.ir.init true

inductive L
| Nil
| Cons : Nat -> L -> L

open L
instance : Inhabited L := ⟨Nil⟩

def filter : L -> L
| Nil => Nil
| Cons n l => if n > 5 then filter l else Cons n (filter l)

partial def make' : Nat -> Nat -> L
| n,d =>
  if d = 0 then Cons n Nil
  else Cons (n-d) (make' n (d -1))                     

def make (n : Nat) : L := make' n n

unsafe def main : List String → IO UInt32
| _ => let x := make 100; pure 0


def main2 : L := make 100 
```


All I had to change in the generated code from matt's lambdapure:

```
sed -i "s|runtime/lean.h|lean/lean.h|g"  out.cpp
sed -i "s|return 0;|main2(); return 0;|g" out.cpp
leanc out.cpp -o out
```

- It appears that `leanc` knows what paths to use to get things working.
- Time to pull all code from `lambdapure` into `lz`.
- I also want to overhaul the part of `lambdapure` that generates the MLIR
  to deal with the erased stuff (the boxes).


# Fri, 29th Jan

- GHC-wpc feedback: consider splitting into a `Maybe AltDefault`? This type of
  factoring of the default is quite ungainly to work with
```
[Alt' idBnd idOcc dcOcc tcOcc]      -- The DEFAULT case is always *first*
                                     -- if it is there at all
```

# Wed, 27th Jan

- `ghc-wpc` is amazing, it's tooling that _actually works_.


```
bollu@cantordust:~/temp/ > cat foo.hs  
{-# LANGUAGE NoImplicitPrelude #-}
module Foo where

data Bar = MkBar

foo :: Bar
foo = MkBar


bollu@cantordust:~/temp/ > lsfoo  foo.ghc_stgapp  foo.hi  foo.hs  foo.o  foo.o_modpak
bollu@cantordust:~/temp/ > rm foo.hi foo.o_modpak foo.o foo.ghc_stgapp 
bollu@cantordust:~/temp/ > ~/work/ghc-whole-program-compiler-project/ghc-wpc/_build/stage1/bin/ghc foo.hs
[1 of 1] Compiling Foo              ( foo.hs, foo.o )
bollu@cantordust:~/temp/ > /home/bollu/work/ghc-whole-program-compiler-project/external-stg/dist-newstyle/build/x86_64-linux/ghc-8.8.3/external-stg-0.1.0.1/x/ext-stg/build/ext-stg/ext-stg show foo.o_modpak
{- stg -}
package main
module Foo where

using ghc-prim : GHC.Types
using main : Foo

externals
  (ghc-prim_GHC.Types.[] : LiftedRep (forall a. [a]))
  (ghc-prim_GHC.Types.krep$* : LiftedRep (KindRep))

type
  ghc-prim_GHC.Types.KindRep
    ghc-prim_GHC.Types.KindRepTyConApp :: AlgDataCon [LiftedRep,LiftedRep]
    ghc-prim_GHC.Types.KindRepVar :: AlgDataCon [IntRep]
    ghc-prim_GHC.Types.KindRepApp :: AlgDataCon [LiftedRep,LiftedRep]
    ghc-prim_GHC.Types.KindRepFun :: AlgDataCon [LiftedRep,LiftedRep]
    ghc-prim_GHC.Types.KindRepTYPE :: AlgDataCon [LiftedRep]
    ghc-prim_GHC.Types.KindRepTypeLitS :: AlgDataCon [LiftedRep,AddrRep]
    ghc-prim_GHC.Types.KindRepTypeLitD :: AlgDataCon [LiftedRep,LiftedRep]
  
  ghc-prim_GHC.Types.Module
    ghc-prim_GHC.Types.Module :: AlgDataCon [LiftedRep,LiftedRep]
  
  ghc-prim_GHC.Types.TrName
    ghc-prim_GHC.Types.TrNameS :: AlgDataCon [AddrRep]
    ghc-prim_GHC.Types.TrNameD :: AlgDataCon [LiftedRep]
  
  ghc-prim_GHC.Types.TyCon
    ghc-prim_GHC.Types.TyCon :: AlgDataCon [WordRep,WordRep,LiftedRep,LiftedRep,IntRep,LiftedRep]
  
  ghc-prim_GHC.Types.[]
    ghc-prim_GHC.Types.[] :: AlgDataCon []
    ghc-prim_GHC.Types.: :: AlgDataCon [LiftedRep,LiftedRep]
  
  main_Foo.Bar
    main_Foo.MkBar :: AlgDataCon []
  

(main_Foo.MkBar : LiftedRep (Bar)) =
  main_Foo.MkBar :: AlgDataCon [] 

(main_Foo.$tc'MkBar1 : AddrRep (Addr#)) =
  "'MkBar"

(main_Foo.$tc'MkBar2 : LiftedRep (TrName)) =
  ghc-prim_GHC.Types.TrNameS :: AlgDataCon [AddrRep] main_Foo.$tc'MkBar1

(main_Foo.$tcBar1 : AddrRep (Addr#)) =
  "Bar"

(main_Foo.$tcBar2 : LiftedRep (TrName)) =
  ghc-prim_GHC.Types.TrNameS :: AlgDataCon [AddrRep] main_Foo.$tcBar1

(main_Foo.$trModule3 : AddrRep (Addr#)) =
  "Foo"

(main_Foo.$trModule4 : LiftedRep (TrName)) =
  ghc-prim_GHC.Types.TrNameS :: AlgDataCon [AddrRep] main_Foo.$trModule3

(main_Foo.$trModule1 : AddrRep (Addr#)) =
  "main"

(main_Foo.$trModule2 : LiftedRep (TrName)) =
  ghc-prim_GHC.Types.TrNameS :: AlgDataCon [AddrRep] main_Foo.$trModule1

(main_Foo.$trModule : LiftedRep (Module)) =
  ghc-prim_GHC.Types.Module :: AlgDataCon [LiftedRep,LiftedRep] main_Foo.$trModule2 main_Foo.$trModule4

(main_Foo.$tcBar : LiftedRep (TyCon)) =
  ghc-prim_GHC.Types.TyCon :: AlgDataCon [WordRep,WordRep,LiftedRep,LiftedRep,IntRep,LiftedRep] #Word#9087065647546038855 #Word#17224336406314564570 main_Foo.$trModule main_Foo.$tcBar2 #Int#0 ghc-prim_GHC.Types.krep$*

(main_Foo.$krep : LiftedRep (KindRep)) =
  ghc-prim_GHC.Types.KindRepTyConApp :: AlgDataCon [LiftedRep,LiftedRep] main_Foo.$tcBar ghc-prim_GHC.Types.[]

(main_Foo.$tc'MkBar : LiftedRep (TyCon)) =
  ghc-prim_GHC.Types.TyCon :: AlgDataCon [WordRep,WordRep,LiftedRep,LiftedRep,IntRep,LiftedRep] #Word#3328458281052523173 #Word#5691101527919328307 main_Foo.$trModule main_Foo.$tc'MkBar2 #Int#0 main_Foo.$krep

(main_Foo.foo : LiftedRep (Bar)) =
  main_Foo.MkBar :: AlgDataCon [] 

foreign stub C header {

}
foreign stub C source {

}
foreign files
```

# Tue, 26th Jan

thinking more carefully about the story, I realise that I can't actually
compare the results of the """demand analysis""" because I don't have an
analysis in the first place. I can only witness the results of the analysis by
proxy, by witnessing whether the worker/wrapper took place or not. So in a
sense, we don't actually compute any intermediate information!

```
testsuite/tests/stranal
testsuite/tests/cpranal
testsuite/tests/arityanal
```

- To read: [CPR analysis](http://research.microsoft.com/~simonpj/Papers/cpr/index.htm)

# Tue, 19th Jan

- https://github.com/csabahruska/p4f-control-flow-analysis
- https://twitter.com/csaba_hruska/status/1287701943863980032
- https://github.com/grin-compiler/haskell-code-spot
- https://www.patreon.com/posts/introducing-ghc-38173710
- https://github.com/u235axe/FeOFu
- https://github.com/grin-compiler/souffle-cfa-optimization-experiment
- https://github.com/grin-compiler/ghc-grin/tree/master/lambda-grin/test

 
# Saturday, Jan 17th
- Trying to fix an MLIR bug with respect to use-after-def and regions.
- When we ops defined one after the other in the wrong order, it gives the 
  error:

> bollu@cantordust:~/work/mlir/llvm-project/mlir/lib/ > cat ../test/IR/reuse-name-later.mlir // RUN: mlir-opt %s 
> 
> func @main() {
>     %one = constant 1 : i64
>     %x = addi %y, %y : i64
>     %y = constant 10 : i64
>     return
> }
>
> 
> ../test/IR/reuse-name-later.mlir:5:10: error: operand #0 does not dominate this use
>     %x = addi %y, %y : i64
>          ^
> ../test/IR/reuse-name-later.mlir:5:10: note: see current operation: %0 = GENERIC OP
> 
> ../test/IR/reuse-name-later.mlir:6:10: note: operand defined here (op in the same block)
>     %y = constant 10 : i64

but this does not work for  stuff in a region.
# Wednesday, Jan 6th

- Tensor is insufficient for my purposes because I see no way to express something like a `zip` in any way that MLIR 
  will know how to optimize. This is because it seems that all the effort in MLIR is spent on affine/linalg/.. all of which
  work on `memref`s.
- I'm going to weaken the checks and balances on `memref`s to see how far it takes me.
  In particular, I'm commenting out:

```diff
diff --git a/mlir/include/mlir/IR/BuiltinTypes.h b/mlir/include/mlir/IR/BuiltinTypes.h
index 3bfb3ce4c79b..ace5b1a24c05 100644
--- a/mlir/include/mlir/IR/BuiltinTypes.h
+++ b/mlir/include/mlir/IR/BuiltinTypes.h
@@ -445,7 +445,8 @@ public:

   /// Return true if the specified element type is ok in a memref.
   static bool isValidElementType(Type type) {
-    return type.isIntOrIndexOrFloat() || type.isa<VectorType, ComplexType>();
+    return true;
+    // return type.isIntOrIndexOrFloat() || type.isa<VectorType, ComplexType>();
   }

   /// Methods for support type inquiry through isa, cast, and dyn_cast.
diff --git a/mlir/lib/Parser/TypeParser.cpp b/mlir/lib/Parser/TypeParser.cpp
index ab7f85a645e4..f777963fd9a7 100644
--- a/mlir/lib/Parser/TypeParser.cpp
+++ b/mlir/lib/Parser/TypeParser.cpp
@@ -217,9 +217,10 @@ Type Parser::parseMemRefType() {
     return nullptr;

   // Check that memref is formed from allowed types.
-  if (!elementType.isIntOrIndexOrFloat() &&
-      !elementType.isa<VectorType, ComplexType>())
-    return emitError(typeLoc, "invalid memref element type"), nullptr;
+  // allow arbitrary element types.
+  // if (!elementType.isIntOrIndexOrFloat() &&
+  //     !elementType.isa<VectorType, ComplexType>())
+  //   return emitError(typeLoc, "invalid memref element type"), nullptr;
```

which checks that the memref has an element type of `int/float/complex/index`.


# Tuesday, Jan 5th
- There's a [`for_with_yield`](https://github.com/llvm/llvm-project/blob/main/mlir/test/Conversion/AffineToStandard/lower-affine.mlir#L29)
  which is what I need. time to update MLIR!
- Seems like `OneResult` needs a separate trait to get result types.

```
commit 9eb3e564d3b1c772a64eef6ecaa3b1705d065218
Author: Chris Lattner <clattner@nondot.org>
Date:   Wed Dec 23 18:13:39 2020 -0800

    [ODS] Make the getType() method on a OneResult instruction return a specific type.

```

- Seems also that the LLVM dialet's helpers like `LLVMType::getI64Type` re
  removed.
- `StandardTypes.h` no longer exists, moved to `BuiltinTypes.h`.

OK this is failing to link against stuff:

```
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::LLVM::LLVMType::getFunctionParamType(unsigned int)'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::MutableDictionaryAttr::set(mlir::Identifier, mlir::Attribute)'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::LLVM::LLVMType::getVectorElementCount()'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::LLVM::LLVMType::getVectorElementType()'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::LLVM::LLVMType::getIntegerBitWidth()'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::LLVM::LLVMType::isArrayTy()'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::LLVM::LLVMType::isVectorTy()'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::IntegerType::get(unsigned int, mlir::MLIRContext*)'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::LLVM::LLVMType::getArrayNumElements()'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::LLVM::LLVMFuncOp::build(mlir::OpBuilder&, mlir::OperationState&, llvm::StringRef, mlir::LLVM::LLVMType, mlir::LLVM::Linkage, llvm::Ar
te> >, llvm::ArrayRef<mlir::MutableDictionaryAttr>)'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::NamedAttrList::append(mlir::Identifier, mlir::Attribute)'
/home/bollu/work/mlir/llvm-project/build/lib/libMLIRTargetLLVMIR.so.12git: undefined reference to `mlir::LLVM::LLVMType::getArrayElementType()'
clang: error: linker command failed with exit code 1 (use -v to see invocation)
ninja: build stopped: subcommand failed.
```

Mh, I should not only build `mlir-opt`, but just run `ninja` on the
top directory. There seem to be things I depend on (what?) that aren't
used my `mlir-opt`.

- Great, I can lower affine!

# Friday
- Got my tests working for end-to-end
- TODO (1): test memref
- TODO (2): test all other examples in Lowering
- TODO (3): implement vector benchmarks

- TODO (10): implement unification
- TODO (12): implement GRIN optimisations
- TODO (13): implement tabled typeclass resolution
- TODO (14): read call by push value

# Thursday, 31st Dec
- Lower `maybe-int-non-tail-recursive` and see that the generated LLVM is optimized.
- Lower `memref`.
- Listen to [coffee house sounds](https://www.youtube.com/watch?v=gaGrHUekGrc) for 
  productivity!

# Monday 28th Dec

For whatever reason, on trying to lower my `Ptr+Standard` dialect to LLVM,
I get a failure in a nonsensical location:

```cpp
class OffsetSizeAndStrideOpInterface : public
::mlir::OpInterface<OffsetSizeAndStrideOpInterface,
detail::OffsetSizeAndStrideOpInterfaceInterfaceTraits> {
```

This happens at the line:

```cpp
failed(mlir::verify(getOperation()))
```

It seems like `mlir::verify()` picks up some nonsensical `OpInterface`?!

The exact traceback is:

```
0.	Program arguments: hask-opt lower-ap.mlir --lz-lower --ptr-lower
 #0 0x000000000046dceb backtrace (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x46dceb)
 #1 0x0000000000632c6c llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x632c6c)
 #2 0x0000000000630844 llvm::sys::RunSignalHandlers() (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x630844)
 #3 0x00000000006309b3 SignalHandler(int) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x6309b3)
 #4 0x00007f9f79ee0980 __restore_rt (/lib/x86_64-linux-gnu/libpthread.so.0+0x12980)
 #5 0x00007f9f7892ffb7 raise /build/glibc-S7xCS9/glibc-2.27/signal/../sysdeps/unix/sysv/linux/raise.c:51:0
 #6 0x00007f9f78931921 abort /build/glibc-S7xCS9/glibc-2.27/stdlib/abort.c:81:0
 #7 0x00007f9f7892148a __assert_fail_base /build/glibc-S7xCS9/glibc-2.27/assert/assert.c:89:0
 #8 0x00007f9f78921502 (/lib/x86_64-linux-gnu/libc.so.6+0x30502)
 #9 0x0000000000985f8a mlir::detail::Interface<mlir::OffsetSizeAndStrideOpInterface, mlir::Operation*, mlir::detail::OffsetSizeAndStrideOpInterfaceInterfaceTraits, mlir::Op<mlir::OffsetSizeAndStrideOpInterface>, mlir::OpTrait::TraitBase>::Interface(mlir::Operation*) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x985f8a)
#10 0x0000000000985de0 mlir::OpInterface<mlir::OffsetSizeAndStrideOpInterface, mlir::detail::OffsetSizeAndStrideOpInterfaceInterfaceTraits>::OpInterface(mlir::Operation*) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x985de0)
#11 0x000000000097cf40 mlir::OffsetSizeAndStrideOpInterface::OffsetSizeAndStrideOpInterface(mlir::Operation*) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x97cf40)
#12 0x000000000097b767 LowerPointerPass::runOnOperation() (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x97b767)
#13 0x0000000000a9eda1 mlir::detail::OpToOpPassAdaptor::run(mlir::Pass*, mlir::Operation*, mlir::AnalysisManager, bool) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0xa9eda1)
#14 0x0000000000a9f051 mlir::detail::OpToOpPassAdaptor::runPipeline(llvm::iterator_range<llvm::pointee_iterator<std::unique_ptr<mlir::Pass, std::default_delete<mlir::Pass> >*, mlir::Pass> >, mlir::Operation*, mlir::AnalysisManager, bool) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0xa9f051)
#15 0x0000000000aa1a11 mlir::PassManager::run(mlir::ModuleOp) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0xaa1a11)
#16 0x00000000009d5525 performActions(llvm::raw_ostream&, bool, bool, llvm::SourceMgr&, mlir::MLIRContext*, mlir::PassPipelineCLParser const&) (.constprop.101) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x9d5525)
#17 0x00000000009d5a97 processBuffer(llvm::raw_ostream&, std::unique_ptr<llvm::MemoryBuffer, std::default_delete<llvm::MemoryBuffer> >, bool, bool, bool, bool, mlir::PassPipelineCLParser const&, mlir::DialectRegistry&) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x9d5a97)
#18 0x00000000009d5c66 mlir::MlirOptMain(llvm::raw_ostream&, std::unique_ptr<llvm::MemoryBuffer, std::default_delete<llvm::MemoryBuffer> >, mlir::PassPipelineCLParser const&, mlir::DialectRegistry&, bool, bool, bool, bool, bool) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x9d5c66)
#19 0x00000000009d60ad mlir::MlirOptMain(int, char**, llvm::StringRef, mlir::DialectRegistry&, bool) (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x9d60ad)
#20 0x00000000004db274 main (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x4db274)
#21 0x00007f9f78912bf7 __libc_start_main /build/glibc-S7xCS9/glibc-2.27/csu/../csu/libc-start.c:344:0
#22 0x00000000004373fa _start (/home/bollu/work/mlir/lz/build/bin/hask-opt+0x4373fa)
fish: Job 1, 'hask-opt lower-ap.mlir --lz-l...' terminated by signal SIGABRT (Abort)
```

The solution is:

```cpp
ModuleOp mod = mlir::cast<ModuleOp>(getOperation());

if (failed(mod.verify())) {
  llvm::errs() << "===Ptr lowering failed at Verification===\n";
  getOperation()->print(llvm::errs());
  llvm::errs() << "\n===\n";
  signalPassFailure();
}
```

I find this sort of thing disturing, since it implies that the heavy use of
"C++ interface" that is very common in MLIR may start failing peculiarly?



- Why can LLVM ops only have LLVM types? This is so annoying. I want to use `LLVMUndefOp`
  but I need some song and dance to use it because I can't say `undef : !ptr.void`
  or `undef: !lz.value`. 

  ```cpp
auto undef = rewriter.create<LLVM::UndefOp>(
  rewriter.getUnknownLoc(),
  typeConverter->convertType(caseop.getResult().getType()));
```

fails with:

```
    //===-------------------------------------------===//
  } -> FAILURE : generated operation 'llvm.mlir.undef'(0x0000607000006D80) was illegal
} -> FAILURE : no matched legalization pattern
```

because for whatever reason, `LLVM::UndefOp` can only take a 

but succeeds with:

```cpp
auto undef = rewriter.create<HaskUndefOp>(
  rewriter.getUnknownLoc(),
  typeConverter->convertType(caseop.getResult().getType()));
```

Because `llvm.mlir.undef` can only return LLVM types. What is this nonsense?


# Thursday 24th Dec

```
===
"func"() ( {
^bb0(%arg0: !ptr.void, %arg1: !ptr.void):  // no predecessors
  %0 = "lz.force"(<<UNKNOWN SSA VALUE>>) : (!lz.thunk<i64>) -> i64
  %1 = "lz.force"(<<UNKNOWN SSA VALUE>>) : (!lz.thunk<i64>) -> i64
  "std.return"(%0) : (i64) -> ()
}) {sym_name = "f", type = (!ptr.void, !ptr.void) -> !ptr.void} : () -> ()
===
```

- The call `rewriter.applySignatureConversion(&newFuncOp.getBody(), inputs);` seems
  to completely fuck up arguments?! Without it, the new function is identical to the
  old one.

- The correct API is `if (failed(rewriter.convertRegionTypes(&newFuncOp.getBody(), *typeConverter, &inputs)))`,
  as I learnt from `StandardToLLVM::FuncOpConversionBase`.


- In a `ForceOp`, should I *manually* call the source materializer? That seems janky as fuck!
   Becase the `ForceOp` lowers to a thing that returns `!ptr.void`, but it should be `!i64`.

```
    // vvv HACK: I shouldn't have to call this manually?!
    typeConverter->materializeSourceConversion(builder, out.getLoc(), )
```


What the blazes is this error now?

```
** Insert  : 'ptr.ptrtoint'(0x60c0000040c0)
hask-opt: /usr/local/include/mlir/IR/Builders.h:400: OpTy mlir::OpBuilder::create(mlir::Location, Args &&...) [OpTy = mlir::ptr::PtrPtrToIntOp, Args = <mlir::Value, mlir::IntegerType &>]: Assertion `result && "builder didn't return the right type"' failed.
```

The location it fails at:

```cpp
// MLIR/IR/Builders.h
OpTy create(Location location, Args &&... args) {
    ...
    OpTy::build(*this, state, std::forward<Args>(args)...);
    auto *op = createOperation(state);
    auto result = dyn_cast<OpTy>(op);
    assert(result && "builder didn't return the right type");
    ...
}
```

How the fuck can `create` fail?! 
OK, fucking CRTP mistakes.


- Now I have a real puzzler: Do I create a `FunctionPtrToVoidPtr` in my `ptr` dialect?
  Or do I treat this wit more delicacy? Hmm. Unsure what the right way to do this is.
- Also, should the casting of `FunctionPtr` to `VoidPtr` be *automatic*? Ie,
  do we agree that at this stage we indeed lose all knowledge of function pointer
  types? Decisions, decisions;

- Fuck me, so apparently `std.constant` function references ALSO don't get 
  rewrittern. Storms, has anyone written ANYTHING nontrivial with this shit?

```cpp
lower-ap-and-force.mlir:20:10: error: 'std.constant' op reference to function with mismatched type
    %f = constant @f : (!lz.thunk<i64>, !lz.thunk<i64>) -> i64
         ^
lower-ap-and-force.mlir:20:10: note: see current operation:
%f_0 = "std.constant"() {value = @f} : () -> ((!lz.thunk<i64>, !lz.thunk<i64>) -> i64)
===Hask -> LLVM lowering failed at Verification===
module  {
  func private @mkClosure_capture0_args2(!ptr.void, !ptr.void, !ptr.void) -> !ptr.void
  func private @mkClosure_capture0_args0(!ptr.void) -> !ptr.void
  func private @evalClosure(!ptr.void) -> !ptr.void
  func @f(%arg0: !ptr.void, %arg1: !ptr.void) -> i64 {
    ...
  }
  func @main() -> i64 {
    // vvv UNCHANGED!
    %f_0 = constant @f : (!lz.thunk<i64>, !lz.thunk<i64>) -> i64
    // ^^^ UNCHANGED!
    ...
  }
}
```

This is just sad.

# Monday 21st december

- Then you read the API to see the nugget:

```cpp
  /// Replaces the result op with a new op that is created without verification.
  /// The result values of the two ops must be the same types.
  template <typename OpTy, typename... Args>
  void replaceOpWithNewOp(Operation *op, Args &&... args) {
    auto newOp = create<OpTy>(op->getLoc(), std::forward<Args>(args)...);
    replaceOpWithResultsOfAnotherOp(op, newOp.getOperation());
  }
```


- `The result values of the two ops must be the same types.` :(
- What a waste of a day, I lost an entire night on this?! Fuck me.
- Why does `async` have a `CallOpConversionPattern`? This is bizarre.

# Friday Dec 18th

```
lower-case-single-alt-no-args.mlir:9:10: error: 'scf.if' op expects region #0 to have 0 or 1 blocks
    %y = lz.case @Maybe %boxedx
         ^
lower-case-single-alt-no-args.mlir:9:10: note: see current operation: %8 = "scf.if"(%7) ( {
^bb1:  // no predecessors
  %9 = "llvm.mlir.addressof"() {global_name = @Nothing} : () -> !llvm.ptr<array<7 x i8>>
  %10 = "llvm.mlir.constant"() {value = 0 : index} : () -> !llvm.i64
  %11 = "llvm.getelementptr"(%9, %10, %10) : (!llvm.ptr<array<7 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
  %12 = "llvm.call"(%11) {callee = @mkConstructor0} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
  "scf.yield"(%12) : (!llvm.ptr<i8>) -> ()
},  {
}) : (!llvm.i1) -> !llvm.ptr<i8>
```

What does it mean! It clearly has a single basic block `^bb1`!


For reasons I don't understand well, 

```
module {
func @main() -> i1 {
    %foo = constant 1 : i1
    lz.return %foo : i1
}
}
```

- can NEVER be lowered directly to LLVM? The problem is that essentially, if I 
   convert an `lz.return` to an `std.return` the `std.return` fails??? I have
   no idea why. Anyway, it seems like I should only use `lz.return` inside a `case`.
    Fuck my pattern matches.

- Joy, this means that I need to convert the outermost `lz.return` to an `std.return`
  everywhere.


##### The solution

- First lower `lz` to `standard+SCF`. Have that then be lowered to `LLVM`.

# Friday Dec 18th



##### Pretty sure I have an MLIR bug. 

Say I have the source IR:

```
module {
  func @main() {
    %y = constant 42 : i64
    %boxy = lz.construct(@Just, %y: i64) // check box of i64
    return
  }
}
```

What needs to happen is for us to insert a lower form of `construct` that
deals with pointers directly, and for the `%y : i64` to get converted
with an `inttoptr` operation. On adding the correct materialization:

```cpp
// int -> !ptr.void
addTargetMaterialization([&](OpBuilder &rewriter, ptr::VoidPtrType resultty,
                              ValueRange vals,
                              Location loc) -> mlir::Optional<Value> {
  if (vals.size() != 1 || !vals[0].getType().isa<IntegerType>()) {
    return {};
  }

  ptr::PtrIntToPtrOp op = rewriter.create<ptr::PtrIntToPtrOp>(loc, vals[0]);
  return op.getResult();
});
```

I get the failure:

```cpp
module  {
  func private @mkConstructor1(!ptr.char, !ptr.void) -> !ptr.void
  func @main() {
    %c42_i64 = constant 42 : i64
    %0 = "ptr.inttoptr"(%c42_i64) : (i64) -> !ptr.void
    %1 = "ptr.string"() {value = "Just"} : () -> !ptr.char
    %2 = "lz.construct"(%c42_i64) {dataconstructor = @Just} : (i64) -> !lz.value
    // vvv %c42_i64 should be %0 vvv!
    %3 = call @mkConstructor1(%1, %c42_i64) : (!ptr.char, i64) -> !ptr.void
    return
  }
}
```

which is illegal! The `%c42_i64` should have been _replaced_ by `%0` at its use
site in `@mkConstructor1: (!ptr.char, !ptr.void) -> !ptr.void` but it is not!  

- I need to perform the *technically illegal* (according to what MLIR asks us to do):

```cpp
// int -> !ptr.void
addTargetMaterialization([&](OpBuilder &rewriter, ptr::VoidPtrType resultty,
                              ValueRange vals,
                              Location loc) -> mlir::Optional<Value> {
  if (vals.size() != 1 || !vals[0].getType().isa<IntegerType>()) {
    return {};
  }

  ptr::PtrIntToPtrOp op = rewriter.create<ptr::PtrIntToPtrOp>(loc, vals[0]);
  llvm::SmallPtrSet<Operation *, 1> exceptions;
  exceptions.insert(op);

  // vvv isn't this a hack? why do I need this?
  vals[0].replaceAllUsesExcept(op.getResult(), exceptions);
  return op.getResult();
});
```

to get the correct IR:

```cpp
module  {
  func private @mkConstructor1(!ptr.char, !ptr.void) -> !ptr.void
  func @main() {
    %c42_i64 = constant 42 : i64
    %0 = "ptr.inttoptr"(%c42_i64) : (i64) -> !ptr.void
    %1 = "ptr.string"() {value = "Just"} : () -> !ptr.char
    %2 = call @mkConstructor1(%1, %0) : (!ptr.char, !ptr.void) -> !ptr.void
    return
  }
}
```

# Thursday Dec 17th

Wow, does the MLIR legalizer literally erase ops it doesn't understand?!

```
    Legalizing operation : 'scf.if'(0x60f0000009a8) {
      * Fold {
      } -> FAILURE : unable to fold

      * Pattern : 'scf.if -> ()' {
        ** Insert  : 'std.br'(0x60c0000046c0)
        ** Insert  : 'std.br'(0x60e000000820)
        ** Erase   : 'lz.return'(0x60c000004480)
```

which leads me down the line to "unknown terminator". Yeah, if you erase
my terminator, you sure as hell won't know! This leads to the error:

```
Error: KNOWN NON TERMINATOR:%14 = scf.if %13 -> (!lz.value) {
^bb1(%15: i64):  // no predecessors
  %c1_i64 = constant 1 : i64
  %16 = addi %15, %c1_i64 : i64
  %17 = "lz.construct"(%16) {dataconstructor = @Just} : (i64) -> !lz.value
  lz.return %17 : !lz.value
}

ERROR IN OPERATION:
%9 = scf.if %6 -> (!lz.value) {
} else {
  %10 = llvm.mlir.addressof @Just : !llvm.ptr<array<4 x i8>>
  %11 = llvm.mlir.constant(0 : index) : !llvm.i64
  %12 = llvm.getelementptr %10[%11, %11] : (!llvm.ptr<array<4 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
  %13 = llvm.call @isConstructorTagEq(%1, %12) : (!lz.value, !llvm.ptr<i8>) -> !llvm.i1
  %14 = scf.if %13 -> (!lz.value) {
  ^bb1(%15: i64):  // no predecessors
    %c1_i64 = constant 1 : i64
    %16 = addi %15, %c1_i64 : i64
    %17 = "lz.construct"(%16) {dataconstructor = @Just} : (i64) -> !lz.value
    lz.return %17 : !lz.value
  }
}
```

- MLIR todo: Add `hasTerminator()` and `getOptionalTerminator()` to deal with still-in-construction OPS

I was doing something naive like:

```cpp
void convertReturnsToYields(mlir::Region *r, mlir::PatternRewriter &rewriter) {
  for (Block &b : r->getBlocks()) {
    HaskReturnOp ret = mlir::dyn_cast<HaskReturnOp>(b.getTerminator());
    if (!ret) {
      continue;
    }
    llvm::errs() << "vvvvvbefore convertReturnsToYields:vvvvv\n";
    b.print(llvm::errs());

    rewriter.setInsertionPointAfter(ret);
    rewriter.replaceOpWithNewOp<mlir::scf::YieldOp>(ret.getOperation(),
                                                    ret.getOperand());

    llvm::errs() << "===after convertReturnsToYields:=====\n";
    b.print(llvm::errs());
    llvm::errs() << "\n^^^^^\n";
  }
}
```

against an op:

```
Error: EMPTY BB!

ERROR IN OPERATION:
%7 = "scf.if"(%6) ( {
^bb1:  // no predecessors
  %8 = "lz.construct"() {dataconstructor = @Nothing} : () -> !lz.value
  "lz.return"(%8) : (!lz.value) -> ()
},  {
}) : (!llvm.i1) -> !lz.value
hask-opt: /home/bollu/work/mlir/llvm-project/mlir/lib/IR/Block.cpp:231: mlir::Operation* mlir::Block::getTerminator(): Assertion `!empty() && !back().isKnownNonTerminator()' faile
```

which ofc will not work since the else block is empty `x(`.


- PROTIP: switch between `applyPartialConversion` and `applyFullConversion` to debug
  what the fuck is going on. They give _different_ error messages. When one is useless,
  the other tends to be useful.


- So the API can only deal with incorrect types from `src -> target` not `target -> target`.
  This is _really_ problematic.  For example, say that we want `i64 -> !llvm.i64`. But sometimes,
  we want to have a `!llvm.i64 -> !llvm.ptr<i8>` since we are marshalling an `int` into a pointer
  using `inttoptr`. This conversion is impossible to perform(?) using the MLIR lowering.


```
lower-case.mlir:6:15: error: 'llvm.call' op operand type mismatch for operand 1: '!llvm.i64' != '!llvm.ptr<i8>'
    %boxedx = lz.construct(@Just, %x: i64)
              ^
lower-case.mlir:6:15: note: see current operation: %4 = "llvm.call"(%3, %0) {callee = @mkConstructor1} : (!llvm.ptr<i8>, !llvm.i64) -> !llvm.ptr<i8>
===Hask -> LLVM lowering failed===
module  {
  llvm.mlir.global internal constant @Nothing("Nothing")
  llvm.func @isConstructorTagEq(!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.i1
  llvm.mlir.global internal constant @Just("Just")
  llvm.func @mkConstructor1(!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
  llvm.func @main() -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(42 : i64) : !llvm.i64
    %1 = llvm.mlir.addressof @Just : !llvm.ptr<array<4 x i8>>
    %2 = llvm.mlir.constant(0 : index) : !llvm.i64
    %3 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr<array<4 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %4 = llvm.call @mkConstructor1(%3, %0) : (!llvm.ptr<i8>, !llvm.i64) -> !llvm.ptr<i8>
    %5 = llvm.mlir.addressof @Nothing : !llvm.ptr<array<7 x i8>>
    %6 = llvm.mlir.constant(0 : index) : !llvm.i64
    %7 = llvm.getelementptr %5[%6, %6] : (!llvm.ptr<array<7 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %8 = llvm.call @isConstructorTagEq(%4, %7) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.i1
    llvm.cond_br %8, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
  ^bb2:  // no predecessors
    %9 = "lz.construct"() {dataconstructor = @Nothing} : () -> !lz.value
    %10 = llvm.inttoptr %9 : !lz.value to !llvm.ptr<i8>
    llvm.br ^bb8(%10 : !llvm.ptr<i8>)
  ^bb3:  // pred: ^bb0
    %11 = llvm.mlir.addressof @Just : !llvm.ptr<array<4 x i8>>
    %12 = llvm.mlir.constant(0 : index) : !llvm.i64
    %13 = llvm.getelementptr %11[%12, %12] : (!llvm.ptr<array<4 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %14 = llvm.call @isConstructorTagEq(%4, %13) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.i1
    llvm.cond_br %14, ^bb4, ^bb6
  ^bb4:  // pred: ^bb3
  ^bb5(%15: !llvm.i64):  // no predecessors
    %c1_i64 = constant 1 : i64
    %16 = "std.addi"(%15, %c1_i64) : (!llvm.i64, i64) -> i64
    %17 = "lz.construct"(%16) {dataconstructor = @Just} : (i64) -> !lz.value
    %18 = llvm.inttoptr %17 : !lz.value to !llvm.ptr<i8>
    llvm.br ^bb6(%18 : !llvm.ptr<i8>)
  ^bb6(%19: !llvm.ptr<i8>):  // 2 preds: ^bb3, ^bb5
    llvm.br ^bb7
  ^bb7:  // pred: ^bb6
    %20 = llvm.inttoptr %19 : !llvm.ptr<i8> to !llvm.ptr<i8>
    llvm.br ^bb8(%20 : !llvm.ptr<i8>)
  ^bb8(%21: !llvm.ptr<i8>):  // 2 preds: ^bb2, ^bb7
    llvm.br ^bb9
  ^bb9:  // pred: ^bb8
    llvm.return %21 : !llvm.ptr<i8>
  }
}
```

# Wednesday Dec 16th

```
lower-linalg.mlir:14:3: error: failed to legalize operation 'func'
  func @sum(%buffert: !lz.thunk<memref<?xi64>>) -> i64 {
```

- WHAT DOES IT FUCKING MEAN? If I try to ask it to lower a dummy `foo.mlir`:

```
//foo.mlir
module {
  func @main () -> i64 {
    %size = std.constant 1024 : i64
    return %size : i64
  }
}
```

it succeeds!

```
[I] /home/bollu/work/mlir/lz/test/ToLLVM > ninja -C ~/work/mlir/lz/build/ &&  hask-opt --lz-lower-to-llvm foo.mlir
module  {
  llvm.func @main() -> !llvm.i64 {
    %0 = llvm.mlir.constant(1024 : i64) : !llvm.i64
    llvm.return %0 : !llvm.i64
  }
}
```

I suspect that it's because of the `lz.thunk` in the type?

Yes indeed. Consider this:

```
[I] /home/bollu/work/mlir/lz/test/ToLLVM > ninja -C ~/work/mlir/lz/build/ &&  hask-opt --lz-lower-to-llvm foo.mlir

foo.mlir:6:3: error: failed to legalize operation 'func'
  func @main (%x: !lz.thunk<i64>) -> i64 {
  ^
foo.mlir:6:3: note: see current operation: "func"() ( {
^bb0(%arg0: !lz.thunk<i64>):  // no predecessors
  %c1024_i64 = "std.constant"() {value = 1024 : i64} : () -> i64
  "std.return"(%c1024_i64) : (i64) -> ()
}) {sym_name = "main", type = (!lz.thunk<i64>) -> i64} : () -> ()
===Hask -> LLVM lowering failed===
module  {
  func @main(%arg0: !lz.thunk<i64>) -> i64 {
    %c1024_i64 = constant 1024 : i64
    return %c1024_i64 : i64
  }
}
```

See that `%arg0` is `!lz.thunk<i64>`. I guess I need to teach the `LLVMTypeConverter`
than a `!lz.thunk` is a void pointer? This kind of thing is deeply annoying.

Amazing, it seems the `linalg` dialect doesn't know how to legalize `dim`?
Or I'm being amazingly stupid. Don't know which:

```
// lower-linalg.mlir
lower-linalg.mlir:17:10: error: failed to legalize operation 'std.dim'
    %N = dim %buffer, %c0 : memref<?xi64>
         ^
lower-linalg.mlir:17:10: note: see current operation: %3 = "std.dim"(%1, %c0) : (memref<?xi64>, index) -> index

module  {
  func @sum(%arg0: !lz.thunk<memref<?xi64>>) -> i64 {
    %0 = "lz.force"(%arg0) : (!lz.thunk<memref<?xi64>>) -> memref<?xi64>
    %c0 = constant 0 : index
    %1 = dim %0, %c0 : memref<?xi64>
    %c0_i64 = constant 0 : i64
    %2 = affine.for %arg1 = 0 to %1 iter_args(%arg2 = %c0_i64) -> (i64) {
      %3 = affine.load %0[%arg1] : memref<?xi64>
      %4 = addi %arg2, %3 : i64
      affine.yield %4 : i64
    }
    return %2 : i64
  }
  func @seq(%arg0: i64) -> memref<?xi64> {
    %0 = index_cast %arg0 : i64 to index
    %1 = alloc(%0) : memref<?xi64>
    affine.for %arg1 = 0 to %0 {
      %2 = index_cast %arg1 : index to i64
      affine.store %2, %1[%arg1] : memref<?xi64>
    }
    return %1 : memref<?xi64>
  }
  func @main() -> i64 {
    %f = constant @seq : (i64) -> memref<?xi64>
    %c1024_i64 = constant 1024 : i64
    %0 = "lz.ap"(%f, %c1024_i64) : ((i64) -> memref<?xi64>, i64) -> !lz.thunk<memref<?xi64>>
    %f_0 = constant @sum : (!lz.thunk<memref<?xi64>>) -> i64
    %1 = "lz.ap"(%f_0, %0) : ((!lz.thunk<memref<?xi64>>) -> i64, !lz.thunk<memref<?xi64>>) -> !lz.thunk<i64>
    %2 = "lz.force"(%1) : (!lz.thunk<i64>) -> i64
    return %2 : i64
  }
}
```

# Thursday Dec 11th

```
    mlir::FuncOp outlinedFn = parentfn.clone();
    outlinedFn.setName(outlinedFnName);
    outlinedFn.setType(outlinedFnty);
```

this *does not set the type* correctly?!

The full module:

```
"module"() ( {
  "func"() ( {
  ^bb0(%arg0: !lz.value):  // no predecessors
    %c42_i64 = "std.constant"() {value = 42 : i64} : () -> i64
    %c1_i64 = "std.constant"() {value = 1 : i64} : () -> i64
    %f = "std.constant"() {value = @f_outline_case_arg} : () -> ((i64) -> !lz.value)
    %0 = "lz.case"(%arg0) ( {
    ^bb0(%arg1: i64):  // no predecessors
      %1 = "lz.caseint"(%arg1) ( {
        %2 = "lz.construct"(%c42_i64) {dataconstructor = @SimpleInt} : (i64) -> !lz.value
        "lz.return"(%2) : (!lz.value) -> ()
      },  {
        %2 = "std.subi"(%arg1, %c1_i64) : (i64, i64) -> i64
        %3 = "lz.apEager"(%f, %2) : ((i64) -> !lz.value, i64) -> !lz.value
        "lz.return"(%3) : (!lz.value) -> ()
      }) {alt0 = 0 : i64, alt1 = @default} : (i64) -> !lz.value
      "lz.return"(%1) : (!lz.value) -> ()
    }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
    "std.return"(%0) : (!lz.value) -> ()
  }) {sym_name = "f", type = (!lz.value) -> !lz.value} : () -> ()
  "func"() ( {
    %c3_i64 = "std.constant"() {value = 3 : i64} : () -> i64
    %f = "std.constant"() {value = @f} : () -> ((!lz.value) -> !lz.value)
    %0 = "lz.construct"(%c3_i64) {dataconstructor = @SimpleInt} : (i64) -> !lz.value
    %1 = "lz.apEager"(%f, %0) : ((!lz.value) -> !lz.value, !lz.value) -> !lz.value
    "std.return"(%1) : (!lz.value) -> ()
  }) {sym_name = "main", type = () -> !lz.value} : () -> ()
  "func"() ( {
  ^bb0(%arg0: !lz.value):  // no predecessors
    %0 = "lz.construct"(%arg0) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
    %1 = "lz.case"(%0) ( {
    ^bb0(%arg1: i64):  // no predecessors
      %2 = "lz.caseint"(%arg1) ( {
        %c42_i64 = "std.constant"() {value = 42 : i64} : () -> i64
        %3 = "lz.construct"(%c42_i64) {dataconstructor = @SimpleInt} : (i64) -> !lz.value
        "lz.return"(%3) : (!lz.value) -> ()
      },  {
        %c1_i64 = "std.constant"() {value = 1 : i64} : () -> i64
        %3 = "std.subi"(%arg1, %c1_i64) : (i64, i64) -> i64
        %f = "std.constant"() {value = @f_outline_case_arg} : () -> ((i64) -> !lz.value)
        %4 = "lz.apEager"(%f, %3) : ((i64) -> !lz.value, i64) -> !lz.value
        "lz.return"(%4) : (!lz.value) -> ()
      }) {alt0 = 0 : i64, alt1 = @default} : (i64) -> !lz.value
      "lz.return"(%2) : (!lz.value) -> ()
    }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
    "std.return"(%1) : (!lz.value) -> ()
  }) {sym_name = "f_outline_case_arg", type = (i64) -> !lz.value} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
```

See that we had:
- `{sym_name = "f_outline_case_arg", type = (i64) -> !lz.value} : () -> ()`
- BUT the fucking entry BB type of this function is: `^bb0(%arg0: !lz.value):  // no predecessors`


- I was hoping the `TypeConverter` did the "sensible thing" on trying to lower `FunctionType`.
  But alas, it does not, probably for flexibility.

```cpp
Type resultTy = typeConverter->convertType(fnty);
```

```cpp
===
===
asked to lower incorrect constant op:
===
%f_0 = "std.constant"() {value = @f} : () -> ((!lz.thunk<i64>, !lz.thunk<i64>) -> i64)
new type: |(!lz.thunk<i64>, !lz.thunk<i64>) -> i64|
```

- I guess I need to manually convert the FunctionType using the `TypeConverter`.


- Another MLIR bug (?) Anything whose legality is checked with `isDynamicallyLegal` needs to be `rewrite.erase`d and then `rewriter.create`d. It seems like you can't use `rewriter.replaceOpWithNewOp` for such operations.
# Wednesday Dec 10th

What are the guarantees of the use/def chain? Does it guarantee us that the
order of visiting expressions? If I have:

```
%a = ... 

%b = f(%a) {
    g(%a)
  }
```

am I guaranteed that I will visit use `f` before use `g`? Ie, what is
the semantics of the walk-the-use-*chain* with respect to nesting of regions.

If I want to find the "first outermost use", how do I do so?


- Seems like all I need to do was to go from `return` to `lz.return` and all
  is well `:)`. 
# Tuesday, Dec 9th

- I'm not tracking number of thunkifies correctly: `ap` should also count as
  thunkify! Fixed this.

- Now I'm trying to debug what's wrong with my `CaseOfFnInput`. Man it's a real
  doozy. Consider the code:

```rust
def f(si: SimpleInt) -> SimpleInt {
  let out = match si {
    SimpleInt(i) =>
      match i {
        0 => return 42;
        _ => {
          let sidec = SimpleInt(i - 1);
          let sj = f(sidec);
          return match sj {
            SimleInt(j) => return (j + 1); 
          } 
        }
      }
  };
  outWrap = SimpleInt(out);
  return out;
}
```

Now the part that makes this annoying is that naively, what we want to do
is to peel the case of `si` into a `fSimpleInt`, giving us
of the `match si { SimpleInt(i) => fSimpleInt(i)}`. Then we want to
replace all recursive calls `f(SimpleInt(y))` with `fSimpleInt(y)`. If
we *naively* perform the translation, here's what we get:

```rust
def fSimpleInt(i: int) -> int {
      match i {
        0 => return 42;
        _ => {
          // let sidec = SimpleInt(i - 1);
          let idec = i - 1;
          // vvv WRONG TYPE! fSimpleInt returns an `int`,
          // vvv but sj is a `SimpleInt`.
          let sj = fSimpleInt(i - 1); 
          return match sj {
            SimpleInt(j) => return (j + 1); 
          } 
        }

}
def f(si: SimpleInt) -> SimpleInt {
  let out = match si {
    SimpleInt(i) => return fSimpleInt(i);
  };
  outWrap = SimpleInt(out);
  return out;
}
```


where did we go wrong?! A little thought shows us that the problem is that
we didn't perform transfer of control flow correctly. What we *should* do
is to copy *all the instructions in `f`* after the `match si { ... }` to
decide how to return from `fSimpleInt`. aa;a;k

# Friday, Dec 5th
- Printing an operation in its generic form:

```cpp
llvm::errs() << "outlinedFn:\n";
mlir::OpPrintingFlags flags;
outlinedFn.print(llvm::errs(), flags.printGenericOpForm());
assert(false);
```


# Thursday, Dec 4th
- Our transformation of outline/inline is very similar to converting a `while(c){..}`
  into an `if(c) { do{..}while(c)}`. What other "classical loop knowledge"
  can we take?
- Is this inlining/outlining nonsense literally just performing CPS? Aren't
  we encoding things as "continuations" when we outline+call? isn't SSA supposed
  to free us from this? why isn't it freeing us from this? is it because of
  recursion? If so, should we convert a `scf.recurse`?

On giving haskell the complicated program I'm interested in:

```hs
{-# LANGUAGE MagicHash #-}
module GHCMaybeIntNonTailRecursive(main) where
import GHC.Int
import GHC.Prim
data MaybeHash = JustHash Int# | NothingHash deriving(Show)

f :: MaybeHash -> MaybeHash
f mi = case mi of
        JustHash i# -> 
               case i# of
                 0# -> JustHash 5#
                 _ -> case f (JustHash (i# -# 1#)) of
                      NothingHash -> NothingHash
                      JustHash j# -> JustHash (j# +# 7#)
        NothingHash -> NothingHash

main :: IO ()
main = print (f (JustHash 100#))
```

and compiled with `-O2 -ddump-simple` it produces the core:


- Entry point: `main`
```
main
  = GHC.IO.Handle.Text.hPutStr'
      GHC.IO.Handle.FD.stdout
      GHCMaybeIntNonTailRecursive.main1
      GHC.Types.True
```

- `GHCMaybeIntNonTailRecursive.main1`: calls `GHCMaybeIntNonTailRecursive.main_$sf` and then does the printing work here.
```
GHCMaybeIntNonTailRecursive.main1
  = case GHCMaybeIntNonTailRecursive.main_$sf 100# of {
      JustHash b1_aLr ->
        ++
          @ Char
          GHCMaybeIntNonTailRecursive.$fShowMaybeHash6
          (case GHC.Show.$wshowSignedInt
                  0# b1_aLr GHCMaybeIntNonTailRecursive.$fShowMaybeHash8
           of
           { (# ww5_a1RD, ww6_a1RE #) ->
           GHC.Types.: @ Char ww5_a1RD ww6_a1RE
           });
      NothingHash -> GHCMaybeIntNonTailRecursive.$fShowMaybeHash3
    }
```

- `GHCMaybeIntNonTailRecursive.main_$sf`: GHC does not optimize this. It just bakes a stupid
   recursive call. It's unable to prove that the wrapper in un-necessary!
   Please let us be able to prove this using `SCEV`ness?

```
GHCMaybeIntNonTailRecursive.main_$sf [Occ=LoopBreaker]
  :: Int# -> MaybeHash
[GblId, Arity=1, Caf=NoCafRefs, Str=<S,1*U>, Unf=OtherCon []]
GHCMaybeIntNonTailRecursive.main_$sf
  = \ (sc_s1X4 :: Int#) ->
      case sc_s1X4 of ds_d1IV {
        __DEFAULT ->
          case GHCMaybeIntNonTailRecursive.main_$sf (-# ds_d1IV 1#) of {
            JustHash j#_aHM ->
              GHCMaybeIntNonTailRecursive.JustHash (+# j#_aHM 7#);
            NothingHash -> GHCMaybeIntNonTailRecursive.NothingHash
          };
        0# -> lvl_r1XW
      }
```

- TODO for tomorrow: write equivalent C code and see what LLVM generates.


# Thursday, Nov 26th
- it seems like using `clang++` is **mandatory** to get correct builds with MLIR. When
  anurudh was attempting to compile the project, we were getting divergent results
  till we both standardized on clang. Super super weird. It seems like `g++` miscompiles.

# Wednesday, Nov 25

- I need to allow my `Identifier` to keep pointers to values...
- I want to read the rust implementation of [pretty error message printing](https://github.com/rust-lang/rust/blob/master/compiler/rustc_errors/src/emitter.rs)
- And the [Elm error reporting code](https://github.com/elm/compiler/blob/master/compiler/src/Reporting/Error/Main.hs)

OK, I'm using the program

```hs
module Main where (main)
main = print (sum ([1..4040] :: [Int]))
```

# Mon, Nov 23

- Function body: see that `%arg0` v/s `%arg1`:

```
  func @factorial(%arg0: !lz.thunk<!lz.value>) -> !lz.value {
    %0 = "lz.caseint"(%arg1) ( {
      %c1_i64 = constant 1 : i64
      %2 = "lz.construct"(%c1_i64) {dataconstructor = @SimpleInt} : (i64) -> !lz.value
      return %2 : !lz.value
    },  {
      %c1_i64 = constant 1 : i64
      %2 = subi %arg1, %c1_i64 : i64
      %3 = "lz.ref"() {sym_name = "factorial"} : () -> !lz.fn<(i64) -> i64>
      %4 = "lz.ap"(%3, %2) : (!lz.fn<(i64) -> i64>, i64) -> !lz.thunk<i64>
      %5 = "lz.force"(%4) : (!lz.thunk<i64>) -> i64
      %6 = "lz.ref"() {sym_name = "mulSimpleInt"} : () -> !lz.fn<(i64, i64) -> i64>
      %7 = "lz.ap"(%6, %arg1, %5) : (!lz.fn<(i64, i64) -> i64>, i64, i64) -> !lz.thunk<i64>
      return %7 : !lz.thunk<i64>
    }) {alt0 = 0 : i64, alt1 = @default} : (i64) -> i64
    return %0 : i64
    %1 = "lz.caseint"(%arg0) ( {
    ^bb0(%arg1: i64):  // no predecessors
    }) {alt0 = @SimpleInt} : (!lz.thunk<!lz.value>) -> i64
    return %1 : i64
}
```

```
unable to find key: |<block argument>|
```

```
owning block:
^bb0(%arg1: i64):  // no predecessors
```

```
owning op:
%1 = "lz.caseint"(%arg0) ( {
^bb0(%arg1: i64):  // no predecessors
}) {alt0 = @SimpleInt} : (!lz.thunk<!lz.value>) -> i64
```

- I have no idea where it hallucinates a `%arg1` attached to the basic block?
  Why does it do this?

- I suspect it's because it comes from a `match fc of SimpleInt(..) => ... `
  which means that we have a `SimpleInt` we are matching on, which tries to
  generate an identifier for the case value. However, the fact that this
  region argument is not printed now worries me.

- FIXED! wasn't moving builder to the correct location.

- TODO: 0. add a custom `caseint` into the surface lang to quickly check that our
           codegen *actually* works.
- TODO: 1. get type info to decide if I need a `caseint` or a `caseconstrcutor`.
- TODO: 2. Track types in the surface lang to have enough info to deduce this.


# Friday: Nov 11th
- https://dl.acm.org/doi/abs/10.1145/99583.99590

- Goal: code generate examples I have, along with new `vector.rs`.
- What do we do with mutually recursive lambdas? x( This kind of thing is annoying.
- Make strictness annotations "less strict". Strictness annotations have
  a side-effect. We don't have side effects on strictness. They have an 
  effect on performance. 

# Thursday, Nov 10th

- Stuff GHC could do better: Nested CPR, deeper dataflow analysis,
  data parallel haskell (Manuel Charkravarty, Jeff Mainland) : Stream fusion with
  packetization, optimizing using laziness. Refcounting?
  For debugging, can compile in slow path; due to purity, allows for
  precise effect tracking. Stream fusion was important.
  What do I call my semantics? There's no easy way to defined the semantics
  that we have in mind, we can only provide an /operational/ description.

- Argument order matters for worker/wrapper, because GHC can only partially
  apply functions in the worker/wrapper, and not reorder parameters. So if we
  have `f x y` where `x` is reused, we can worker/wrapper around `y`.

# Friday. Nov 6th

- [Core Spec](https://gitlab.haskell.org/ghc/ghc/-/blob/master/docs/core-spec/core-spec.pdf)

```
data X = X1 !Int | X2 !Char
foo :: X -> X;
foo x = case x of X1 i -> X1 (i * 2); X2 c = X2 (c + 'a')


(%x1, %x2) = lz.variant(%x)
%x1_plus_1 = add(%x1, 1)
%y1 = lz.construct(@X1, %x1_plus_1)

%x2_plus_a = add(%x1, 97) -- ord(a) = 97
%y2 = lz.construct(@X2, %x2_plus_a)
%out = lz.union(%y1, %y2)
```



# Monday, Nov 2nd

#### From `fast-math`:

> How does this interact with LLVM?  The LLVM backend can perform a number of
> these optimizations for us as well if we pass it the right flags. It does not
> perform all of them, however. (Possibly GHC's optimization passes remove the
> opportunity?) In any event, executables from the built-in code generator and
> llvm generator will both see speed improvements.

- [GHC page on rewrite rules has more food for thought](https://wiki.haskell.org/GHC/Using_rules)





# Friday, Oct 30th

# Thursday, Oct 29th

- Email arnaud, we're talking Nov 10th, maybe? He's busy because of his
  haskell exchange talk. Until then, I can shore up my code and implement
  things properly.
- Getting a generic MLIR printer infrastructure up in Haskell. Will use it for
  my GHC plugin, as well as to optimize cherry picked examples from `Data.Vector.Unboxed`
- I maybe able to perform [`freeJIT`](https://github.com/bollu/freejit) now that MLIR exists!

```
module {

  hask.func @two () -> !hask.adt<@SimpleInt>  {
     %v = hask.make_i64(2)
     %boxed = hask.construct(@SimpleInt, %v:!hask.value) : !hask.adt<@SimpleInt> 
     hask.return(%boxed): !hask.adt<@SimpleInt> 
  }

  hask.func @main (%v: !hask.adt<@SimpleInt>, %wt: !hask.thunk<!hask.adt<@SimpleInt>>) -> !hask.adt<@SimpleInt> {
      %number = hask.make_i64(0 : i64)
      %reti = hask.case @SimpleInt %v 
           [@SimpleInt -> { ^entry(%ival: !hask.value):
              %w = hask.force(%wt):!hask.adt<@SimpleInt>
               %number43 = hask.make_i64(43 : i64)
               hask.return(%number43):!hask.value
            }]
            [@default -> { 
               ^entry:
                   %number42 = hask.make_i64(42 : i64)
                   hask.return(%number42):!hask.value

            }]
      %two = hask.ref(@two):  !hask.fn<() -> !hask.adt<@SimpleInt>>
      %twot = hask.ap(%two :  !hask.fn<() -> !hask.adt<@SimpleInt>> )
      hask.return(%reti) : !hask.value
  }
}
```

```
module {
  "hask.func"() ( {
    %0 = "hask.make_i64"() {value = 2 : i64} : () -> !hask.value
    %1 = "hask.construct"(%0) {dataconstructor = @SimpleInt} : (!hask.value) -> !hask.adt<@SimpleInt>
    "hask.return"(%1) : (!hask.adt<@SimpleInt>) -> ()
  }) {retty = !hask.adt<@SimpleInt>, sym_name = "two"} : () -> ()

  "hask.func"() ( {
  ^bb0(%arg0: !hask.adt<@SimpleInt>, %arg1: !hask.thunk<!hask.adt<@SimpleInt>>):  // no predecessors
    %0 = "hask.make_i64"() {value = 0 : i64} : () -> !hask.value
    %1 = "hask.case"(%arg0) ( {
    ^bb0(%arg2: !hask.value):  // no predecessors
      %4 = "hask.force"(%arg1) : (!hask.thunk<!hask.adt<@SimpleInt>>) -> !hask.adt<@SimpleInt>
      %5 = "hask.make_i64"() {value = 43 : i64} : () -> !hask.value
      "hask.return"(%5) : (!hask.value) -> ()
    },  {
      %4 = "hask.make_i64"() {value = 42 : i64} : () -> !hask.value
      "hask.return"(%4) : (!hask.value) -> ()
    }) {alt0 = @SimpleInt, alt1 = @default, constructorName = @SimpleInt} : (!hask.adt<@SimpleInt>) -> !hask.value
    %2 = "hask.ref"() {sym_name = "two"} : () -> !hask.fn<() -> !hask.adt<@SimpleInt>>
    %3 = "hask.ap"(%2) : (!hask.fn<() -> !hask.adt<@SimpleInt>>) -> !hask.thunk<!hask.adt<@SimpleInt>>
    "hask.return"(%1) : (!hask.value) -> ()
  }) {retty = !hask.adt<@SimpleInt>, sym_name = "main"} : () -> ()
}
```


# Wednesday, Oct 28th
- `PeelCommonConstructorsInCase` miscompiles `:(`

- OK I am more and more sure that this is an MLIR bug. When I rewrite the IR,
  the type of the result does not change?!
- **Old**:

- **New**: [It thinks the type is still `hask.adt`!]

```
%1 = hask.case @Maybe %0 [@Nothing ->  {
  %3 = hask.make_i64(0 : i64)
  hask.return(%3) : !hask.value
}]
 [@Just ->  {
^bb0(%arg1: !hask.value):  // no predecessors
  %3 = hask.make_i64(1 : i64)
  hask.return(%3) : !hask.value
}]

!hask.adt<@Maybe>
```

- So it seems that `getType()` returns whatever the type was *at construction*.
  So my semantics of the 'return type' of a `case` is actually based on what
  the branches return. MLIR has no notion of this, though. So if you ever have
  anything that returns, you should make the return type some kind of attribute,
  and not *infer* it.
- In fact, I'm not even sure that that suffices. I might have to build an entirely
  new instruction just to fix the result type of the `case`?
- This is beyond fucked. 
- Got some paper writing done!
- Reading the generic parsing code to write a small haskell API for it, I'm done
  gluing the fucking printing together by hand...
  [parseGenericOperation](https://github.com/llvm/llvm-project/blob/735ab4be35695df9f9da7ae8b584cec28eabf1fe/mlir/lib/Parser/Parser.cpp#L727)

```hs
import Data.Vector.Unboxed as V


-- a * x + b
a, x, b :: Vector Int
a = fromList [1, 2, 3, 4, 5, 6, 7, 8, 9]
x = fromList [3, 1, 4, 1, 5, 1, 6, 1, 7]
b = fromList [10, 20, 30, 40, 50, 60, 70]

outv = V.zipWith (+) (V.zipWith (*) a x) b
outf = V.foldl (+) 0 outv

main :: IO ()
main = print outv >> print outf
```

GHC performs no constant folding on this. On the other hand, MLIR should be able
to reduce the above program to a single constant


# Friday, Oct 23rd

- It looks like the dinky pass I wrote, with bugs fixed, can actually eliminate
  all laziness in the toy examples I have.
- Next, I'm going to implement elimnating boxing. So I can 'unwrap' a function
  that uses `SimpleInt int#` (with no laziness, mind you, not `thunk<SimpleInt>`
  into a function that uses only a `int#`. Let's see how well this does.
- MLIR TODO: Add `arg.getSingleUse()` API
- MLIR TODO: Add `getNumArguments()` and `getArgument(int i)` API to any `callable`.
- Consider making `case` a terminator of a block? Seems to make a lot of rewrites
  way easier. Not sure.



- I think I have a good reason to make a `hask.case` instruction a terminator. I can be sure
  that I can transform :

```
====
hask.func @f {
^bb0(%arg0: !hask.thunk<!hask.adt<@SimpleInt>>):  // no predecessors
  %0 = hask.force(%arg0):!hask.adt<@SimpleInt>
  %1 = hask.case @SimpleInt %0 [@SimpleInt ->  {
  ^bb0(%arg1: !hask.value):  // no predecessors
    %2 = hask.caseint %arg1 [0 : i64 ->  {
      %3 = hask.make_i64(5 : i64)
      %4 = hask.construct(@SimpleInt, %3 : !hask.value) : !hask.adt<@SimpleInt>
      hask.return(%4) : !hask.adt<@SimpleInt>
    }]
 [@default ->  {
      %3 = hask.make_i64(1 : i64)
      %4 = hask.primop_sub(%arg1,%3)
      %5 = hask.construct(@SimpleInt, %4 : !hask.value) : !hask.adt<@SimpleInt>
      %6 = hask.thunkify(%5 :!hask.adt<@SimpleInt>):!hask.thunk<!hask.adt<@SimpleInt>>
      %7 = hask.ref(@f) : !hask.fn<(!hask.thunk<!hask.adt<@SimpleInt>>) -> !hask.adt<@SimpleInt>>
      %8 = hask.apEager(%7 :!hask.fn<(!hask.thunk<!hask.adt<@SimpleInt>>) -> !hask.adt<@SimpleInt>>, %6)
      %9 = hask.ap(%7 :!hask.fn<(!hask.thunk<!hask.adt<@SimpleInt>>) -> !hask.adt<@SimpleInt>>, %6)
      %10 = hask.case @SimpleInt %8 [@SimpleInt ->  {
      ^bb0(%arg2: !hask.value):  // no predecessors
        %11 = hask.make_i64(1 : i64)
        %12 = hask.primop_add(%arg2,%11)
        %13 = hask.construct(@SimpleInt, %12 : !hask.value) : !hask.adt<@SimpleInt>
        hask.return(%13) : !hask.adt<@SimpleInt>
      }]

      hask.return(%10) : !hask.adt<@SimpleInt>
    }]

    hask.return(%2) : !hask.adt<@SimpleInt>
  }]

  hask.return(%1) : !hask.adt<@SimpleInt>
}
```

easily. If `hask.case` is a terminator, then I can be sure that my transform


# Thursday, Oct 22nd

- [GPU Outlining function](https://github.com/llvm/llvm-project/blob/366d8435b41dcc01013c507681523c65cdee2180/mlir/lib/Dialect/GPU/Transforms/KernelOutlining.cpp#L234)
- I'm going to write an outlining pass so I can perform my outline rewrites.

- Amazing, so MLIR hangs on trying to print my newly minted outlined function,
and the backtrace is at:

```
0x00005555565c4854 in mlir::Block::getParentOp() ()
(gdb) bt
#0  0x00005555565c4854 in mlir::Block::getParentOp() ()
#1  0x00005555565b5da6 in mlir::Operation::print(llvm::raw_ostream&, mlir::OpPrintingFlags) ()
#2  0x0000555556437dd7 in mlir::OpState::print (this=0x7fffffffd728, os=..., flags=...) at /usr/local/include/mlir/IR/OpDefinition.h:127
#3  0x0000555556437e34 in mlir::operator<< (os=..., op=...) at /usr/local/include/mlir/IR/OpDefinition.h:265
#4  0x0000555556454911 in mlir::standalone::OutlineUknownForcePattern::matchAndRewrite (this=0x555558f95bd0, force=..., rewriter=...)
    at /home/bollu/work/mlir/coremlir/lib/Hask/WorkerWrapperPass.cpp:127
#5  0x00005555564597ec in mlir::OpRewritePattern<mlir::standalone::ForceOp>::matchAndRewrite (this=0x555558f95bd0, op=0x555558f918a0, rewriter=...)
    at /usr/local/include/mlir/IR/PatternMatch.h:213
#6  0x000055555662c27b in mlir::PatternApplicator::matchAndRewrite(mlir::Operation*, mlir::RewritePattern const&, mlir::PatternRewriter&, llvm::function_ref<bool (mlir::RewritePattern const&)>, llvm::function_ref<void (mlir::RewritePattern const&)>, llvm::function_ref<mlir::LogicalResult (mlir::RewritePattern const&)>) ()
#7  0x000055555662c58f in mlir::PatternApplicator::matchAndRewrite(mlir::Operation*, mlir::PatternRewriter&, llvm::function_ref<bool (mlir::RewritePattern const&)>, llvm::function_ref<void (mlir::RewritePattern const&)>, llvm::function_ref<mlir::LogicalResult (mlir::RewritePattern const&)>) ()
#8  0x0000555556785f6c in mlir::applyPatternsAndFoldGreedily(llvm::MutableArrayRef<mlir::Region>, mlir::OwningRewritePatternList const&) ()
#9  0x000055555645532a in mlir::standalone::WorkerWrapperPass::runOnOperation (this=0x555558f189e0)
    at /home/bollu/work/mlir/coremlir/lib/Hask/WorkerWrapperPass.cpp:223
#10 0x000055555667f0a2 in mlir::Pass::run(mlir::Operation*, mlir::AnalysisManager) ()
#11 0x000055555667f182 in mlir::OpPassManager::run(mlir::Operation*, mlir::AnalysisManager) ()
#12 0x0000555556687a96 in mlir::PassManager::run(mlir::ModuleOp) ()
#13 0x0000555555881eae in main (argc=4, argv=0x7fffffffe4e8) at /home/bollu/work/mlir/coremlir/hask-opt/hask-opt.cpp:157
(gdb) Quit
```

- (1) I'm not even sure anymore that I should be doing this in a `RewritePattern`, because I'm not
  actually going to be deleting the `force`. Rather, I'm going to be replacing stuff
  that follows the `force` with other stuff. So I should really be using an
  MLIR pass
- (2) Alternatively, I should in fact rewrite at the `ApEagerOp` by noticing that
  it is a function call, and then checking if the argument is being forced etc.
- I'm going to try the (2) option, since it seems more local-rewrite-y,
  and it seems too painful to attempt to write a `Pass`.

- Amazing, so I now have outlining that works, but it now crashes inside `PatternRewriter.h`:

```
hask-opt: /usr/local/include/llvm/Support/Casting.h:269: typename llvm::cast_retty<X, Y*>::ret_type llvm::cast(Y*) [with X = mlir::standalone::ApEagerOp; Y = mlir::Operation; typename llvm::cast_retty<X,
) argument of incompatible type!"' failed.

Program received signal SIGABRT, Aborted.
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
51	../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007ffff661a8b1 in __GI_abort () at abort.c:79
#2  0x00007ffff660a42a in __assert_fail_base (fmt=0x7ffff6791a38 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x555557fd6198 "isa<X>(Val) && \"cast<Ty>() argument of incompatible
    file=file@entry=0x555557fd6168 "/usr/local/include/llvm/Support/Casting.h", line=line@entry=269,
    function=function@entry=0x555557fd85e0 <llvm::cast_retty<mlir::standalone::ApEagerOp, mlir::Operation*>::ret_type llvm::cast<mlir::standalone::ApEagerOp, mlir::Operation>(mlir::Operation*)::__PRETTY_F
ir::standalone::ApEagerOp; Y = mlir::Operation; typename llvm::cast_retty<X, Y*>::ret_type = mlir::standalone::ApEagerOp]") at assert.c:92
#3  0x00007ffff660a4a2 in __GI___assert_fail (assertion=0x555557fd6198 "isa<X>(Val) && \"cast<Ty>() argument of incompatible type!\"", file=0x555557fd6168 "/usr/local/include/llvm/Support/Casting.h", line
    function=0x555557fd85e0 <llvm::cast_retty<mlir::standalone::ApEagerOp, mlir::Operation*>::ret_type llvm::cast<mlir::standalone::ApEagerOp, mlir::Operation>(mlir::Operation*)::__PRETTY_FUNCTION__> "typ
:ApEagerOp; Y = mlir::Operation; typename llvm::cast_retty<X, Y*>::ret_type = mlir::standalone::ApEagerOp]") at assert.c:101
#4  0x0000555556418afd in llvm::cast<mlir::standalone::ApEagerOp, mlir::Operation> (Val=0x555558f1adf0) at /usr/local/include/llvm/Support/Casting.h:269
#5  0x0000555556459e0d in mlir::OpRewritePattern<mlir::standalone::ApEagerOp>::matchAndRewrite (this=0x555558f98a50, op=0x555558f1adf0, rewriter=...) at /usr/local/include/mlir/IR/PatternMatch.h:213
#6  0x000055555662ca4b in mlir::PatternApplicator::matchAndRewrite(mlir::Operation*, mlir::RewritePattern const&, mlir::PatternRewriter&, llvm::function_ref<bool (mlir::RewritePattern const&)>, llvm::func
lt (mlir::RewritePattern const&)>) ()
#7  0x000055555662cd5f in mlir::PatternApplicator::matchAndRewrite(mlir::Operation*, mlir::PatternRewriter&, llvm::function_ref<bool (mlir::RewritePattern const&)>, llvm::function_ref<void (mlir::RewriteP
t&)>) ()
#8  0x000055555678673c in mlir::applyPatternsAndFoldGreedily(llvm::MutableArrayRef<mlir::Region>, mlir::OwningRewritePatternList const&) ()
#9  0x00005555564558aa in mlir::standalone::WorkerWrapperPass::runOnOperation (this=0x555558f189e0) at /home/bollu/work/mlir/coremlir/lib/Hask/WorkerWrapperPass.cpp:316
#10 0x000055555667f872 in mlir::Pass::run(mlir::Operation*, mlir::AnalysisManager) ()
#11 0x000055555667f952 in mlir::OpPassManager::run(mlir::Operation*, mlir::AnalysisManager) ()
#12 0x0000555556688266 in mlir::PassManager::run(mlir::ModuleOp) ()
#13 0x0000555555881eae in main (argc=4, argv=0x7fffffffe4e8) at /home/bollu/work/mlir/coremlir/hask-opt/hask-opt.cpp:157
```

- [The suspect code is `mlir/IR/PatternMatch.h:213`](https://github.com/llvm/llvm-project/blob/63c58c2b934525c9863e624cf39ec542dd84ca78/mlir/include/mlir/IR/PatternMatch.h#L212):

```
LogicalResult matchAndRewrite(Operation *op,
                              PatternRewriter &rewriter) const final {
  return matchAndRewrite(cast<SourceOp>(op), rewriter);
}
```

- I'm at MLIR commit [63c58c2](https://github.com/llvm/llvm-project/commit/63c58c2b934525c9863e624cf39ec542dd84ca78).

- This maybe because of my assumption that `failure()` was supposed to undo *all* intermediate changes.
  Maybe there's a bug in the bail-out infrastructure, because this bug happens when / after
  a bail out in my pattern.

- OK, so it's either me mis-understanding the invariant of `failure()`, or there's an MLIR bug where you can't
  back out with a `failure()` in the middle of a transform.

- I "fixed" the bug by [moving all my checking code to the beginning in commit 7c90bd](7c90bdc66ce8fad833d45061833150d4aa0dca72)




# Wednesday, Oct 21st

- Power stable again, yay!
- [It seems like MLIR's inlining infrastructure isn't "up" yet?](https://github.com/joker-eph/mlir/pull/3#issuecomment-538687366)
- The commut is a year old. We seem to have a `CallInterface` now. It's unclear what the correct way to call the
  thing, though.
- [Seems I need to talk to `DialectInlinerInterface`](https://github.com/llvm/llvm-project/blob/22219cfc6a2a752c53238df4ceea342672392818/mlir/include/mlir/Transforms/InliningUtils.h)
- [Toy Ch4](https://github.com/llvm/llvm-project/blob/1b012a9146b85d30083a47d4929e86f843a5938d/mlir/docs/Tutorials/Toy/Ch-4.md)
- [LEAN header file for runtime](https://github.com/leanprover/lean4/blob/master/src/include/lean/lean.h)

# Friday, Oct 16th

- Can we do demand analysis by phrasing it as a dependence analysis problem (RAW?)
- The workhorse was SCEV, which allows us to recover loops
- The workhorse of that was definition of a natural loop, which told us what
  types of programs we can analyze
- What is the functional equivalent of a natural loop?
- The naive guess is "tail calls". I'm not so sure. Consider the loop:

```cpp
sum = 0; for(int i = n; i > 0; i--) { sum += i*i ; }
```
- versus the haskell program:

```hs
f 0 = 0; f n = n*n + f (n - 1)
```

- The above is 'clearly' a natural loop, while the program below is not. What gives?
- We can transform the above into accumulator style:

```hs
f 0 k = k; f n k = f (n-1) (k + n*n)
```

- When can we convert something into accumulator style? How do we know how to
  convert something into accumulator style?

- Naively, I feel that this involves something about 'destination passing style'.
  We first go from:

```hs
f 0 = 0; f n = n*n + f(n-1)
```

- into destination passing style:

```hs
f 0 slot = write slot 0;
f n slot = do f (n - 1) slot; out <- read slot; write (n*n + out) slot
```

- which is then purified into:

```
f 0 slot = 0
f n slot = f (n - 1) (slot + n*n)
```

- Of course, this is all incohate rambling.

# Thursday, Oct 15th

- Wow, another amazing nit:
``` cpp
Type retty = 
  this->getAttrOfType<TypeAttr>(HaskFuncOp::getReturnTypeAttributeKey())
    .getType();
// retty will be null!
```
- The correct invocation is:

```cpp
Type retty = 
  this->getAttrOfType<TypeAttr>(HaskFuncOp::getReturnTypeAttributeKey())
  .getValue();
```
- Because the _value_ of the `TypeAttr` is the type. The `Type` is `none`! It's
  forced to have a `Type` because, well, that's how inheritance works. It should
  just return `Type` so we have `Type : Type` and we're set :)

# Friday Oct 9th 

- [Meeting docs](https://docs.google.com/document/d/1tbeqlwunRKomN8WdfxuCJxVQUMuLd5kRqpIsGxF-w6o/preview)

#### Compiling without continuations

 - [Compiling without continuations video](https://www.youtube.com/watch?v=LMTr8yw0Gk4)

We might intially be tempted to convert

 ```hs
 case (case xs of [] -> T; _ -> F) of
   T -> BIG1; F -> BIG2
 ```

 into:
 
 ```hs
 case xs of
   [] -> case T of T -> BIG1; F -> BIG2
   _ -> case F of T -> BIG1; F -> BIG2
 ```

 of course this involves copying. so we should rather transform
 this into

 ```
let j1 () = BIG1; j2 () = BIG2
in case xs of
     [] -> case T of T -> j1 (); F -> j2 ()
     _ -> case F of T -> j1 (); F -> j2 ()
 ```

 Essentially, they once again outline code into a common
 names called `(j1, j2)` and then convert the rest into
 function invocations.

 Clearly this also works for pattern bound variables. We can transform:

 ```hs
 case (case xs of [] -> Nothing; (p:ps) -> Just p) of
   Nothing -> BIG1; Just x -> BIG2 x
 ```

 into:

 ```
 let j1 () = BIG11; j2 x = BIG2 x
 in case (case xs of [] -> Nothing; (p:ps) -> Just p) of
      Nothing -> j1; Just x -> j2 x
 ```

#### What is a join point?
 - All calls are saturated tail calls, 
 - They are not captured in a thunk/closure, so they can be compiled
   efficiently

#### We don't want to lose join points: A bad transformation example

We case-of-case on this program:

```hs
case (let j x = E1
       in case xs of Just x -> j x; Nothing -> E2) of
  True -> R1; False - R2
```

to get this program:

```hs
let j x = E1
in case xs of 
  Just x ->  case j x of True -> R1; False -> R2 
  Nothing -> case E2 of  True -> R1; False -> R2
```

- Note that this `j x` is now case-scrutinized, and is thus not a tail. The
   R1/R2 case does not actually use `E1`?

- So what we do is to perform this transformation:

#### Join based:

- Original `let` based starting program, deprecated, shown for comparison:

```hs
-- | original `let`
case (let j x = E1
       in case xs of Just x -> j x; Nothing -> E2) of
  True -> R1; False - R2
```

- New starting program with `let` changed to `join!`. We are yet to sink the
  `case` inside.

```hs
-- | original with `join!` instead of `let`
case (join! j x = E1
       in case xs of Just x -> j x; Nothing -> E2) of
  True -> R1; False - R2
```

- Since we have a `Just x -> j x` where `j = join! ... `,
  we're going to try to preserve the tail call `j x`.
  when we push the outer `case` inside, (1) we don't push the `case` *around* the `join`.
  Rather, we push the `case` _into_ the `join!`. (2) we push the `case` around 
  the `Nothing -> E2` as usual. This gives us the program:

```hs
-- | case pushed inside origin with `join!`
join j x = case E1 of  True -> R1; False -> R2
in case xs of 
    Just x -> j x; 
    Nothing -> case E2 of True -> R1; False -> R2
```

- Peyton jones says that "this slide is the **slide to remember**"
- (1) We want to move the outer evaluation context into the body of the join-point.
- (2) For E2, since the body eats `E2`, we push it in.
- Formalize join points as a language construct.
- Add join-point bindings and jumps into the language.
- This has deep relationships to [sequent calculus](https://ncatlab.org/nlab/show/sequent+calculus)
- Infer which `let` bindings are join-points: `contification` is the keyword
  to look for.
- Automagically allows `Stream`s to fuse without needing an extraneous `Skip`
  constructor. Don't know what this is referring to.

# Friday Oct 2nd 2020

- [Meeting documentation](https://docs.google.com/document/d/1JD2RgNbRoztiuSQtN8IskyaYDF4Yd9WWjwecyyVzum4/edit?usp=sharing)

#### What is a loop-breaker?
- [Taken from `mpickering`'s blog](https://mpickering.github.io/posts/2017-03-20-inlining-and-specialisation.html)
> In general, if we were to inline recursive definitions without care we could
> easily cause the simplifier to diverge. However, we still want to inline as
> many functions which appear in mutually recursive blocks as possible. GHC
> statically analyses each recursive groups of bindings and chooses one of them
> as the loop-breaker. Any function which is marked as a loop-breaker will
> never be inlined. Other functions in the recursive group are free to be
> inlined as eventually a loop-breaker will be reached and the inliner will
> stop.

He continues to write:

> Sometimes people ask if GHC is smart enough to unroll a recursive definition
> when given a static argument. For example, if we could define sum using
> direct recursion:

```hs
sum :: [Int] -> Int
sum [] = 0
sum (x:xs) = x + sum xs
```

- I have no idea if this continues to be the case.
- EDIT: I do know! I implemented the above program. GHC still has
  this behaviour, so the above program does not become a single constant.


# Tuesday, Sep 29 2020

- Apparently, I can't print a `mlir::Value` from an `mir::InFlightDiagnostic`.
- `mlir::Value` does not implement a `<`, so you can't use it as a key in a `std::map` for a
  decent interpreter.

# Friday, Sep 25 2020

- [Meeting google doc link](https://docs.google.com/document/d/10cgXbXME0D_SV0VJTrQrz0obhUBa5kdM74crWDXbDgU/edit?usp=sharing)

- [GHC was unable to optimise a top level list!](https://docs.google.com/spreadsheets/d/1YhZlDRGvnCtN8UQf_0ItmgRWI9MhL21HDTlBEKqgWHc/edit?usp=sharing)
- GHC is unable to remove laziness from `data A = B | C | D`: there is no way
  to ask for this to be unboxed.
- https://www.scs.stanford.edu/16wi-cs240h/slides/ghc-compiler.html

# Thursday, Sep 24 2020

- [What optimizations can GHC be expected to perform reliably](https://stackoverflow.com/questions/12653787/what-optimizations-can-ghc-be-expected-to-perform-reliably)

Also, it seems I was wrong. Haskell only guarantees non-strict (call by name),
not lazy (call by need):

> The language spec promises non-strict semantics; it does not promise anything
> about whether or not superfluous work will be performed  ~ Dan Burton


- [sketch of worker wrapper](reading/sep-24-worker-wrapper-sketch.md)




# Wednesday, Sep 23 2020


```
%0 = hask.lambda(%arg0:!hask.value) {
  %1 = hask.transmute(%arg0 :!hask.value):i64
  %2 = hask.caseint %1 [0 : i64 ->  {
  ^bb0(%arg1: i64):  // no predecessors
    %3 = hask.transmute(%1 :i64):!hask.value
    hask.return(%3) : !hask.value
  }]
  ...
running TransmuteOpConversionPattern on: hask.transmute | loc("./case-int-roundtrip.mlir":7:12)
transmute:%0 = hask.transmute(<<UNKNOWN SSA VALUE>> :!hask.value):i64
in: <block argument>
inRemapped: <block argument>
inType:!hask.value
```

- I find this `<<UNKNOWN SSA VALUE>>` thing extremely tiresome.
  It makes debugging way harder than it ought to be.
- Strangely, when I try to print the `in`put directly, it says `<block argument>`
  which is SO MUCH MORE HELPFUL! It would be evern more helpful if it says *which block* argument.
- I also don't understand how to print _regions_ in MLIR. Region can't be `llvm::errs() << region`,
  nor do they have a `dump()` method. This is garbage.
- I also don't understand how to print a basic block correctly. You can't
  `llvm::errs() << *bb`. Fortunately, at least basic block has a `dump()`. 
- Unfortunately, this `dump()` is less than helpful when you are moving BBs around. For exmple,
  on trying to print:

```cpp
Block *bb = new Block();
llvm::errs() << "newBB:"; bb->dump();
``` 

it says:

```
newBB: <<UNLINKED BLOCK>>
```

what the hell kind of answer is that? just print the BB! So, if one has a block that's unlinked to a Region, you can't
even _print_ the block! 

- It doesn't [seem like `addTargetMaterialization` is used a lot?](https://github.com/llvm/llvm-project/search?q=addTargetMaterialization)
  only one "real" use in `StandardToLLVM.cpp`. I have strange errors:
  
```
case-int.mlir:10:14: error: failed to materialize conversion for result #0 of operation 'hask.transmute' that remained live after conversion
     %ival = hask.transmute(%ihash : !hask.value): i64
             ^
case-int.mlir:10:14: note: see current operation: %1 = "hask.transmute"(<<UNKNOWN SSA VALUE>>) : (!hask.value) -> i64
case-int.mlir:10:14: note: see existing live user here: %6 = llvm.inttoptr %1 : i64 to !llvm.ptr<i8>
```

The materialization code is:

```cpp
    addTargetMaterialization([](OpBuilder &builder, LLVM::LLVMIntegerType, ValueRange vals, Location loc) {
      if (vals.size() > 1) {
        assert(false && "trying to lower more than 1 value into an integer");
      }
      Value in = vals[0];
      Value out = builder.create<LLVM::PtrToIntOp>(loc, LLVM::LLVMType::getInt64Ty(builder.getContext()), in).getResult();
      return out;
    });
```
- I'm quite confused abot why the result is live after conversion, isn't the fucking framework supposed to kill the result?


- OK, the sequence of calls is _very weird_. It's as follows:
```
---materialization %0 = hask.make_i64(42 : i64) ->  pointer
running TransmuteOpConversionPattern on: hask.transmute | loc("playground.mlir":9:17)
transmute:%2 = hask.transmute(%0 :!hask.value):i64
in: %0 = hask.make_i64(42 : i64)
inRemapped: %0 = hask.make_i64(42 : i64)
inType:!hask.value
convert(inType):!llvm.ptr<i8>
retty:i64
rettyRemapped:!llvm.i64
---materialization %0 = hask.make_i64(42 : i64) ->  int
ret: %2 = llvm.ptrtoint %0 : !hask.value to !llvm.i64
===mod:==
llvm.func @main() -> !llvm.ptr<i8> {
  %0 = hask.make_i64(42 : i64)
  %1 = llvm.inttoptr %0 : !hask.value to !llvm.ptr<i8>
  %2 = llvm.ptrtoint %0 : !hask.value to !llvm.i64
  %3 = hask.transmute(%0 :!hask.value):i64
  hask.return(%3) : i64
}
playground.mlir:9:17: error: failed to materialize conversion for result #0 of operation 'hask.transmute' that remained live after conversion
        %ival = hask.transmute(%lit_42 : !hask.value): i64
                ^
playground.mlir:9:17: note: see current operation: %3 = "hask.transmute"(%0) : (!hask.value) -> i64
playground.mlir:10:9: note: see existing live user here: hask.return(%3) : i64
        hask.return(%ival) : i64
```

So it: 

1. tries to materialize `make_i64` using the target conversion pattern 
2. THEN asks me to lower transmute
3. where I lower the input using `%2 = llvm.ptrtoint %0 : !hask.value to !llvm.i64`
4. I then call `replaceOp(transmute, ret)`, but for whatever reason, that doesn't take!
5. It complains about `failed to materialize conversion for result #0 of operation 'hask.transmute'`??? what does that
   fucking _mean_? You shouldn't even _have_ a `hask.transmute`! I asked you to _replace_ it! WTF.

So even before I start to lower `transmute`, the target conversion pattern has decided that I need
to lower the `i64`, because I don't have a `makeI64ConversionPattern` enabled? It then complains that the
result 
A backtrace shows:

```
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007ffff661a8b1 in __GI_abort () at abort.c:79
#2  0x00007ffff660a42a in __assert_fail_base (fmt=0x7ffff6791a38 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x555557e44738 "false && \"want to see backtrace\"",
    file=file@entry=0x555557e44048 "/home/bollu/work/mlir/coremlir/lib/Hask/HaskOps.cpp", line=line@entry=1182,
    function=function@entry=0x555557e4d200 <mlir::standalone::HaskToLLVMTypeConverter::HaskToLLVMTypeConverter(mlir::MLIRContext*)::{lambda(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location)#5}::operator()(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location) const::__PRETTY_FUNCTION__> "mlir::standalone::HaskToLLVMTypeConverter::HaskToLLVMTypeConverter(mlir::MLIRContext*)::<lambda(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location)>") at assert.c:92
#3  0x00007ffff660a4a2 in __GI___assert_fail (assertion=0x555557e44738 "false && \"want to see backtrace\"", file=0x555557e44048 "/home/bollu/work/mlir/coremlir/lib/Hask/HaskOps.cpp",
    line=1182,
    function=0x555557e4d200 <mlir::standalone::HaskToLLVMTypeConverter::HaskToLLVMTypeConverter(mlir::MLIRContext*)::{lambda(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange,
mlir::Location)#5}::operator()(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location) const::__PRETTY_FUNCTION__> "mlir::standalone::HaskToLLVMTypeConverter::HaskToLLVMTypeConverter(mlir::MLIRContext*)::<lambda(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location)>") at assert.c:101
#4  0x0000555556398f10 in mlir::standalone::HaskToLLVMTypeConverter::HaskToLLVMTypeConverter(mlir::MLIRContext*)::{lambda(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location)#5}::operator()(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location) const (__closure=0x7fffffffd440, builder=..., ptrty=..., vals=..., loc=...)
    at /home/bollu/work/mlir/coremlir/lib/Hask/HaskOps.cpp:1182
#5  0x00005555563a5948 in std::function<llvm::Optional<mlir::Value> (mlir::OpBuilder&, mlir::Type, mlir::ValueRange, mlir::Location)> mlir::TypeConverter::wrapMaterialization<mlir::LLVM::LLVMPointerType, mlir::standalone::HaskToLLVMTypeConverter::HaskToLLVMTypeConverter(mlir::MLIRContext*)::{lambda(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location)#5}>(mlir::standalone::HaskToLLVMTypeConverter::HaskToLLVMTypeConverter(mlir::MLIRContext*)::{lambda(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location)#5}&&)::{lambda(mlir::OpBuilder&, llvm::Optional<mlir::Value>, mlir::ValueRange, mlir::Location)#1}::operator()(mlir::OpBuilder&, llvm::Optional<mlir::Value>, mlir::ValueRange, mlir::Location) const
    (__closure=0x7fffffffd440, builder=..., resultType=..., inputs=..., loc=...) at /usr/local/include/mlir/Transforms/DialectConversion.h:288
#6  0x00005555563adfa5 in std::_Function_handler<llvm::Optional<mlir::Value> (mlir::OpBuilder&, mlir::Type, mlir::ValueRange, mlir::Location), std::function<llvm::Optional<mlir::Value> (mlir::OpBuilder&, mlir::Type, mlir::ValueRange, mlir::Location)> mlir::TypeConverter::wrapMaterialization<mlir::LLVM::LLVMPointerType, mlir::standalone::HaskToLLVMTypeConverter::HaskToLLVMTypeConverter(mlir::MLIRContext*)::{lambda(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location)#5}>(mlir::standalone::HaskToLLVMTypeConverter::HaskToLLVMTypeConverter(mlir::MLIRContext*)::{lambda(mlir::OpBuilder&, mlir::LLVM::LLVMPointerType, mlir::ValueRange, mlir::Location)#5}&&)::{lambda(mlir::OpBuilder&, mlir::Type, mlir::ValueRange, mlir::Location)#1}>::_M_invoke(std::_Any_data const&, mlir::OpBuilder&, mlir::Type&&, mlir::ValueRange&&, mlir::Location&&) (__functor=..., __args#0=..., __args#1=..., __args#2=..., __args#3=...)
    at /usr/include/c++/7/bits/std_function.h:302
#7  0x0000555556617c0b in mlir::TypeConverter::materializeConversion(llvm::MutableArrayRef<std::function<llvm::Optional<mlir::Value> (mlir::OpBuilder&, mlir::Type, mlir::ValueRange, mlir::Location)> >, mlir::OpBuilder&, mlir::Location, mlir::Type, mlir::ValueRange) ()
#8  0x000055555661e482 in mlir::detail::ConversionPatternRewriterImpl::remapValues(mlir::Location, mlir::PatternRewriter&, mlir::TypeConverter*, mlir::OperandRange, llvm::SmallVectorImpl<mlir::Value>&) ()
#9  0x000055555661e712 in mlir::ConversionPattern::matchAndRewrite(mlir::Operation*, mlir::PatternRewriter&) const ()
#10 0x000055555658668b in mlir::PatternApplicator::matchAndRewrite(mlir::Operation*, mlir::RewritePattern const&, mlir::PatternRewriter&, llvm::function_ref<bool (mlir::RewritePattern const&)>, llvm::function_ref<void (mlir::RewritePattern const&)>, llvm::function_ref<mlir::LogicalResult (mlir::RewritePattern const&)>) ()
#11 0x000055555658699f in mlir::PatternApplicator::matchAndRewrite(mlir::Operation*, mlir::PatternRewriter&, llvm::function_ref<bool (mlir::RewritePattern const&)>, llvm::function_ref<void (mlir::RewritePattern const&)>, llvm::function_ref<mlir::LogicalResult (mlir::RewritePattern const&)>) ()
#12 0x0000555556624e54 in (anonymous namespace)::OperationLegalizer::legalize(mlir::Operation*, mlir::ConversionPatternRewriter&) ()
#13 0x0000555556627c3e in (anonymous namespace)::OperationConverter::convertOperations(llvm::ArrayRef<mlir::Operation*>) ()
#14 0x000055555662a074 in mlir::applyPartialConversion(llvm::ArrayRef<mlir::Operation*>, mlir::ConversionTarget&, mlir::OwningRewritePatternList const&, llvm::DenseSet<mlir::Operation*, llvm::DenseMapInfo<mlir::Operation*> >*) ()
#15 0x000055555662a1a1 in mlir::applyPartialConversion(mlir::Operation*, mlir::ConversionTarget&, mlir::OwningRewritePatternList const&, llvm::DenseSet<mlir::Operation*, llvm::DenseMapInfo<mlir::Operation*> >*) ()
#16 0x000055555639409c in mlir::standalone::(anonymous namespace)::LowerHaskToStandardPass::runOnOperation (this=0x555559096370) at /home/bollu/work/mlir/coremlir/lib/Hask/HaskOps.cpp:2251
#17 0x00005555565d9472 in mlir::Pass::run(mlir::Operation*, mlir::AnalysisManager) ()
#18 0x00005555565d9552 in mlir::OpPassManager::run(mlir::Operation*, mlir::AnalysisManager) ()
#19 0x00005555565e1e66 in mlir::PassManager::run(mlir::ModuleOp) ()
#20 0x00005555557ef47e in main (argc=4, argv=0x7fffffffdd18) at /home/bollu/work/mlir/coremlir/hask-opt/hask-opt.cpp:408
```


- The error "failed to materialize conversion for result" is
  [from `DialectConversion.cpp`](https://github.com/llvm/llvm-project/blob/deb99610ab002702f43de79d818c2ccc80371569/mlir/lib/Transforms/DialectConversion.cpp#L2321).
- Reading the sources:

```cpp
LogicalResult OperationConverter::legalizeChangedResultType(
    Operation *op, OpResult result, Value newValue,
    TypeConverter *replConverter, ConversionPatternRewriter &rewriter,
    ConversionPatternRewriterImpl &rewriterImpl) {
  // Walk the users of this value to see if there are any live users that
  // weren't replaced during conversion.
  auto liveUserIt = llvm::find_if_not(result.getUsers(), [&](Operation *user) {
    return rewriterImpl.isOpIgnored(user);
  });
  if (liveUserIt == result.user_end())
    return success();

  // If the replacement has a type converter, attempt to materialize a
  // conversion back to the original type.
  if (!replConverter) {
    // TODO: We should emit an error here, similarly to the case where the
    // result is replaced with null. Unfortunately a lot of existing
    // patterns rely on this behavior, so until those patterns are updated
    // we keep the legacy behavior here of just forwarding the new value.
    return success();
  }

  // Track the number of created operations so that new ones can be legalized.
  size_t numCreatedOps = rewriterImpl.createdOps.size();

  // Materialize a conversion for this live result value.
  Type resultType = result.getType();
  Value convertedValue = replConverter->materializeSourceConversion(
      rewriter, op->getLoc(), resultType, newValue);
  if (!convertedValue) {
    InFlightDiagnostic diag = op->emitError()
                              << "failed to materialize conversion for result #"
                              << result.getResultNumber() << " of operation '"
                              << op->getName()
                              << "' that remained live after conversion";
    diag.attachNote(liveUserIt->getLoc())
        << "see existing live user here: " << *liveUserIt;
    return failure();
  }
```

- I see no implementations of [`materializeSourceConversion`](https://github.com/llvm/llvm-project/search?q=materializeSourceConversion)
  

- [`IsOpIgnored`](https://github.com/llvm/llvm-project/blob/deb99610ab002702f43de79d818c2ccc80371569/mlir/lib/Transforms/DialectConversion.cpp#L1096)

```cpp
bool ConversionPatternRewriterImpl::isOpIgnored(Operation *op) const {
  // Check to see if this operation was replaced or its parent ignored.
  return replacements.count(op) || ignoredOps.count(op->getParentOp());
}
```

- OK, whatever, I give up for today. For whatever reason, it doesn't seem to choose to recursively convert 
  the inner region. 
# Monday, Sep 21 2020

I vote `replaceOpWithNewOp` to be the worst named function in MLIR! 
This fucking thing depnds on the state of the `Rewriter`. I feel
like any sane human being would assume it would create a new
`Op` **at the location of the old `Op`**. FML, I wasted
two hours on trying to debug this!

```cpp
// replace altRhsRet with a BrOp that is created
// **AT THE LOCATION** of the rewriter.
 rewriter.replaceOpWithNewOp<LLVM::BrOp>(altRhsRet, altRhsRet.getOperand(),
                                              afterCaseBB);

```

Seriously, **fuck the entire MLIR API design.** Why does
everything have to carry so much state? Didn't we learn from
LLVM?

# Friday, Sep 18th 2020

- [Link to google doc](https://docs.google.com/document/d/1nkcM3o3D7G6stkxdCbJIEXdgbqRMdiL38x-oJiA6fJQ/edit?usp=sharing)

# Monday, Sep 14th 2020

- I need to fix functions/globals ASAP. I think it should be like this:
0. Lazy functions are denoted by `a ~> b`. Strict functions by `a => b`.
1. `apLazy(a ~> b)` can peel off arguments, leaving one with finally `() ~> b`.
2. `force` can 'invoke' a `() => b` leaving one with a `b`.
2. `apStrict(a -> b)` can peel off arguments, leaving one with finally `b`.


This is hard to write an example for. But basically, there is a difference
between a value that is expected to be forced and the value itself.

for example, should `plus` be:

```
  hask.func @plus {
    %lam = hask.lambdaSSA(%i : !hask.thunk, %j: !hask.thunk) {
      %icons = hask.force(%i: !hask.thunk): !hask.value
      %reti = hask.caseSSA %icons 
           [@MkSimpleInt -> { ^entry(%ival: !hask.value):
              %jcons = hask.force(%j: !hask.thunk):!hask.value
              %retj = hask.caseSSA %jcons 
                  [@MkSimpleInt -> { ^entry(%jval: !hask.value):
                        %sum_v = hask.primop_add(%ival, %jval)
                        %boxed = hask.construct(@MkSimpleInt, %sum_v)
                        // do we return the box?
                        hask.return(%boxed) :!hask.thunk
                        // or do we return a closure that holds the box?
                        // this matters to callees. In one case, they can
                        // `case` case on the box. In the other case, they need
                        // to `force`, and then `case`.
                        hask.suspend(%boxed) :!hask.thunk

                  }]
              hask.return(%retj):!hask.thunk
           }]
      hask.return(%reti): !hask.thunk
    }
    hask.return(%lam): !hask.fn<!hask.thunk, !hask.fn<!hask.thunk, !hask.thunk>>
  }
```


# Friday, Sep 11 2020

- [doc to call](https://docs.google.com/document/d/1AMTo9cTpPTVzLrBAnzE9NS5wJcQ6Jo8PeMKO7-foHEg/edit?usp=sharing)

# Wednesday, Sep 9 2020

##### `k-lazy`: MLIR

```
module {
  // k x y = x
  hask.func @k {
    %lambda = hask.lambdaSSA(%x: !hask.thunk, %y: !hask.thunk) {
      hask.return(%x) : !hask.thunk
    }
    hask.return(%lambda) :!hask.fn<!hask.thunk, !hask.fn<!hask.thunk, !hask.thunk>>
  }

  // loop a = loop a
  hask.func @loop {
    %lambda = hask.lambdaSSA(%a: !hask.thunk) {
      %loop = hask.ref(@loop) : !hask.fn<!hask.thunk, !hask.thunk>
      %out_t = hask.apSSA(%loop : !hask.fn<!hask.thunk, !hask.thunk>, %a)
      // HACK! This will emit an `evalClosure` though it is nowhere 
      // reachable from hask.return (%out_t).
      // We need to rework the type system...
      %out_v = hask.force(%out_t)
      hask.return(%out_t) : !hask.thunk
    }
    hask.return(%lambda) : !hask.fn<!hask.thunk, !hask.thunk>
  }

  hask.adt @X [#hask.data_constructor<@MkX []>]

  // k (x:X) (y:(loop X)) = x
  // main = 
  //     let y = loop x -- builds a closure.
  //     in k x y
  hask.func @main {
    %lambda = hask.lambdaSSA(%_: !hask.thunk) {
      %x = hask.construct(@X)
      %k = hask.ref(@k) : !hask.fn<!hask.thunk, !hask.fn<!hask.thunk, !hask.thunk>>
      %loop = hask.ref(@loop) :  !hask.fn<!hask.thunk, !hask.thunk>
      %y = hask.apSSA(%loop : !hask.fn<!hask.thunk, !hask.thunk>, %x)
      %out_t = hask.apSSA(%k: !hask.fn<!hask.thunk, !hask.fn<!hask.thunk, !hask.thunk>>, %x, %y)
      %out = hask.force(%out_t)
      hask.return(%out) : !hask.value
    }
    hask.return(%lambda) :!hask.fn<!hask.thunk, !hask.value>
  }
}
```

#### `k-lazy`: LLVM

```
declare i8* @malloc(i64)
declare void @free(i8*)
declare i8* @mkClosure_capture0_args2(i8*, i8*, i8*)
declare i8* @malloc__(i32)
declare i8* @evalClosure(i8*)
declare i8* @mkClosure_capture0_args1(i8*, i8*)

define i64 @k(i64 %0, i64 %1) !dbg !3 {
  ret i64 %0, !dbg !7
}

define i64 @loop(i64 %0) !dbg !9 {
  %2 = inttoptr i64 %0 to i8*, !dbg !10
  %3 = call i8* @mkClosure_capture0_args1(i8* bitcast (i64 (i64)* @loop to i8*), i8* %2), !dbg !10
  %4 = call i8* @evalClosure(i8* %3), !dbg !12
  ret i8* %3, !dbg !13
}

define i64 @main(i64 %0) !dbg !14 {
  %2 = call i8* @malloc__(i32 4200), !dbg !15
  %3 = ptrtoint i8* %2 to i64, !dbg !15
  %4 = inttoptr i64 %3 to i8*, !dbg !17
  %5 = call i8* @mkClosure_capture0_args1(i8* bitcast (i64 (i64)* @loop to i8*), i8* %4), !dbg !17
  %6 = inttoptr i64 %3 to i8*, !dbg !18
  %7 = call i8* @mkClosure_capture0_args2(i8* bitcast (i64 (i64, i64)* @k to i8*), i8* %6, i8* %5), !dbg !18
  %8 = call i8* @evalClosure(i8* %7), !dbg !19
  ret i8* %8, !dbg !20
}
```

- I can reduce the `inttoptr`/`ptrtoint` noise by assuming everything will
  always be `i8*`.

- I need to write some code that prints the final answer. Then I can have
  testing with `FileCheck`. Can steal from `simplexhc-cpp`.

- What's annoying is that we're back to making closures and having saturated
  function applications. I was hoping I could avoid both, but no dice.

- Also, our type system is broken. Note the definition of `loop`:

```
  // loop a = loop a
  hask.func @loop {
    %lambda = hask.lambdaSSA(%a: !hask.thunk) {
      %loop = hask.ref(@loop) : !hask.fn<!hask.thunk, !hask.thunk>
      %out_t = hask.apSSA(%loop : !hask.fn<!hask.thunk, !hask.thunk>, %a)
      // HACK! This will emit an `evalClosure` though it is nowhere 
      // reachable from hask.return (%out_t).
      // We need to rework the type system...
      %out_v = hask.force(%out_t)
      hask.return(%out_t) : !hask.thunk
    }
    hask.return(%lambda) : !hask.fn<!hask.thunk, !hask.thunk>
  }
```

I want to be able to return `%out_v` but I cannot. The *actual* types
that I have are:

- Stuff that is on the heap, which is created by `mkConstructor` [constructors]
  and `apSSA` [closures]
- Stuff that we get 'after forcing', which is going to be either
  constructors or raw values. This is because every time we force, we evaluate
  upto WHNF: the outermost thing must be either a constructor or a raw
  value.
- We are also lucky: in the above example, we don't actually capture
  any variables. If we were capturing things, then we would have had
  to work harder when building closures :(


# Tuesday, Sep 8 2020

### Naive compilation

Consider how we wish to lower

```
f :: Int -> Int -> Int
f = plus x y
```

we lower this to:

```
fn @f = lambda (%x) {
  return lambda (%y) {
    %plus_ref = ref(@plus)
    %x_plus = ap(%plus_ref, %x)
    %x_plus_y = ap(%x_plus, %y)
    return %x_plus_y

  }
}

global @g {
  %f = ref(@f)
  %one = ref(@one)
  %two = ref(@two)
  %fx = ap(%f, %one)
  %fxy = ap(fx, %two)
  %fxy_val = force(%fxy) //value is forced here
  case %fxy_val {
    ...
  }
}
```

Let's compile this:

```
f: 
  x = pop(); y = pop();
  push(y); push(x); enter(plus)

g: 
  push(two); push(one);
  enter(f);
  // assumes control flow returns here: this is another "?". Compiling naively
  // like this may not work, because stack space is too small is the STG wisdom.
  fxy_val = pop();
  case(fxy_val, ... )
```

#### Partial application

Now consider a slightly different program:

```
fn @f = lambda (%x) {
  return lambda (%y) {
    %plus_ref = ref(@plus)
    %x_plus = ap(%plus_ref, %x)
    %x_plus_y = ap(%x_plus, %y)
    return %x_plus_y

  }
}


fn @h = lambda (%x) {
  %f = ref(@f)
  %fortytwo = ref(@fortytwo)
  %fx = ap(%f, %x)
  %fx42 = ap(%x, %x, %fortytwo) // this is a value, not a thunk (?)
  return %fx42
}

global @g2 {
  %h = ref(@h)
  %one = ref(@one)
  %hone = ap(%h, %one)
  %honeval = force(%hone) //value is forced here
  case %honeval {
    ...
  }
}
```

How do we compile this? 
```
f: 
  x = pop(); y = pop();
  push(y); push(x); enter(plus)

h:
  x = pop()
  push(fortytwo)
  push(x)
  enter(f)

g2:
  push(one)
  enter(h)
  honeval = pop()
  case(honeval, ... )
```

#### Strictness

Consider we wish to call `+#`. The difference is that such a function does not
need? want? a 'force' call [in theory]. So, naively, we would want:

```
fn @fstrict = lambda (%x) {
  return lambda (%y) {
    %plus#_ref = ref(@plus#)
    %x_plus# = ap(%plus#_ref, %x)
    %x_plus#_y = ap(%x_plus#, %y) <- VALUE COMPUTED HERE
    return %x_plus_y

  }
}
```


ie, the value is 'computed' at the step of

```
%x_plus#_y = ap(%x_plus#, %y) <- VALUE COMPUTED HERE
```

and does not in fact wait for a `force`. In theory, we should compile such a thing
as:

```
f:
  x = pop(); y = pop();
  z = x + y;
  push(z) 
```

However, this is nonsensical. Before, we knew *when* to generate a sequence of
`pop`s: whenever there was a `force`. Now, however, this is not the case. Consider
the code:

```
fn @h = lambda (%x) {
  %plus# = ref(@plus#)
  %fortytwo = ref(@fortytwo)
  %fx = ap(%plus#, %x)
  %fx42 = ap(%x, %x, %fortytwo) // this is a value, not a thunk (?)
  return %fx42
}

global @g2 {
  %h = ref(@h)
  %one = ref(@one)
  %hone = ap(%h, %one) // <- should the value be computed here? automatically?
  %honeval = force(%hone) // <- or should the value be computed here?
  case %honeval {
    ...
  }
```

If we say that the value should be computed at

```
%hone = ap(%h, %one)
```

then how would we discover such a thing? How do we know that `h` calls `@plus#`?
It's impossible. So we can only compile the code in such a way that

```
%honeval = force(%hone) // <- or should the value be computed here?
```

must return the right value. But this forces us to eschew strict
semantics everywhere, even for seemingly 'strict' operations like
addition of integers? It's unclear to me what this means, and why there's a
difference between STG and our implementation.


#### Compiling lambdas

Inside STG, a `lambda` is not an *expression*. We can only have bindings at particular
*binding sites*. These binding sites create ("lambdas" closures). For this week,
we can assume that none of our lambdas have any free variables, so we don't
need to implement closure capturing immediately. That will come next week ;)


#### How do we compile constructors?

```
hask.func @minus {
%lami = hask.lambdaSSA(%i: !hask.thunk) {
     %lamj = hask.lambdaSSA(%j :!hask.thunk) {
          %icons = hask.force(%i)
          %reti = hask.caseSSA %icons 
               [@SimpleInt -> { ^entry(%ival: !hask.value):
                  %jcons = hask.force(%j)
                  %retj = hask.caseSSA %jcons 
                      [@SimpleInt -> { ^entry(%jval: !hask.value):
                            %minus_hash = hask.ref (@"-#") : !hask.fn<!hask.value, !hask.fn<!hask.value, !hask.thunk>>
                            %i_sub = hask.apSSA(%minus_hash : !hask.fn<!hask.value, !hask.fn<!hask.value, !hask.thunk>>, %ival)
                            %i_sub_j_thunk = hask.apSSA(%i_sub : !hask.fn<!hask.value, !hask.thunk>, %jval)
                            %i_sub_j = hask.force(%i_sub_j_thunk)
                            %mk_simple_int = hask.ref (@MkSimpleInt) :!hask.fn<!hask.value, !hask.thunk>
                            %boxed = hask.apSSA(%mk_simple_int:!hask.fn<!hask.value, !hask.thunk>, %i_sub_j)
                            hask.return(%boxed) :!hask.thunk
                      }]
                  hask.return(%retj) :!hask.thunk
               }]
          hask.return(%reti):!hask.thunk
      }
      hask.return(%lamj): !hask.fn<!hask.thunk, !hask.thunk>
}
hask.return(%lami): !hask.fn<!hask.thunk, !hask.fn<!hask.thunk, !hask.thunk>>
}
```

Note that this is problematic: nowhere do we 'force' the call to `mk_simple_int`.
So why should such a call be compiled?

The only way out that I can see is to actually do the damn thing that
STG does, and always ask for saturated function calls. That way, when
we see an `ap`, we know that it should compile to a `push-enter`. Otherwise,
we seem to get into thorny issues of 'when do we force an `ap`?


All of this seems to force us into considering saturated function calls.


#### What does GRIN do?

GRIN compiles each partial application as a separate function.

True to the GRIN philosophy, also function objects are represented by node
values. Just like the G-machine and most other combinator-based abstract ma-
chines, function objects in GRIN programs exist in the form of curried applica-
tions of functions with too few arguments. Consider again the function upto of
our running example, which takes two arguments. We represent the function ob-
ject of upto by a node Pupto_2 , and an application of upto to one argument by
a node Pupto_1 e . The naming convention we use is that prefix `P` indicates
a partial application, and `_2` etc. is the number of missing arguments.
In analogy with the generic eval procedure, programs which use higher or-
der functions must also have a generic apply procedure, which must cover pos-
sible function nodes that might appear in the program. An example is shown
in Figure. apply returns the value of a function value (node) applied to one
additional argument. Generally, apply just returns the next version of the func-
tion node with one more argument present, except when the final argument is
supplied: then the call of the procedure takes place.


GRIN does not provide a way to do a function application of a variable in
a lazy context directly, e.g., build a representation of f x where f is a variable,
instead a closure must be wrapped around it; this is the purpose of the ap2
procedure.


#### What do we do?

It would have been lovely to have an IR that can automatically deal with partial
applications. For now, I'm switching to having saturated function calls.


# Monday, Sep 7 2020

- I am not sure if I need a new operation called as `haskConstruct(<dataConstructor>, <params>)`. Intuitively,
  I ought not have such a thing, because of indirection:

```
data X = MkX Int
f :: Int -> X; f = MkX 
o :: Int; o = 1
x :: X; x = f o
```
- we will see an `apSSA(f, o)` with no sight of the `haskConstruct` call.
  However, perhaps we should normalize `apSSA(f, o)` into `haskConstruct(@MkX, 1)`,
  because this will allow us to analyze the idea of a 'constructor application'
  separately from a 'function application'. So we should have a normalization
  rule from:

```
 %cons = hask.ref(@Constructor)
 %result = hask.apSSA(%cons, %v1, ..., %vn)
```

into:

```
 %result = hask.construct(@Constructor, %v1, ..., %vn)
```

- It is very unclear what the type of `lambda`, `ap` ought to be. For now,
  let's say it's all `!hask.value`. This will break once we mix strict and
  non-strict.

- This is correct code:
                                        
```
%mk_simple_int = hask.ref (@MkSimpleInt)
// what do now?
%boxed = hask.apSSA(%mk_simple_int, %i_sub_j)
hask.return(%boxed) :!hask.thunk
```

but if we assume that `hask.apSSA` must always return a `hask.value`, we
are screwed. The only way out I can see is to teaach `apSSA` and my
type system about currying and, well, function types. GG. Let's do this.

Great, so I now have a type system!

```
hask.force: (box: hask.thunk) -> hask.value
hask.case<T>: (scrutinee: hask.value) -> T. All the pattern matches have to return the same value.
hask.ap: (fn: hask.func<A, B>) * (param: A) -> B
hask.return: (retval: T) -> void
hask.lambda: (param: A) * (region with return: B) -> hask.func<A, B>
hask.ref<T>: (refname: Symbol) -> T
```

##### Raw git log

```
* a8c43a4 76 seconds ago Siddharth Bhat (HEAD -> master, origin/master) get first cut of type system working
|
|  8 files changed, 201 insertions(+), 125 deletions(-)
* 490c3af 3 hours ago Siddharth Bhat get hask.func to round-trip
|
|  4 files changed, 20 insertions(+), 14 deletions(-)
* ce64e16 4 hours ago Siddharth Bhat get angle bracket based fn type parsing working
|
|  2 files changed, 13 insertions(+), 1 deletion(-)
* 1ce1810 4 hours ago Siddharth Bhat add a HaskFunctionType that's not hooked in anywhere
|
|  2 files changed, 39 insertions(+), 1 deletion(-)
* ad0d367 5 hours ago Siddharth Bhat add appel paper on SSA v/s functional code
|
|  1 file changed, 6515 insertions(+)
* 50a656a 5 hours ago Siddharth Bhat Spring cleaning: rename ops from XSSAOp -> XOp
|
|  3 files changed, 44 insertions(+), 44 deletions(-)
* d4dda1a 6 hours ago Siddharth Bhat need function types. Scott be blessed.
|
|  9 files changed, 213 insertions(+), 216 deletions(-)
* 53bc03c 8 hours ago Siddharth Bhat started migrating to new normalization
|
|  8 files changed, 328 insertions(+), 83 deletions(-)
```

# Wed, Sep 2 2020


- [`A @Class@ corresponds to a Greek kappa in the static semantics:`](https://haskell-code-explorer.mfix.io/package/ghc-8.4.3/show/types/Class.hs#L271)
  --- Gee thanks,                                             
  that tells me where to lookup the static semantics and what `kappa` is...

- We extract out the data from `data ConcreteProd = MkConcreteProd Int# Int#`
  as:

```
//unique:rza
//name: ConcreteProd
//|data constructors|
  dcName: MkConcreteProd
  dcOrigTyCon: ConcreteProd
  dcFieldLabels: []
  dcRepType: Int# -> Int# -> ConcreteProd
  constructor types: [Int#, Int#]
  result type: ConcreteProd
  ---
  dcSig: ([], [], [Int#, Int#], ConcreteProd)
  dcFullSig: ([], [], [], [], [Int#, Int#], ConcreteProd)
  dcUniverseTyVars: []
  dcArgs: [Int#, Int#]
  dcOrigArgTys: [Int#, Int#]
  dcOrigResTy: ConcreteProd
  dcRepArgTys: [Int#, Int#]
```

- Similarly, for an *abstract* product, things are slightl more complicated:
  `data AbstractProd a b = MkAbstractProd a b`. I don't have a good idea for
  how the abstract binders should be serialized. In theory, we can just represent
  them as `lambda`s. In practice...

- For a concrete sum type, we get two data constructors:
```
//unique:rz7
//name: ConcreteSum
//|data constructors|
  dcName: ConcreteLeft
  dcOrigTyCon: ConcreteSum
  dcFieldLabels: []
  dcRepType: Int# -> ConcreteSum
  constructor types: [Int#]
  result type: ConcreteSum
  ...

  dcName: ConcreteRight
  dcOrigTyCon: ConcreteSum
  dcFieldLabels: []
  dcRepType: Int# -> ConcreteSum
  constructor types: [Int#]
  result type: ConcreteSum
  ...
//----
```

- For a concrete recursive type, the data constructor `ConcreteRecSumCons`
  refers to the type constructor `ConcreteRecSum`, which is also the result.
```
//unique:rz2
//name: ConcreteRecSum
//|data constructors|
  dcName: ConcreteRecSumCons
  dcOrigTyCon: ConcreteRecSum
  dcFieldLabels: []
  dcRepType: Int# -> ConcreteRecSum -> ConcreteRecSum
  constructor types: [Int#, ConcreteRecSum]
  result type: ConcreteRecSum
  ...
```

- So, I am unsure how we ought to handle abstract types like `Maybe a = Just a | Nothing`.
  I don't have a good sense of whether we should respect Core or not. I believe that
  what GRIN does is to not *care* about such issues: It doesn't even know what the hell
  a `Maybe` is. To it, it's just two types of boxes: Either `{tag:Just, data: [a]}`,
  `{tag:nothing, data:[]}`. Mh, I wish I had more clarity on any of this.

- Either way, let's say I want to represent these data constructors. I would
  like to have been able to write:

```
data ConcreteSum = ConcreteLeft Int# | ConcreteRight Int#
hask.make_algebraic_data_type @ConcreteSum  -- name of the ADT
  [@ConcreteLeft"[@"Int#"], # constructor1: Int# -> ConcreteSum
   @ConcreteRight[@"Int#"]] # constructor2: Int# -> ConcreteSum

# data ConcreteProd = MkConcreteProd Int# Int#
hask.make_algebraic_data_type @ConcreteProd 
 [@MkConcreteProd [@"Int#", @"Int#"]] 

# data ConcreteRec = MkConcreteRec Int# ConcreteRec
hask.make_algebraic_data_type @ConcreteRec 
 [@MkConcreteRec [@"Int#", @ConcreteRec]] 
```

- However, as far as I understand, such a declaration cannot be done easily
  because MLIR does not support *attribute lists*. It supports *type lists*,
  and *attribute dicts*. What do? One can of course encode a list using a dict
  with judicious use of torture. This seems like  a terrible solution to me
  though. Can we just beg upstram for attribute lists?

- OK, never mind, I am just horrendous at RTFMing. Turns out they call it
  "array attributes":

```
array-attribute ::= `[` (attribute-value (`,` attribute-value)*)? `]`
```
> An array attribute is an attribute that represents a collection of attribute values.

- FWIW, what threw me off is that this list attribute belongs to standard,
  and is not a primitive of the attribute vocabulary. Seems disingenous to me.


I'm trying to figure how to use custom attributes. On providing this input:

```
playground.mlir
module {
  hask.adt @SimpleInt [#hask.data_constructor<@MkSimpleInt, [@"Int#"]>]
}
```

I get the ever-so-helpful error message:

```
Error can't load file ./playground.mlir
```

Gee, thanks.
OK, now I need to find out which part of what I wrote is illegal.


- Fun aside: creating an `Op` derived class with _no traits_ results in an error!

```
/usr/local/include/mlir/IR/OpDefinition.h: In instantiation of ‘static bool mlir::Op<ConcreteType, Traits>::hasTrait(mlir::TypeID) [with ConcreteType = mlir::standalone::HaskADTOp; Traits = {}]’:
/usr/local/include/mlir/IR/OperationSupport.h:156:12:   required from ‘static mlir::AbstractOperation mlir::AbstractOperation::get(mlir::Dialect&) [with T = mlir::standalone::HaskADTOp]’
/usr/local/include/mlir/IR/Dialect.h:154:54:   required from ‘void mlir::Dialect::addOperations() [with Args = {mlir::standalone::HaskADTOp}]’
/home/bollu/mlir/coremlir/lib/Hask/HaskDialect.cpp:40:28:   required from here
/usr/local/include/mlir/IR/OpDefinition.h:1357:49: error: no matching function for call to ‘makeArrayRef(<brace-enclosed initializer list>)’
     return llvm::is_contained(llvm::makeArrayRef({TypeID::get<Traits>()...}),
```

- OK, stupid errors are past. I'm now learning the `Attribute` framework. It seems
  to hold data in my class, I need to have an `AttributeStorage` member. I'm
  taking `ArrayAttr` as my prototype. Here's the code, for ease of use:
  ([Github permalink](https://github.com/llvm/llvm-project/blob/deb99610ab002702f43de79d818c2ccc80371569/mlir/include/mlir/IR/Attributes.h#L187))

```cpp
/// Array attributes are lists of other attributes.  They are not necessarily
/// type homogenous given that attributes don't, in general, carry types.
class ArrayAttr : public Attribute::AttrBase<ArrayAttr, Attribute,
                                             detail::ArrayAttributeStorage> {
public:
  using Base::Base;
  using ValueType = ArrayRef<Attribute>;

  static ArrayAttr get(ArrayRef<Attribute> value, MLIRContext *context);

  ArrayRef<Attribute> getValue() const;
  Attribute operator[](unsigned idx) const;

  /// Support range iteration.
  using iterator = llvm::ArrayRef<Attribute>::iterator;
  iterator begin() const { return getValue().begin(); }
  iterator end() const { return getValue().end(); }
  size_t size() const { return getValue().size(); }
  bool empty() const { return size() == 0; }

private:
  /// Class for underlying value iterator support.
  template <typename AttrTy>
  class attr_value_iterator final
      : public llvm::mapped_iterator<ArrayAttr::iterator,
                                     AttrTy (*)(Attribute)> {
  public:
    explicit attr_value_iterator(ArrayAttr::iterator it)
        : llvm::mapped_iterator<ArrayAttr::iterator, AttrTy (*)(Attribute)>(
              it, [](Attribute attr) { return attr.cast<AttrTy>(); }) {}
    AttrTy operator*() const { return (*this->I).template cast<AttrTy>(); }
  };

public:
  template <typename AttrTy>
  iterator_range<attr_value_iterator<AttrTy>> getAsRange() {
    return llvm::make_range(attr_value_iterator<AttrTy>(begin()),
                            attr_value_iterator<AttrTy>(end()));
  }
  template <typename AttrTy, typename UnderlyingTy = typename AttrTy::ValueType>
  auto getAsValueRange() {
    return llvm::map_range(getAsRange<AttrTy>(), [](AttrTy attr) {
      return static_cast<UnderlyingTy>(attr.getValue());
    });
  }
};
```

- [Github permalink](https://github.com/llvm/llvm-project/blob/deb99610ab002702f43de79d818c2ccc80371569/mlir/lib/IR/AttributeDetail.h#L49) of storage details
```cpp
struct ArrayAttributeStorage : public AttributeStorage {
  using KeyTy = ArrayRef<Attribute>;

  ArrayAttributeStorage(ArrayRef<Attribute> value) : value(value) {}

  /// Key equality function.
  bool operator==(const KeyTy &key) const { return key == value; }

  /// Construct a new storage instance.
  static ArrayAttributeStorage *construct(AttributeStorageAllocator &allocator,
                                          const KeyTy &key) {
    return new (allocator.allocate<ArrayAttributeStorage>())
        ArrayAttributeStorage(allocator.copyInto(key));
  }

  ArrayRef<Attribute> value;
};
```

#### Git log at the end of today:

```
c7370bf 25 minutes ago Siddharth Bhat (HEAD -> master, origin/master) add legalizer data

 1 file changed, 18 insertions(+)
4abfd7a 38 minutes ago Siddharth Bhat It appears my attribute is created correctly. We print:

 2 files changed, 3 insertions(+), 2 deletions(-)
3261975 71 minutes ago Siddharth Bhat [WIP] getting there... can now store the data

 1 file changed, 8 insertions(+), 4 deletions(-)
f803c15 2 hours ago Siddharth Bhat [WIP] Playing with template errors, trying to figure out how to store attributes

 4 files changed, 119 insertions(+), 6 deletions(-)
cc6145a 2 hours ago Siddharth Bhat FUCK ME, I forgot to return x(

 1 file changed, 1 insertion(+), 1 deletion(-)
91d4b4e 3 hours ago Siddharth Bhat FFS, do NOT define classof() unless you know what you're doing

 2 files changed, 36 insertions(+), 6 deletions(-)
ff05162 3 hours ago Siddharth Bhat [WIP] I am literally unable to add an attribute...

 3 files changed, 9 insertions(+), 4 deletions(-)
dc4fec5 4 hours ago Siddharth Bhat [WIP] attr parsing

 6 files changed, 39 insertions(+), 17 deletions(-)
df17693 4 hours ago Siddharth Bhat add current status of getting attributes up

 12 files changed, 235 insertions(+), 272 deletions(-)
6ba2990 4 hours ago Siddharth Bhat add README documenting that we do in fact have attribute lists.

 1 file changed, 40 insertions(+)
4e16ba8 4 hours ago Siddharth Bhat [SIDEQUEST] Fuck this, let's just reboot hask98 from scratch on the weekend

 4 files changed, 14 insertions(+)
266201e 10 hours ago Siddharth Bhat add the exploration of data constructors here

 10 files changed, 2012 insertions(+), 551 deletions(-)
```




# Monday, 24 August 2020
- Nuked `HaskModuleOp`, `HaskDummyFinishOp` since I'm just using the regular `ModuleOp` now. I now understand
  why `ModuleOp` doesn't allow SSA variables in its body: these are not accessible from functions because of the
  `IsolatedFromAbove` constraint. So it only makes sense to have "true global data" in a `ModuleOp`. I really wish
  I didn't have to "learn their design choices" by reinventing the bloody wheel. Oh well, it was at least very
  instructive.
  
- Got full lowering down into LLVM. I now need to lower a program with `Int`, not just `Int#`.

- [Wow the names of data constructors are complicated](https://haskell-code-explorer.mfix.io/package/ghc-8.6.1/show/basicTypes/DataCon.hs#L126)

> Note [Data Constructor Naming]
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Each data constructor C has two, and possibly up to four, Names associated with it:
- My god, GHC does love inflicting pain on those who decide to read its sources.

- I'm writing the simplest possible version of `fib` that compiles through the GHC toolchain:

```hs
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}
import GHC.Prim
import GHC.Types(IO(..))
data SimpleInt = MkSimpleInt Int#

plus :: SimpleInt -> SimpleInt -> SimpleInt
plus i j = case i of MkSimpleInt ival -> case j of MkSimpleInt jval -> MkSimpleInt (ival +# jval)


minus :: SimpleInt -> SimpleInt -> SimpleInt
minus i j = case i of MkSimpleInt ival -> case j of MkSimpleInt jval -> MkSimpleInt (ival -# jval)


one :: SimpleInt; one = MkSimpleInt 1#
zero :: SimpleInt; zero = MkSimpleInt 0#

fib :: SimpleInt -> SimpleInt
fib i =
    case i of
       MkSimpleInt 0# -> zero
       MkSimpleInt 1# -> one
       n -> plus (fib n) (fib (minus n one))
main = IO (\s -> (# s, ()#))
```

```
/tmp/ghc1433_0/ghc_2.s:194:0: error:
     Error: symbol `Main_MkSimpleInt_info' is already defined
    |
194 | Main_MkSimpleInt_info:
    | ^

/tmp/ghc1433_0/ghc_2.s:214:0: error:
     Error: symbol `Main_MkSimpleInt_closure' is already defined
    |
214 | Main_MkSimpleInt_closure:
    | ^
```
- OK, interesting, my GHC plugin is somehow causing `Int` to be defined twice.
 
- I gave up. It seems to be because I run `CorePrep` myself manually, after which GHC
  also decides to run `CorePrep`. So I came up with the brilliant solution of killing `GHC`
  in a plugin pass after all of my scheduled passes run. This is so fucked up.

- I need to change `apSSA` to be capable of accepting the second parameter as a symbol
  as well.
```
tomlir-fib.pass-0000.mlir:82:39: error: expected SSA operand
        %app_24 = hask.apSSA(%app_23, @one)
```

- OK, no, that's not going to work. I now understand why MLIR needs the `std.constant` instruction. So, consider
two different variations:

1. `apSSA(@f1, %v1)`
2. `apSSA(%v2, @f2)`

Now, note that as MLIR `Op`s, these have the exact same "shape". They both have
one _operand_ (`%v1` / `%v2`) and they both have one _symbol attribute_, 
`@f1 / @f2`. So, there's no way to tell one from the other (easily)!. 

1. Either we do something terrible, like naming the symbol attribute at the `i`th parameter
  location as `param_i`, but, I mean, this is too horrible to even consider.
2. Or, we introduce a `%val = hask.reference(@sym)` just like `std.constant`, which we then
   use to write `%vf1 = hask.reference(@f1); apSSA(%vf1, %v1)` and similarly for the
   other case, we write `%vf2 = hask.reference(@f2); apSSA(%v2, %vf2)`. 
3. This makes me sad. Why can't we have `@var` as a real parameter, rather than some kind of
   stilted "attribute".
   
It seems like I'll be spending today fixing my lowering to learn about this `hask.ref` syntax.

# Log:  [oldest] to [newest]

## Concerns about this `Graph` version of region

The code that looks like below is considered as a non-dominated use. So it
checks **use-sites**, not **def-sites**.

```cpp
standalone.module { 
standalone.dominance_free_scope {
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^-Blocking dominance_free_scope
    vvvv-DEF
    %fib = standalone.toplevel_binding {  
        // ... standalone.dominance_free_scope { standalone.return (%fib) } ...
        ... standalone.return (%fib) } ...
                           USE-^^^^
    }
} // end dominance_free_scope
```

On the other hand, the code below is considered a dominated use (well, the domaintion
that is masked by `standalone.dominance_free_scope`:

```cpp
standalone.module { 
// standalone.dominance_free_scope {

    vvvv-DEF
    %fib = standalone.toplevel_binding {  
        ... standalone.dominance_free_scope { standalone.return (%fib) } ...
   BLOCKING-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                 USE-^^^^
        //... standalone.return (%fib) } ...
                                    
    }
//} // end dominance_free_scope
```

So, abstractly, the version below round-trips through MLIR. I will denote
this as `DEF(BLOCKING(USE))`:

```
DEF-MUTUAL-RECURSIVE
   BLOCKING----------->
     | USE-MUTUAL-RECURSIVE
     |
     v
```

The one below (denoted as `BLOCKING(DEF(USE)))`) does not
round-trip through MLIR; It gives domination errors:

```
BLOCKING----------->
|DEF-MUTUAL-RECURSIVE
|   USE-MUTUAL-RECURSIVE
|    
v    
```

- My mental model of the "blocking" was off! I thought it meant that
  everything inside this region can disobey SSA conditions. Rather,
  it means that everything **inside** this region can disobey SSA _with respect to_
  everything **outside** this region. [Maybe the other way round as well, I have not tried,
  nor do I have a good mental model of this].


- Unfortunately, for `Core`, it is the latter version with `BLOCKING (DEF (USE))` that 
  is of more use, since the `Core` encoding encodes the recursion as:

```
rec { -- BLOCKING
  fib :: Int -> Int
  
  {- Core Size{terms=23 types=6 cos=0 vbinds=0 jbinds=0} -}
  fib = -- DEF-MUTUAL-RECURSIVE
    λ i →
       ...
      (APP(Main.fib i)) -- USE-MUTUAL-RECURSIVE
      ...
}
```

So when we translate from `Core` into MLIR, we need to either
figure out which are the bindings that are `use-before-def` and then wrap them.
Or we participate in the discussion and petition for this kind of "lazy-region"
as well. Maybe both.

## Stuff discovered in this process about `ghc-dump`:

##### Fib for reference

```hs
{- Core Size{terms=23 types=6 cos=0 vbinds=0 jbinds=0} -}
fib = λ i → case i of wild {
    I# ds →
      case ds of ds {
        DEFAULT →
          APP(GHC.Num.+ @Int GHC.Num.$fNumInt // fib(i-1) + fib(i)
            (APP(Main.fib i)) // fib(i)
            (APP(Main.fib  -- fib(i - 1)
                    APP(GHC.Num.- @Int GHC.Num.$fNumInt i (APP(GHC.Types.I# 1#))))))) -- (i - 1)
        0# → APP(GHC.Types.I# 0#)
        1# → APP(GHC.Types.I# 1#)
      }
  }
```
I feel that `ghc-dump` does not preserve all the information we want. Hence
I started hand-writing the IR we want. I'll finish the translator after
I sleep and wake up. However, it's unclear to me how much extending `ghc-dump`
makes sense. I should maybe clean-slate from a Core plugin.


- Why? Because `ghc-dump` does not retain enough information. For example,
  it treats both `GHC.Num.$fNumInt` and `GHC.Types.I#` as variables; It has
  erased the fact that one is a typeclass dictionary and the other is
  a data constructor.

- Similarly, there is no way to query from within `ghc-dump` what `GHC.Num.-`
  is, and it's impossible to infer from context.

- In general, this is full of unknown-unknowns for me. I don't know enough 
  of the details of core to forsee what we will may need from GHC. Using
  `ghc-dump` is a bad idea because it's technical debt against a 
  _prettyprinter of core_ (fundamentally).

- Hence, we should really be reusing the
  [code in `ghc-dump` that traverses `Core` from within GHC](https://github.com/bgamari/ghc-dump/blob/master/ghc-dump-core/GhcDump/Convert.hs#L237).


# 1 July 2020

- [Reading GHC core sources paid off, the `CorePrep` invariants are documented here](https://haskell-code-explorer.mfix.io/package/ghc-8.6.1/show/coreSyn/CorePrep.hs#L142)
- In particular we have `case <body> of`. So nested cases are legal, 
  which is something we need to flatten.
- Outside of nested cases, everything else seems "reasonable": laziness is
  at each point of `let`. We can lower `let var = e` as `%let_var = lazy(e)`
  for example.
- Will first transcribe our `fibstrict` example by hand, then write a small
  Core plugin to do this automagically.
- I don't understand WTF `cabal` is doing. In particular, why `cabal install --library`
  installs the library twice :(
- It _seems_ like the cabal documentation on [how to install a system library](https://downloads.haskell.org/~cabal/Cabal-latest/doc/users-guide/installing-packages.html#building-and-installing-a-system-package)
  should do the trick.

```hs
$ runghc Setup.hs configure --ghc
$ runghc Setup.hs build
$ runghc Setup.hs install
```

- OK, so the problem was that I somehow had `cabal` hidden in my package management.
  It turns that even `ghc-pkg` maintains a local and a global package directory,
  and I was exposing stuff in my _local_ package directory (which is in `~/.ghc/.../package.conf.d`),
  note the global one (which is in `/usr/lib/ghc-6.12.1/package.conf.d`).
- The solution is to ask `ghc-pkg --global expose Cabal` which exposes `cabal`,
  which contains `Distribution.Simple`, which is needed to run `Setup.hs`.
- `runghc` is some kind of wrapper around `ghc` runs a file directly without
  having to compile things.
- Of course, this is disjoint from `cabal`'s `exposed-modules`, which is a layer
  disjoint from `ghc-pkg`. I think cabal commands `ghc-pkg` to expose and hide
  what it needs. This is fucking hilarious if it weren't so complex.

- To quote the GHC manual on `Cabal`'s `Distribution.Simple`:

> This module isn't called "Simple" because it's simple. Far from it. It's
> called "Simple" because it does complicated things to simple software.
> The original idea was that there could be different build systems that all
> presented the same compatible command line interfaces. There is still a
> Distribution.Make system but in practice no packages use it.
> https://hackage.haskell.org/package/Cabal-3.2.0.0/docs/Distribution-Simple.html


Reading GHC sources can sometimes be unpleasant. There are many, many invariants
to be maintained. [This is from CorePrep.hs:1450](https://haskell-code-explorer.mfix.io/package/ghc-8.6.1/show/coreSyn/CorePrep.hs#L1450):

> There is a subtle but important invariant ...
> The solution is CorePrep to have a miniature inlining pass...
> Why does the removal of 'lazy' have to occur in CorePrep? he gory details are in Note [lazyId magic]...
> We decided not to adopt this solution to keep the definition of 'exprIsTrivial' simple....
> There is ONE caveat however...
> the (hacky) non-recursive -- binding for data constructors...

- Brilliant, my tooling suddenly died thanks to https://github.com/well-typed/cborg/issues/242: GHC Prim
  and `cborg` started overlapping an export. 


- [`cabal install --lib` is not idempotent](https://github.com/haskell/cabal/issues/6394).
  Only haskellers would have issue citing a problem about **library installs**,
  while describing the issue as one of **idempotence**.

# 3 July 2020 (Friday)

Got the basic examples converted to SSA. Trying to do this in a GHC plugin.
Most of the translation code works. I'm stuck at a point, though. I need
to rename a variable `GHC.Num.-#` into something that can be named. Otherwise,
I try to create the MLIR:

```
%app_100  =  hask.apSSA(%-#, %i_s1wH)
```

where the `-#` refers to the variable name `GHC.Num.-#`. This is pretty
ludicrous. However, attempting to get a name from GHC seems quite complicated.
There are things like:

- `Id`
- `Var`
- `class NamedThing`
- `data OccName`

it's quite confusing as to what does what.

# 7 July 2020 (Tuesday)

- `mkUniqueGrimily`: great name for a function that creates data.
- OK, good, we now have MLIR that round-trips, in the sense that our
  MLIR gets verified. Now we have undeclared SSA variable problems:

```
tomlir-fibstrict.pass-0000.mlir:12:56: error: use of undeclared SSA value name
                                 %app_0  =  hask.apSSA(%var_minus_hash_99, %var_i_a12E)
                                                       ^
tomlir-fibstrict.pass-0000.mlir:12:76: error: use of undeclared SSA value name
                                 %app_0  =  hask.apSSA(%var_minus_hash_99, %var_i_a12E)
                                                                           ^
tomlir-fibstrict.pass-0000.mlir:25:72: error: use of undeclared SSA value name
                                                 %app_5  =  hask.apSSA(%var_plus_hash_98, %var_wild_X5)
                                                                       ^
tomlir-fibstrict.pass-0000.mlir:49:29: error: use of undeclared SSA value name
      %app_1  =  hask.apSSA(%var_TrNameS_ra, %lit_0)
                            ^
tomlir-fibstrict.pass-0000.mlir:50:29: error: use of undeclared SSA value name
      %app_2  =  hask.apSSA(%var_Module_r7, %app_1)
                            ^
tomlir-fibstrict.pass-0000.mlir:59:29: error: use of undeclared SSA value name
      %app_1  =  hask.apSSA(%var_fib_rwj, %lit_0)
                            ^
tomlir-fibstrict.pass-0000.mlir:65:37: error: use of undeclared SSA value name
              %app_3  =  hask.apSSA(%var_return_02O, %type_2)
                                    ^
tomlir-fibstrict.pass-0000.mlir:66:45: error: use of undeclared SSA value name
              %app_4  =  hask.apSSA(%app_3, %var_$fMonadIO_rob)
                                            ^
tomlir-fibstrict.pass-0000.mlir:69:45: error: use of undeclared SSA value name
              %app_7  =  hask.apSSA(%app_6, %var_unit_tuple_71)
                                            ^
tomlir-fibstrict.pass-0000.mlir:77:29: error: use of undeclared SSA value name
      %app_1  =  hask.apSSA(%var_runMainIO_01E, %type_0)
                            ^
makefile:4: recipe for target 'fibstrict' failed
make: *** [fibstrict] Error 1
```

Note that all of these names are GHC internals. We need to:
- Process all names, figure out what are our 'external' references.
- Code-generate 'extern' stubs for all of these.

There is also going to be the annoying "recursive call does not dominate use"
problem badgering us. We'll have to analyze Core to decide which use site is
recursive. This entire enterprise is messy, messy business.

The GHC sources are confusing. Consider `Util/Bag.hs`. We have `filterBagM` which
seems like an odd operation to have becuse a `Bag` is supposed to be unordered.
Nor does the function have any users at any rate. Spoke to Ben about it,
he said it's fine to delete the function, so I'll send a PR to do that once
I get this up and running...

# Wednesday, 8th july

- change my codegen so that regular variables are not uniqued, only wilds. This
  gives us stable names for things like `fib`, `runMain`, rather than names like `fib_X1` 
  or whatever. That will allow me to hardcode the preamble I need to build a
  vertical proptotype. This is also what Core seems to do:

```hs
Rec {
-- RHS size: {terms: 21, types: 4, coercions: 0, joins: 0/0}
fib [Occ=LoopBreaker] :: Int# -> Int#
[LclId]
fib -- the name fib is not uniqued
  = \ (i_a12E :: Int#) ->  -- this lambda variable is uniqued
      case i_a12E of {
        __DEFAULT ->
          case fib (-# i_a12E 1#) of wild_00 { __DEFAULT ->
          (case fib i_a12E of wild_X5 { __DEFAULT -> +# wild_X5 }) wild_00
          };
        0# -> i_a12E;
        1# -> i_a12E
      }
end Rec }

-- RHS size: {terms: 5, types: 0, coercions: 0, joins: 0/0}
$trModule :: Module
[LclIdX]
$trModule = Module (TrNameS "main"#) (TrNameS "Main"#)

-- RHS size: {terms: 7, types: 3, coercions: 0, joins: 0/0}
main :: IO ()
[LclIdX]
main
  = case fib 10# of { __DEFAULT -> return @ IO $fMonadIO @ () () }

-- RHS size: {terms: 2, types: 1, coercions: 0, joins: 0/0}
main :: IO ()
[LclIdX]
main = runMainIO @ () main

```

Note that only parameters to lambdas and wilds are `unique`d. Toplevel names
are not. I need some sane way in the code to figure out what I should unique
and what I should not by reading the Core pretty printing properly.

- There is a bigger problem. Note that the Core appears to have ** two `main` ** 
  declarations. I have no idea WTF is the semantics of this.

- OK, names are now fixed. I call the underlying `Outputable` instance of `Var` that knows the 
  right thing to do in all contexts. I didn't do this earlier because it prints
  functions as `-#`, `+#`, `()`, etc. So I intercept these. The implementation
  is 4 lines, but figuring it out took half an hour :/. This entire enterprise
  is like this.

```hs
-- use the ppr of Var because it knows whether to print or not.
cvtVar :: Var -> SDoc
cvtVar v = 
	let name = unpackFS $ occNameFS $ getOccName v
	in if name == "-#" then  (text "%minus_hash")
  	   else if name == "+#" then (text "%plus_hash")
  	   else if name == "()" then (text "%unit_tuple")
  	   else text "%" >< ppr v 
```


##### Re-checking the dumps from `fibstrict.hs`

OK, so I decided to view the dump from the horse's mouth:

```hs
-- | fibstrict.hs
{-# LANGUAGE MagicHash #-}
import GHC.Prim
fib :: Int# -> Int#
fib i = case i of
        0# ->  i; 1# ->  i
        _ ->  (fib i) +# (fib (i -# 1#))
main :: IO (); main = let x = fib 10# in return ()
```

```Core
-- | generated from fibstrict.hs
==================== Desugar (after optimization) ====================
2020-07-08 16:31:29.998915479 UTC
...

-- RHS size: {terms: 7, types: 3, coercions: 0, joins: 0/0}
main :: IO ()
[LclIdX]
main
  = case fib 10# of { __DEFAULT ->
    return @ IO GHC.Base.$fMonadIO @ () GHC.Tuple.()
    }

-- | what is this :Main.main?
-- RHS size: {terms: 2, types: 1, coercions: 0, joins: 0/0}
:Main.main :: IO ()
[LclIdX]
:Main.main = GHC.TopHandler.runMainIO @ () main

```

Note that there is `main`, and then there is `:Main.main` [So there is an extra `:Main.`].
This appears to inform the difference. One of them is some kind of top handler
that is added automagically. I might have to strip this from my printing.
I need to see how to deal with this. Will first identify what adds this symbol
and if there's a clean way to disable this.

- TODO: figure out how to get the core dump that I print in my MLIR file
  to contain as much information as the GHC dump. for example,
  the GHC dump says:

```
-- ***GHC file fibstrict.dump-ds***
-- RHS size: {terms: 2, types: 1, coercions: 0, joins: 0/0}
:Main.main :: IO ()
[LclIdX]
:Main.main = GHC.TopHandler.runMainIO @ () main

```

```
-- ***my MLIR file with the Core appended to the end as a comment***
-- RHS size: {terms: 2, types: 1, coercions: 0, joins: 0/0}
main :: IO ()
[LclIdX]
main = runMainIO @ () main

```
- In particular, note that `fibstrict.dump-ds` says `:Main.main = GHC.TopHandler.runMainIO` while my
  MLIR file only says `main = runMainIO ...`. I want that full qualification
  in my dump as well. I will spend some time on this, because the upshot
  is **huge**: accurate debugging and names!

- The GHC codebase is written with misery as a resource, it seems:

```hs
-- compiler/GHC/Rename/Env.hs
        -- We can get built-in syntax showing up here too, sadly.  If you type
        --      data T = (,,,)
        -- the constructor is parsed as a type, and then GHC.Parser.PostProcess.tyConToDataCon
        -- uses setRdrNameSpace to make it into a data constructors.  At that point
        -- the nice Exact name for the TyCon gets swizzled to an Orig name.
        -- Hence the badOrigBinding error message.
        --
        -- Except for the ":Main.main = ..." definition inserted into
        -- the Main module; ugh!
```

Ugh indeed. I have no idea how to check if the binder is `:Main.main`

- What I do know is that this is built here:

```
compiler/GHC/Tc/Module.hs
-- See Note [Root-main Id]
-- Construct the binding
--      :Main.main :: IO res_ty = runMainIO res_ty main
; run_main_id <- tcLookupId runMainIOName
; let { root_main_name =  mkExternalName rootMainKey rOOT_MAIN
                   (mkVarOccFS (fsLit "main"))
                   (getSrcSpan main_name)
; root_main_id = Id.mkExportedVanillaId root_main_name
                                      (mkTyConApp ioTyCon [res_ty])
```

After which I have no _fucking_ clue how to check that the binding
comes from this module.

The note reads:

```
Note [Root-main Id]
~~~~~~~~~~~~~~~~~~~
The function that the RTS invokes is always :Main.main, which we call
root_main_id.  (Because GHC allows the user to have a module not
called Main as the main module, we can't rely on the main function
being called "Main.main".  That's why root_main_id has a fixed module
":Main".)

This is unusual: it's a LocalId whose Name has a Module from another
module. Tiresomely, we must filter it out again in GHC.Iface.Make, less we
get two defns for 'main' in the interface file!
```

# Monday, 13th July 2020

- Added a new type `hask.untyped` to represent all things in my hask dialect.
  This was mostly to future proof and ensure that stuff is not
  accidentally wrecked by my use of `none`.

## how is `FuncOp` implemented?

How the funcOp gets parsed:

- Toplevel: It calls `parseFunctionLikeOp`. They use `PIMPL` style here for whatever
  reason.

- https://github.com/llvm/llvm-project/blob/74145d584126da2ce7a836d9b2240d56442f3ea1/mlir/lib/IR/Function.cpp

```cpp
ParseResult FuncOp::parse(OpAsmParser &parser, OperationState &result) {
  auto buildFuncType = [](Builder &builder, ArrayRef<Type> argTypes,
                          ArrayRef<Type> results, impl::VariadicFlag,
                          std::string &) {
    return builder.getFunctionType(argTypes, results);
  };

  return impl::parseFunctionLikeOp(parser, result, /*allowVariadic=*/false,
                                   buildFuncType);
}
```

- the call to `parseFunctioLikeOp` does bog-standard stuff. The interesting
  bit is that it parses the function name as a _symbol_ (attribute). so the
  syntax `func foo` has `func` as a keyword, with `foo` being a symbol.

- Now I'm confused as to how this prevents "double declarations" of the same
  function. is this verified by the module after as a separate check, and
  not encoded as SSA? If so, that's fugly.

- https://github.com/llvm/llvm-project/blob/5eae715a3115be2640d0fd37d0bd4771abf2ab9b/mlir/lib/IR/FunctionImplementation.cpp#L160
```cpp
ParseResult
mlir::impl::parseFunctionLikeOp(OpAsmParser &parser, OperationState &result,
                                bool allowVariadic,
                                mlir::impl::FuncTypeBuilder funcTypeBuilder) {
  SmallVector<OpAsmParser::OperandType, 4> entryArgs;
  SmallVector<NamedAttrList, 4> argAttrs;
  SmallVector<NamedAttrList, 4> resultAttrs;
  SmallVector<Type, 4> argTypes;
  SmallVector<Type, 4> resultTypes;
  auto &builder = parser.getBuilder();

  // Parse the name as a symbol.
  StringAttr nameAttr;
  if (parser.parseSymbolName(nameAttr, ::mlir::SymbolTable::getSymbolAttrName(),
                             result.attributes))
    return failure();

  // Parse the function signature.
  auto signatureLocation = parser.getCurrentLocation();
  bool isVariadic = false;
  if (parseFunctionSignature(parser, allowVariadic, entryArgs, argTypes,
                             argAttrs, isVariadic, resultTypes, resultAttrs))
    return failure();

  std::string errorMessage;
  if (auto type = funcTypeBuilder(builder, argTypes, resultTypes,
                                  impl::VariadicFlag(isVariadic), errorMessage))
    result.addAttribute(getTypeAttrName(), TypeAttr::get(type));    
  else
    return parser.emitError(signatureLocation)
           << "failed to construct function type"
           << (errorMessage.empty() ? "" : ": ") << errorMessage;

  // If function attributes are present, parse them.
  if (parser.parseOptionalAttrDictWithKeyword(result.attributes))
    return failure();

  // Add the attributes to the function arguments.
  assert(argAttrs.size() == argTypes.size());
  assert(resultAttrs.size() == resultTypes.size());
  addArgAndResultAttrs(builder, result, argAttrs, resultAttrs);

  // Parse the optional function body.
  auto *body = result.addRegion();
  return parser.parseOptionalRegion(
      *body, entryArgs, entryArgs.empty() ? ArrayRef<Type>() : argTypes);
}
```

##### How `call` works:

- FML, tobias was right. I was hoping he was not. It is indeed true that the
  function name argument is a string :/ So then, how does one walk the
  use chain when one hits a function?
- https://github.com/llvm/llvm-project/blob/master/mlir/include/mlir/Dialect/StandardOps/IR/Ops.td#L632

```cpp
def CallOp : Std_Op<"call", [CallOpInterface]> {
  ...
  let arguments = (ins FlatSymbolRefAttr:$callee, Variadic<AnyType>:$operands);
  let results = (outs Variadic<AnyType>);

  let builders = [OpBuilder<
    "OpBuilder &builder, OperationState &result, FuncOp callee,"
    "ValueRange operands = {}", [{
      result.addOperands(operands);
      result.addAttribute("callee", builder.getSymbolRefAttr(callee));
      result.addTypes(callee.getType().getResults());
  }]>, OpBuilder<
    "OpBuilder &builder, OperationState &result, SymbolRefAttr callee,"
    "ArrayRef<Type> results, ValueRange operands = {}", [{
      result.addOperands(operands);
      result.addAttribute("callee", callee);
      result.addTypes(results);
  }]>, OpBuilder<
    "OpBuilder &builder, OperationState &result, StringRef callee,"
    "ArrayRef<Type> results, ValueRange operands = {}", [{
      build(builder, result, builder.getSymbolRefAttr(callee), results,
            operands);
  }]>];

  let extraClassDeclaration = [{
    StringRef getCallee() { return callee(); }
    FunctionType getCalleeType();

    /// Get the argument operands to the called function.
    operand_range getArgOperands() {
      return {arg_operand_begin(), arg_operand_end()};
    }

    /// Return the callee of this operation.
    CallInterfaceCallable getCallableForCallee() {
      return getAttrOfType<SymbolRefAttr>("callee");
    }
  }];

  let assemblyFormat = [{
    $callee `(` $operands `)` attr-dict `:` functional-type($operands, results)
  }];
}
```

- What is a `FlatSymbolRefAttr` you ask? excellent question.
- https://github.com/llvm/llvm-project/blob/9db53a182705ac1f652c6ee375735bea5539272c/mlir/include/mlir/IR/Attributes.h#L551
- OK, so it's not a string! It's a `symbolName`, as parsed by `parseSymbolName`.


```cpp
 /// A symbol reference attribute represents a symbolic reference to another
 /// operation.
 class SymbolRefAttr
    : public Attribute::AttrBase<SymbolRefAttr, Attribute,
                                 detail::SymbolRefAttributeStorage> {
```

- symbols are explained in MLIR as follows, at the 'Symbols and symbol tables' doc: https://github.com/llvm/llvm-project/blob/9db53a182705ac1f652c6ee375735bea5539272c/mlir/docs/SymbolsAndSymbolTables.md

> A Symbol is a named operation that resides immediately within a region that
> defines a SymbolTable. The name of a symbol must be unique within the parent
> SymbolTable. This name is semantically similarly to an SSA result value, and
> may be referred to by other operations to provide a symbolic link, or use, to
> the symbol. An example of a Symbol operation is func. func defines a symbol
> name, which is referred to by operations like `std.call`.

- It continues, talking explicitly about SSA:

> Using an attribute, as opposed to an SSA value, has several benefits:
>
> If we were to use SSA values, we would need to create some mechanism in which
> to opt-out of certain properties of it such as dominance. Attributes allow
> for referencing the operations irregardless of the order in which they were
> defined.
>
> Attributes simplify referencing operations within nested symbol tables, which
> are traditionally not visible outside of the parent region.

- OK, nice, this is not fugly! Great `:D` I am so releived.

##### How `ret` works:

- https://github.com/llvm/llvm-project/blob/master/mlir/include/mlir/Dialect/StandardOps/IR/Ops.td#L2063

```cpp
 def ReturnOp : Std_Op<"return", [NoSideEffect, HasParent<"FuncOp">, ReturnLike,
                                 Terminator]> {
  ...

  let arguments = (ins Variadic<AnyType>:$operands);
  let builders = [OpBuilder<
    "OpBuilder &b, OperationState &result", [{ build(b, result, llvm::None); }]
  >];
  let assemblyFormat = "attr-dict ($operands^ `:` type($operands))?";
}
```

### Can we use the `recursive_ref` construct to encode `fib` more simply?

Yes we can. We can write, for example:

```mlir
hask.module { 
    %fib = hask.recursive_ref  {  
        %core_one =  hask.make_i32(1)
        %fib_call = hask.apSSA(%fib, %core_one) <- use does not dominate def
        hask.return(%fib_call)
    }
    hask.return(%fib)
}
```

and this "just works".

**EDIT**: Nope, NVM. I implemented this and found out that this _does not work_:

```mlir
hask.module { 
    %core_one =  hask.make_i32(1)

    // passes
    %flat = hask.recursive_ref  {  
        %fib_call = hask.apSSA(%flat, %core_one)
        hask.return(%fib_call)
    }

    // fails!
    %nested = hask.recursive_ref  {  
        %case = hask.caseSSA %core_one 
                ["default" -> { //default
                    // fails because the use is nested inside a region.
                    %fib_call = hask.apSSA(%nested, %core_one)
                    hask.return(%fib_call)
                }]
        hask.return(%case)
    }
    hask.dummy_finish
}
```

- In particular, note that the `%nested` use fails. This is because the use
  is wrapped inside a normal region of the `default` block. This normal
  region again establishes SSA rules.


### Email to GHC-devs about how to use names


I'm trying to understand how to query information about `Var`s from a
Core plugin. Consider the snippet of haskell:

```
{-# LANGUAGE MagicHash #-}
import GHC.Prim
fib :: Int# -> Int#
fib i = case i of 0# ->  i; 1# ->  i; _ ->  (fib i) +# (fib (i -# 1#))

main :: IO (); main = let x = fib 10# in return ()
```

That compiles to the following (elided) GHC Core, dumped right after desugar:

```mlir
Rec {
fib [Occ=LoopBreaker] :: Int# -> Int#
[LclId]
fib
  = \ (i_a12E :: Int#) ->
      case i_a12E of {
        __DEFAULT ->
          case fib (-# i_a12E 1#) of wild_00 { __DEFAULT ->
          (case fib i_a12E of wild_X5 { __DEFAULT -> +# wild_X5 }) wild_00
          };
        0# -> i_a12E;
        1# -> i_a12E
      }
end Rec }

Main.$trModule :: GHC.Types.Module
[LclIdX]
Main.$trModule
  = GHC.Types.Module
      (GHC.Types.TrNameS "main"#) (GHC.Types.TrNameS "Main"#)

-- RHS size: {terms: 7, types: 3, coercions: 0, joins: 0/0}
main :: IO ()
[LclIdX]
main
  = case fib 10# of { __DEFAULT ->
    return @ IO GHC.Base.$fMonadIO @ () GHC.Tuple.()
    }

-- RHS size: {terms: 2, types: 1, coercions: 0, joins: 0/0}
:Main.main :: IO ()
[LclIdX]
:Main.main = GHC.TopHandler.runMainIO @ () main
```

I've been  using `occNameString . getOccName :: Id -> String` to detect names from a `Var`
. I'm rapidly finding this insufficient, and want more information
about a variable. In particular, How to I figure out:

1. When I see the Var with occurence name `fib`, that it belongs to module `Main`?
2. When I see the Var with name `main`, whether it is `Main.main` or `:Main.main`?
3. When I see the Var with name `+#`, that this is an inbuilt name? Similarly
   for `-#` and `()`.
4. In general, given a Var, how do I decide where it comes from, and whether it is
   user-defined or something GHC defined ('wired-in' I believe is the term I am
   looking for)?
5. When I see a `Var`, how do I learn its type?
6. In general, is there a page that tells me how to 'query' Core/`ModGuts` from within a core plugin?


### Answers to email [Where to find name info]:

- I received one answer (so far) that told me to look at https://hackage.haskell.org/package/ghc-8.10.1/docs/Name.html#g:3
- In `haskell-code-explorer`: https://haskell-code-explorer.mfix.io/package/ghc-8.6.1/show/basicTypes/Name.hs#L107

- The link seems to contain answers to some of my questions, but not others. I
  had tried some of the APIs among them, and didn't understand their semantics.
  But it's at least comforting to know that I was looking at the right place.

- Another  file that might be useful: https://hackage.haskell.org/package/ghc-8.10.1/docs/Module.html#t:Module
- In `haskell-code-exporer`: https://haskell-code-explorer.mfix.io/package/ghc-8.6.1/show/basicTypes/Module.hs#L407

### Trying to use `SymbolAttr` for implementing functions

- The problem appears to be that something like `@foo` is not considered an SSA value, but a `SymbolAttr`
  So what is the "type" of my function `apSSA`? does it take first parameter an SSA value?
  or does it take first parameter `SymbolAttr`? I need both!

```mlir
// foo :: Int -> (Int -> Int)
func @foo() {
  ... 
  %ret = hask.ap(@foo, 1) // recursive call
  hask.ap(%ret, 1) // 
}
```

Possible solutions:
1. Make the call of two types: `callToplevel`, and `callOther`. This is against the ethos of haskell.
2. Continue using our `reucrsive_ref` hack that lets us treat toplevel bindings uniformly.
3. Use MLIR hackery to have `call(...)` take first parameter _either_ `FlatSymbolAttr` _or_ an SSA value.
   It seems that this is sub-optimal, which is why the `std` dialect seems to have both `call`
   and `indirect_call`.

- `call`: https://mlir.llvm.org/docs/Dialects/Standard/#stdcall-callop. Has attribute `callee`
  of type `::mlir::FlatSymbolRefAttr`

- `call_indirect`: https://mlir.llvm.org/docs/Dialects/Standard/#stdcall_indirect-callindirectop Has operand `callee` of type `function type`.

This will lead to pain, because we have a `SymbolAttr` and an SSA value with the
same name, like so:

```mlir
// This is hopeless, we can have SSA values and symbol table entries with
// the same name.
hask.func @function {
    %function = hask.make_i32(1)
    hask.return (%function)
}
```

This round trips through MLIR `:(`. Big sad.

### Hacked `apSSA`:

got `apSSA` to accept both `@fib` and `%value`. I don't see this as a good
solution, primarily because later on, when we are trying to write stuff
that rewrites the IR, we will need to handle the two cases separately. 

- Plus, it's not possible to stash this `SymbolAttr` which is the name of
  `@fib`, and the `mlir::Value` which is `%value` in the same `set/vector/container` data
  structure since they don't share a base class. 

- I guess the argument will be that we should store the _full_ `func @symbol = {... }`,
  which is an `Op`. But `Op` and `Value` don't share the same base class either?

## Tuesday, 14th July 2020

- added a `hask.force` to allow us to write `case e of ename { default -> ... }`
  as `ename = hask.force(e); …`

- This brings up another problem. Assume we have `y = case e of ename { default -> …; val = …; return val }`. We would
  like to make _emitting_ MLIR easy, so I took the decision to emit this as `hask.copy(...)`:

```mlir
//NEW
%ename = hask.force(%e)
...
%val = ...
%y = hask.copy(%val)
```                                                                      

Old (what we used to have):

```mlir
// old
%y = case %e of { ^default(%ename): …; %val = … ; return %val; }
```

- So we have a new instruction called `hask.copy`, which is necessary because one can't write `%y = %x`.
  It's a stupid hack around MLIR's (overly-restrictive) SSA form. It can be removed by a rewriter that replaces
  `%y = hask.copy(%x)` by replacing all uses of `%y` with `%x`.

### Another design for function calls

We can perhaps force all functions to be of the form:

```mlir
hask.func @fib {
  ...
  %fibref = constant @fib
  hask.apSSA(%fibref, %constant_one) // <- new proposal
  hask.apSSA(@fib, %constant_one) // <- current version
  This simplifies the use of the variable: We will always have an SSA variable
  as the called function.
}
```

### Can generate resonable code from Core:

```
// Main
// Core2MLIR: GenMLIR BeforeCorePrep
hask.module {
    %plus_hash = hask.make_data_constructor<"+#">
    %minus_hash = hask.make_data_constructor<"-#">
    %unit_tuple = hask.make_data_constructor<"()">
  hask.func @fib {
  %lambda_0 = hask.lambdaSSA(%i_a12E) {
    %case_1 = hask.caseSSA  %i_a12E
    ["default" ->
    {
    ^entry(%ds_d1jZ: !hask.untyped):
      # app_2 = (-# i_a123)
      %app_2 = hask.apSSA(%minus_hash, %i_a12E)
      # lit_3 = 1
      %lit_3 = hask.make_i32(1)
      # app_4 = (-# i_a123 1)
      %app_4 = hask.apSSA(%app_2, %lit_3)
      # app_5 = fib (-# i_a123 1)
      %app_5 = hask.apSSA(@fib, %app_4)
      # wild_00 = force(fib(-# i_a123 1))
      %wild_00 = hask.force (%app_5)
      # app_7 = fib(i)
      %app_7 = hask.apSSA(@fib, %i_a12E)
      # wild_X5 = force(fib(i))
      %wild_X5 = hask.force (%app_7)
      # app_7 = (+# force(fib(i)))
      %app_9 = hask.apSSA(%plus_hash, %wild_X5)
      # app_10 = (+# force(fib(i)) fib(-# i_a123 1))
      %app_10 = hask.apSSA(%app_9, %wild_00)
    hask.return(%app_10)
    }
    ]
    [0 ->
    {
    ^entry(%ds_d1jZ: !hask.untyped):
    hask.return(%i_a12E)
    }
    ]
    [1 ->
    {
    ^entry(%ds_d1jZ: !hask.untyped):
    hask.return(%i_a12E)
    }
    ]
    hask.return(%case_1)
  }
  hask.return(%lambda_0)
  }
hask.dummy_finish
}
// ============ Haskell Core ========================
//Rec {
//-- RHS size: {terms: 21, types: 4, coercions: 0, joins: 0/0}
//main:Main.fib [Occ=LoopBreaker]
//  :: ghc-prim-0.5.3:GHC.Prim.Int# -> ghc-prim-0.5.3:GHC.Prim.Int#
//[LclId]
//main:Main.fib
//  = \ (i_a12E :: ghc-prim-0.5.3:GHC.Prim.Int#) ->
//      case i_a12E of {
//        __DEFAULT ->
//          case main:Main.fib (ghc-prim-0.5.3:GHC.Prim.-# i_a12E 1#)
//          of wild_00
//          { __DEFAULT ->
//          (case main:Main.fib i_a12E of wild_X5 { __DEFAULT ->
//           ghc-prim-0.5.3:GHC.Prim.+# wild_X5
//           })
//            wild_00
//          };
//        0# -> i_a12E;
//        1# -> i_a12E
//      }
//end Rec }
//
//-- RHS size: {terms: 5, types: 0, coercions: 0, joins: 0/0}
//main:Main.$trModule :: ghc-prim-0.5.3:GHC.Types.Module
//[LclIdX]
//main:Main.$trModule
//  = ghc-prim-0.5.3:GHC.Types.Module
//      (ghc-prim-0.5.3:GHC.Types.TrNameS "main"#)
//      (ghc-prim-0.5.3:GHC.Types.TrNameS "Main"#)
//
//-- RHS size: {terms: 7, types: 3, coercions: 0, joins: 0/0}
//main:Main.main :: ghc-prim-0.5.3:GHC.Types.IO ()
//[LclIdX]
//main:Main.main
//  = case main:Main.fib 10# of { __DEFAULT ->
//    base-4.12.0.0:GHC.Base.return
//      @ ghc-prim-0.5.3:GHC.Types.IO
//      base-4.12.0.0:GHC.Base.$fMonadIO
//      @ ()
//      ghc-prim-0.5.3:GHC.Tuple.()
//    }
//
//-- RHS size: {terms: 2, types: 1, coercions: 0, joins: 0/0}
//main::Main.main :: ghc-prim-0.5.3:GHC.Types.IO ()
//[LclIdX]
//main::Main.main
//  = base-4.12.0.0:GHC.TopHandler.runMainIO @ () main:Main.main
//
```

### Reading the rewriter/lowering documentation of MLIR
- https://mlir.llvm.org/docs/Tutorials/Toy/Ch-5/
- https://mlir.llvm.org/docs/Tutorials/Toy/Ch-6/
- https://github.com/bollu/musquared/blob/master/lib/LeanDialect.cpp#L824
- https://github.com/bollu/musquared/blob/master/include/LeanDialect.h#L220

### Updating `fibstrict`
- I managed to eliminate the need for `hask.copy` from the auto-generated code,
  but I don't really understand _how_. I need to think about this a bit more, and a bit more carefully.
  This stuff is subtle!

The new readable hand-written `fibstrict` (adapted from the auto-generated code) is:

```
// Main
// Core2MLIR: GenMLIR BeforeCorePrep
hask.module {
    %plus_hash = hask.make_data_constructor<"+#">
    %minus_hash = hask.make_data_constructor<"-#">
    %unit_tuple = hask.make_data_constructor<"()">
  hask.func @fib {
    %lambda = hask.lambdaSSA(%i) {
      %retval = hask.caseSSA  %i
      ["default" -> { ^entry(%default_random_name: !hask.untyped): // todo: remove this defult
        %i_minus = hask.apSSA(%minus_hash, %i)
        %lit_one = hask.make_i32(1)
        %i_minus_one = hask.apSSA(%i_minus, %lit_one)
        %fib_i_minus_one = hask.apSSA(@fib, %i_minus_one)
        %force_fib_i_minus_one = hask.force (%fib_i_minus_one) // todo: this is extraneous!
        %fib_i = hask.apSSA(@fib, %i)
        %force_fib_i = hask.force (%fib_i) // todo: this is extraneous!
        %plus_force_fib_i = hask.apSSA(%plus_hash, %force_fib_i)
        %fib_i_plus_fib_i_minus_one = hask.apSSA(%plus_force_fib_i, %force_fib_i_minus_one)
        hask.return(%fib_i_plus_fib_i_minus_one) }]
      [0 -> { ^entry(%default_random_name: !hask.untyped):
        hask.return(%i) }]
      [1 -> { ^entry(%default_random_name: !hask.untyped):
        hask.return(%i) }]
      hask.return(%retval)
    }
    hask.return(%lambda)
  }
hask.dummy_finish
}
```
- It is quite unclear to me why GHC generates the extra `hask.force` around the fibs
  when it knows perfectly well that they are strict values. It is a bit weird I feel.
- Perhaps they later use demand analysis to learn these are strict. Not sure.

# Wednesday: 16th July 2020

- Decided I couldn't use the default `opt` stuff any longer, since I now need
  fine grained control over which passes are run how.

- Stole code from toy to do the printing. Unfortunately, toy only uses
  `module->dump()`.
- What I want to do is to print the module to `stdout`. `module->print()`
  needs an `OpAsmPrinter`. Kill me.
- Let's see how `MlirOptMain` prints to the output file.

```cpp
LogicalResult mlir::MlirOptMain(raw_ostream &os,
                                std::unique_ptr<MemoryBuffer> buffer,
                                const PassPipelineCLParser &passPipeline,
                                bool splitInputFile, bool verifyDiagnostics,
                                bool verifyPasses,
                                bool allowUnregisteredDialects) {
  // The split-input-file mode is a very specific mode that slices the file
  // up into small pieces and checks each independently.
  if (splitInputFile)
    return splitAndProcessBuffer(
        std::move(buffer),
        [&](std::unique_ptr<MemoryBuffer> chunkBuffer, raw_ostream &os) {
          return processBuffer(os, std::move(chunkBuffer), verifyDiagnostics,
                               verifyPasses, allowUnregisteredDialects,
                               passPipeline);
        },
        os);

  return processBuffer(os, std::move(buffer), verifyDiagnostics, verifyPasses,
                       allowUnregisteredDialects, passPipeline);
}
```

- OK, so we need to know how `processBuffer` works:

```cpp
static LogicalResult processBuffer(raw_ostream &os,
                                   std::unique_ptr<MemoryBuffer> ownedBuffer,
                                   bool verifyDiagnostics, bool verifyPasses,
                                   bool allowUnregisteredDialects,
                                   const PassPipelineCLParser &passPipeline) {
  ...
  // If we are in verify diagnostics mode then we have a lot of work to do,
  // otherwise just perform the actions without worrying about it.
  if (!verifyDiagnostics) {
    SourceMgrDiagnosticHandler sourceMgrHandler(sourceMgr, &context);
    return performActions(os, verifyDiagnostics, verifyPasses, sourceMgr,
                          &context, passPipeline);
  }
  ...
}
```
- Recursive into `performActions`:

```cpp
static LogicalResult performActions(raw_ostream &os, bool verifyDiagnostics,
                                    bool verifyPasses, SourceMgr &sourceMgr,
                                    MLIRContext *context,
                                    const PassPipelineCLParser &passPipeline) {
  ...
  // Print the output.
  module->print(os);
  os << '\n';
  ...
}
```

- WTF, so a `raw_ostream` satisfies an `OpAsmPrinter`? no way
- OK, I found the overloads. Weird that `VSCode`'s intellisense missed these
  and pointed me to the wrong location. I should stop trusting it:

```cpp
class ModuleOp
...
public:
...
  /// Print the this module in the custom top-level form.
  void print(raw_ostream &os, OpPrintingFlags flags = llvm::None);
  void print(raw_ostream &os, AsmState &state,
             OpPrintingFlags flags = llvm::None);
...
}
```

- Cool, so I can just say `module->print(llvm::outs())` and it's going to print
  it.

- OK, I now need to figure out how to get the MLIR framework to pick up
  my `ApSSARewriter`. Jesus, getting used to MLIR is a pain. I suppose
  some of it has to do with my refusal to use TableGen. But then again, TableGen
  just makes me feel more lost, so it's not a good style.

- Doing exactly what `toy ch3` suggests does not seem to work. OK, I guess I'll
  read what `mlir::createCanonicalizerPass` does, since that's what seems
  to be responsible for adding my rewriter in the code snippet:

```cpp
  if (enableOptimization) {
    mlir::PassManager pm(&context);
    // Apply any generic pass manager command line options and run the pipeline.
    applyPassManagerCLOptions(pm);

    // Add a run of the canonicalizer to optimize the mlir module.
    pm.addNestedPass<mlir::FuncOp>(mlir::createCanonicalizerPass());
    if (mlir::failed(pm.run(*module))) {
      llvm::errs() << "Run of canonicalizer failed.\n";
      return 4;
    }
  }
```

- It's darkly funny to me that no snippet of MLIR has ever worked out of the box.
  Judging from past experience, I estimate an hour of searching and pain.

- OK, first peppered code with `assert`s to see how far it is getting:


```cpp
struct UncurryApplication : public mlir::OpRewritePattern<ApSSAOp> {
  UncurryApplication(mlir::MLIRContext *context)
      : OpRewritePattern<ApSSAOp>(context, /*benefit=*/1) {
          assert(false && "uncurry application constructed")
      }
  mlir::LogicalResult
  matchAndRewrite(ApSSAOp op,
                  mlir::PatternRewriter &rewriter) const override {
    assert(false && "UncurryApplication::matchAndRewrite called");
    return failure();
  }
};

void ApSSAOp::getCanonicalizationPatterns(OwningRewritePatternList &results,
                                          MLIRContext *context) {
  assert(false && "ApSSAOp::getCanonicalizationPatterns called");
  results.insert<UncurryApplication>(context);
}
```

- FML, literally no `assert` fails. OK, I guess I actually do need to read 
  `mlir::createCanonicalizerPass`: https://github.com/llvm/llvm-project/blob/a5b9316b24ce1de54ae3ab7a5254f0219fee12ac/mlir/lib/Transforms/Canonicalizer.cpp#L41

```cpp
namespace {
/// Canonicalize operations in nested regions.
struct Canonicalizer : public CanonicalizerBase<Canonicalizer> {
  void runOnOperation() override {
    OwningRewritePatternList patterns;

    // TODO: Instead of adding all known patterns from the whole system lazily
    // add and cache the canonicalization patterns for ops we see in practice
    // when building the worklist.  For now, we just grab everything.
    auto *context = &getContext();
    for (auto *op : context->getRegisteredOperations())
      op->getCanonicalizationPatterns(patterns, context); // <- this should be asserting!
    Operation *op = getOperation();
    applyPatternsAndFoldGreedily(op->getRegions(), patterns);
  }
};
} // end anonymous namespace
```

- OK, progress made. It's the difference between:

```cpp
// v this, as I understand it, runs only inside `mlir::FuncOp`.
pm.addNestedPass<mlir::FuncOp>(mlir::createCanonicalizerPass()); 
// v this runs on everything.
pm.addPass(mlir::createCanonicalizerPass());
```

- Of course, I need to understand this properly. So let's figure out WTF
  `addNestedPass` actually means: https://github.com/llvm/llvm-project/blob/6d15451b175293cc98ef1d0fd9869ac71904e3bd/mlir/include/mlir/Pass/PassManager.h#L77

```cpp
/// Add the given pass to a nested pass manager for the given operation kind
/// `OpT`.
template <typename OpT> void addNestedPass(std::unique_ptr<Pass> pass) {
  nest<OpT>().addPass(std::move(pass));
}
```

- What is `nest`? https://github.com/llvm/llvm-project/blob/6d15451b175293cc98ef1d0fd9869ac71904e3bd/mlir/include/mlir/Pass/PassManager.h#L65
```cpp
  /// Nest a new operation pass manager for the given operation kind under this
  /// pass manager.
  OpPassManager &nest(const OperationName &nestedName);
  OpPassManager &nest(StringRef nestedName);
  template <typename OpT> OpPassManager &nest() {
    return nest(OpT::getOperationName());
  }
```

- This file in MLIR about passes seems good: https://github.com/llvm/llvm-project/blob/master/mlir/docs/PassManagement.md

- Got nerd sniped by the devloping story of twitter being hacked: https://news.ycombinator.com/item?id=23851275#23852853.
  High profile accounts are asking folks to donate to a BTC address. Seems like a really weak use of 
  incredible amounts of power. Tinfoil hat theory: this is a demonstration.
- Twitter acknowledgement of the hack: https://twitter.com/TwitterSupport/status/1283518038445223936

- OK, I'm actually writing my pass now. Jesus, I realised that my implemtnation of `ApSSA` is really annoying and perhaps
  mildly broken.

- I allow the first parameter to be either a `Symbol` or a `Value`. Now that I need to rewrite stuff,
  how do I find out *what* the symbol is? The MLIR docs wax poetic about symbol tables:
   https://mlir.llvm.org/docs/SymbolsAndSymbolTables/#symbol-table

- I tried to give my `ModuleOp` the trait `OpTrait::SymbolTable`. All hell
  has broken loose.

- I now can't have a result from my module (makes sense). So I make it
  `OpTrait::ZeroResult` and remove the `hask.dummy_finish` thing I had
  hanging around.

- This somehow destroys the correctness of my module, with errors:

```
./fib-strict.mlir:4:18: error: block with no terminator
    %plus_hash = hask.make_data_constructor<"+#">
```

Here is my file:

```mlir
// Main
// Core2MLIR: GenMLIR BeforeCorePrep
hask.module {
    %plus_hash = hask.make_data_constructor<"+#">
    %minus_hash = hask.make_data_constructor<"-#">
...
```

- I confess, I do not know what it is talking about. What terminator? Why ought
  I terminate the block? Do I need to terminate it with an operator
  that returns zero results?. This to me seems the most reasonable explanation

- Whatever the explanation, that is an _atrocious_ place to put the error marker.
  Maybe I send a patch.

- Nice, I make progress. Now my printing of `ApSSA` is broken, my module compiles. I get the amazing backtrace:

```
(gdb) run
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: /home/bollu/work/mlir/coremlir/build/bin/hask-opt ./fib-strict.mlir
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
- parse:197attribute: "+#"
- parse:198attribute ty: none
- parse:197attribute: "-#"
- parse:198attribute ty: none
- parse:197attribute: "()"
- parse:198attribute ty: none
-parse:454:%i
parse:396
parse:398
parse:413
parse:417
parse:420
parse:423
Module (no optimization):

module {
  hask.module {
    %0 = hask.make_data_constructor<"+#">
    %1 = hask.make_data_constructor<"-#">
    %2 = hask.make_data_constructor<"()">
    hask.func @fib {
      %3 = hask.lambdaSSA(%arg0) {
        %4 = hask.caseSSA %arg0 ["default" ->  {
        ^bb0(%arg1: !hask.untyped):  // no predecessors
          %5 = hask.apSSA(%5,hask-opt: /home/bollu/work/mlir/llvm-project/mlir/lib/IR/Value.cpp:22: mlir::Value::Value(mlir::Operation*, unsigned int): Assertion `op->getNumResults() > resultNo && "invalid result number"' failed.
```

- Had to add builder for `ApSSAOp`:

```cpp
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value fn, SmallVectorImpl<Value> params);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    FlatSymbolRefAttr fn, SmallVectorImpl<Value> params);
```

- I find it interesting that the builder API is specified entirely through
  mutation of the `OperationState`. I would love to have discussions
  with the folks who designed this API to undertand their ideas for why
  they did it this way.

- The API is getting fugly, because everywhere this dichotomy between having a `Value`
  and having a `SymbolRef` keeps showing up. Is it really this complicated? Mh.

- In LLVM, a `Function` is a `GlobalObject` is a `GlobalValue` is a `Constant` is a
  `User` which is a `Value`: https://llvm.org/doxygen/classllvm_1_1Function.html
- The reason it's able to break SSA is embedded in `Verifier`:https://github.com/llvm/llvm-project/blob/master/llvm/lib/IR/Verifier.cpp
- We only check that an instruction dominates all of its uses _of other instructions_:
  https://github.com/llvm/llvm-project/blob/master/llvm/lib/IR/Verifier.cpp#L4147;
  https://github.com/llvm/llvm-project/blob/master/llvm/lib/IR/Verifier.cpp#L4292

```cpp
...
// https://github.com/llvm/llvm-project/blob/master/llvm/lib/IR/Verifier.cpp#L4147
void Verifier::verifyDominatesUse(Instruction &I, unsigned i) {
  Instruction *Op = cast<Instruction>(I.getOperand(i));
  ...
  if (!isa<PHINode>(I) && InstsInThisBlock.count(Op))
    return;
  ...
  const Use &U = I.getOperandUse(i);
  Assert(DT.dominates(Op, U),
         "Instruction does not dominate all uses!", Op, &I);
}
...
// https://github.com/llvm/llvm-project/blob/master/llvm/lib/IR/Verifier.cpp#L4292
} else if (isa<Instruction>(I.getOperand(i))) {
  verifyDominatesUse(I, i);
} 

```

- On the other hand, if the instruction has a use of a _function_, then we check
  other (unrelated) properties:

```cpp
    if (Function *F = dyn_cast<Function>(I.getOperand(i))) {
      // Check to make sure that the "address of" an intrinsic function is never
      // taken.
      Assert(!F->isIntrinsic() ||
                 (CBI && &CBI->getCalledOperandUse() == &I.getOperandUse(i)),
             "Cannot take the address of an intrinsic!", &I);
      Assert(
          !F->isIntrinsic() || isa<CallInst>(I) ||
              F->getIntrinsicID() == Intrinsic::donothing ||
              F->getIntrinsicID() == Intrinsic::coro_resume ||
              F->getIntrinsicID() == Intrinsic::coro_destroy ||
              F->getIntrinsicID() == Intrinsic::experimental_patchpoint_void ||
              F->getIntrinsicID() == Intrinsic::experimental_patchpoint_i64 ||
              F->getIntrinsicID() == Intrinsic::experimental_gc_statepoint ||
              F->getIntrinsicID() == Intrinsic::wasm_rethrow_in_catch,
          "Cannot invoke an intrinsic other than donothing, patchpoint, "
          "statepoint, coro_resume or coro_destroy",
          &I);
      Assert(F->getParent() == &M, "Referencing function in another module!",
             &I, &M, F, F->getParent());
    } else if (BasicBlock *OpBB = dyn_cast<BasicBlock>(I.getOperand(i))) {
```

- So really, LLVM had a sort of *exception* for functions. Or, rather, it's
  notion of SSA was strictly for *instructions*, not for *all Ops* 
  (Ops in the MLIR sense of the word).

- OK, our code now looks like:

```
Module (+optimization):

module {
  hask.module {
    %0 = hask.make_data_constructor<"+#">
    %1 = hask.make_data_constructor<"-#">
    %2 = hask.make_data_constructor<"()">
    hask.func @fib {
      %3 = hask.lambdaSSA(%arg0) {
        %4 = hask.caseSSA %arg0 ["default" ->  {
        ^bb0(%arg1: !hask.untyped):  // no predecessors
          %5 = hask.apSSA(%1, %arg0) // <- dead!
          %6 = hask.make_i32(1 : i64)
          %7 = hask.apSSA(%1, %arg0, %6)
          %8 = hask.apSSA(@fib, %7)
          %9 = hask.force(%8)
          %10 = hask.apSSA(@fib, %arg0)
          %11 = hask.force(%10)
          %12 = hask.apSSA(%0, %11) // <- dead!
          %13 = hask.apSSA(%0, %11, %9)
          hask.return(%13)
        }]
 [0 : i64 ->  {
        ^bb0(%arg1: !hask.untyped):  // no predecessors
          hask.return(%arg0)
        }]
 [1 : i64 ->  {
        ^bb0(%arg1: !hask.untyped):  // no predecessors
          hask.return(%arg0)
        }]

        hask.return(%4)
      }
      hask.return(%3)
    }
    hask.dummy_finish
  }
}
```
- We do fuse away the applications. But I now have dead instructions. Need
  to find the pass that eliminates dead values. Looks like CSE takes
  care of this, so I'll just run CSE and see what output I get.


- Good reference to learn how to deal with symbols, the inliner: https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/lib/Transforms/Inliner.cpp
- [InliningUtils that contains the actually useful function `inlineCall`](https://github.com/llvm/llvm-project/blob/22219cfc6a2a752c53238df4ceea342672392818/mlir/lib/Transforms/Utils/InliningUtils.cpp)
- List of passes in MLIR: https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/include/mlir/Transforms/Passes.h 

- After CSE, we get the code:

```cpp
module {
  hask.module {
    %0 = hask.make_data_constructor<"+#">
    %1 = hask.make_data_constructor<"-#">
    %2 = hask.make_data_constructor<"()">
    hask.func @fib {
      %3 = hask.lambdaSSA(%arg0) {
        %4 = hask.caseSSA %arg0 ["default" ->  {
        ^bb0(%arg1: !hask.untyped):  // no predecessors
          %5 = hask.make_i32(1 : i64)
          %6 = hask.apSSA(%1, %arg0, %5)
          %7 = hask.apSSA(@fib, %6)
          %8 = hask.force(%7)
          %9 = hask.apSSA(@fib, %arg0)
          %10 = hask.force(%9)
          %11 = hask.apSSA(%0, %10, %8)
          hask.return(%11)
        }]
 [0 : i64 ->  {
        ^bb0(%arg1: !hask.untyped):  // no predecessors
          hask.return(%arg0)
        }]
 [1 : i64 ->  {
        ^bb0(%arg1: !hask.untyped):  // no predecessors
          hask.return(%arg0)
        }]

        hask.return(%4)
      }
      hask.return(%3)
    }
    hask.dummy_finish
  }
}
```

- We now need to lower `force(apSSA(...))` and `apSSA(+#, … )`, `apSSA(-#, … )`,
  and `make_i32`. Time to learn the lowering infrastructure properly.

- Started thinking of how to lower to LLVM. There's a huge problem: I don't know the type of `fib`. Now what? `:(`.
  For now, I can of course assume that all parameters are `i32`. This is, naturally, not scalable.

# Thursday, 17th July 2020

- Of course the MLIR-LLVM dialect does not have switch case: https://reviews.llvm.org/D75433.
- I guess I should reduce my code to `scf` then? it's pretty unclear to me
  what the expectation is.
- Alternatively, I just emit a bunch of `cmp`s. This is really really annoying.
  Fuck it, SCF it is.
- First I work on lowering `hask.fib` and `hask.func` to standard, then
  I lower case to `SCF` with its if-then-else support. 
- If this mix of standard-and-SCF works, that will be great!

```cpp
/// This class provides a CRTP wrapper around a base pass class to define
/// several necessary utility methods. This should only be used for passes that
/// are not suitably represented using the declarative pass specification(i.e.
/// tablegen backend).
template <typename PassT, typename BaseT> class PassWrapper : public BaseT {
public:
  /// Support isa/dyn_cast functionality for the derived pass class.
  static bool classof(const Pass *pass) {
    return pass->getTypeID() == TypeID::get<PassT>();
  }

protected:
  PassWrapper() : BaseT(TypeID::get<PassT>()) {}

  /// Returns the derived pass name.
  StringRef getName() const override { return llvm::getTypeName<PassT>(); }

  /// A clone method to create a copy of this pass.
  std::unique_ptr<Pass> clonePass() const override {
    return std::make_unique<PassT>(*static_cast<const PassT *>(this));
  }
};
```

Why do we need a `PassWrapper`? whatever. I defined my own pass as:

```cpp
namespace {
struct LowerHaskToStandardPass
    : public PassWrapper<LowerHaskToStandardPass, OperationPass<ModuleOp>> {
  void runOnOperation();
};
} // end anonymous namespace.
void LowerHaskToStandardPass::runOnOperation() {
  this->getOperation();
  assert(false && "running lower hask pass");
}
std::unique_ptr<mlir::Pass> createLowerHaskToStandardPass() {
  return std::make_unique<LowerHaskToStandardPass>();
}
```

which of course, greets me with the delightful error:

```
Module (no optimization):hask-opt: /home/bollu/work/mlir/llvm-project/mlir/lib/Pass/Pass.cpp:275:
mlir::OpPassManager::OpPassManager(mlir::OperationName, bool):
Assertion `name.getAbstractOperation()->hasProperty( OperationProperty::IsolatedFromAbove) &&
"OpPassManager only supports operating on operations marked as " "'IsolatedFromAbove'"' failed.
Aborted (core dumped)
../build/bin/hask-opt ./fib-strict-roundtrip.mlir
Module (no optimization):

module {
}hask-opt: /home/bollu/work/mlir/llvm-project/mlir/lib/Pass/Pass.cpp:275:
mlir::OpPassManager::OpPassManager(mlir::OperationName, bool):
Assertion `name.getAbstractOperation()->hasProperty( OperationProperty::IsolatedFromAbove) &&
"OpPassManager only supports operating on operations marked as " "'IsolatedFromAbove'"' failed.
```

- Now I need to read what `IsolatedFromAbove` is. IIRC, it can't
  use values that are defined outside/ above it in terms of depth?

The MLIR docs say:
> Passes are expected to not modify operations at or above the current
> operation being processed.
> If the operation is not isolated,
> it may inadvertently
> modify the use-list of an operation it is not supposed to modify.

- Indeed, the question is precisely _what_ and _why_ am I "not supposed to modify".
- So I made the `ModuleOp` `IsolatedFromAbove`.
- I now realise that I'm confused. I need to change both my functions from `hask.func` to the regular `std.func`
  while simultaneously changing my call instructions from `apSSA` to `std.call`.
  So the IR in between will be illegal [indeed, "nonsensical"]?
  We shall see how this goes.

- OK, I see, so we are expected to replace the _root_ operation in a conversion pass. 
  So this:

```cpp
namespace {
struct LowerHaskToStandardPass
    : public PassWrapper<LowerHaskToStandardPass, OperationPass<ModuleOp>> {
  void runOnOperation();
};
} // end anonymous namespace.

void LowerHaskToStandardPass::runOnOperation() {
    ConversionTarget target(getContext());
  OwningRewritePatternList patterns;
  patterns.insert<HaskFuncOpLowering>(&getContext());
  patterns.insert<HaskApSSAOpLowering>(&getContext());

  if (failed(applyPartialConversion(this->getOperation(), target, patterns))) {
    llvm::errs() << __FUNCTION__ << ":" << __LINE__ << "\n";
    llvm::errs() << "fn\nvvvv\n";
    getOperation().dump() ;
    llvm::errs() << "\n^^^^^\n";
    signalPassFailure();
    assert(false);
  }
```
dies with:

```
Module (no optimization):Module: lowering to standard+SCF...hask-opt:
/home/bollu/work/mlir/llvm-project/mlir/lib/Transforms/DialectConversion.cpp:1504:
mlir::LogicalResult
  {anonymous}::OperationLegalizer
  ::legalizePatternResult(mlir::Operation*,
      const mlir::RewritePattern&,
      mlir::ConversionPatternRewriter&,
      {anonymous}::RewriterState&):
  Assertion `(replacedRoot || updatedRootInPlace()) &&
  "expected pattern to replace the root operation"' failed.
```

So it appears that in a `ModuleOp`, I _must_ replace a module. So I guess
the "correct" thing to do is to have _separate_ conversion passes for 
each of my `HaskFuncOpLowering`, `HaskApSSAOpLowering`? I really don't
understand what the hell the invariants

- What is the rationale of `ConversionPattern : RewritePattern`? What new
  powers does `ConversionPattern` confer on me? `:(` I am generally sad panda
  because I have no idea why I need this tower of abstraction, it's not
  well motivated.

- Ookay, so I decided to replace my module with Standard. It dies with:
```
Module (no optimization):Module: lowering to standard+SCF...
hask-opt: /home/bollu/work/mlir/llvm-project/mlir/lib/IR/PatternMatch.cpp:142:
void mlir::PatternRewriter::replaceOpWithResultsOfAnotherOp(mlir::Operation*, mlir::Operation*):
Assertion `op->getNumResults() == newOp->getNumResults() &&
"replacement op doesn't match results of original op"' failed.
```

But that's ludicrous! 

```cpp


class ModuleOp : public Op<ModuleOp, OpTrait::ZeroResult, OpTrait::OneRegion, OpTrait::SymbolTable, OpTrait::IsIsolatedFromAbove> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "hask.module"; };
  ...
};
```

```cpp
class ModuleOp
    : public Op<
          ModuleOp, OpTrait::ZeroOperands, OpTrait::ZeroResult,
          OpTrait::IsIsolatedFromAbove, OpTrait::AffineScope,
          OpTrait::SymbolTable,
          OpTrait::SingleBlockImplicitTerminator<ModuleTerminatorOp>::Impl,
          SymbolOpInterface::Trait> {
public:
  using Op::Op;
  using Op::print;
  static StringRef getOperationName() { return "module"; }
```

- Both of these have zero results! What drugs is the assert on?

- OK WTF?
- Ah I see:

```cpp
class ModuleOpLowering : public ConversionPattern {
public:
  explicit ModuleOpLowering(MLIRContext *context)
      : ConversionPattern(ApSSAOp::getOperationName(), 1, context) {}
                          // ^ I see, so I made a mistake here. 
```

- Damn, I am sleepy or something, this is quite obvious.
- OK, now my pass isn't even running:

```cpp
class ModuleOpLowering : public ConversionPattern {
public:
  explicit ModuleOpLowering(MLIRContext *context)
      : ConversionPattern(ModuleOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    llvm::errs() << "vvvvvvvvvvvvvvvvvvvvvv\nop: " << *op << "^^^^^^^^^^^^^^\n";
    rewriter.replaceOpWithNewOp<mlir::ModuleOp>(op);
    assert(false); // should crash

    return success();
  }
};
```

- So it runs, but it seems to double my module? WTF is going on:

```cpp
class ModuleOpLowering : public ConversionPattern {
public:
  explicit ModuleOpLowering(MLIRContext *context)
      : ConversionPattern(ModuleOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    rewriter.replaceOpWithNewOp<mlir::ModuleOp>(op);
    return success();
  }
};
```
```
vvvvvvvvvvvvvvvvvvvvvvvvvvvv
Module (+optimization), lowered to Standard+SCF:


module {
  module {
    hask.module {
      %0 = hask.make_data_constructor<"+#">
      %1 = hask.make_data_constructor<"-#">
      %2 = hask.make_data_constructor<"()">
      hask.func @fib {
        %3 = hask.lambdaSSA(%arg0) {
          %4 = hask.caseSSA %arg0 ["default" ->  {
          ^bb0(%arg1: !hask.untyped):  // no predecessors
            %5 = hask.make_i32(1 : i64)
            %6 = hask.apSSA(%1, %arg0, %5)
            %7 = hask.apSSA(@fib, %6)
            %8 = hask.force(%7)
            %9 = hask.apSSA(@fib, %arg0)
            %10 = hask.force(%9)
            %11 = hask.apSSA(%0, %10, %8)
            hask.return(%11)
          }]
 [0 : i64 ->  {
          ^bb0(%arg1: !hask.untyped):  // no predecessors
            hask.return(%arg0)
          }]
 [1 : i64 ->  {
          ^bb0(%arg1: !hask.untyped):  // no predecessors
            hask.return(%arg0)
          }]

          hask.return(%4)
        }
        hask.return(%3)
      }
      hask.dummy_finish
    }
  }
  module {
    hask.module {
      %0 = hask.make_data_constructor<"+#">
      %1 = hask.make_data_constructor<"-#">
      %2 = hask.make_data_constructor<"()">
      hask.func @fib {
        %3 = hask.lambdaSSA(%arg0) {
          %4 = hask.caseSSA %arg0 ["default" ->  {
          ^bb0(%arg1: !hask.untyped):  // no predecessors
            %5 = hask.make_i32(1 : i64)
            %6 = hask.apSSA(%1, %arg0, %5)
            %7 = hask.apSSA(@fib, %6)
            %8 = hask.force(%7)
            %9 = hask.apSSA(@fib, %arg0)
            %10 = hask.force(%9)
            %11 = hask.apSSA(%0, %10, %8)
            hask.return(%11)
          }]
 [0 : i64 ->  {
          ^bb0(%arg1: !hask.untyped):  // no predecessors
            hask.return(%arg0)
          }]
 [1 : i64 ->  {
          ^bb0(%arg1: !hask.untyped):  // no predecessors
            hask.return(%arg0)
          }]

          hask.return(%4)
        }
        hask.return(%3)
      }
      hask.dummy_finish
    }
  }
}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```

- I have no fucking clue WTF is happening `:(`
- Right, I built an `ApSSAOp` which I can't use because it's not `IsolatedFromAbove`. OK, I really don't understand
  the semantics of lowering.

- Read the dialect conversion document: https://mlir.llvm.org/docs/DialectConversion/

- OK, now I understand why we need `ConversionPattern`:

> When type conversion comes into play, the general Rewrite Patterns can no
> longer be used. This is due to the fact that the operands of the operation
> being matched will not correspond with the operands of the correct type as
> determined by TypeConverter. The operation rewrites on type boundaries must
> thus use a special pattern, the ConversionPattern

Also:

> If a pattern matches, it must erase or replace the op it matched on.
>  Operations can not be updated in place.
> Match criteria should not be based on the IR outside of the op itself. The
> preceding ops will already have been processed by the framework (although it
> may not update uses), and the subsequent IR will not yet be processed. This can
> create confusion if a pattern attempts to match against a sequence of ops (e.g.
> rewrite A + B -> C). That sort of rewrite should be performed in a separate
> pass.

- So it seems to me that my rewrite of `ApSSA(@plus_hash, %1, %2) -> addi %1 %2`
  should be a separate Pass? and cannot reuse the infrastructure?


- To convert the types of block arguments within a Region, a custom hook 
  on the `ConversionPatternRewriter` must be invoked; `convertRegionTypes`

- I guess I should be using the more general `PatternRewriter` and `applyPatternsAndFoldGreedily`?
  Or can I not, because I need a `ConversionPattern`? Argh, this is so poorly
  documented.

-`VectorToSCF.cpp`: https://github.com/llvm/llvm-project/blob/master/mlir/lib/Conversion/VectorToSCF/VectorToSCF.cpp
- `VectorToSCF.h`: https://github.com/llvm/llvm-project/blob/master/mlir/lib/Conversion/VectorToSCF/VectorToSCF.cpp

# Tuesday, 18th August 2020

- Lowering our IR down to LLVM. Currently hacking the shit out of it,
  assuming all our types are int, etc. We then fix it gradually as we
  get more online, as per our iteration strategy.
- Currently, I'm getting annoyed at the non-existence of a `RegionTrait`
  called `SingleBlockExplicitTerminator`: this is precisely what my `func` is:
  it should just create a `lambda` and then return the `lambda`. Hm, perhaps
  I should put this information in an attribute. Not sure. Oh well.
- What is going on with `LLVMTypeConverter`? Why does it exist?
- For whatever reason, any IR I generate from the legalization pass
  mysteriously vanishes after being generated. I presume I'm being really
  stupid and missing something extremely obvious. 
- Got annoyed at the MLIR documentation, so spent some time messing with doxygen
  to get both (1) very detailed doxygen pages, and also (2) man pages. Hopefully
  this helps me search for things faster when it comes to the sprawling MLIR
  sources.
- There are lots of design concerns that I'm basically giving up on for the
  first iteration. Non-exhaustive list: (1) we need to at least know the types
  of functions when we lower to MLIR, to the granularity of int-value-or-boxed-value.
  I currently assume everything is `int`. (2) We need to go through the usual
  pain in converting from the nice lazy representation to the `void*` mess that
  is representing closures inside LLVM. This too needs to know types to know
  how much space to allocate. Completely ignore these issues as well.

# Thursday, 20th August 2020
- Yay, more kludge to get MLIR to behave how I want:

```cpp
llvm::errs() << "debugging? " << ::llvm::DebugFlag << "\n";
LLVM_DEBUG({ assert(false && "llvm debug exists"); });
::llvm::DebugFlag = true; 
```

- I **manually** turn on debugging. This is, of course, horrible. On the other
  hand, I'm really not sure what the best practice is. When it came to developing
  with LLVM, since we would always run with `opt`, things "just worked". This
  time around, I'm not sure how we are expected to allow the `llvm::CommandLine`
  machinery to kick in, without explicitly invoking said machinery.

- In my `hask-opt.cpp` file, I used to use:

```cpp
  if (failed(MlirOptMain(output->os(), std::move(file), passPipeline,
                         splitInputFile, verifyDiagnostics, verifyPasses,
                         allowUnregisteredDialects))) {
    return 1;
  }
```

But I then saw that the toy tutorials themselves don't do this. They use:

```cpp
mlir::registerAsmPrinterCLOptions();
mlir::registerMLIRContextCLOptions();
mlir::registerPassManagerCLOptions();

cl::ParseCommandLineOptions(argc, argv, "toy compiler\n");
```

So I presume that this `ParseCommandLineOptions` is going to launch the LLVM
machinery.

- Anyway, here's what the debug info of the legalizer spits out:

```cpp
    ** Erase   : 'hask.func'(0x560b1f99f5d0)

    //===-------------------------------------------===//
    Legalizing operation : 'func'(0x560b1f99f640) {
      * Fold {
      } -> FAILURE : unable to fold
    } -> FAILURE : no matched legalization pattern
    //===-------------------------------------------===//
  } -> FAILURE : operation 'func'(0x0000560B1F99F640) became illegal after block action
} -> FAILURE : no matched legalization pattern
//===-------------------------------------------===//
```

- I don't understand 'became illegal after block action'. Time to read the
  sources.

- OK, so we can do the simplest thing known to man: delete the entire `hask.func`

```
// Input
// Debugging file: Can do anything here.
hask.module {
    %plus_hash = hask.make_data_constructor<"+#">
    %minus_hash = hask.make_data_constructor<"-#">
    %unit_tuple = hask.make_data_constructor<"()">
  hask.func @fib {
    %lambda = hask.lambdaSSA(%i) {
      hask.return(%unit_tuple)
    }
    hask.return(%lambda)
  }
  hask.dummy_finish
}
```

```
// Output
module {
  hask.module {
    %0 = hask.make_data_constructor<"+#">
    %1 = hask.make_data_constructor<"-#">
    %2 = hask.make_data_constructor<"()">
    hask.dummy_finish
  }
}
```


- So to generate a `FuncOp`, I apparently need to **explicitly call**
  `target.addLegalOp<FuncOp>()`, even though I have a
  `target.addLegalDialect<mlir::StandardOpsDialect>()`.

```cpp
target.addLegalDialect<mlir::StandardOpsDialect>();
// Why do I need this? Isn't adding StandardOpsDialect enough?
target.addLegalOp<FuncOp>(); <- WHY?
```

- I really don't understand what's happening `:(`. I want to understand why
  `FuncOp` is not considered legal-by-default on marking `std` legal. Either
  (i) `FuncOp` does not, in fact, belong to `std`, or (ii) there is some
  kind of precedence in the way in which the `addLegal*` rules kick in, where
  somehow `FuncOp` is becoming illegal? I don't even know.

- Anyway, we can now lower the `play.mlir` file from an empty `hask.func`
  to an empty `func`:

##### input
```
// INPUT
hask.module {
    %plus_hash = hask.make_data_constructor<"+#">
    %minus_hash = hask.make_data_constructor<"-#">
    %unit_tuple = hask.make_data_constructor<"()">
  hask.func @fib {
    %lambda = hask.lambdaSSA(%i) {
      hask.return(%unit_tuple)
    }
    hask.return(%lambda)
  }
  hask.dummy_finish
}
```
##### lowered

```
// LOWERED
module {
  hask.module {
    %0 = hask.make_data_constructor<"+#">
    %1 = hask.make_data_constructor<"-#">
    %2 = hask.make_data_constructor<"()">
    func @fib_lowered()
    hask.dummy_finish
  }
}
```

- `LinalgToStandard` creates new functions with `FuncOp`: 
```cpp
//LinalgToStandard.cpp
// Get a SymbolRefAttr containing the library function name for the LinalgOp.
// If the library function does not exist, insert a declaration.
template <typename LinalgOp>
static FlatSymbolRefAttr getLibraryCallSymbolRef(Operation *op,
                                                 PatternRewriter &rewriter) {
  auto linalgOp = cast<LinalgOp>(op);
  auto fnName = linalgOp.getLibraryCallName();
  if (fnName.empty()) {
    op->emitWarning("No library call defined for: ") << *op;
    return {};
  }

  // fnName is a dynamic std::string, unique it via a SymbolRefAttr.
  FlatSymbolRefAttr fnNameAttr = rewriter.getSymbolRefAttr(fnName);
  auto module = op->getParentOfType<ModuleOp>();
  if (module.lookupSymbol(fnName)) {
    return fnNameAttr;
  }

  SmallVector<Type, 4> inputTypes(extractOperandTypes<LinalgOp>(op));
  assert(op->getNumResults() == 0 &&
         "Library call for linalg operation can be generated only for ops that "
         "have void return types");
  auto libFnType = FunctionType::get(inputTypes, {}, rewriter.getContext());

  OpBuilder::InsertionGuard guard(rewriter);
  // Insert before module terminator.
  rewriter.setInsertionPoint(module.getBody(),
                             std::prev(module.getBody()->end()));
  FuncOp funcOp =
      rewriter.create<FuncOp>(op->getLoc(), fnNameAttr.getValue(), libFnType,
                              ArrayRef<NamedAttribute>{});
  // Insert a function attribute that will trigger the emission of the
  // corresponding `_mlir_ciface_xxx` interface so that external libraries see
  // a normalized ABI. This interface is added during std to llvm conversion.
  funcOp.setAttr("llvm.emit_c_interface", UnitAttr::get(op->getContext()));
  return fnNameAttr;
}
...
void ConvertLinalgToStandardPass::runOnOperation() {
   auto module = getOperation();
   ConversionTarget target(getContext());
   target.addLegalDialect<AffineDialect, scf::SCFDialect, StandardOpsDialect>();
   target.addLegalOp<ModuleOp, FuncOp, ModuleTerminatorOp, ReturnOp>();
   ...
```

- They too add `FuncOp` as legal manually. Man I wish I understood this.
  What dialect does `FuncOp, ModuleOp`, etc belong to?


- OK, we can now lower a dummy `hask.func` into a dummy `FuncOp`:

##### input

```cpp
// INPUT
hask.module {
  // vvvv unusedvvv
  %unit_tuple = hask.make_data_constructor<"()">
  hask.func @fib {
    %lambda = hask.lambdaSSA(%i) {
      %foo = hask.make_data_constructor<"foo">
      hask.return(%foo)
    }
    hask.return(%lambda)
  }
  hask.dummy_finish
}
```

##### lowered
```cpp
 // LOWERED
 module {
  hask.module {
    %0 = hask.make_data_constructor<"+#">
    %1 = hask.make_data_constructor<"-#">
    %2 = hask.make_data_constructor<"()">
    func @fib_lowered(%arg0: !hask.untyped) {
      %3 = hask.make_data_constructor<"foo">
      hask.return(%3)
    }
    hask.dummy_finish
  }
}
```

- What I am actually interested is to have our function return a `%unit_tuple`,
  but that does not seem to be allowed because `FuncOp` has a `IsolatedFromAbove`
  trait. This is very strange: how do I use global data?

- I think I should be using a symbol, so my signature should read something
  like `hask.make_data_constructor @"+#"` or something like that to mark
  the data constructor as a global piece of information. Let me try and check
  that a `Symbol` is what I need.


- Fun fact: LLVM out-of-memorys if you hand it an uninitialized OperandType.

```cpp
OpAsmParser::OperandType scrutinee;
if(parser.resolveOperand(scrutinee, 
    parser.getBuilder().getType<UntypedType>(), 
    results)) { return failure(); } // BOOM! out of memory
```

- OK, we can now lower references to `make_data_constructor`:

##### input
```
hask.module {
    hask.make_data_constructor @"+#"
    hask.make_data_constructor @"-#"
    hask.make_data_constructor @"()"

  hask.func @fib {
    %lambda = hask.lambdaSSA(%i) {
      // %foo_ref = constant @XXXX : () -> ()
      %f = hask.ref(@"+#")
      hask.return(%f)
    }
    hask.return(%lambda)
  }
  hask.dummy_finish
}
```

##### output

```
module {
  hask.module {
    hask.make_data_constructor +#
    hask.make_data_constructor -#
    hask.make_data_constructor ()
    vvv is a std func with a real argument.
    func @fib_lowered(%arg0: !hask.untyped) {
      %0 = hask.ref (@"+#")
      hask.return(%0)
    }
    hask.dummy_finish
  }
}                                                                                                                                      
```

- This `Symbol` thing is prone to breakage, I feel. For example, consider:

```
hask.func @fib {
  %lambda = hask.lambdaSSA(%i) {
      ...
      %fib_i = hask.apSSA(@fib, %i)
      ...
  }
}
```

- Upon lowering, if I generate a function called `@fib_lowered`, the code 
  [which passes verification] becomes:

```
func @fib_lowered(%arg0: !hask.untyped) {
      ...
      %fib_i = hask.apSSA(@fib, %i) <- still called fib!
      ...
  }
}
```

- The thing really, truly is a god damm symbol table, with a danging symbol
  of `@fib`. Is there some way to verify that we do not have a dangling `Symbol`
  in a module?

# Friday, 21 August 2020

- `ConversionPatternRewriter::mergeBlocks` is not defined in my copy of MLIR.
  Time to pull and waste a whole bunch of time in building `:(`
  my MLIR commit is [`7ddee0922fc2b8629fa12392e61801a8ad96b7af`](https://github.com/llvm/llvm-project/commit/7ddee0922fc2b8629fa12392e61801a8ad96b7af)
  `Tue Jun 23 16:07:44 2020 +0300`, with message `[NFCI][CostModel] Add const to Value*`
- I'm going to get the stuff other than `case` working before I pull and
  waste an hour or two compiling MLIR.

- Great, the type related things changed. Before, one created an non-parametric
  type using

```cpp
namespace HaskTypes {
  enum Types {
    // TODO: I don't really understand how this works. In that,
    //       what if someone else has another 
    Untyped = mlir::Type::FIRST_PRIVATE_EXPERIMENTAL_0_TYPE,
  };
};

class UntypedType : public mlir::Type::TypeBase<UntypedType, mlir::Type,
                                               TypeStorage> {
public:
  /// Inherit some necessary constructors from 'TypeBase'.
  using Base::Base;

  /// This static method is used to support type inquiry through isa, cast,
  /// and dyn_cast.
  static bool kindof(unsigned kind) { return kind == HaskTypes::Untyped; }
  static UntypedType get(MLIRContext *context) { return Base::get(context, HaskTypes::Types::Untyped); } 
};
```

- Now, I have no idea, this seems to not be the solution anymore :(

- It seems that in `Toy`, the stopped using the tablegen'd version of the
  dialect: [they define the dialect in C++](https://github.com/llvm/llvm-project/blob/e1cd7cac8a36608616d515b64d12f2e86643970d/mlir/examples/toy/Ch7/include/toy/Dialect.h#L54).
  I switched to doing this as well --- I prefer the C++ version at any rate.

- Making progress with  my pile-of-hacks. I replace the `case` with the
  body of the default, and I get this:

```
./playground.mlir:14:28: error: 'std.call' op 'fib' does not reference a valid function
        %fib_i_minus_one = hask.apSSA(@fib, %i_minus_one)
                           ^
./playground.mlir:14:28: note: see current operation: %1 = "std.call"(%0) {callee = @fib} : (i32) -> i32
===Lowering failed.===
===Incorrectly lowered Module to Standard+SCF:===


module {
  hask.module {
    hask.make_data_constructor @"+#"
    hask.make_data_constructor @"-#"
    hask.make_data_constructor @"()"
    func @fib_lowered(%arg0: i32) {
      %c1_i32 = constant 1 : i32
      %0 = subi %arg0, %c1_i32 : i32
      %1 = call @fib(%0) : (i32) -> i32
      %2 = call @fib(%arg0) : (i32) -> i32
      %3 = addi %2, %1 : i32
      return %3 : i32
    }
    hask.dummy_finish
  }
}
```

- I am not sure why `fib` does not reference a valid function! What on earth
  is it talking about?

```cpp
static LogicalResult verify(CallOp op) {
  // Check that the callee attribute was specified.
  auto fnAttr = op.getAttrOfType<FlatSymbolRefAttr>("callee");
  if (!fnAttr)
    return op.emitOpError("requires a 'callee' symbol reference attribute");
  auto fn =
      op.getParentOfType<ModuleOp>().lookupSymbol<FuncOp>(fnAttr.getValue());
  if (!fn)
    return op.emitOpError() << "'" << fnAttr.getValue()
                            << "' does not reference a valid function";
```

- So I think the problem is that it doesn't have a `parentOfType<ModuleOp>`?


- I now generate this:

```cpp
module {
  module {
    hask.make_data_constructor @"+#"
    hask.make_data_constructor @"-#"
    hask.make_data_constructor @"()"
    func @fib(%arg0: i32) -> i32 {
      %c0_i32 = constant 0 : i32
      %0 = cmpi "eq", %c0_i32, %arg0 : i32
      scf.if %0 {
      ^bb1(%6: !hask.untyped):  // no predecessors
        return %arg0 : i32
      }
      %c1_i32 = constant 1 : i32
      %1 = cmpi "eq", %c1_i32, %arg0 : i32
      scf.if %1 {
      ^bb1(%6: !hask.untyped):  // no predecessors
        return %arg0 : i32
      }
      %c1_i32_0 = constant 1 : i32
      %2 = subi %arg0, %c1_i32_0 : i32
      %3 = call @fib(%2) : (i32) -> i32
      %4 = call @fib(%arg0) : (i32) -> i32
      %5 = addi %4, %3 : i32
      return %5 : i32
    }
  }
}
```

which fails legalization with:

> ./playground.mlir:9:17: error: 'scf.if' op expects region #0 to have 0 or 1 blocks

Not sure which region is `region #0`. Need to read the code where the
error comes from.


- The MLIR API sucks with 32 bit numbers `:(` The problem is that `IntegerAttr`
  is parsed as 64-bit by default. So to get to 32 bit values, one needs
  to juggle a decent amount. By switching to 64-bit as the
  default, I got quite a bit of code cleanup:

```patch
-            IntegerAttr lhsVal = caseop.getAltLHS(i).cast<IntegerAttr>();
-            mlir::IntegerAttr lhsI32 =
-                mlir::IntegerAttr::get(rewriter.getI32Type(),lhsVal.getInt());
             mlir::ConstantOp lhsConstant =
-                rewriter.create<mlir::ConstantOp>(rewriter.getUnknownLoc(), lhsI32);
-
-            llvm::errs() << "- lhs constant: " << lhsConstant << "\n";
+                rewriter.create<mlir::ConstantOp>(rewriter.getUnknownLoc(),
+                                                  caseop.getAltLHS(i));
```

# Monday, 24 August 2020
- See under "Newest to Oldest". I changed the organization strategy to keep the 
  newest log at the top.


# Command to generate cute git log

```
git log --pretty='%C(yellow)%h %C(cyan)%ad %Cgreen%an%C(cyan)%d %Creset%s' --date=relative --date-order --graph --shortstat
