; ModuleID = 'MaybeIntNonTailRecursive.c'
source_filename = "MaybeIntNonTailRecursive.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i64 @nothing() local_unnamed_addr #0 {
  ret i64 180388626433
}

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i64 @just(i32 %0) local_unnamed_addr #0 {
  %2 = zext i32 %0 to i64
  %3 = shl nuw i64 %2, 32
  ret i64 %3
}

; Function Attrs: nounwind readnone uwtable
define dso_local i64 @f(i64 %0) local_unnamed_addr #1 {
  %2 = trunc i64 %0 to i32
  %3 = lshr i64 %0, 32
  %4 = trunc i64 %3 to i32
  %5 = icmp eq i32 %2, 0
  br i1 %5, label %6, label %21

6:                                                ; preds = %1
  %7 = icmp eq i32 %4, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %6
  %9 = call i64 @just(i32 5)
  br label %21

10:                                               ; preds = %6
  %11 = add nsw i32 %4, -1
  %12 = call i64 @just(i32 %11)
  %13 = call i64 @f(i64 %12)
  %14 = trunc i64 %13 to i32
  %15 = icmp eq i32 %14, 1
  br i1 %15, label %21, label %16

16:                                               ; preds = %10
  %17 = lshr i64 %13, 32
  %18 = trunc i64 %17 to i32
  %19 = add nsw i32 %18, 7
  %20 = call i64 @just(i32 %19)
  br label %21

21:                                               ; preds = %1, %10, %16, %8
  %22 = phi i64 [ %9, %8 ], [ %20, %16 ], [ 180388626433, %10 ], [ 180388626433, %1 ]
  ret i64 %22
}

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #2 {
  %1 = call i64 @just(i32 5)
  %2 = call i64 @f(i64 %1)
  %3 = lshr i64 %2, 32
  %4 = trunc i64 %3 to i32
  %5 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i32 %4)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #3

attributes #0 = { norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nofree nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1~18.04.2 "}
