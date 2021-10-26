library(tibble)
library(pillar)
library(stringr)
library(purrr)

setwd("/home/bollu/work/lz/test/lambdapure/compile/bench/")
LEAN_PATH="/home/bollu/work/lean4/build/release/stage1/bin/lean"
LEANC_PATH="/home/bollu/work/lean4/build/release/stage1/bin/leanc"
NRUNS=1

G_FPATHS = tribble(
   ~file.path, ~problem.size,
   "binarytrees-int.lean", 20,
   "const_fold.lean", 9
)


# G_FPATHS.append(("binarytrees-int.lean", 20))
# G_FPATHS.append(("binarytrees.lean", 20))
# G_FPATHS.append(("const_fold.lean", 9)) # 10 miscompiles!
# G_FPATHS.append(("deriv.lean", 4))
# G_FPATHS.append(("filter.lean", 50000))
# G_FPATHS.append(("rbmap_checkpoint.lean", 400000))
# G_FPATHS.append(("unionfind.lean", 100000))
# G_NFILES = len(G_FPATHS)

read.str <- function(file.path) {
  f <- file(file.path, open ="rb");
  out <- readChar(f, file.info(file.path)$size);
  close(f)
  return(out)
}

do.bench.file <- function(file.path, problem.size) {
  system("rm exe-mlir.out || true")
  system("rm exe.ll || true")
  system("rm exe-linked.ll || true")
  system("rm exe.o || true")

  system(str_glue("{LEAN_PATH} {fpath} -c exe-ref.c"))
  system(str_glue("{LEANC_PATH} exe-ref.c -O3 -o exe-ref.out"))
 
  for (i in 1:NRUNS) {
    stdout <- tempfile("perf-out")
    stderr <- tempfile("perf-err")
    out = system2(str_glue("perf stat ./exe-mlir.out {problem_size}"), stdout=stdout, stderr=stderr);
  }


  system(str_glue("{LEAN_PATH} {file.path} -m exe.mlir"))
  system("hask-opt exe.mlir --convert-scf-to-std --lean-lower-rgn --convert-rgn-to-std --convert-std-to-llvm --ptr-lower | \
                  mlir-translate --mlir-to-llvmir -o exe.ll")
  # TODO: link in lean-shell.ll
  system(str_glue("llvm-link ", 
                    "exe.ll ", 
                    "/home/bollu/work/lz/lean-linking-incantations/lib-includes/library.ll ", 
                    "/home/bollu/work/lz/lean-linking-incantations/lean-shell.ll ",
                    # TODO: remake `runtime.ll`, this time with LEAN_MULTI_THREAD.
                    "/home/bollu/work/lz/lean-linking-incantations/lib-runtime/runtime.ll ",
                    "| opt -passes=bitcast-call-converter  | opt --always-inline -O3 -S -o exe-linked.ll"))
  # system("sed -i s/musttail/tail/g exe-linked.ll")
  system("opt -O3 -S exe-linked.ll -o exe-linked-o3.ll")
  system("opt -O3 -S exe-linked-o3.ll -o exe-linked-o3-2.ll")
  system("mv exe-linked-o3-2.ll exe-linked.ll")
  # print("@@@ HACK: converting muttail to tail because of llc miscompile@@@")
  system("sed -i s/musttail/tail/g exe-linked.ll")
  system("llc -O3 --relocation-model=static  -march=x86-64 -filetype=obj exe-linked.ll -o exe.o")
  # TODO: create these libraries by hand.
  system(str_glue("c++ -O3 -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/release/stage1/include ",
                    " exe.o ",
                    " -no-pie ", 
                    # TODO: find out which of these are necessary!
                    " -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group ",
                    " -L/home/bollu/work/lean4/build/release/stage1/lib/lean -lgmp -ldl -pthread ",
                    " -Wno-unused-command-line-argument -o exe-mlir.out"))

  for (i in 1:NRUNS) {
    stdout <- tempfile("mlir-perf-out")
    stderr <- tempfile("mlir-perf-err")
    out = system2(str_glue("perf stat ./exe-mlir.out {problem_size}"));
  }
}
# datum["ours-out"] = []
# datum["ours-perf"] = []
# for _ in range(ARGS.nruns):
#  out, perf = sh(f"perf stat ./exe-mlir.out {problem_size}")
#datum["ours-out"].append(out)
#datum["ours-perf"].append(perf)
