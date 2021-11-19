; ModuleID = 'lean-shell.c'
source_filename = "lean-shell.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.lean_object = type { i64 }

@.str.1 = private unnamed_addr constant [64 x i8] c"/home/bollu/work/lean4/build/release/stage0/include/lean/lean.h\00", align 1
@.str.5 = private unnamed_addr constant [26 x i8] c"i < lean_ctor_num_objs(o)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set = private unnamed_addr constant [63 x i8] c"void lean_ctor_set(b_lean_obj_arg, unsigned int, lean_obj_arg)\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"lean_is_ctor(o)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_num_objs = private unnamed_addr constant [47 x i8] c"unsigned int lean_ctor_num_objs(lean_object *)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_get = private unnamed_addr constant [59 x i8] c"b_lean_obj_res lean_ctor_get(b_lean_obj_arg, unsigned int)\00", align 1

; Function Attrs: nounwind sspstrong uwtable
define dso_local i32 @main(i32 %0, i8** nocapture readonly %1) local_unnamed_addr #0 {
  tail call void (...) @lean_initialize_runtime_module() #3
  %3 = tail call %struct.lean_object* @init_lean_custom_entrypoint_hack(%struct.lean_object* nonnull inttoptr (i64 1 to %struct.lean_object*)) #3
  tail call void (...) @lean_io_mark_end_initialization() #3
  %4 = bitcast %struct.lean_object* %3 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 7
  %6 = load i8, i8* %5, align 1, !tbaa !4
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %8, label %93

8:                                                ; preds = %2
  %9 = getelementptr inbounds i8, i8* %4, i64 5
  %10 = load i8, i8* %9, align 1, !tbaa !4
  switch i8 %10, label %23 [
    i8 0, label %11
    i8 1, label %17
  ], !prof !7

11:                                               ; preds = %8
  %12 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i64 0, i32 0
  %13 = load i64, i64* %12, align 8, !tbaa !8
  %14 = add i64 %13, -1
  store i64 %14, i64* %12, align 8, !tbaa !8
  %15 = and i64 %14, 4294967295
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %22, label %23

17:                                               ; preds = %8
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i64 0, i32 0
  %19 = atomicrmw sub i64* %18, i64 1 acq_rel
  %20 = and i64 %19, 4294967295
  %21 = icmp eq i64 %20, 1
  br i1 %21, label %22, label %23

22:                                               ; preds = %17, %11
  tail call void @lean_del(%struct.lean_object* nonnull %3) #3
  br label %23

23:                                               ; preds = %8, %11, %17, %22
  tail call void (...) @lean_init_task_manager() #3
  %24 = icmp sgt i32 %0, 1
  br i1 %24, label %25, label %60

25:                                               ; preds = %23
  %26 = zext i32 %0 to i64
  br label %27

27:                                               ; preds = %25, %53
  %28 = phi i64 [ %26, %25 ], [ %57, %53 ]
  %29 = phi %struct.lean_object* [ inttoptr (i64 1 to %struct.lean_object*), %25 ], [ %33, %53 ]
  %30 = phi i32 [ %0, %25 ], [ %31, %53 ]
  %31 = add nsw i32 %30, -1
  %32 = tail call i8* @lean_alloc_small(i32 24, i32 2) #3
  %33 = bitcast i8* %32 to %struct.lean_object*
  %34 = bitcast i8* %32 to i64*
  store i64 72620543991349249, i64* %34, align 8, !tbaa !8
  %35 = zext i32 %31 to i64
  %36 = getelementptr inbounds i8*, i8** %1, i64 %35
  %37 = load i8*, i8** %36, align 8, !tbaa !11
  %38 = tail call %struct.lean_object* @lean_mk_string(i8* %37) #3
  %39 = getelementptr inbounds i8, i8* %32, i64 7
  %40 = load i8, i8* %39, align 1, !tbaa !4
  %41 = icmp ult i8 %40, -11
  br i1 %41, label %43, label %42

42:                                               ; preds = %27
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #4
  unreachable

43:                                               ; preds = %27
  %44 = getelementptr inbounds i8, i8* %32, i64 6
  %45 = load i8, i8* %44, align 1, !tbaa !4
  %46 = icmp eq i8 %45, 0
  br i1 %46, label %47, label %48

47:                                               ; preds = %43
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.str.1, i64 0, i64 0), i32 709, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set, i64 0, i64 0)) #4
  unreachable

48:                                               ; preds = %43
  %49 = getelementptr inbounds i8, i8* %32, i64 8
  %50 = bitcast i8* %49 to %struct.lean_object**
  store %struct.lean_object* %38, %struct.lean_object** %50, align 8, !tbaa !11
  %51 = icmp eq i8 %45, 1
  br i1 %51, label %52, label %53

52:                                               ; preds = %48
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.str.1, i64 0, i64 0), i32 709, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set, i64 0, i64 0)) #4
  unreachable

53:                                               ; preds = %48
  %54 = getelementptr inbounds i8, i8* %32, i64 16
  %55 = bitcast i8* %54 to %struct.lean_object**
  store %struct.lean_object* %29, %struct.lean_object** %55, align 8, !tbaa !11
  %56 = icmp sgt i64 %28, 2
  %57 = add nsw i64 %28, -1
  br i1 %56, label %27, label %58, !llvm.loop !13

58:                                               ; preds = %53
  %59 = bitcast i8* %32 to %struct.lean_object*
  br label %60

60:                                               ; preds = %58, %23
  %61 = phi %struct.lean_object* [ inttoptr (i64 1 to %struct.lean_object*), %23 ], [ %59, %58 ]
  %62 = tail call %struct.lean_object* @main_lean_custom_entrypoint_hack(%struct.lean_object* nonnull %61, %struct.lean_object* nonnull inttoptr (i64 1 to %struct.lean_object*)) #3
  %63 = bitcast %struct.lean_object* %62 to i8*
  %64 = getelementptr inbounds i8, i8* %63, i64 7
  %65 = load i8, i8* %64, align 1, !tbaa !4
  %66 = icmp eq i8 %65, 0
  br i1 %66, label %67, label %93

67:                                               ; preds = %60
  %68 = getelementptr inbounds i8, i8* %63, i64 6
  %69 = load i8, i8* %68, align 1, !tbaa !4
  %70 = icmp eq i8 %69, 0
  br i1 %70, label %71, label %72

71:                                               ; preds = %67
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.str.1, i64 0, i64 0), i32 704, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get, i64 0, i64 0)) #4
  unreachable

72:                                               ; preds = %67
  %73 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %62, i64 1
  %74 = bitcast %struct.lean_object* %73 to %struct.lean_object**
  %75 = load %struct.lean_object*, %struct.lean_object** %74, align 8, !tbaa !11
  %76 = ptrtoint %struct.lean_object* %75 to i64
  %77 = lshr i64 %76, 1
  %78 = trunc i64 %77 to i32
  %79 = getelementptr inbounds i8, i8* %63, i64 5
  %80 = load i8, i8* %79, align 1, !tbaa !4
  switch i8 %80, label %110 [
    i8 0, label %81
    i8 1, label %87
  ], !prof !7

81:                                               ; preds = %72
  %82 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %62, i64 0, i32 0
  %83 = load i64, i64* %82, align 8, !tbaa !8
  %84 = add i64 %83, -1
  store i64 %84, i64* %82, align 8, !tbaa !8
  %85 = and i64 %84, 4294967295
  %86 = icmp eq i64 %85, 0
  br i1 %86, label %92, label %110

87:                                               ; preds = %72
  %88 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %62, i64 0, i32 0
  %89 = atomicrmw sub i64* %88, i64 1 acq_rel
  %90 = and i64 %89, 4294967295
  %91 = icmp eq i64 %90, 1
  br i1 %91, label %92, label %110

92:                                               ; preds = %87, %81
  tail call void @lean_del(%struct.lean_object* nonnull %62) #3
  br label %110

93:                                               ; preds = %2, %60
  %94 = phi %struct.lean_object* [ %62, %60 ], [ %3, %2 ]
  %95 = phi i8* [ %63, %60 ], [ %4, %2 ]
  tail call void @lean_io_result_show_error(%struct.lean_object* nonnull %94) #3
  %96 = getelementptr inbounds i8, i8* %95, i64 5
  %97 = load i8, i8* %96, align 1, !tbaa !4
  switch i8 %97, label %110 [
    i8 0, label %98
    i8 1, label %104
  ], !prof !7

98:                                               ; preds = %93
  %99 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %94, i64 0, i32 0
  %100 = load i64, i64* %99, align 8, !tbaa !8
  %101 = add i64 %100, -1
  store i64 %101, i64* %99, align 8, !tbaa !8
  %102 = and i64 %101, 4294967295
  %103 = icmp eq i64 %102, 0
  br i1 %103, label %109, label %110

104:                                              ; preds = %93
  %105 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %94, i64 0, i32 0
  %106 = atomicrmw sub i64* %105, i64 1 acq_rel
  %107 = and i64 %106, 4294967295
  %108 = icmp eq i64 %107, 1
  br i1 %108, label %109, label %110

109:                                              ; preds = %104, %98
  tail call void @lean_del(%struct.lean_object* nonnull %94) #3
  br label %110

110:                                              ; preds = %109, %104, %98, %93, %92, %87, %81, %72
  %111 = phi i32 [ %78, %72 ], [ %78, %81 ], [ %78, %87 ], [ %78, %92 ], [ 1, %93 ], [ 1, %98 ], [ 1, %104 ], [ 1, %109 ]
  ret i32 %111
}

declare void @lean_initialize_runtime_module(...) local_unnamed_addr #1

declare %struct.lean_object* @init_lean_custom_entrypoint_hack(%struct.lean_object*) local_unnamed_addr #1

declare void @lean_io_mark_end_initialization(...) local_unnamed_addr #1

declare void @lean_init_task_manager(...) local_unnamed_addr #1

declare %struct.lean_object* @lean_mk_string(i8*) local_unnamed_addr #1

declare %struct.lean_object* @main_lean_custom_entrypoint_hack(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #1

declare void @lean_io_result_show_error(%struct.lean_object*) local_unnamed_addr #1

declare void @lean_del(%struct.lean_object*) local_unnamed_addr #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) local_unnamed_addr #2

declare i8* @lean_alloc_small(i32, i32) local_unnamed_addr #1

attributes #0 = { nounwind sspstrong uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{!"clang version 12.0.1"}
!4 = !{!5, !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!"branch_weights", i32 1, i32 4000, i32 1}
!8 = !{!9, !10, i64 0}
!9 = !{!"", !10, i64 0}
!10 = !{!"long", !5, i64 0}
!11 = !{!12, !12, i64 0}
!12 = !{!"any pointer", !5, i64 0}
!13 = distinct !{!13, !14}
!14 = !{!"llvm.loop.mustprogress"}
