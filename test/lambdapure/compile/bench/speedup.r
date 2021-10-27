#!/usr/bin/env Rscript
# https://hal.inria.fr/hal-00764454/document
# The Speedup-Test: A Statistical Methodology for
# Program Speedup Analysis and Computation
library(tibble)
library(stringr)
library(readr)
library(dplyr)
library(purrr)
library(argparser)
library(ggplot2)
library(cli) # http://blog.sellorm.com/2018/01/02/command-line-utilities-in-r-pt-7/
# library(magrittr)https://r4ds.had.co.nz/pipes.html. is imported by default.
# https://moderndive.com/9-hypothesis-testing.html#understanding-ht
library(infer) # https://www.tidymodels.org/learn/statistics/infer/
setwd("/home/bollu/work/lz/test/lambdapure/compile/bench/")
LEAN_PATH = "/home/bollu/work/lean4/build/release/stage1/bin/lean"
LEANC_PATH = "/home/bollu/work/lean4/build/release/stage1/bin/leanc"
NRUNS = 5

options(show.error.locations = TRUE)


G_FPATHS = tribble(
   ~file.path, ~problem.size,
   "binarytrees-int.lean", 20,
   # "binarytrees.lean", 20
   "const_fold.lean", 9,
   # "deriv.lean", 4,
   "filter.lean", 50000,
   # "rbmap_checkpoint.lean", 400000,
   # "unionfind.lean", 100000
)


# levels for runner factors - theirs v/s ours
RUNNER.LEVELS <- c("theirs", "ours")

# G_FPATHS.append(("binarytrees-int.lean", 20))
# G_FPATHS.append(("binarytrees.lean", 20))
# G_FPATHS.append(("const_fold.lean", 9)) # 10 miscompiles!
# G_FPATHS.append(("deriv.lean", 4))
# G_FPATHS.append(("filter.lean", 50000))
# G_FPATHS.append(("rbmap_checkpoint.lean", 400000))
# G_FPATHS.append(("unionfind.lean", 100000))
# G_NFILES = len(G_FPATHS)

#   df <- tribble(~path, ~runix, ~runner, ~stdout, ~stderr)
do.bench.file <- function(df, file.path, problem.size) {
  system("rm exe-mlir.out || true")
  system("rm exe.ll || true")
  system("rm exe-linked.ll || true")
  system("rm exe.o || true")

  system(str_glue("{LEAN_PATH} {file.path} -c exe-ref.c"))
  system(str_glue("{LEANC_PATH} exe-ref.c -O3 -o exe-ref.out"))
  # TODO: Write wrapper around system2 that logs the command to be run.
  for (i in 1:NRUNS) {
    stdout.path <- tempfile("perf-out")
    stderr.path <- tempfile("perf-err")
    out = system2("perf", str_glue("stat ./exe-ref.out ", problem.size),
                  stdout=stdout.path,
                  stderr=stderr.path);
    df <- df %>% add_row(path=file.path,
                   runner=factor("theirs", levels=RUNNER.LEVELS),
                   stdout=readr::read_file(stdout.path),
                   stderr=readr::read_file(stderr.path),
                   runix=i)
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
    stdout.path <- tempfile("mlir-perf-out")
    stderr.path <- tempfile("mlir-perf-err")
    system2("perf", str_glue("stat ./exe-mlir.out ", problem.size),
                  stdout=stdout.path,
                  stderr=stderr.path);

    df <- df %>% add_row(path=file.path,
                   runner=factor("ours", levels=RUNNER.LEVELS),
                   stdout=readr::read_file(stdout.path),
                   stderr=readr::read_file(stderr.path),
                   runix=i)
  }
  return(df)
}


PARSER <- arg_parser("Gather speedup data and plot")
PARSER <- add_argument(PARSER, "--data", help="generate data", flag=TRUE)
PARSER <- add_argument(PARSER, "--plot", help="plot values", flag=TRUE)
PARSER <- add_argument(PARSER, "--nruns", help="num runs", default=1)
ARGV <- parse_args(PARSER)
NRUNS <- ARGV$nruns

parse.perf <- function(stderr) {
    # return(str_length(str_squish(stderr)))
    # 0 ['',
    # 1 " Performance counter stats for './exe-mlir.out':",
    # 2 '',
    # 3 '             10.35 msec task-clock:u              #    0.931 CPUs utilized          ',
    # 4 '                 0      context-switches:u        #    0.000 K/sec                  ',
    # 5 '                 0      cpu-migrations:u          #    0.000 K/sec                  ',
    # 6 '             1,236      page-faults:u             #    0.119 M/sec                  ',
    # 7 '         76,05,059      cycles:u                  #    0.735 GHz                    ',
    # 8 '       1,04,08,658      instructions:u            #    1.37  insn per cycle         ',
    # 9 '         19,34,949      branches:u                #  186.950 M/sec                  ',
    # 10 '            31,181      branch-misses:u           #    1.61% of all branches        ',
    # 11 '',
    # 12 '       0.011116120 seconds time elapsed',
    #   '',
    #   '       0.002787000 seconds user',
    #   '       0.008270000 seconds sys',
    #   '',
    #   '']
    # 1,559.42 msec
    # elapsed <- str_split(str_squish(str_split(stderr, "\n", simplify=TRUE)[1, 13]), " ", simplify=TRUE)[1]
    # return(str_split(stderr, "\n", simplify=TRUE)[1, 2])
    # TODO: why does .* start from the newline?
    elapsed <- str_split(str_squish(str_extract(stderr, ".*seconds time elapsed")), " ", simplify=TRUE)[1]
    return(readr::parse_number(elapsed))

}

if (isTRUE(ARGV$data)) {
  df <- tribble(~path, ~runix, ~runner, ~stdout, ~stderr)
  for (i in 1:nrow(G_FPATHS)) {
    df <- do.bench.file(df, G_FPATHS$file.path[i], G_FPATHS$problem.size[i])
  }
  print("data: ")
  print(df)
  save(df, file="speedup.Rdata")
}

if (isTRUE(ARGV$plot)) {
  print("plotting..")
  load(file="speedup.Rdata")
   # loaded df. now plot from df.
  print(df)
  # need to fix column with perf stat into runtime
  # df <- df %>% mutate(time = stderr %>% unlist %>% map(parse.perf))
  # TODO: why do I need two unlists?
  df["time"] <- df["stderr"] %>% unlist %>% map(parse.perf) %>% unlist
  # after parsing time
  print(df)
  # Page 24: Data Visualization with ggplot2.
  plot <- ggplot(data = df) + geom_bar(mapping = aes(x = path, y = time), stat="identity")

  pdf("speedup.pdf")
  print(plot)
  dev.off()

}

if (!isTRUE(ARGV$data) && !isTRUE(ARGV$plot)) {
  print("ERROR: expected --data or --plot")
}
