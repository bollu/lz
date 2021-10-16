#!/usr/bin/env bash
make -C ~/work/lean4/build/release -j
echo ""
echo "NO-CASE-SIMPL"
~/work/lean4/build/release/stage1/bin/lean case-branches.lean -Dcompiler.caseSimpl=false -m case-simpl-NO.mlir
~/work/lean4/build/release/stage1/bin/lean case-branches.lean -Dcompiler.caseSimpl=false -c case-simpl-NO.c
echo ""
echo "YES-CASE-SIMPL"
~/work/lean4/build/release/stage1/bin/lean case-branches.lean -Dcompiler.caseSimpl=true -m case-simpl-YES.mlir
~/work/lean4/build/release/stage1/bin/lean case-branches.lean -Dcompiler.caseSimpl=false -c case-simpl-YES.c
diff case-simpl-NO.mlir case-simpl-YES.mlir


