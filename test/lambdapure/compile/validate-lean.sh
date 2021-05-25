#!/usr/bin/env bash

set -e
set -o xtrace

# For whatever reason this does not work with relative paths.
lean $1 -c exe-ref.c
leanc exe-ref.c -o exe-ref.out
rm out-ref.txt || true
./exe-ref.out > ref.txt 


rm out-ours.txt || true
./run-lean.sh $1 > ours.txt 


diff ref.txt ours.txt
