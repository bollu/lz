# for me, LEANPATH is:
# export LEANPATH=/home/bollu/work/lean4/build/stage1/
# compiler flags stolen from `which leanc` and then `cat /path/to/leanc`.
#
all: handlink.out main-print.out


lean-shell.o: lean-shell.c
	gcc -I/home/bollu/work/lean4/build/stage0/include/ -c lean-shell.c  -o lean-shell.o

use-lean-shell.o: use-lean-shell.c
	gcc -I/home/bollu/work/lean4/build/stage0/include/ -c use-lean-shell.c  -o use-lean-shell.o


handlink.out: lean-shell.o use-lean-shell.o
	c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/bin/../include \
		lean-shell.o use-lean-shell.o ./lib-includes/library.o  -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
		-L/home/bollu/work/lean4/build/stage1/bin/../lib/lean -lgmp -ldl -pthread -Wno-unused-command-line-argument -o handlink.out

# arcane commands discovered by `cat` ing `leanc
main-print.out: main-print.c
	c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/bin/../include \
		main-print.c ./lib-includes/library.o  -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
		-L/home/bollu/work/lean4/build/stage1/bin/../lib/lean -lgmp -ldl -pthread -Wno-unused-command-line-argument -o main-print.out
