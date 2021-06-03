#!/usr/bin/env bash

# https://stackoverflow.com/a/23161454/5305365
SCRIPTDIR="${BASH_SOURCE[0]}";
SCRIPTDIR=$(dirname $SCRIPTDIR)


set -e
set -o xtrace

# For whatever reason this does not work with relative paths.
lean $1 -c exe-ref.c
leanc exe-ref.c -o exe-ref.out
rm out-ref.txt || true
./exe-ref.out > ref.txt 

rm out-ours.txt || true
$SCRIPTDIR/run-lean.sh $1 > ours.txt 
diff ref.txt ours.txt
