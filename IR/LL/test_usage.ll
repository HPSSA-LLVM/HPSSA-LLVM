; ModuleID = 'IR/LL/test_mem2reg.ll'
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

; Function Attrs: mustprogress noinline norecurse uwtable
define dso_local i32 @main() #4 {
entry:
  %a = alloca i32, align 4
  %c = alloca i32, align 4
  br label %start

start:                                            ; preds = %entry
  %call = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) @_ZSt3cin, i32* nonnull align 4 dereferenceable(4) %a)
  %call1 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %call, i32* nonnull align 4 dereferenceable(4) %c)
  %i = load i32, i32* %c, align 4
  switch i32 %i, label %sw.default [
    i32 1, label %sw.bb
    i32 2, label %sw.bb2
    i32 3, label %sw.bb3
    i32 4, label %sw.bb4
    i32 5, label %sw.bb5
    i32 6, label %sw.bb6
  ]

sw.bb:                                            ; preds = %start
  br label %label_1

sw.bb2:                                           ; preds = %start
  br label %label_2

sw.bb3:                                           ; preds = %start
  br label %label_3

sw.bb4:                                           ; preds = %start
  br label %label_4

sw.bb5:                                           ; preds = %start
  br label %label_5

sw.bb6:                                           ; preds = %start
  br label %label_8

sw.default:                                       ; preds = %start
  br label %label_6

label_1:                                          ; preds = %sw.bb
  store i32 30, i32* %a, align 4
  br label %end

label_2:                                          ; preds = %sw.bb2
  store i32 40, i32* %a, align 4
  br label %end

label_3:                                          ; preds = %sw.bb3
  store i32 50, i32* %a, align 4
  br label %end

label_4:                                          ; preds = %sw.bb4
  store i32 10, i32* %a, align 4
  %i1 = load i32, i32* %a, align 4
  %add = add nsw i32 %i1, 30
  br label %label_7

label_5:                                          ; preds = %sw.bb5
  store i32 86, i32* %a, align 4
  %i2 = load i32, i32* %a, align 4
  %add7 = add nsw i32 %i2, 1
  store i32 %add7, i32* %a, align 4
  br label %label_7

label_8:                                          ; preds = %sw.bb6
  store i32 110, i32* %a, align 4
  %i3 = load i32, i32* %a, align 4
  %add8 = add nsw i32 %i3, 1
  store i32 %add8, i32* %a, align 4
  br label %label_7

label_7:                                          ; preds = %label_8, %label_5, %label_4
  %e.0 = phi i32 [ 0, %label_8 ], [ 0, %label_5 ], [ %add, %label_4 ]
  %b.0 = phi i32 [ -11, %label_8 ], [ 13, %label_5 ], [ 90, %label_4 ]
  %tau1 = call i32 (...) @llvm.tau.i32(i32 %b.0, i32 90)
  %tau = call i32 (...) @llvm.tau.i32(i32 %e.0, i32 %add)
  %i4 = load i32, i32* %a, align 4
  %add9 = add nsw i32 %i4, %tau
  br label %end

label_6:                                          ; preds = %sw.default
  store i32 23, i32* %a, align 4
  br label %end

end:                                              ; preds = %label_6, %label_7, %label_3, %label_2, %label_1
  %e.1 = phi i32 [ 0, %label_6 ], [ %tau, %label_7 ], [ 0, %label_3 ], [ 0, %label_2 ], [ 90, %label_1 ]
  %b.1 = phi i32 [ 77, %label_6 ], [ %tau1, %label_7 ], [ 50, %label_3 ], [ 60, %label_2 ], [ 70, %label_1 ]
  %tau4 = call i32 (...) @llvm.tau.i32(i32 %b.1, i32 %b.0)
  %tau2 = call i32 (...) @llvm.tau.i32(i32 %e.1, i32 %e.0)
  %add10 = add nsw i32 %tau2, 10
  %i7 = load i32, i32* %a, align 4
  %add11 = add nsw i32 %i7, %tau4
  %cmp = icmp sge i32 %add11, 100
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %end
  %i10 = load i32, i32* %a, align 4
  %add12 = add nsw i32 %i10, 190
  store i32 %add12, i32* %a, align 4
  br label %if.end

if.else:                                          ; preds = %end
  %i11 = load i32, i32* %a, align 4
  %sub = sub nsw i32 %i11, 100
  store i32 %sub, i32* %a, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %tau5 = call i32 (...) @llvm.tau.i32(i32 %tau4, i32 %b.0)
  %tau3 = call i32 (...) @llvm.tau.i32(i32 %tau2, i32 %e.0)
  %i12 = load i32, i32* %a, align 4
  %add13 = add nsw i32 %add11, %i12
  ret i32 0
}

declare dso_local nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16), i32* nonnull align 4 dereferenceable(4)) #1

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
attributes #4 = { mustprogress noinline norecurse uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nosync nounwind willreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 14.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)"}
