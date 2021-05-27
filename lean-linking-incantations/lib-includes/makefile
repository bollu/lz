.PHONY: all

all: library.ll library.o

library.ll: 
	clang -I. -fPIC -c  library.c  -S -emit-llvm -o library.ll

library.o:
	gcc -I. -fPIC -c  library.c  -o library.o

clean:
	-rm library.ll
	-rm library.o
