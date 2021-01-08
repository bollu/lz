// Check that floats interoperate properly with lz.
// RUN: hask-opt --lz-lower %s
// RUN: hask-opt --lz-lower --convert-scf-to-std --ptr-lower %s
func private @f(%f: f64) -> ()

func @main() {
  %c0 = constant 0.0 : f64
  %x = lz.construct(@Tup, %c0 : f64)

  %v = lz.case @Tup %x
    [@Tup -> { ^entry(%f: f64):
        lz.return %f : f64
    }]
  return
}

