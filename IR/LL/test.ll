; ModuleID = 'tests/test.cpp'
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
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i32 0, i32 0), i8* @__dso_handle) #3
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
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  br label %start

start:                                            ; preds = %entry
  store i32 0, i32* %e, align 4
  %0 = load i32, i32* %c, align 4
  switch i32 %0, label %sw.default [
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
  store i32 50, i32* %a, align 4
  store i32 50, i32* %b, align 4
  store i32 90, i32* %e, align 4
  %1 = load i32, i32* %a, align 4
  %2 = load i32, i32* %b, align 4
  %add = add nsw i32 %1, %2
  %3 = load i32, i32* %e, align 4
  %add2 = add nsw i32 %add, %3
  store i32 %add2, i32* %d, align 4
  br label %label_7

label_4:                                          ; preds = %sw.bb1
  store i32 10, i32* %a, align 4
  store i32 90, i32* %b, align 4
  %4 = load i32, i32* %a, align 4
  %add3 = add nsw i32 %4, 80
  store i32 %add3, i32* %e, align 4
  br label %label_7

label_7:                                          ; preds = %label_4, %label_3
  %5 = load i32, i32* %a, align 4
  %6 = load i32, i32* %e, align 4
  %add4 = add nsw i32 %5, %6
  store i32 %add4, i32* %d, align 4
  store i32 90, i32* %e, align 4
  br label %end

label_6:                                          ; preds = %sw.default
  store i32 23, i32* %a, align 4
  store i32 77, i32* %b, align 4
  %7 = load i32, i32* %a, align 4
  %8 = load i32, i32* %b, align 4
  %add5 = add nsw i32 %7, %8
  %sub = sub nsw i32 %add5, 10
  store i32 %sub, i32* %e, align 4
  br label %end

end:                                              ; preds = %label_6, %label_7
  %9 = load i32, i32* %a, align 4
  %10 = load i32, i32* %b, align 4
  %add6 = add nsw i32 %9, %10
  store i32 %add6, i32* %z, align 4
  %11 = load i32, i32* %e, align 4
  %cmp = icmp sge i32 %11, 150
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %end
  %12 = load i32, i32* %a, align 4
  %add7 = add nsw i32 %12, 190
  store i32 %add7, i32* %a, align 4
  br label %if.end

if.else:                                          ; preds = %end
  %13 = load i32, i32* %a, align 4
  %sub8 = sub nsw i32 %13, 100
  store i32 %sub8, i32* %a, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %14 = load i32, i32* %a, align 4
  %15 = load i32, i32* %z, align 4
  %add9 = add nsw i32 %15, %14
  store i32 %add9, i32* %z, align 4
  ret i32 0
}

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #0 section ".text.startup" {
entry:
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { mustprogress noinline norecurse nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 14.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)"}
