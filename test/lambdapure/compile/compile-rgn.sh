#!/usr/bin/env bash

set -e
set -o xtrace

rm $1-exe.out || true

# lean -c fails if relative path walks upward. eg. lean -c ../exe.c -o foo
(lean $1 -c exe-ref.c && clang -I /home/bollu/work/lean4/build/stage0/include  -O2 -S  -emit-llvm exe-ref.c -o exe-lean-ref.ll) || true

# hask-opt --convert-rgn-to-std | hask-opt --ptr-lower --convert-std-to-llvm
# compile MLIR file
lean $1 -m exe.mlir
hask-opt exe.mlir | \
  hask-opt  --convert-scf-to-std | hask-opt --lean-lower-rgn  | hask-opt --convert-rgn-to-std | hask-opt --convert-std-to-llvm --ptr-lower | \
  mlir-translate --mlir-to-llvmir -o exe.ll
# | opt -S -O3 | llc -filetype=obj -o exe.o
llvm-link exe.ll \
  /home/bollu/work/lz/lean-linking-incantations/lib-includes/library.ll \
  /home/bollu/work/lz/lean-linking-incantations/lib-runtime/runtime.ll \
  /home/bollu/work/lz/lean-linking-incantations/lean-shell.ll \
  -S -o exe-linked.ll
opt exe-linked.ll -passes=bitcast-call-converter -S -o exe-linked-nobitcast.ll
# opt exe-linked.ll  -S -o exe-linked-nobitcast.ll
opt -always-inline -O1  exe-linked-nobitcast.ll -S  -o exe-linked-o3.ll
opt -always-inline -O1  exe-linked-o3.ll -S  -o exe-linked-o3-2.ll
mv exe-linked-o3-2.ll exe-linked-o3.ll
opt -verify exe-linked-o3.ll
echo "@@@@HACK: REMOVING TAIL ANNOTATIONS!"
sed -i "s/musttail/tail/g" exe-linked-o3.ll
llc --relocation-model=static -O1 -march=x86-64 -filetype=obj exe-linked-o3.ll -o exe.o

# leancpp: undefined reference to lean_name_eq
# `l_Lean_Syntax_isOfKind':

# Lean: lean_name_hash 
c++ -O1 -U LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/include \
    exe.o \
    -no-pie -Wl,--start-group  -lleancpp -lInit -lStd -lLean -Wl,--end-group \
    -L/home/bollu/work/lean4/build/stage1/lib/lean -lgmp -ldl -pthread \
    -Wno-unused-command-line-argument -o exe.out

# c++ -O3 -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/include \
#     exe.o \
#     /home/bollu/work/lz/lean-linking-incantations/lean-shell.o \
#     -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
#     -L/home/bollu/work/lean4/build/stage1/lib/lean -lgmp -ldl -pthread \
#     -Wno-unused-command-line-argument -o exe.out
