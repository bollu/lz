// RUN: hask-opt --lz-interpret %s
// Fig 7 from paper
//    The GRIN Project: A Highly Optimising Back End for Lazy Functional Languages
module {
    func @int_add(%x: !grn.box, %y: !grn.box) -> !grn.box {
       %xv = grn.unbox @Cint, %x : (i64)
       %yv = grn.unbox @Cint, %y : (i64)
       %sum = std.addi %xv, %yv : i64
       %out = grn.box @Cint, %sum : (i64)
       grn.return %out
    }
    func @main() {
        %one = constant 1 : i64
        %intone = grn.box @Cint, %one : (i64)
        %t1 = grn.store %intone

        %ten = constant 10 : i64
        %intten = grn.box @Cint, %ten : (i64)
        %t2 = grn.store %intten

        %upto = grn.box @Fupto, %t1, %t2 : (!grn.box, !grn.box)
        %t3 = grn.store %upto

        %sum = grn.box @Sum, %t3 : (!grn.box)
        %t4 = grn.store %sum

        %res = std.call @eval(%t4) : (!grn.box) -> !grn.box
        %resint = grn.unbox @Cint %res : (i64)

        grn.return %resint
    }

    func @upto(%m: !grn.hp, %n: !grn.hp) -> !grn.box {
       %mwh = std.call @eval(%m) : (!grn.hp) -> !grn.box
       %nwh = std.call @eval(%n) : (!grn.hp) -> !grn.box

       %mv = grn.unboxval @Cint %mv : (i64)
       %nv = grn.unboxval @Cint %nv : (i64)

       %gt = cmpi %mv, %nv : i64
       condbr  %gt ^bbnil ^bbcons

       bbnil:
         %cnil = grn.box @Cnil
         grn.return %cnil

       bbcons:
         %one = constant 1 : i64
         %mincr = add %m %one : i64
         %m1box = grn.box @Cint %mincr : (i64)
         %m1 = grn.store %m1box

         %pbox = grn.box @Fupto %m1 %nbox
         %ccons = grn.box @Ccons %m1 %p
         grn.return %ccons
    }

    func sum (%m: !grn.hp) -> !grn.box {
      %l2 = std.call @eval(%m) : (!grn.hp) -> !grn.box
      %tag = grn.unboxtag %l2
      %out = grn.case %tag
        @Cnil { 
          %zero = std.constant 0 : i64
          %v = grn.box @Cint %zero
          grn.return %v
        }
       @Ccons {
         %zero = std.constant 0 : i64
         %one = std.constant 1 : i64
         %x = grn.unboxix %l2, %zero : (!grn.hp)
         %xprime = grn.eval %x

         %xs = grn.unboxix %l2, %one : (!grn.hp)
         %s = std.call sum(%xs) : (!grn.hp) -> !grn.box
         %axprime = std.call @int_add(%xprime, %s) : (!grn.box, !grn.box) -> !grn.box
         grn.return (%axprime)
       }



    }

    func @eval(%l: !grn.hp) : !grn.box {
       %l2 = grn.fetch %l
       %tag = grn.unboxtag %l2
       %out = grn.case %tag 
         @Cint { return %l2 },
         @Cnil { return %l2 },
         @Ccons { return %l2 },
         @Fupto {
            %zero = std.constant 0 : i64
            %one = std.constant 1 : i64
            %m = grn.unboxix %l2 %zero : !grn.hp
            %n = grn.unboxix %l2 %one : !grn.hp
            %v = std.call @upto (%m, %n) : (!grn.hp, !grn.hp) -> !grn.box
            grn.update %l, %v
            grn.return %l, %v
         },
         @Fsum {
             %linner = grn.unboxix %l2 %zero : !grn.hp
             %v = std.call @sum(%linner) : (!grn.hp) -> !grn.box
             grn.update %l, %v
             grn.return %v
         }
      grn.return %ou5

    }
}


