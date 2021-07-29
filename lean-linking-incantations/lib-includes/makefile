.PHONY: all

all: library.ll library.o

library.ll: 
	clang -DLEAN_MULTI_THREAD -O3 -I. -fPIC -c  library.c  -S -emit-llvm -o library.ll
	sed -i "s/attributes #0 = { /attributes #0 = { alwaysinline /" library.ll
	sed -i "s/optnone//g" library.ll
	opt -O3 library.ll -S -o library-o3.ll
	mv library-o3.ll library.ll

library.o:
	gcc -I. -fPIC -c  library.c  -o library.o

clean:
	-rm library.ll
	-rm library.o
