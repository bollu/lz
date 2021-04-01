# NOTE: the start-group / end-group this is NECESSARY to link correctly!
# NOTE: the C++ name mangling is NECESSARY to link correctly!
set -o xtrace
c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/bin/../include \
    main-print.c -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
    -L/home/bollu/work/lean4/build/stage1/bin/../lib/lean -lgmp -ldl -pthread -Wno-unused-command-line-argument

c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/bin/../include \
    -c lean-shell.c -o lean-shell.o

c++ -D LEAN_MULTI_THREAD \
    -c use-lean-shell.c -o use-lean-shell.o

c++ -D LEAN_MULTI_THREAD -I/home/bollu/work/lean4/build/stage1/bin/../include \
    lean-shell.o use-lean-shell.o ./lib-includes/library.o  -no-pie -Wl,--start-group -lleancpp -lInit -lStd -lLean -Wl,--end-group \
    -L/home/bollu/work/lean4/build/stage1/bin/../lib/lean -lgmp -ldl -pthread -Wno-unused-command-line-argument -o handlink.out
