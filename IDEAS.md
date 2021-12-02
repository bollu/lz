# Future plans for LZ

- Integrate `mlir-lean` to dogfood our framework.
- Rewrite our transformation and lowering passes in `lz` directly in `lean` to dogfood.
- Add hooks in the compiler to allow lowering LEAN constructs into MLIR.
- Implement fast rewrites purely in LEAN, bench against PDL (`rete`? re-implement `PDL`?)
- Implement `hoopl` for MLIR to have easy ways to declare dataflow analysis + optimization.
- Explore "hyper IR"s --- directly encode dominance information within MLIR? other information?
- Explore interactive pattern matching and rewriting with tactics.
- Can we exploit dependent types? It's unclear how to make our system dependently typed.
- Provide a lightweight "verification framework" for `mlir-lean`.
