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
@_ZSt4cout = external dso_local global %"class.std::basic_ostream", align 8
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
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %call = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) @_ZSt3cin, i32* nonnull align 4 dereferenceable(4) %a)
  %call1 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %call, i32* nonnull align 4 dereferenceable(4) %b)
  %call2 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %call1, i32* nonnull align 4 dereferenceable(4) %c)
  %call3 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %call2, i32* nonnull align 4 dereferenceable(4) %d)
  %call4 = call i32 @rand() #3
  %rem = srem i32 %call4, 181
  br i1 false, label %if.then, label %if.else14

if.then:                                          ; preds = %entry
  br i1 undef, label %if.then9, label %if.else

if.then9:                                         ; preds = %if.then
  br label %if.end

if.else:                                          ; preds = %if.then
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then9
  br label %if.end29

if.else14:                                        ; preds = %entry
  %add15 = add nsw i32 undef, 762
  %i12 = load i32, i32* %c, align 4
  %i13 = load i32, i32* %d, align 4
  %add16 = add nsw i32 %i12, %i13
  %i14 = load i32, i32* %a, align 4
  %add17 = add nsw i32 %i14, 887
  %call18 = call i32 @rand() #3
  %rem19 = srem i32 %call18, 70
  %i15 = load i32, i32* %a, align 4
  %mul20 = mul nsw i32 2, %i15
  %cmp21 = icmp sge i32 %rem19, %mul20
  br i1 %cmp21, label %if.then22, label %if.else24

if.then22:                                        ; preds = %if.else14
  %i16 = load i32, i32* %a, align 4
  %i17 = load i32, i32* %b, align 4
  %add23 = add nsw i32 %i16, %i17
  store i32 8568, i32* %b, align 4
  br label %if.end27

if.else24:                                        ; preds = %if.else14
  %i18 = load i32, i32* %c, align 4
  %add25 = add nsw i32 932, %i18
  %i19 = load i32, i32* %b, align 4
  %i20 = load i32, i32* %c, align 4
  %add26 = add nsw i32 %i19, %i20
  br label %if.end27

if.end27:                                         ; preds = %if.else24, %if.then22
  %y.1 = phi i32 [ %add17, %if.then22 ], [ %add26, %if.else24 ]
  %x.1 = phi i32 [ %add23, %if.then22 ], [ %add25, %if.else24 ]
  %add28 = add nsw i32 %x.1, 1145
  store i32 %add28, i32* %a, align 4
  br label %if.end29

if.end29:                                         ; preds = %if.end27, %if.end
  %y.2 = phi i32 [ undef, %if.end ], [ %y.1, %if.end27 ]
  %x.2 = phi i32 [ undef, %if.end ], [ %x.1, %if.end27 ]
  %tau4 = call i32 (...) @llvm.tau.i32(i32 %x.2, i32 undef)
  %tau2 = call i32 (...) @llvm.tau.i32(i32 %y.2, i32 undef)
  %i23 = load i32, i32* %a, align 4
  %add30 = add nsw i32 %tau4, %i23
  %add31 = add nsw i32 %tau2, %add30
  %add32 = add nsw i32 %add31, 1
  %i26 = load i32, i32* %d, align 4
  %i27 = load i32, i32* %a, align 4
  %add33 = add nsw i32 %i26, %i27
  %call34 = call i32 @rand() #3
  %rem35 = srem i32 %call34, 60
  %cmp36 = icmp sgt i32 %add33, %rem35
  br i1 %cmp36, label %if.then37, label %if.else39

if.then37:                                        ; preds = %if.end29
  %i29 = load i32, i32* %a, align 4
  %add38 = add nsw i32 %add31, %i29
  br label %if.end41

if.else39:                                        ; preds = %if.end29
  %i31 = load i32, i32* %a, align 4
  %add40 = add nsw i32 %tau4, %i31
  br label %if.end41

if.end41:                                         ; preds = %if.else39, %if.then37
  %y.3 = phi i32 [ %add38, %if.then37 ], [ %add40, %if.else39 ]
  %tau6 = call i32 (...) @llvm.tau.i32(i32 %y.3, i32 %add38)
  %tau5 = call i32 (...) @llvm.tau.i32(i32 %tau4, i32 undef)
  %tau3 = call i32 (...) @llvm.tau.i32(i32 %tau2, i32 undef)
  %i33 = load i32, i32* %a, align 4
  %add42 = add nsw i32 %tau5, %i33
  %add43 = add nsw i32 %tau6, %add42
  %call44 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 %add43)
  ret i32 0
}

declare dso_local nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16), i32* nonnull align 4 dereferenceable(4)) #1

; Function Attrs: nounwind
declare dso_local i32 @rand() #2

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i32) #1

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
