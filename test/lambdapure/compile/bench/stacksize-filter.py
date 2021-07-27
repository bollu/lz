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
import msparser # https://github.com/MathieuTurcotte/msparser
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
FPATH="filter-tail-test.lean"

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

class ShResult:
  def __init__(self, command: str, stdout: str, stderr:str, retcode:int):
    self.command = command
    self.stdout = stdout
    self.stderr = stderr 
    self.retcode = retcode

  def assert_success(self):
    assert self.retcode == 0
  
  @property
  def success(self):
    return self.retcode == 0

def sh(command: str) -> ShResult:
    proc = subprocess.Popen(command, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    stdout = proc.stdout.read()
    stderr = proc.stderr.read()
    proc.wait()
    return ShResult(command, stdout.decode(),stderr.decode(), proc.returncode)


def run_data():
    ds = []
    sh(f"rm exe-ref.out")
    sh(f"lean {FPATH} -c exe-ref.c")
    sh(f"leanc exe-ref.c -O3 -o exe-ref.out")

    sh(f"rm exe-mlir.out")
    sh(f"lean {FPATH} -m exe.mlir")
    sh("hask-opt exe.mlir --convert-scf-to-std --lean-lower --ptr-lower | \
            mlir-translate --mlir-to-llvmir -o exe.ll")
    sh("llvm-link " + 
              "exe.ll " + 
              "/home/bollu/work/lz/lean-linking-incantations/lib-includes/library.ll " + 
              "/home/bollu/work/lz/lean-linking-incantations/lib-runtime/runtime.ll " +
              "| opt -passes=bitcast-call-converter  | opt --always-inline -O3 -S -o exe-linked.ll")
    print("@@@ HACK: converting muttail to tail because of llc miscompile@@@")
    sh("sed -i s/musttail/tail/g exe-linked.ll")
    sh("sed -i s/musttail/tail/g exe-linked.ll")
    sh("llc -O3 -march=x86-64 -filetype=obj exe-linked.ll -o exe.o")
    sh(f"c++ -O3 -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/include \
        exe.o \
        /home/bollu/work/lz/lean-linking-incantations/lean-shell.o \
        -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
        -L/home/bollu/work/lean4/build/stage1/lib/lean -lgmp -ldl -pthread \
        -Wno-unused-command-line-argument -o exe-mlir.out")
        # sh("opt -O3 exe-linked.ll -o exe-linked-o3.ll")
        # sh("mv exe-linked-o3.ll exe-linked.ll")

    for two_pow in range(2, 20):

        datum = {"problem_size": two_pow } # logarithmic
        psz = 2**two_pow
        # x = run_with_output("perf stat ./exe-ref.out 1>/dev/null")
        # proc = subprocess.Popen("perf stat ./exe-ref.out", shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
        datum["theirs-out"] = []
        datum["theirs-perf"] = []
        for _ in range(ARGS.nruns):
          sh("rm massif.out")
          exe_ref = sh(f"valgrind --massif-out-file=massif.out --stacks=yes --tool=massif ./exe-ref.out {psz}");
          if exe_ref.success:
            massif = msparser.parse_file('massif.out')
            datum["theirs-out"].append(exe_ref.stdout)
            datum["theirs-perf"].append([snap['mem_stack'] for snap in massif['snapshots']])

        datum["ours-out"] = []
        datum["ours-perf"] = []
        for _ in range(ARGS.nruns):
           sh("rm massif.out")
           exe = sh(f"valgrind --massif-out-file=massif.out --stacks=yes --tool=massif ./exe-mlir.out {psz}");
           if exe.success:
             massif = msparser.parse_file('massif.out')
             datum["ours-perf"].append([snap['mem_stack'] for snap in massif['snapshots']])
             datum["ours-out"].append(exe.stdout)
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
    return float(o.splitlines()[3].split()[0].replace(',',''))

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

def plot():
  with open(ARGS.out, "r") as f:
      datapoints = json.load(f)
  assert datapoints is not None

  matplotlib.rcParams['pdf.fonttype'] = 42
  matplotlib.rcParams['ps.fonttype'] = 42

  matplotlib.rcParams['figure.figsize'] = 5, 2

  labels = []
  theirs = []
  ours = []
  for i, data in enumerate(datapoints):
      # mark = "Y" if data['success'] else 'n'
      log(f"[{i+1:3}/{len(datapoints)}]|{data['problem_size']:80}|")
      # if data["success"] == False:
      #     continue
      labels.append(data["problem_size"])

      # take maximum of stack size used.
      print(data["theirs-perf"])
      if data["theirs-perf"]:
        theirs.append(np.log2(np.median([np.max(run) for run in data["theirs-perf"]])))
      if data["ours-perf"]:
        ours.append(np.log2(np.median([np.max(run) for run in data["ours-perf"]])))

  print(labels)
  print(theirs)
  print(ours)

  x = np.arange(len(labels))  # the label locations
  width = 0.35  # the width of the bars

  fig, ax = plt.subplots()
  rects1 = ax.bar(x[:len(theirs)] - width/2, theirs, width, label='theirs', color = light_blue)
  rects2 = ax.bar(x[:len(ours)] + width/2, ours, width, label='ours', color = dark_blue)
  # rects2[-1].set_color(light_blue) # color geomean separately.


  # straight line
  # plt.axhline(y=avg_speedup, color=light_red, linestyle='-', lw=1, label='Geomean speedup')

  # Y-Axis Label
  #
  # Use a horizontal label for improved readability.
  ax.set_ylabel('log2(peak # stack frames)', rotation='horizontal', position = (1, 1.1),
      horizontalalignment='left', verticalalignment='bottom', fontsize=8)

  # Add some text for labels, title and custom x-axis tick labels, etc.
  ax.set_xticks(x)
  ax.set_xticklabels(labels, rotation=15, fontsize=7)
  ax.legend(ncol=100, frameon=False, loc='lower right', bbox_to_anchor=(0, 1, 1, 0))
  ax.set_xlabel('log2(problem size)', fontsize=8)
  # Hide the right and top spines
  # This reduces the number of lines in the plot. Lines typically catch
  # a readers attention and distract the reader from the actual content.
  # By removing unnecessary spines, we help the reader to focus on
  # the figures in the graph.
  ax.spines['right'].set_visible(False)
  ax.spines['top'].set_visible(False)
  # autolabel(ax, rects1)
  # autolabel(ax, rects2)

  fig.tight_layout()
  filename = os.path.basename(__file__).replace(".py", ".jpg")
  fig.savefig(filename)

  filename = os.path.basename(__file__).replace(".py", ".pdf")
  fig.savefig(filename)
  subprocess.run(["xdg-open",  filename])



if __name__ == "__main__":
    if ARGS.data: run_data()
    if ARGS.plot: plot()
    if not ARGS.data and not ARGS.plot: PARSER.print_help()

