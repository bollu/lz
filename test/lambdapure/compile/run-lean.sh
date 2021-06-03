#!/usr/bin/env bash
# https://stackoverflow.com/a/23161454/5305365
SCRIPTDIR="${BASH_SOURCE[0]}";
SCRIPTDIR=$(dirname $SCRIPTDIR)

$SCRIPTDIR/compile-lean.sh $1
./exe.out
