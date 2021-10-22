# for me, LEANPATH is:
# export LEANPATH=/home/bollu/work/lean4/build/stage1/
# compiler flags stolen from `which leanc` and then `cat /path/to/leanc`.
#
.PHONY: all clean
all: handlink.out main-print.out lean-shell.o use-lean-shell.o lean-shell.ll


lean-shell.o: lean-shell.c
	gcc -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/release/stage0/include/ -c lean-shell.c  -o lean-shell.o

lean-shell.ll: lean-shell.c
	clang -D LEAN_MULTI_THREAD -O3 -I/home/bollu/work/lean4/build/release/stage0/include/ -c lean-shell.c  -S -emit-llvm -o lean-shell.ll


use-lean-shell.o: use-lean-shell.c
	gcc -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/release/stage0/include/ -c use-lean-shell.c  -o use-lean-shell.o


handlink.out: lean-shell.o use-lean-shell.o
	make -C lib-includes
	c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/release/stage1/bin/../include \
		lean-shell.o use-lean-shell.o ./lib-includes/library.o  -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
		-L/home/bollu/work/lean4/build/release/stage1/bin/../lib/lean -lgmp -ldl -pthread -Wno-unused-command-line-argument -o handlink.out

clean: 
	-rm lean-shell.o
	-rm use-lean-shell.o
	-rm main-print.out
	-rm handlink.out

# arcane commands discovered by `cat` ing `leanc
main-print.out: main-print.c
	make -C lib-includes
	c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/release/stage1/bin/../include \
		main-print.c ./lib-includes/library.o  -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
		-L/home/bollu/work/lean4/build/release/stage1/bin/../lib/lean -lgmp -ldl -pthread -Wno-unused-command-line-argument -o main-print.out
