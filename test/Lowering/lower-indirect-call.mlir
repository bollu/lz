// RUN: hask-opt %s --lz-lower
// RUN: hask-opt %s --lz-lower --ptr-lower
func private @modify (!lz.value, !lz.value) -> !lz.value

func private @prescanl(%f: (!lz.value, !lz.value) -> (!lz.value), 
               %seed: !lz.value) -> !lz.value

func @main() {
    %modify = std.constant @modify : (!lz.value, !lz.value) -> !lz.value
    %v = lz.construct (@V)
    %scanl = call @prescanl(%modify, %v)
      : ((!lz.value, !lz.value) -> (!lz.value),  !lz.value) -> !lz.value
    return
}


