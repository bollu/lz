sep-30-worker-wrapper.out: sep-30-worker-wrapper.cpp
	g++ -std=c++17 -O0 sep-30-worker-wrapper.cpp -o sep-30-worker-wrapper.out

nov-11-IO-force.out: nov-11-IO-force.cpp
	g++ -std=c++17 -O0 nov-11-IO-force.cpp -o nov-11-IO-force.out

MaybeIntNonTailRecursive.ll: MaybeIntNonTailRecursive.c
	clang -S -O3 -emit-llvm MaybeIntNonTailRecursive.c  -o MaybeIntNonTailRecursive.ll
