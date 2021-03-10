#!/usr/bin/env python3

import argparse
import glob
import os
import sh
import json
import sys

def log(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


parser = argparse.ArgumentParser(description='Run MLIR files to document number of thunks dropped')
parser.add_argument('--out', metavar='o', type=str,
                    help='path to dump output')

args = parser.parse_args()

g_opt = sh.hask_opt
g_fpaths = glob.glob("../**/*.mlir"); g_nfiles = len(g_fpaths)

g_data = []
for (i, fpath) in enumerate(g_fpaths):
    log(f"[{i+1:3}/{g_nfiles}] |{fpath}|")
    data = {"file": str(fpath)}
    try:
        call = g_opt(fpath, "--lz-interpret", "-o", "/dev/null").wait()
        data["baseline"] = {}
        data["baseline"]["stdout"] = call.stdout.decode()
        data["baseline"]["stderr"] = call.stderr.decode()

        call = g_opt(fpath, "--lz-worker-wrapper", "--lz-interpret", "-o", "/dev/null").wait()
        data["optimised"] = {}
        data["optimised"]["stdout"] = call.stdout.decode()
        data["optimised"]["stderr"] = call.stderr.decode()

        data["success"] = True
    except Exception as e:
        data["success"] = False
        data["err"] = str(e)
    g_data.append(data)

print(json.dumps(g_data, indent=1))

with open("speedup_data.json", "w") as f:
    json.dump(g_data, f, indent=2)
