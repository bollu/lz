#!/usr/bin/env python3

import argparse
import glob
import os
import json
import sys
import os
import subprocess
import os.path
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import json
import sys
import subprocess
import numpy as np
import time
from scipy.stats import mstats


PARSER = argparse.ArgumentParser(description='Speedup b/w MLIR and LEAN')
PARSER.add_argument("--data", help="regenerate plotting data", action="store_true")
PARSER.add_argument("--plot", help="make the plot", action="store_true")
PARSER.add_argument('--out', metavar='o', type=str,
                    help='path to dump output', default=os.path.basename(__file__).replace(".py", ".json"))
PARSER.add_argument('--nruns', type=int,
                    help='number of runs to average', default=10)
ARGS = PARSER.parse_args()

G_BASELINE = "../baseline-lean.sh"
G_OURS = "../run-lean.sh"
G_FPATHS = []
# G_FPATHS.append("binarytrees-int.lean")
# G_FPATHS.append("binarytrees.lean")
# G_FPATHS.append("const_fold.lean")
# G_FPATHS.append("deriv.lean")
# G_FPATHS.append("filter.lean")
# G_FPATHS.append("qsort.lean") # miscompile because of jmp!
# G_FPATHS.append("rbmap_checkpoint.lean")
G_FPATHS.append("unionfind.lean")
G_NFILES = len(G_FPATHS)


# Color palette
light_gray = "#cacaca"
dark_gray = "#827b7b"
light_blue = "#a6cee3"
dark_blue = "#1f78b4"
light_green = "#b2df8a"
dark_green = "#33a02c"
light_red = "#fb9a99"
dark_red = "#e31a1c"


def log(*ARGS, **kwargs):
    print(*ARGS, file=sys.stderr, **kwargs)

def os_system_synch(path):
    return subprocess.check_output(path, shell=True)

def sh(path):
    proc = subprocess.Popen(path, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    output = proc.stdout.read()
    err = proc.stderr.read()
    return (output.decode(), err.decode())

def ns_to_milli(ns):
    return ns / 1e6

# def run_data():
#     ds = []
#     for (i, fpath) in enumerate(G_FPATHS):
#         datum = {"file": str(fpath) }
#         LEAN_OPTIMIZED_PATH="/code/lean4-baseline/build/release/stage1/bin/lean"
#         LEANC_OPTIMIZED_PATH="/code/lean4-baseline/build/release/stage1/bin/leanc"
#         os_system_synch(f"rm exe-ref.out || true")
#         os_system_synch(f"{LEAN_OPTIMIZED_PATH} {fpath} -c exe-ref.c")
#         os_system_synch(f"{LEANC_OPTIMIZED_PATH} exe-ref.c -O3 -o exe-ref.out")
#         # x = run_with_output("perf stat ./exe-ref.out 1>/dev/null")
#         # proc = subprocess.Popen("perf stat ./exe-ref.out", shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
#         datum["theirs-out"] = []
#         datum["theirs-perf"] = []
#         for _ in range(ARGS.nruns):
#           timeStarted = time.time_ns()
#           out, perf = sh("./exe-ref.out")
#           datum["theirs-out"].append(out)
#           timeDelta = ns_to_milli(time.time_ns() - timeStarted)
#           datum["theirs-perf"].append(timeDelta)
# 
#         os_system_synch(f"rm exe-mlir.out || true")
#         os_system_synch(f"rm exe.ll  || true")
#         os_system_synch(f"rm exe-linked.ll  || true")
#         os_system_synch(f"rm exe.o  || true")
#         LEAN_NOOPTIMIZE_PATH="/code/lean4/build/release/stage1/bin/lean"
#         os_system_synch(f"{LEAN_NOOPTIMIZE_PATH} {fpath} -m exe.mlir")
#         os_system_synch("hask-opt exe.mlir --convert-scf-to-std --lean-lower-rgn --convert-rgn-to-std --convert-std-to-llvm --ptr-lower | \
#                 mlir-translate --mlir-to-llvmir -o exe.ll")
#         os_system_synch("llvm-link " + 
#                   "exe.ll " + 
#                   "/code/lz/lean-linking-incantations/lib-includes/library.ll " + 
#                   "/code/lz/lean-linking-incantations/lib-runtime/runtime.ll " +
#                   "| opt -passes=bitcast-call-converter  | opt --always-inline -O3 -S -o exe-linked.ll")
#         os_system_synch("sed -i s/musttail/tail/g exe-linked.ll")
#         os_system_synch("opt -O3 exe-linked.ll -o exe-linked-o3.ll")
#         os_system_synch("mv exe-linked-o3.ll exe-linked.ll")
#         print("@@@ HACK: converting muttail to tail because of llc miscompile@@@")
#         os_system_synch("sed -i s/musttail/tail/g exe-linked.ll")
#         os_system_synch("llc -O3 -march=x86-64 -filetype=obj exe-linked.ll -o exe.o")
#         os_system_synch(f"clang++-12 -lstdc++ -O3 -D LEAN_MULTI_THREAD -I/code/lean4/build/release/stage1/include \
#             exe.o \
#             /code/lz/lean-linking-incantations/lean-shell.o \
#             -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
#             -L/code/lean4/build/release/stage1/lib/lean -lgmp -ldl -pthread \
#             -Wno-unused-command-line-argument -o exe-mlir.out")
#         datum["ours-out"] = []
#         datum["ours-perf"] = []
#         for _ in range(ARGS.nruns):
#            timeStarted = time.time_ns()
#            out, perf = sh("perf stat ./exe-mlir.out")
#            timeDelta = ns_to_milli(time.time_ns() - timeStarted)
#            datum["ours-out"].append(out)
#            datum["ours-perf"].append(timeDelta)
# 
#         ds.append(datum)
#     with open(ARGS.out, "w") as f:
#         json.dump(ds, f, indent=2)
#     return ds

def run_data():
    ds = []
    for (i, fpath) in enumerate(G_FPATHS):
        # with simpcase: 850fd84e43407ed647837652b6442e143199abb0
        datum = {"file": str(fpath) }
        LEAN_ENABLE_SIMPCASE_PATH="/code/lean4/build/release/stage1/bin/lean"
        os_system_synch(f"rm exe-mlir.out || true")
        os_system_synch(f"rm exe.ll || true")
        os_system_synch(f"rm exe-linked.ll || true")
        os_system_synch(f"rm exe.o || true")
        os_system_synch(f"{LEAN_ENABLE_SIMPCASE_PATH} {fpath} -m exe.mlir")
        os_system_synch(f"rm exe.mlir || true")
        os_system_synch("hask-opt exe.mlir --convert-scf-to-std --lean-lower-rgn --convert-rgn-to-std --convert-std-to-llvm --ptr-lower | \
                mlir-translate --mlir-to-llvmir -o exe.ll")
        os_system_synch("llvm-link " + 
                  "exe.ll " + 
                  "/code/lz/lean-linking-incantations/lib-includes/library.ll " + 
                  "/code/lz/lean-linking-incantations/lib-runtime/runtime.ll " +
                  "| opt -passes=bitcast-call-converter  | opt --always-inline -O3 -S -o exe-linked.ll")
        os_system_synch("sed -i s/musttail/tail/g exe-linked.ll")
        os_system_synch("opt -O3 exe-linked.ll -o exe-linked-o3.ll")
        os_system_synch("mv exe-linked-o3.ll exe-linked.ll")
        print("@@@ HACK: converting muttail to tail because of llc miscompile@@@")
        os_system_synch("sed -i s/musttail/tail/g exe-linked.ll")
        os_system_synch("llc -O3 -march=x86-64 -filetype=obj exe-linked.ll -o exe.o")
        os_system_synch(f"clang++-12  -lstdc++ -O3 -D LEAN_MULTI_THREAD -I/code/lean4/build/release/stage1/include \
            exe.o \
            /code/lz/lean-linking-incantations/lean-shell.o \
            -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
            -L/code/lean4/build/release/stage1/lib/lean -lgmp -ldl -pthread  \
            -Wno-unused-command-line-argument -o exe-ref.out")
        print ("ERROR: SUCCEEDED")
        os.exit(1)
        # os_system_synch(f"clang++-12 -lstdc++ -O3 -D LEAN_MULTI_THREAD -I/code/lean4/build/release/stage1/include \
        #     exe.o \
        #     /code/lz/lean-linking-incantations/lean-shell.o \
        #     -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
        #     -L/code/lean4/build/release/stage1/lib/lean -lgmp -ldl -pthread \
        #     -Wno-unused-command-line-argument -o exe-ref.out")
        datum["theirs-out"] = []
        datum["theirs-perf"] = []
        for _ in range(ARGS.nruns):
          timeStarted = time.time_ns()
          # out, perf = sh("perf stat ./exe-ref.out")
          out, perf = sh("./exe-ref.out")
          timeDelta = ns_to_milli(time.time_ns() - timeStarted)
          datum["theirs-out"].append(out)
          datum["theirs-perf"].append(timeDelta)

        # disabled simpcase + MLIR.rgn optimization passes: 55a63f500b23b8c0c180e43108c5f844839a693f
        os_system_synch(f"rm exe-mlir.out || true")
        os_system_synch(f"rm exe.ll  || true")
        os_system_synch(f"rm exe-linked.ll  || true")
        os_system_synch(f"rm exe.o  || true")
        LEAN_DISABLE_SIMPCASE_PATH="/code/lean4/build/release/stage1/bin/lean"
        os_system_synch(f"{LEAN_DISABLE_SIMPCASE_PATH} {fpath} -m exe.mlir")
        # os_system_synch("hask-opt exe.mlir --convert-scf-to-std --lean-lower-rgn  --rgn-cse --cse --convert-rgn-to-std --convert-std-to-llvm --ptr-lower | \
        #        mlir-translate --mlir-to-llvmir -o exe.ll")
        os_system_synch("hask-opt exe.mlir --convert-scf-to-std --lean-lower-rgn --cse --convert-rgn-to-std --convert-std-to-llvm --ptr-lower | \
                mlir-translate --mlir-to-llvmir -o exe.ll")

        os_system_synch("llvm-link " + 
                  "exe.ll " + 
                  "/code/lz/lean-linking-incantations/lib-includes/library.ll " + 
                  "/code/lz/lean-linking-incantations/lib-runtime/runtime.ll " +
                  "| opt -passes=bitcast-call-converter  | opt --always-inline -O3 -S -o exe-linked.ll")
        os_system_synch("sed -i s/musttail/tail/g exe-linked.ll")
        os_system_synch("opt -O3 exe-linked.ll -o exe-linked-o3.ll")
        os_system_synch("mv exe-linked-o3.ll exe-linked.ll")
        print("@@@ HACK: converting muttail to tail because of llc miscompile@@@")
        os_system_synch("sed -i s/musttail/tail/g exe-linked.ll")
        os_system_synch("llc -O3 -march=x86-64 -filetype=obj exe-linked.ll -o exe.o")
        os_system_synch(f"clang++-12 -lstdc++ -O3 -D LEAN_MULTI_THREAD -I/code/lean4/build/release/stage1/include \
            exe.o \
            /code/lz/lean-linking-incantations/lean-shell.o \
            -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
            -L/code/lean4/build/release/stage1/lib/lean -lgmp -ldl -pthread \
            -Wno-unused-command-line-argument -o exe-mlir.out")
        datum["ours-out"] = []
        datum["ours-perf"] = []
        for _ in range(ARGS.nruns):
           timeStarted = time.time_ns()
           # out, perf = sh("perf stat ./exe-mlir.out")
           out, perf = sh("./exe-mlir.out")
           timeDelta = ns_to_milli(time.time_ns() - timeStarted)
           datum["ours-out"].append(out)
           datum["ours-perf"].append(timeDelta)

        # disabled simpcase and no MLIR.rgn optimization either: 55a63f500b23b8c0c180e43108c5f844839a693f
        os_system_synch(f"rm exe-mlir.out || true")
        os_system_synch(f"rm exe.ll  || true")
        os_system_synch(f"rm exe-linked.ll  || true")
        os_system_synch(f"rm exe.o  || true")
        LEAN_DISABLE_SIMPCASE_PATH="/code/lean4/build/release/stage1/bin/lean"
        os_system_synch(f"{LEAN_DISABLE_SIMPCASE_PATH} {fpath} -m exe.mlir")
        # os_system_synch("hask-opt exe.mlir --convert-scf-to-std --lean-lower-rgn  --rgn-cse --cse --convert-rgn-to-std --convert-std-to-llvm --ptr-lower | \
        #        mlir-translate --mlir-to-llvmir -o exe.ll")
        os_system_synch("hask-opt exe.mlir --convert-scf-to-std --lean-lower-rgn --convert-rgn-to-std --convert-std-to-llvm --ptr-lower | \
                mlir-translate --mlir-to-llvmir -o exe.ll")

        os_system_synch("llvm-link " + 
                  "exe.ll " + 
                  "/code/lz/lean-linking-incantations/lib-includes/library.ll " + 
                  "/code/lz/lean-linking-incantations/lib-runtime/runtime.ll " +
                  "| opt -passes=bitcast-call-converter  | opt --always-inline -O3 -S -o exe-linked.ll")
        os_system_synch("sed -i s/musttail/tail/g exe-linked.ll")
        os_system_synch("opt -O3 exe-linked.ll -o exe-linked-o3.ll")
        os_system_synch("mv exe-linked-o3.ll exe-linked.ll")
        print("@@@ HACK: converting muttail to tail because of llc miscompile@@@")
        os_system_synch("sed -i s/musttail/tail/g exe-linked.ll")
        os_system_synch("llc -O3 -march=x86-64 -filetype=obj exe-linked.ll -o exe.o")
        os_system_synch(f"clang++-12 -lstdc++ -O3 -D LEAN_MULTI_THREAD -I/code/lean4/build/release/stage1/include \
            exe.o \
            /code/lz/lean-linking-incantations/lean-shell.o \
            -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
            -L/code/lean4/build/release/stage1/lib/lean -lgmp -ldl -pthread \
            -Wno-unused-command-line-argument -o exe-mlir.out")
        datum["none-out"] = []
        datum["none-perf"] = []
        for _ in range(ARGS.nruns):
           timeStarted = time.time_ns()
           # out, perf = sh("perf stat ./exe-mlir.out")
           out, perf = sh("./exe-mlir.out")
           timeDelta = ns_to_milli(time.time_ns() - timeStarted)
           datum["none-out"].append(out)
           datum["none-perf"].append(timeDelta)

        ds.append(datum)
    with open(ARGS.out, "w") as f:
        json.dump(ds, f, indent=2)
    return ds


### PLOTTING ###
### PLOTTING ###
### PLOTTING ###
### PLOTTING ###
### PLOTTING ###
### PLOTTING ###
### PLOTTING ###
### PLOTTING ###
### PLOTTING ###
### PLOTTING ###

def perf_stat_to_time(file, o):
    print(f"===={file} output:|{o}|===")
    return float(o)
    # print(f"===={file}===")
    # print(o)
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
    # return float(o.splitlines()[12].split()[0].replace(',',''))

def autolabel(ax, rects):
    """Attach a text label above each bar in *rects*, displaying its height."""
    for rect in rects:
        height = rect.get_height()
        ax.annotate('{}'.format(height),
                    xy=(rect.get_x() + rect.get_width() / 2, height),
                    xytext=(0, 1),  # 1 points vertical offset
                    textcoords="offset points",
                    fontsize="smaller",
                    ha='center', va='bottom')

# def plot():
#   with open(ARGS.out, "r") as f:
#       datapoints = json.load(f)
#   assert datapoints is not None
# 
#   matplotlib.rcParams['pdf.fonttype'] = 42
#   matplotlib.rcParams['ps.fonttype'] = 42
# 
#   matplotlib.rcParams['figure.figsize'] = 5, 2
# 
#   labels = []
#   baselines = []
#   optims = []
#   speedups = []
#   for i, data in enumerate(datapoints):
#       # mark = "Y" if data['success'] else 'n'
#       log(f"[{i+1:3}/{len(datapoints)}]|{data['file']:80}|")
#       # if data["success"] == False:
#       #     continue
#       labels.append(data["file"].split(".lean")[0])
#       N = len(data["theirs-perf"])
#       assert N == len(data["ours-perf"])
# 
#       theirs = np.median([perf_stat_to_time(data["file"], t) for t in data["theirs-perf"] ])
#       ours = np.median([perf_stat_to_time(data["file"], t) for t in data["ours-perf"] ])
#       speedup = float("%4.2f" % (theirs/ours))
#       speedups.append(speedup)
#       # baselines.append(baseline/baseline)
#       optims.append(speedup)
# 
#   avg_speedup = mstats.gmean(speedups)
#   print("average speedup: %4.2f" % (avg_speedup, ))
#   baselines.append(1)
#   optims.append(float("%4.2f" % (avg_speedup)))
#   labels.append("geomean")
# 
#   print(labels)
#   print(baselines)
#   print(optims)
# 
# 
# 
#   x = np.arange(len(labels))  # the label locations
#   width = 0.35  # the width of the bars
# 
#   fig, ax = plt.subplots()
#   # rects1 = ax.bar(x - width/2, baselines, width, label='Baseline', color = light_blue)
#   rects2 = ax.bar(x + width/2, optims, width, label='Optimised', color = dark_blue)
#   rects2[-1].set_color(light_blue) # color geomean separately.
# 
# 
# 
#   # straight line
#   # plt.axhline(y=avg_speedup, color=light_red, linestyle='-', lw=1, label='Geomean speedup')
# 
#   # Y-Axis Label
#   #
#   # Use a horizontal label for improved readability.
#   ax.set_ylabel('Speedup over leanc (via regions for optimization)', rotation='horizontal', position = (1, 1.1),
#       horizontalalignment='left', verticalalignment='bottom', fontsize=8)
# 
#   # Add some text for labels, title and custom x-axis tick labels, etc.
#   ax.set_xticks(x)
#   ax.set_xticklabels(labels, rotation=15, fontsize=7)
#   # ax.legend(ncol=100, frameon=False, loc='lower right', bbox_to_anchor=(0, 1, 1, 0))
# 
#   # Hide the right and top spines
#   # This reduces the number of lines in the plot. Lines typically catch
#   # a readers attention and distract the reader from the actual content.
#   # By removing unnecessary spines, we help the reader to focus on
#   # the figures in the graph.
#   ax.spines['right'].set_visible(False)
#   ax.spines['top'].set_visible(False)
#   # autolabel(ax, rects1)
#   autolabel(ax, rects2)
# 
#   fig.tight_layout()
#   filename = os.path.basename(__file__).replace(".py", ".jpg")
#   fig.savefig(filename)
# 
#   filename = os.path.basename(__file__).replace(".py", ".pdf")
#   fig.savefig(filename)
#   # subprocess.run(["xdg-open",  filename])


def plot():
  with open(ARGS.out, "r") as f:
      datapoints = json.load(f)
  assert datapoints is not None

  matplotlib.rcParams['pdf.fonttype'] = 42
  matplotlib.rcParams['ps.fonttype'] = 42

  matplotlib.rcParams['figure.figsize'] = 5, 2

  labels = []
  ours_over_none = []
  theirs_over_none = []
  for i, data in enumerate(datapoints):
      # mark = "Y" if data['success'] else 'n'
      log(f"[{i+1:3}/{len(datapoints)}]|{data['file']:80}|")
      # if data["success"] == False:
      #     continue
      labels.append(data["file"].split(".lean")[0])
      N = len(data["theirs-perf"])
      assert N == len(data["ours-perf"])
      assert N == len(data["none-perf"])

      theirs = np.median([perf_stat_to_time(data["file"], t) for t in data["theirs-perf"] ])
      ours = np.median([perf_stat_to_time(data["file"], t) for t in data["ours-perf"] ])
      none = np.median([perf_stat_to_time(data["file"], t) for t in data["none-perf"] ])
      ours_over_none.append(float("%4.2f" % (none/ours)))
      theirs_over_none.append(float("%4.2f" % (none/theirs)))
      print("%20s | ours/none: %4.2f | theirs/none: %4.2f" % (data["file"], none/ours, none/theirs))

  # avg_speedup = mstats.gmean(speedups)
  # print("average speedup: %4.2f" % (avg_speedup, ))
  # optims.append(float("%4.2f" % (avg_speedup)))

  # avg_speedup = mstats.gmean(nones)
  # nones.append(float("%4.2f" % (avg_speedup)))

  # labels.append("geomean")
  x = np.arange(len(labels))  # the label locations
  width = 0.6  # the width of the bars

  fig, ax = plt.subplots()
  # rects1 = ax.bar(x - width/3, baselines, width/3, label='λpure simplifier', color = dark_blue)
  rects2 = ax.bar(x - width/3, theirs_over_none, width/3, label='λpure over none', color = dark_red)
  rects3 = ax.bar(x, ours_over_none, width/3, label='rgn over none', color = dark_gray)
  # rects1[-1].set_color(light_blue) # color geomean separately.
  # rects2[-1].set_color(light_red) # color geomean separately.
  # rects3[-1].set_color(light_gray) # color geomean separately.



  # straight line
  # plt.axhline(y=avg_speedup, color=light_red, linestyle='-', lw=1, label='Geomean speedup')

  # Y-Axis Label
  #
  # Use a horizontal label for improved readability.  
  ax.set_ylabel('Speedup over no simplifier', rotation='horizontal', position = (1, 1.1),
      horizontalalignment='left', verticalalignment='bottom', fontsize=7)

  # Add some text for labels, title and custom x-axis tick labels, etc.
  ax.set_xticks(x)
  ax.set_xticklabels(labels, rotation=15, fontsize=7)
  ax.legend(ncol=100, frameon=False, fontsize=6, loc='upper right', bbox_to_anchor=(0, 1.3, 1, 0))

  # Hide the right and top spines
  # This reduces the number of lines in the plot. Lines typically catch
  # a readers attention and distract the reader from the actual content.
  # By removing unnecessary spines, we help the reader to focus on
  # the figures in the graph.
  ax.spines['right'].set_visible(False)
  ax.spines['top'].set_visible(False)
  # autolabel(ax, rects1)
  autolabel(ax, rects2)

  fig.tight_layout()
  filename = os.path.basename(__file__).replace(".py", ".jpg")
  fig.savefig(filename)

  filename = os.path.basename(__file__).replace(".py", ".pdf")
  fig.savefig(filename)
  # subprocess.run(["xdg-open",  filename])
  # filename = os.path.basename(__file__).replace(".py", ".tex")
  # tikzplotlib.save(filename)


if __name__ == "__main__":
    if ARGS.data: run_data()
    if ARGS.plot: plot()
    if not ARGS.data and not ARGS.plot: PARSER.print_help()

