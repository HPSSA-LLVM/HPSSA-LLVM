; ModuleID = 'IR/LL/test_mem2reg.ll'
source_filename = "tests/test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_test.cpp, i8* null }]

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
entry:
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %i = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #3
  ret void
}

declare dso_local void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare dso_local void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #3

; Function Attrs: mustprogress noinline norecurse nounwind uwtable
define dso_local i32 @main() #4 {
entry:
  switch i32 undef, label %sw.default [
    i32 2, label %sw.bb
    i32 4, label %sw.bb1
  ]

sw.bb:                                            ; preds = %entry
  br label %label_3

sw.bb1:                                           ; preds = %entry
  br label %label_4

sw.default:                                       ; preds = %entry
  br label %label_5

label_3:                                          ; preds = %sw.bb
  %add = add nsw i32 90, 21
  br label %end

label_4:                                          ; preds = %sw.bb1
  %add2 = add nsw i32 undef, 37
  br label %end

label_5:                                          ; preds = %sw.default
  %sub = sub nsw i32 undef, 87
  br label %end

end:                                              ; preds = %label_5, %label_4, %label_3
  %a.0 = phi i32 [ %sub, %label_5 ], [ %add2, %label_4 ], [ %add, %label_3 ]
  %tau = call i32 (...) @llvm.tau.i32(i32 %a.0, i32 %add2)
  %add3 = add nsw i32 90, 30
  %add4 = add nsw i32 %tau, %add3
  %add5 = add nsw i32 %add4, 100
  %cmp = icmp sge i32 %add5, 100
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %end
  %add6 = add nsw i32 90, 777
  br label %if.end

if.else:                                          ; preds = %end
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %a.1 = phi i32 [ %add6, %if.then ], [ 3223, %if.else ]
  %tau2 = call i32 (...) @llvm.tau.i32(i32 %a.1, i32 3223)
  %tau1 = call i32 (...) @llvm.tau.i32(i32 %tau, i32 %add2)
  %add7 = add nsw i32 %tau2, 1
  ret i32 0
}

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #0 section ".text.startup" {
entry:
  call void @__cxx_global_var_init()
  ret void
}

; Function Attrs: nofree nosync nounwind willreturn
declare i32 @llvm.tau.i32(...) #5

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { mustprogress noinline norecurse nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nosync nounwind willreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 14.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)"}
