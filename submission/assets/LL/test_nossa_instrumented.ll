; ModuleID = 'test_nossa.ll'
source_filename = "tests/test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_istream" = type { ptr, i64, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", ptr, i8, i8, ptr, ptr, ptr, ptr }
%"class.std::ios_base" = type { ptr, i64, i64, i32, i32, i32, ptr, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, ptr, %"class.std::locale" }
%"struct.std::ios_base::_Words" = type { ptr, i64 }
%"class.std::locale" = type { ptr }

$__llvm_profile_raw_version = comdat any

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@_ZSt3cin = external global %"class.std::basic_istream", align 8
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @_GLOBAL__sub_I_test.cpp, ptr null }]
@__llvm_profile_raw_version = hidden constant i64 72057594037927946, comdat
@__profn_tests_test.cpp___cxx_global_var_init = private constant [36 x i8] c"tests/test.cpp;__cxx_global_var_init"
@__profn_main = private constant [4 x i8] c"main"
@__profn_tests_test.cpp__GLOBAL__sub_I_test.cpp = private constant [38 x i8] c"tests/test.cpp;_GLOBAL__sub_I_test.cpp"

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
entry:
  call void @llvm.instrprof.increment(ptr @__profn_tests_test.cpp___cxx_global_var_init, i64 742261418966908927, i32 1, i32 0)
  call void @_ZNSt8ios_base4InitC1Ev(ptr nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %0 = call i32 @__cxa_atexit(ptr @_ZNSt8ios_base4InitD1Ev, ptr @_ZStL8__ioinit, ptr @__dso_handle) #3
  ret void
}

declare void @_ZNSt8ios_base4InitC1Ev(ptr nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(ptr nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: nounwind
declare i32 @__cxa_atexit(ptr, ptr, ptr) #3

; Function Attrs: mustprogress noinline norecurse uwtable
define i32 @main() #4 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %m = alloca i32, align 4
  %n = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 2, ptr %x, align 4
  store i32 0, ptr %y, align 4
  store i32 9, ptr %z, align 4
  store i32 1, ptr %c, align 4
  %call = call nonnull align 8 dereferenceable(16) ptr @_ZNSirsERi(ptr nonnull align 8 dereferenceable(16) @_ZSt3cin, ptr nonnull align 4 dereferenceable(4) %m)
  %0 = load i32, ptr %m, align 4
  switch i32 %0, label %sw.default [
    i32 2, label %sw.bb
    i32 4, label %sw.bb1
    i32 6, label %sw.bb4
  ]

sw.bb:                                            ; preds = %entry
  call void @llvm.instrprof.increment(ptr @__profn_main, i64 948827211749449834, i32 7, i32 2)
  %1 = load i32, ptr %c, align 4
  %mul = mul nsw i32 2, %1
  %add = add nsw i32 %mul, 5
  store i32 %add, ptr %x, align 4
  store i32 10, ptr %n, align 4
  br label %sw.epilog

sw.bb1:                                           ; preds = %entry
  call void @llvm.instrprof.increment(ptr @__profn_main, i64 948827211749449834, i32 7, i32 0)
  %2 = load i32, ptr %c, align 4
  %mul2 = mul nsw i32 2, %2
  %add3 = add nsw i32 %mul2, 5
  store i32 %add3, ptr %x, align 4
  %3 = load i32, ptr %x, align 4
  %sub = sub nsw i32 %3, 2
  store i32 %sub, ptr %n, align 4
  br label %sw.epilog

sw.bb4:                                           ; preds = %entry
  call void @llvm.instrprof.increment(ptr @__profn_main, i64 948827211749449834, i32 7, i32 1)
  %4 = load i32, ptr %c, align 4
  %mul5 = mul nsw i32 2, %4
  %add6 = add nsw i32 %mul5, 1
  store i32 %add6, ptr %x, align 4
  %5 = load i32, ptr %x, align 4
  %add7 = add nsw i32 %5, 2
  store i32 %add7, ptr %n, align 4
  br label %sw.epilog

sw.default:                                       ; preds = %entry
  call void @llvm.instrprof.increment(ptr @__profn_main, i64 948827211749449834, i32 7, i32 3)
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default, %sw.bb4, %sw.bb1, %sw.bb
  %6 = load i32, ptr %x, align 4
  %mul8 = mul nsw i32 2, %6
  %add9 = add nsw i32 %mul8, 10
  store i32 %add9, ptr %y, align 4
  %7 = load i32, ptr %y, align 4
  %8 = load i32, ptr %z, align 4
  %9 = load i32, ptr %x, align 4
  %add10 = add nsw i32 %8, %9
  %cmp = icmp sle i32 %7, %add10
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %sw.epilog
  br label %if.end

if.else:                                          ; preds = %sw.epilog
  %10 = load i32, ptr %n, align 4
  %11 = load i32, ptr %x, align 4
  %mul11 = mul nsw i32 3, %11
  %add12 = add nsw i32 %10, %mul11
  store i32 %add12, ptr %z, align 4
  %12 = load i32, ptr %z, align 4
  switch i32 %12, label %sw.default13 [
    i32 200, label %sw.bb14
    i32 300, label %sw.bb15
  ]

sw.default13:                                     ; preds = %if.else
  br label %sw.epilog16

sw.bb14:                                          ; preds = %if.else
  call void @llvm.instrprof.increment(ptr @__profn_main, i64 948827211749449834, i32 7, i32 4)
  br label %end

sw.bb15:                                          ; preds = %if.else
  call void @llvm.instrprof.increment(ptr @__profn_main, i64 948827211749449834, i32 7, i32 6)
  call void @exit(i32 0) #6
  unreachable

sw.epilog16:                                      ; preds = %sw.default13
  call void @llvm.instrprof.increment(ptr @__profn_main, i64 948827211749449834, i32 7, i32 5)
  br label %if.end

if.end:                                           ; preds = %sw.epilog16, %if.then
  %13 = load i32, ptr %n, align 4
  %14 = load i32, ptr %x, align 4
  %add17 = add nsw i32 %13, %14
  store i32 %add17, ptr %m, align 4
  br label %end

end:                                              ; preds = %if.end, %sw.bb14
  %15 = load i32, ptr %x, align 4
  store i32 %15, ptr %z, align 4
  ret i32 0
}

declare nonnull align 8 dereferenceable(16) ptr @_ZNSirsERi(ptr nonnull align 8 dereferenceable(16), ptr nonnull align 4 dereferenceable(4)) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #5

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #0 section ".text.startup" {
entry:
  call void @llvm.instrprof.increment(ptr @__profn_tests_test.cpp__GLOBAL__sub_I_test.cpp, i64 742261418966908927, i32 1, i32 0)
  call void @__cxx_global_var_init()
  ret void
}

; Function Attrs: nounwind
declare void @llvm.instrprof.increment(ptr, i64, i32, i32) #3

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { mustprogress noinline norecurse uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{!"clang version 13.0.0 (git@github.com:HPSSA-LLVM/llvm-project.git 4d11ba38b47de1da1cee156a8bf8b5d3447326b9)"}
