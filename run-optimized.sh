#!/usr/bin/env bash
set -e
set -o xtrace
clang++ -DNODEBUG -O2 -S -emit-llvm -I /home/bollu/work/mlir/lz/include/ /home/bollu/work/mlir/lz/hask-opt/Runtime.cpp -o runtime.ll
sed -i "s/attributes #3 = {/attributes #3 = {norecurse alwaysinline argmemonly /g" runtime.ll
sed -i "s/attributes #2 = {/attributes #2 = {norecurse alwaysinline argmemonly /g" runtime.ll
sed -i "s/attributes #6 = {/attributes #6 = {norecurse alwaysinline argmemonly /g" runtime.ll
sed -i "s/attributes #7 = {/attributes #7 = {norecurse alwaysinline argmemonly /g" runtime.ll

hask-opt $@ --lz-worker-wrapper --lz-lower --convert-scf-to-std --ptr-lower -o /tmp/out.mlir
mlir-translate /tmp/out.mlir --mlir-to-llvmir -o /tmp/out.ll
llvm-link /home/bollu/work/mlir/lz/runtime.ll /tmp/out.ll -S -o /tmp/out-linked.ll
opt -always-inline -O3 -S /tmp/out-linked.ll -o /tmp/out-linked-o3.ll
llc /tmp/out-linked-o3.ll -o /tmp/out-linked-o3.o -filetype=obj -relocation-model=pic
gcc -lc /tmp/out-linked-o3.o -o /tmp/out-linked-o3.out
/tmp/out-linked-o3.out
