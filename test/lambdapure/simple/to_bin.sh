#!/usr/bin/env bash
if [ $# -eq 0 ]; then
    echo "Usage: run.sh [file] [args]*"
    exit 1
fi
ff=$1
$(~/../../mnt/c/Users/Matthew/Desktop/lean4/bin/leanc $ff)
