#!/usr/bin/env python3
import argparse
import glob
import os
import json
import sys
import os
import subprocess
import os.path
import sys
import subprocess

def os_system_synch(path):
    print(f"\t$ {path}")
    return subprocess.check_output(path, shell=True)

def sh(path):
    proc = subprocess.Popen(path, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    output = proc.stdout.read()
    err = proc.stderr.read()
    return (output.decode(), err.decode())


def mk_runtime():
    LEANCC="clang -O3 -DLEAN_MULTI_THREAD -I $HOME/work/lean4/build/release/stage0/include -I $HOME/work/lean4/src/"
    cpp_files = glob.glob("*.cpp")
    for cpp_file in cpp_files:
        basename = cpp_file.split(".cpp")[0]
        os_system_synch(f"{LEANCC} -O3 {basename}.cpp -S -emit-llvm -o {basename}.ll")

    ll_files = [f.split(".cpp")[0] + ".ll" for f in cpp_files]
    os_system_synch(f"llvm-link {' '.join(ll_files)} -S -o runtime.ll")
    os_system_synch("sed -i s/noinline/alwaysinline/g runtime.ll")
    # os_system_synch("sed -i s/noinline//g runtime.ll")
    os_system_synch("sed -i s/optnone//g runtime.ll")
    os_system_synch("opt -S -O3 runtime.ll -o runtime-optimized.ll")
    os_system_synch("mv runtime-optimized.ll runtime.ll")
    os_system_synch("cp ~/work/lean4/src/runtime/runtime.ll ~/work/lz/lean-linking-incantations/lib-runtime")

if __name__ == "__main__":
    mk_runtime()
