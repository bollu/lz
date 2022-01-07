{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
	name = "lz";
	src = ./.;
	nativeBuildInputs = [cmake ninja clang lld python3 ./llvm-project/.];
	cmakeFlags = ''
		   -G Ninja  .
		   -DLLVM_ENABLE_PROJECTS=mlir 
		   -DLLVM_BUILD_EXAMPLES=ON 
		   -DCMAKE_BUILD_TYPE=RelWithDebInfo 
                   -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
		'';
	buildPhase = ''ninja'';
}

