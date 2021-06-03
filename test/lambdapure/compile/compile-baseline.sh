set -e
set -o xtrace

rm $1-exe.out || true
lean $1 -c exe-ref.c
leanc exe-ref.c -o exe-ref.out
