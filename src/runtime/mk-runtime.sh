#!/usr/bin/env bash
# ./src/config.h.in
# ./build/stage0/include/lean/config.h
set -o xtrace
set -e 

FILES=$(ls -1u *.cpp)
LLFILES=""
LEANCC="clang -O3 -DLEAN_MULTI_THREAD -I $HOME/code/lean4/build/release/stage0/include -I $HOME/work/lean4/src/"

for file in $FILES; do 
    i=$(basename $file .cpp)
    LLFILES="$LLFILES $i.ll"
    $LEANCC -O3 $file -S -emit-llvm  -o  $i.ll
done

echo $LLFILES

# alwaysinline causes runtime to take infinite amounts of time.
sed -i s/noinline/alwaysinline/g runtime.ll
sed -i s/optnone//g runtime.ll
opt -S -O3 runtime.ll -o runtime-optimized.ll
mv runtime-optimized.ll runtime.ll
cp /code/lean4/src/runtime/runtime.ll /code/lz/lean-linking-incantations/lib-runtime/
