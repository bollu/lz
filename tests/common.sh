set -euo pipefail

ulimit -s 8192
DIFF=diff
if diff --color --help >/dev/null 2>&1; then
    DIFF="diff --color";
fi

function fail {
    echo $1
    exit 1
}

INTERACTIVE=no
if [ $1 == "-i" ]; then
    INTERACTIVE=yes
    shift
fi
f="$1"
shift
[ $# -eq 0 ] || fail "Usage: test_single.sh [-i] test-file.lean"


function compile_lean {
    # lean --c="$f.c" "$f" || fail "Failed to compile $f into C file"
    # leanc -O3 -DNDEBUG -o "$f.out" "$@" "$f.c" || fail "Failed to compile C file $f.c"
    lean -m "$f.mlir" "$f"
    hask-opt "$f.mlir" --convert-scf-to-std --lean-lower --ptr-lower | \
      mlir-translate --mlir-to-llvmir -o "$f.ll"
    llvm-link "$f.ll" /code/lz/lean-linking-incantations/lib-includes/library.ll -S | opt -O3 -S  | \
    llc -O3 -march=x86-64 -filetype=obj  -o "$f.o"
    g++ -D LEAN_MULTI_THREAD -I/code/lean4/build/release/stage1/include \
            "$f.o" \
            /code/lz/lean-linking-incantations/lean-shell.o \
            -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
            -L/code/lean4/build/release/stage1/lib/lean -lgmp -ldl -pthread \
            -Wno-unused-command-line-argument -o "$@" "$f.out"
}


# function compile_lean {
#     # lean --c="$f.c" "$f" || fail "Failed to compile $f into C file"
#     # leanc -O3 -DNDEBUG -o "$f.out" "$@" "$f.c" || fail "Failed to compile C file $f.c"
#     lean -m "$f.mlir" "$f"
#     hask-opt "$f.mlir" --convert-scf-to-std --lean-lower --ptr-lower | \
#       mlir-translate --mlir-to-llvmir -o "$f.ll"
#     llvm-link "$f.ll" /home/bollu/work/lz/lean-linking-incantations/lib-includes/library.ll -S | opt -O3 -S  | \
#     llc -O3 -march=x86-64 -filetype=obj  -o "$f.o"
#     g++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/include \
#             "$f.o" \
#             /home/bollu/work/lz/lean-linking-incantations/lean-shell.o \
#             -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
#             -L/home/bollu/work/lean4/build/release/stage1/lib/lean -lgmp -ldl -pthread \
#             -Wno-unused-command-line-argument -o "$@" "$f.out"
# }

function exec_capture {
    # mvar suffixes like in `?m.123` are deterministic but prone to change on minor changes, so strip them
    "$@" 2>&1 | sed -E 's/(\?\w)\.[0-9]+/\1/g' > "$f.produced.out"
}

# Remark: `${var+x}` is a parameter expansion which evaluates to nothing if `var` is unset, and substitutes the string `x` otherwise.
function exec_check {
    ret=0
    [ -n "${expected_ret+x}" ] || expected_ret=0
    [ -f "$f.expected.ret" ] && expected_ret=$(< "$f.expected.ret")
    exec_capture "$@" || ret=$?
    if [ -n "$expected_ret" ] && [ $ret -ne $expected_ret ]; then
        echo "Unexpected return code $ret executing '$@'; expected $expected_ret. Output:"
        cat "$f.produced.out"
        exit 1
    fi
}

function diff_produced {
    if test -f "$f.expected.out"; then
        if $DIFF -au --strip-trailing-cr -I "executing external script" "$f.expected.out" "$f.produced.out"; then
            exit 0
        else
            echo "ERROR: file $f.produced.out does not match $f.expected.out"
            if [ $INTERACTIVE == "yes" ]; then
                meld "$f.produced.out" "$f.expected.out"
                if diff -I "executing external script" "$f.expected.out" "$f.produced.out"; then
                    echo "-- mismatch was fixed"
                fi
            fi
            exit 1
        fi
    else
        echo "ERROR: file $f.expected.out does not exist"
        if [ $INTERACTIVE == "yes" ]; then
            read -p "copy $f.produced.out (y/n)? "
            if [ $REPLY == "y" ]; then
                cp -- "$f.produced.out" "$f.expected.out"
                echo "-- copied $f.produced.out --> $f.expected.out"
            fi
        fi
        exit 1
    fi
}
