#!/usr/bin/env bash

set -e
set -o xtrace

rm $1-exe.out || true

# lean -c fails if relative path walks upward. eg. lean -c ../exe.c -o foo
(lean $1 -c exe-ref.c && clang -I /home/bollu/work/lean4/build/stage0/include  -S  -emit-llvm exe-ref.c -o exe-lean-ref.ll) || true

lean $1 2>&1 | \
        hask-opt | tee exe.mlir | \
        hask-opt  --convert-scf-to-std | hask-opt --lean-lower  | hask-opt --ptr-lower | \
        mlir-translate --mlir-to-llvmir | tee exe.ll  | llc -filetype=obj -o exe.o


c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/include \
    exe.o \
    /home/bollu/work/lz/lean-linking-incantations/lean-shell.o \
    /home/bollu/work/lz/lean-linking-incantations/lib-includes/library.o  \
    -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
    -L/home/bollu/work/lean4/build/stage1/lib/lean -lgmp -ldl -pthread \
    -Wno-unused-command-line-argument -o exe.out
./exe.out
