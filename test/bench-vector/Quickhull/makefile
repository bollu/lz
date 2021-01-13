.PHONY: run hs.out cpp.out

run: hs.out cpp.out
	-rm out-hs.bin
	-rm out-cpp.bin
	./hs.out | tee hs.log
	@echo "#############################"
	./cpp.out | tee cpp.log
	sha256sum out-hs.bin
	sha256sum out-cpp.bin

cpp.out:
	clang++ -O3 test.cpp -o cpp.out -lbenchmark -L/usr/local/lib/ -lpthread


hs.out:
	ghc test.hs -O2 -fllvm -o hs.out
