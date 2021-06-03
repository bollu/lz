#!/usr/bin/env python3

import os
import os.path
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import json
import sys
import subprocess

def log(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

# Use TrueType fonts instead of Type 3 fonts
# Type 3 fonts embed bitmaps and are not allowed in camera-ready submissions
# for many conferences. TrueType fonts look better and are accepted.
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42

matplotlib.rcParams['figure.figsize'] = 5, 2

labels = []
baselines = []
optims = []

# Color palette
light_gray = "#cacaca"
dark_gray = "#827b7b"
light_blue = "#a6cee3"
dark_blue = "#1f78b4"
light_green = "#b2df8a"
dark_green = "#33a02c"
light_red = "#fb9a99"
dark_red = "#e31a1c"

datapoints = None
with open("speedup_data.json", "r") as f:
    datapoints = json.load(f)
assert datapoints is not None

def perf_stat_to_time(file, o):
    print(f"===={file}===")
    print(o)
    # 0 ['',
    # 1 " Performance counter stats for './exe-mlir.out':",
    # 2 '',
    # 3 '             10.35 msec task-clock:u              #    0.931 CPUs utilized          ',
    #   '                 0      context-switches:u        #    0.000 K/sec                  ',
    #   '                 0      cpu-migrations:u          #    0.000 K/sec                  ',
    #   '             1,236      page-faults:u             #    0.119 M/sec                  ',
    #   '         76,05,059      cycles:u                  #    0.735 GHz                    ',
    #   '       1,04,08,658      instructions:u            #    1.37  insn per cycle         ',
    #   '         19,34,949      branches:u                #  186.950 M/sec                  ',
    #   '            31,181      branch-misses:u           #    1.61% of all branches        ',
    #   '',
    #   '       0.011116120 seconds time elapsed',
    #   '',
    #   '       0.002787000 seconds user',
    #   '       0.008270000 seconds sys',
    #   '',
    #   '']
    # 1,559.42 msec
    return float(o.splitlines()[3].split()[0].replace(',',''))

for i, data in enumerate(datapoints):
    # mark = "Y" if data['success'] else 'n'
    log(f"[{i+1:3}/{len(datapoints)}]|{data['file']:80}|")
    # if data["success"] == False:
    #     continue
    labels.append(data["file"].split(".lean")[0])
    baseline = perf_stat_to_time(data["file"], data["theirs-perf"])
    optimised = perf_stat_to_time(data["file"], data["ours-perf"])
    # baselines.append(baseline/baseline)
    optims.append(float("%4.2f" % (baseline/optimised)))

print(labels)
print(baselines)
print(optims)

x = np.arange(len(labels))  # the label locations
width = 0.35  # the width of the bars

fig, ax = plt.subplots()
# rects1 = ax.bar(x - width/2, baselines, width, label='Baseline', color = light_blue)
rects2 = ax.bar(x + width/2, optims, width, label='Optimised', color = dark_blue)

# Y-Axis Label
#
# Use a horizontal label for improved readability.
ax.set_ylabel('leanc/mlircc', rotation='horizontal', position = (1, 1.05),
    horizontalalignment='left', verticalalignment='bottom')

# Add some text for labels, title and custom x-axis tick labels, etc.
ax.set_xticks(x)
ax.set_xticklabels(labels, rotation=10)
ax.legend(ncol=100, frameon=False, loc='lower right', bbox_to_anchor=(0, 1, 1, 0))

# Hide the right and top spines
#
# This reduces the number of lines in the plot. Lines typically catch
# a readers attention and distract the reader from the actual content.
# By removing unnecessary spines, we help the reader to focus on
# the figures in the graph.
ax.spines['right'].set_visible(False)
ax.spines['top'].set_visible(False)

def autolabel(rects):
    """Attach a text label above each bar in *rects*, displaying its height."""
    for rect in rects:
        height = rect.get_height()
        ax.annotate('{}'.format(height),
                    xy=(rect.get_x() + rect.get_width() / 2, height),
                    xytext=(0, 1),  # 1 points vertical offset
                    textcoords="offset points",
                    fontsize="smaller",
                    ha='center', va='bottom')

# autolabel(rects1)
autolabel(rects2)

fig.tight_layout()

filename = os.path.basename(__file__).replace(".py", ".pdf")
fig.savefig(filename)
subprocess.run(["xdg-open",  filename])
