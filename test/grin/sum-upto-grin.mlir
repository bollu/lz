// Fig 7 from paper:
//  | The GRIN Project: 
//  | A Highly Optimising Back End for Lazy Functional Languages
// RUN: hask-opt --lz-interpret %s | FileCheck %s
// CHECK: 55

module {
    func @int_add(%x: !grn.box, %y: !grn.box) -> !grn.box {
       %xv = grn.unbox @Cint, %x : i64
       %yv = grn.unbox @Cint, %y : i64
       %sum = std.addi %xv, %yv : i64
       %out = grn.box @Cint, %sum : i64
       grn.return %out : !grn.box
    }
    func @main() -> i64 {
        %zero = constant 0 : i64
        %intzero = grn.box @Cint, %zero : i64
        %t1 = grn.store %intzero

        %ten = constant 10 : i64
        %intten = grn.box @Cint, %ten : i64
        %t2 = grn.store %intten

        %upto = grn.box @Fupto, %t1, %t2 : !grn.hp, !grn.hp
        %t3 = grn.store %upto

        %sum = grn.box @Fsum, %t3 : !grn.hp
        %t4 = grn.store %sum

        %res = std.call @eval(%t4) : (!grn.hp) -> !grn.box
        %resint = grn.unbox @Cint, %res : i64

        grn.return %resint : i64
    }

    func @upto(%m: !grn.hp, %n: !grn.hp) -> !grn.box {
       %mwh = std.call @eval(%m) : (!grn.hp) -> !grn.box
       %nwh = std.call @eval(%n) : (!grn.hp) -> !grn.box

       %mv = grn.unbox @Cint, %mwh : i64
       %nv = grn.unbox @Cint, %nwh : i64

       %gt = cmpi "eq", %mv, %nv : i64
       cond_br  %gt, ^bbnil, ^bbcons

       ^bbnil:
         %cnil = grn.box @Cnil
         grn.return %cnil : !grn.box

       ^bbcons:
         %one = constant 1 : i64
         %mincr = addi %mv, %one : i64
         %m1box = grn.box @Cint, %mincr : i64
         %m1 = grn.store %m1box

         %pbox = grn.box @Fupto, %m1, %n : !grn.hp, !grn.hp
         %p = grn.store %pbox
         %ccons = grn.box @Ccons, %m1, %p : !grn.hp, !grn.hp
         grn.return %ccons : !grn.box
    }

    func @sum (%m: !grn.hp) -> !grn.box {
      %l2 = std.call @eval(%m) : (!grn.hp) -> !grn.box
      %tag = grn.unboxtag %l2
      %out = grn.case %tag
        @Cnil { 
          %zero = std.constant 0 : i64
          %v = grn.box @Cint, %zero : i64
          grn.return %v : !grn.box
        },
       @Ccons {
         %zero = std.constant 0 : i64
         %one = std.constant 1 : i64
         %x = grn.unboxix %l2, %zero :  !grn.hp  
         %xprime = call @eval(%x) : (!grn.hp) -> !grn.box
         %xs = grn.unboxix %l2, %one : !grn.hp 
         %s = std.call @sum(%xs) : (!grn.hp) -> !grn.box
         %axprime = std.call @int_add(%xprime, %s) : (!grn.box, !grn.box) -> !grn.box
         grn.return  %axprime : !grn.box
       } : !grn.box
       grn.return %out : !grn.box

    }

    func @eval(%l: !grn.hp) -> !grn.box {
       %l2 = grn.fetch %l
       %tag = grn.unboxtag %l2
       %out = grn.case %tag 
         @Cint { grn.return %l2 : !grn.box },
         @Cnil { grn.return %l2 : !grn.box },
         @Ccons { grn.return %l2 : !grn.box },
         @Fupto {
            %zero = std.constant 0 : i64
            %one = std.constant 1 : i64
            %m = grn.unboxix %l2, %zero : !grn.hp
            %n = grn.unboxix %l2, %one : !grn.hp
            %v = std.call @upto (%m, %n) : (!grn.hp, !grn.hp) -> !grn.box
            grn.update %l, %v
            grn.return %v : !grn.box
         },
         @Fsum {
            %zero = std.constant 0 : i64
            %linner = grn.unboxix %l2, %zero : !grn.hp
            %v = std.call @sum(%linner) : (!grn.hp) -> !grn.box
            grn.update %l, %v
            grn.return %v : !grn.box
         } : !grn.box
      grn.return %out : !grn.box

    }
}


