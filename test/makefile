# Yes I hate myself, but this is far too convenient to be able to write
# pipelines which involve tee and allow such pipelines to fail.
targets =  fib add case-int fib-strict k-lazy either playground test-ops case-usage rec generic-op-printing worker-wrapper-int-non-tail-recursive peel-common-constructors-in-case

all: $(targets)

$(targets): %: %.mlir
	make -C ../build/
	../build/bin/hask-opt $<
	../build/bin/hask-opt ./$< > $@-roundtrip.mlir
	../build/bin/hask-opt -interpret ./$
	# ../build/bin/hask-opt ./$@-roundtrip.mlir
	# ../build/bin/hask-opt ./$@-roundtrip.mlir -lower-std
	# ../build/bin/hask-opt ./$@-roundtrip.mlir -lower-std -lower-llvm
	# ../build/bin/hask-opt ./$@-roundtrip.mlir -lower-std -lower-llvm -jit




# GDB execution
# make -C ../build && gdb -ex run --args ../build/bin/hask-opt fib.mlir > fib-roundtrip.mlir
