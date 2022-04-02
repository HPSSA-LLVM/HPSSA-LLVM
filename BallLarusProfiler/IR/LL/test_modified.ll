; ModuleID = 'IR/LL/test_mem2reg_sumit.ll'
source_filename = "tests/test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_istream" = type { i32 (...)**, i64, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@_ZSt3cin = external dso_local global %"class.std::basic_istream", align 8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_test.cpp, i8* null }]
@counter = global i32 0

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

; Function Attrs: noinline norecurse uwtable mustprogress
define dso_local i32 @main() #4 {
entry:
  %m = alloca i32, align 4
  %call = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) @_ZSt3cin, i32* nonnull align 4 dereferenceable(4) %m)
  %i = load i32, i32* %m, align 4
  switch i32 %i, label %sw.default [
    i32 2, label %sw.bb
    i32 4, label %sw.bb1
    i32 6, label %sw.bb4
  ]

sw.bb:                                            ; preds = %entry
  %mul = mul nsw i32 2, 1
  %add = add nsw i32 %mul, 5
  br label %sw.bb.split

sw.bb.split:                                      ; preds = %sw.bb
  %0 = load i32, i32* @counter, align 4
  %1 = add i32 %0, -7
  store i32 %1, i32* @counter, align 4
  br label %sw.epilog

sw.bb1:                                           ; preds = %entry
  %mul2 = mul nsw i32 2, 1
  %add3 = add nsw i32 %mul2, 5
  %sub = sub nsw i32 %add3, 2
  br label %sw.bb1.split

sw.bb1.split:                                     ; preds = %sw.bb1
  %2 = load i32, i32* @counter, align 4
  %3 = add i32 %2, -11
  store i32 %3, i32* @counter, align 4
  br label %sw.epilog

sw.bb4:                                           ; preds = %entry
  %mul5 = mul nsw i32 2, 1
  %add6 = add nsw i32 %mul5, 1
  %add7 = add nsw i32 %add6, 2
  br label %sw.bb4.split

sw.bb4.split:                                     ; preds = %sw.bb4
  %4 = load i32, i32* @counter, align 4
  %5 = add i32 %4, -15
  store i32 %5, i32* @counter, align 4
  br label %sw.epilog

sw.default:                                       ; preds = %entry
  br label %sw.default.split

sw.default.split:                                 ; preds = %sw.default
  %6 = load i32, i32* @counter, align 4
  %7 = add i32 %6, -3
  store i32 %7, i32* @counter, align 4
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default.split, %sw.bb4.split, %sw.bb1.split, %sw.bb.split
  %n.0 = phi i32 [ undef, %sw.default.split ], [ %add7, %sw.bb4.split ], [ %sub, %sw.bb1.split ], [ 10, %sw.bb.split ]
  %x.0 = phi i32 [ 2, %sw.default.split ], [ %add6, %sw.bb4.split ], [ %add3, %sw.bb1.split ], [ %add, %sw.bb.split ]
  %mul8 = mul nsw i32 2, %x.0
  %add9 = add nsw i32 %mul8, 10
  %add10 = add nsw i32 9, %x.0
  %cmp = icmp sle i32 %add9, %add10
  br i1 %cmp, label %sw.epilog.if.end_crit_edge, label %if.else

sw.epilog.if.end_crit_edge:                       ; preds = %sw.epilog
  %8 = load i32, i32* @counter, align 4
  %9 = add i32 %8, 3
  store i32 %9, i32* @counter, align 4
  br label %if.end

if.else:                                          ; preds = %sw.epilog
  %mul11 = mul nsw i32 3, %x.0
  %add12 = add nsw i32 %n.0, %mul11
  switch i32 %add12, label %if.else.if.end_crit_edge [
    i32 200, label %sw.bb14
    i32 300, label %sw.bb15
  ]

if.else.if.end_crit_edge:                         ; preds = %if.else
  %10 = load i32, i32* @counter, align 4
  %11 = add i32 %10, 2
  store i32 %11, i32* @counter, align 4
  br label %if.end

sw.bb14:                                          ; preds = %if.else
  br label %sw.bb14.split

sw.bb14.split:                                    ; preds = %sw.bb14
  %12 = load i32, i32* @counter, align 4
  %13 = add i32 %12, 1
  store i32 %13, i32* @counter, align 4
  br label %end

sw.bb15:                                          ; preds = %if.else
  call void @exit(i32 0) #6
  unreachable

if.end:                                           ; preds = %if.else.if.end_crit_edge, %sw.epilog.if.end_crit_edge
  %add17 = add nsw i32 %n.0, %x.0
  store i32 %add17, i32* %m, align 4
  br label %end

end:                                              ; preds = %if.end, %sw.bb14.split
  %14 = load i32, i32* @counter, align 4
  call void @_Z7counterii(i32 %14, i32 1)
  ret i32 0
}

declare dso_local nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16), i32* nonnull align 4 dereferenceable(4)) #1

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #5

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #0 section ".text.startup" {
entry:
  call void @__cxx_global_var_init()
  ret void
}

declare void @_Z7counterii(i32, i32)

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { noinline norecurse uwtable mustprogress "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 14.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)"}
