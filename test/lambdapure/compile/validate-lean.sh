#!/usr/bin/env bash


# https://stackoverflow.com/a/23161454/5305365
SCRIPTDIR="${BASH_SOURCE[0]}";
SCRIPTDIR=$(dirname $SCRIPTDIR)


set -e
set -o xtrace

# For whatever reason this does not work with relative paths.
lean $1 -c exe-ref.c
leanc -O3 exe-ref.c -o exe-ref.out
leanc -O3 exe-ref.c -S -emit-llvm -o exe-ref-leanc.ll
clang++ -U LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/include \
   -O3 -S  -emit-llvm  exe-ref.c -o exe-ref.ll
rm ref.txt || true
./exe-ref.out > ref.txt 

rm ours.txt || true
$SCRIPTDIR/compile-lean.sh $1
./exe.out > ours.txt 
diff ref.txt ours.txt

time ./exe-ref.out
time ./exe.out
