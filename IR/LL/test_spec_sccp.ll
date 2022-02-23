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
  br label %start

start:                                            ; preds = %entry
  switch i32 2, label %sw.default [
    i32 2, label %sw.bb
    i32 4, label %sw.bb1
  ]

sw.bb:                                            ; preds = %start
  br label %label_3

sw.bb1:                                           ; preds = %start
  br label %label_4

sw.default:                                       ; preds = %start
  br label %label_6

label_3:                                          ; preds = %sw.bb
  br label %label_7

label_4:                                          ; preds = %sw.bb1
  br label %label_7

label_7:                                          ; preds = %label_4, %label_3
  %tau2 = call i32 (...) @llvm.tau.i32(i32 50, i32 10)
  %tau1 = call i32 (...) @llvm.tau.i32(i32 50, i32 90)
  %tau = call i32 (...) @llvm.tau.i32(i32 90, i32 undef)
  %add4 = add nsw i32 %tau2, %tau
  br label %end

label_6:                                          ; preds = %sw.default
  br label %end

end:                                              ; preds = %label_6, %label_7
  %b.1 = phi i32 [ 77, %label_6 ], [ %tau1, %label_7 ]
  %a.1 = phi i32 [ 23, %label_6 ], [ %tau2, %label_7 ]
  %add6 = add nsw i32 %a.1, %b.1
  br i1 false, label %if.then, label %if.else

if.then:                                          ; preds = %end
  br label %if.end

if.else:                                          ; preds = %end
  %tau7 = call i32 (...) @llvm.tau.i32(i32 %a.1, i32 50)
  %tau5 = call i32 (...) @llvm.tau.i32(i32 %b.1, i32 50)
  %tau3 = call i32 (...) @llvm.tau.i32(i32 90, i32 90)
  %sub8 = sub nsw i32 %tau7, 100
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %a.2 = phi i32 [ undef, %if.then ], [ %sub8, %if.else ]
  %add9 = add nsw i32 %add6, %a.2
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
