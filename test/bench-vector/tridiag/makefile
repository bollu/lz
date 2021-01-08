.PHONY: run
run: tridiaghs.out tridiagc.out
	-rm tridiag-out-hs.bin
	-rm tridiag-out-cpp.bin
	./tridiaghs.out
	./tridiagc.out
	sha256sum tridiag-out-hs.bin
	sha256sum tridiag-out-cpp.bin

tridiagc.out: tridiag.cpp
	clang++ -O3 tridiag.cpp -o tridiagc.out -lbenchmark -L/usr/local/lib/ -lpthread


tridiaghs.out: Tridiag.hs
	ghc Tridiag.hs -O2 -o tridiaghs.out
