#!/usr/bin/env python3

import argparse
import glob
import os
import json
import sys
import os
import subprocess

def log(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

parser = argparse.ArgumentParser(description='Run MLIR files to document number of thunks dropped')
parser.add_argument('--out', metavar='o', type=str,
                    help='path to dump output')

args = parser.parse_args()


# "sh /home/bollu/work/lz/test/lambdapure/compile/run-lean.sh binarytrees.lean"

g_baseline = "../baseline-lean.sh"
g_ours = "../run-lean.sh"

g_fpaths = []
g_fpaths.append("binarytrees-int.lean")
g_fpaths.append("binarytrees.lean")
g_fpaths.append("const_fold.lean")
g_fpaths.append("deriv.lean")
g_fpaths.append("filter.lean")
g_fpaths.append("qsort.lean")
# g_fpaths.append("rbmap2.lean")
# g_fpaths.append("rbmap3.lean")
# g_fpaths.append("rbmap4.lean")
# g_fpaths.append("rbmap500k.lean")
g_fpaths.append("rbmap_checkpoint.lean")
g_fpaths.append("unionfind.lean")
g_nfiles = len(g_fpaths)

def run_with_output(path):
    return subprocess.check_output(path, shell=True)

def sh(path):
    proc = subprocess.Popen(path, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    output = proc.stdout.read()
    err = proc.stderr.read()
    return (output.decode(), err.decode())

if __name__ == "__main__":
    g_data = []
    for (i, fpath) in enumerate(g_fpaths):
        data = {"file": str(fpath) }
        os.system(f"lean {fpath} -c exe-ref.c")
        os.system(f"leanc exe-ref.c -o exe-ref.out")
        # x = run_with_output("perf stat ./exe-ref.out 1>/dev/null")
        # proc = subprocess.Popen("perf stat ./exe-ref.out", shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
        out, perf = sh("perf stat ./exe-ref.out")
        data["theirs-out"] = out
        data["theirs-perf"] = perf

        os.system(f"lean {fpath} 2>&1 | \
                hask-opt --convert-scf-to-std --lean-lower --ptr-lower | \
                mlir-translate --mlir-to-llvmir -o exe.ll")
        os.system("llvm-link exe.ll /home/bollu/work/lz/lean-linking-incantations/lib-includes/library.ll -S | opt -O3 -S -o exe-linked.ll")
        os.system("llc -filetype=obj exe-linked.ll -o exe.o")
        os.system(f"c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/include \
            exe.o \
            /home/bollu/work/lz/lean-linking-incantations/lean-shell.o \
            -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
            -L/home/bollu/work/lean4/build/stage1/lib/lean -lgmp -ldl -pthread \
            -Wno-unused-command-line-argument -o exe-mlir.out")
        out, perf = sh("perf stat ./exe-mlir.out")
        data["ours-out"] = out
        data["ours-perf"] = perf


        g_data.append(data)

    print(g_data)
    with open("speedup_data.json", "w") as f:
        json.dump(g_data, f, indent=2)
