.PHONY: map

map:
	# lean map.lean 2> map.lambdapure
	echo "please edit map.lambdapure file to remove proofs"
	../../build/bin/lambdapure map.lambdapure -mlir 2> map.mlir 
	../../build/bin/lambdapure map.lambdapure --des 2> map-destruct.mlir
	../../build/bin/lambdapure  map.lambdapure --des --ref 2> map-ref.mlir
	../../build/bin/lambdapure map.lambdapure --des --ref --runtime 2> map-runtime.mlir

loop:
	# lean lopo.lean 2> lopo.lambdapure
	echo "please edit loop.lambdapure file to remove proofs"
	../../build/bin/lambdapure loop.lambdapure -mlir 2> loop.mlir 
	../../build/bin/lambdapure loop.lambdapure --des 2> loop-destruct.mlir
	../../build/bin/lambdapure  loop.lambdapure --des --ref 2> loop-ref.mlir
	../../build/bin/lambdapure loop.lambdapure --des --ref --runtime 2> loop-runtime.mlir
