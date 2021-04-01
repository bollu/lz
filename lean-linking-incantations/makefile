# for me, LEANPATH is:
# export LEANPATH=/home/bollu/work/lean4/build/stage1/
# compiler flags stolen from `which leanc` and then `cat /path/to/leanc`.


lean-shell.o: lean-shell.c
	gcc -I/home/bollu/work/lean4/build/stage0/include/ -c lean-shell.c  -o lean-shell.o

test-lean-main.o: test-lean-main.c
	gcc -I/home/bollu/work/lean4/build/stage0/include/ -c test-lean-main.c -o test-lean-main.o

exe.out: lean-shell.o test-lean-main.o
	c++ \
		-no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group -L/home/bollu/work/lean4/build/stage1/bin/../lib/lean -lgmp -ldl -pthread \
		test-lean-main.o lean-shell.o -o exe.out

