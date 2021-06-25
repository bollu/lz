.PHONY: all

all: library.ll library.o

library.ll: 
	clang -I. -fPIC -c  library.c  -S -emit-llvm -o library.ll
	sed -i "s/attributes #0 = { noinline/attributes #0 = { alwaysinline/" library.ll
	sed -i "s/optnone//g" library.ll

library.o:
	gcc -I. -fPIC -c  library.c  -o library.o

clean:
	-rm library.ll
	-rm library.o
