#!/usr/bin/env zsh
set -e
set -o xtrace
LEANPATH=/home/bollu/work/mlir/lean4/build/release/stage1/bin/lean
DIRPATH=$(dirname $1)
BASENAME=$(basename -s .lean $1)
LAMPUREPATH=$DIRPATH/$BASENAME-bollu.lambdapure

$LEANPATH $1 &> $LAMPUREPATH

g++ out.cpp \
    -I /home/bollu/work/mlir/lean4/build/release/stage0/include/lean \
    -I/home/bollu/work/mlir/lean4/build/release/stage0/include \
    -L /home/bollu/work/mlir/lean4/build/release/stage0/lib/lean \
    -lleancpp -lpthread -lgmp -o outfile
