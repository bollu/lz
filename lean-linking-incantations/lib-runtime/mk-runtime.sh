#!/usr/bin/env bash
# ./src/config.h.in
# ./build/stage0/include/lean/config.h
# file to be run 
set -o xtrace
set -e 

LEANPATH=/home/bollu/work/lean4/
FILES=$(ls -1u *.cpp)
LLFILES=""
LEANCC="clang-12 -O3 -DLEAN_MULTI_THREAD -I $LEANPATH/build/release/stage0/include -I /code/lean4/src/"

for file in $FILES; do 
    i=$(basename $file .cpp)
    LLFILES="$LLFILES $i.ll"
    $LEANCC -O3 $file -S -emit-llvm  -o  $i.ll
done

echo $LLFILES

# alwaysinline causes runtime to take infinite amounts of time.
llvm-link $LLFILES -o runtime.ll
sed -i s/noinline/alwaysinline/g runtime.ll
sed -i s/optnone//g runtime.ll
opt -S -O3 runtime.ll -o runtime-optimized.ll
mv runtime-optimized.ll runtime.ll
cp /code/lean4/src/runtime/runtime.ll /code/lz/lean-linking-incantations/lib-runtime/
