# ./src/config.h.in
# ./build/stage0/include/lean/config.h
set -o xtrace
set -e 

LEANCC="clang -I $HOME/work/lean4/build/stage0/include -I $HOME/work/lean4/src/"
$LEANCC alloc.cpp -S -emit-llvm -o alloc.ll 
$LEANCC object.cpp -S -emit-llvm -o object.ll 
$LEANCC apply.cpp -S -emit-llvm -o apply.ll 
llvm-link alloc.ll object.ll apply.ll -S -o runtime.ll
# alwaysinline causes runtime to take infinite amounts of time.
# sed -i s/noinline/alwaysinline/g runtime.ll
sed -i s/noinline//g runtime.ll
sed -i s/optnone//g runtime.ll
opt -O3 runtime.ll -o runtime-optimized.ll
mv runtime-optimized.ll runtime.ll
cp ~/work/lean4/src/runtime/runtime.ll ~/work/lz/lean-linking-incantations/lib-runtime
