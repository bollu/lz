#!/usr/bin/env bash

set -e
set -o xtrace

lean $1 -c exe.c 2>&1 | \
        hask-opt | tee exe.mlir | \
        hask-opt --lean-lower --ptr-lower | \
        mlir-translate --mlir-to-llvmir | tee exe.ll  | llc -filetype=obj -o exe.o

c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/include \
    exe.o \
    /home/bollu/work/lz/lean-linking-incantations/lean-shell.o \
    /home/bollu/work/lz/lean-linking-incantations/lib-includes/library.o  \
    -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
    -L/home/bollu/work/lean4/build/stage1/lib/lean -lgmp -ldl -pthread \
    -Wno-unused-command-line-argument -o exe.out
