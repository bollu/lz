# for me, LEANPATH is:
# export LEANPATH=${LEANPATH}/build/stage1/
# compiler flags stolen from `which leanc` and then `cat /path/to/leanc`.
#
export LEANPATH=${LEAN4_PATH}

.PHONY: all clean
all: handlink.out main-print.out lean-shell.o use-lean-shell.o lean-shell.ll


lean-shell.o: lean-shell.c
	gcc -U LEAN_MULTI_THREAD -I${LEANPATH}/build/release/stage0/include/ -c lean-shell.c  -o lean-shell.o

lean-shell.ll: lean-shell.c
	clang -U LEAN_MULTI_THREAD -O3 -I${LEANPATH}/build/release/stage0/include/ -c lean-shell.c  -S -emit-llvm -o lean-shell.ll


use-lean-shell.o: use-lean-shell.c
	gcc -U LEAN_MULTI_THREAD -I${LEANPATH}/build/release/stage0/include/ -c use-lean-shell.c  -o use-lean-shell.o


handlink.out: lean-shell.o use-lean-shell.o
	make -C lib-includes
	c++ -U LEAN_MULTI_THREAD -I${LEANPATH}/build/release/stage1/include \
		lean-shell.o use-lean-shell.o ./lib-includes/library.o  -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
		-L${LEANPATH}/build/release/stage1//lib/lean -lgmp -ldl -pthread -Wno-unused-command-line-argument -o handlink.out

clean: 
	-rm lean-shell.o
	-rm use-lean-shell.o
	-rm main-print.out
	-rm handlink.out

# arcane commands discovered by `cat` ing `leanc
main-print.out: main-print.c
	make -C lib-includes
	c++ -U LEAN_MULTI_THREAD -I${LEANPATH}/build/release/stage1/include \
		main-print.c ./lib-includes/library.o  -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
		-L${LEANPATH}/build/release/stage1/lib/lean -lgmp -ldl -pthread -Wno-unused-command-line-argument -o main-print.out
