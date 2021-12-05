#!/usr/bin/env bash
source ../common.sh


# lean --c="$f.c" "$f" || fail "Failed to compile $f into C file"
# leanc -O3 -DNDEBUG -o "$f.out" "$@" "$f.c" || fail "Failed to compile C file $f.c"
lean -m "$f.mlir" "$f"
hask-opt "$f.mlir" --convert-scf-to-std --lean-lower --ptr-lower | \
mlir-translate --mlir-to-llvmir -o "$f.ll"
llvm-link "$f.ll" /code/lz/lean-linking-incantations/lib-includes/library.ll -S | opt -O3 -S  | \
llc -relocation-model=pic -O3 -march=x86-64 -filetype=obj  -o "$f.o"
g++ -D LEAN_MULTI_THREAD -I/code/lean4/build/release/stage1/include \
    "$f.o" \
    /code/lz/lean-linking-incantations/lean-shell.o \
    -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
    -L/code/lean4/build/release/stage1/lib/lean -lgmp -ldl -pthread \
    -Wno-unused-command-line-argument -fPIC -shared -o "${f%.lean}.so"


# compile_lean -shared -o "${f%.lean}.so"
expected_ret=1
exec_check lean --plugin="${f%.lean}.so" "$f"
diff_produced
