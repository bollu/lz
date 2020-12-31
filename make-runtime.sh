#!/usr/bin/env bash
set -e
set -o xtrace
clang++ -O2 -S -emit-llvm -I ./include/ ./hask-opt/Runtime.cpp -o runtime.ll
sed -i "s/attributes #3 = {/attributes #3 = {norecurse alwaysinline argmemonly /g" runtime.ll
sed -i "s/attributes #2 = {/attributes #2 = {norecurse alwaysinline argmemonly /g" runtime.ll

