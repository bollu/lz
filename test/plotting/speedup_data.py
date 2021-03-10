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
g_fpaths = glob.glob("../**/*.mlir")
g_fpaths.extend(glob.glob("../*.mlir"))
g_fpaths = []
g_fpaths.append("../grin/sum-upto-grin.mlir")
# g_fpaths.append("../k-lazy.mlir")
# g_fpaths.append("../foo.mlir")
g_fpaths.append("../rec.mlir")
# g_fpaths.append("../worker-wrapper-fact.mlir")
# g_fpaths.append("../case-of-boxed-recursive-ap-with-final-construct.mlir")
# g_fpaths.append("../worker-wrapper-int-tail-recursive.mlir")
# g_fpaths.append("../add.mlir")
g_fpaths.append("../worker-wrapper-int-non-tail-recursive.mlir")
g_fpaths.append("../outline-return-of-constructor.mlir")
# g_fpaths.append("../either.mlir")
g_fpaths.append("../fib.mlir")
g_fpaths.append("../outline-case-of-fn-input.mlir")
# g_fpaths.append("../Interpreter/stdops.mlir")
# g_fpaths.append("../Lowering/lower-ap-and-force-2.mlir")
# g_fpaths.append("../Lowering/lower-construct-return.mlir")
# g_fpaths.append("../Lowering/lower-add.mlir")
# g_fpaths.append("../Lowering/lower-case-int.mlir")
# g_fpaths.append("../Lowering/lower-lz-and-memref.mlir")
# g_fpaths.append("../Lowering/lower-ap-and-force.mlir")
# g_fpaths.append("../Lowering/lower-case-single-alt-no-args.mlir")
# g_fpaths.append("../Lowering/lower-construct-memref.mlir")
# g_fpaths.append("../Lowering/lower-apeager.mlir")
# g_fpaths.append("../Lowering/lower-thunkify.mlir")
# g_fpaths.append("../Lowering/lower-lz-and-affine.mlir")
g_fpaths.append("../fib-strict.mlir")
# g_fpaths.append("../updatable-thunks-infer-non-upatable.mlir")
g_fpaths.append("../worker-wrapper-maybe-non-tail-recursive.mlir")
# g_fpaths.append("../worker-wrapper-maybe-tail-recursive.mlir")
# g_fpaths.append("../case-usage.mlir")
# g_fpaths.append("../case-int.mlir")
# g_fpaths.append("../optimize-linalg.mlir")
g_nfiles = len(g_fpaths)

g_data = []
for (i, fpath) in enumerate(g_fpaths):
    data = {"file": str(fpath)}
    try:
        call = g_opt(fpath, "--lz-interpret", "-o", "/dev/null").wait()
        data["baseline"] = {}
        stdout = call.stdout.decode()
        data["baseline"]["nthunks"] = int(stdout.split("num_thunkify_calls(")[1].split(")")[0])
        data["baseline"]["nconstructs"] = int(stdout.split("num_construct_calls(")[1].split(")")[0])
        stdout = None


        call = g_opt(fpath, "--lz-worker-wrapper", "--lz-interpret", "-o", "/dev/null").wait()
        data["optimised"] = {}
        # data["optimised"]["stdout"] = call.stdout.decode()
        # data["optimised"]["stderr"] = call.stderr.decode()
        stdout = call.stdout.decode()
        data["optimised"]["nthunks"] = int(stdout.split("num_thunkify_calls(")[1].split(")")[0])
        data["optimised"]["nconstructs"] = int(stdout.split("num_construct_calls(")[1].split(")")[0])

        baseline = data["baseline"]["nthunks"] + data["baseline"]["nconstructs"]

        if baseline <= 20:
            raise RuntimeError(fpath)

        data["success"] = True
        g_data.append(data)
        log(f"success [{i+1:3}/{g_nfiles}] |{fpath}|")
    except Exception as e:
        log(f"failure [{i+1:3}/{g_nfiles}] |{fpath}|")
        raise e
      # data["success"] = False
      # data["err"] = str(e)

# print(json.dumps(g_data, indent=1))

with open("speedup_data.json", "w") as f:
    json.dump(g_data, f, indent=2)
