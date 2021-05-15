structure LHS where
  name: String


structure Binding where
  lhs: LHS
  rhs: Int

prefix:300 "%" => LHS.mk
infix:100 "=:=" => Binding.mk

#check (% "x") =:= 10
#check % "x" =:= 10
