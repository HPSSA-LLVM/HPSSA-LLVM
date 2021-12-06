; ModuleID = 'tests/test.cpp'
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
@_ZSt3cin = external global %"class.std::basic_istream", align 8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_test.cpp, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nofree nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) local_unnamed_addr #2

; Function Attrs: norecurse uwtable mustprogress
define i32 @main() local_unnamed_addr #3 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #6
  %4 = bitcast i32* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #6
  %5 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) @_ZSt3cin, i32* nonnull align 4 dereferenceable(4) %1)
  %6 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %5, i32* nonnull align 4 dereferenceable(4) %2)
  %7 = load i32, i32* %1, align 4, !tbaa !4
  %8 = icmp sgt i32 %7, 5
  br i1 %8, label %9, label %15

9:                                                ; preds = %0
  %10 = mul nsw i32 %7, 9
  %11 = add nsw i32 %10, 6
  store i32 %11, i32* %1, align 4, !tbaa !4
  %12 = load i32, i32* %2, align 4, !tbaa !4
  %13 = mul nsw i32 %12, 3
  %14 = add nsw i32 %13, 1
  br label %19

15:                                               ; preds = %0
  %16 = add nsw i32 %7, 8
  store i32 %16, i32* %1, align 4, !tbaa !4
  %17 = load i32, i32* %2, align 4, !tbaa !4
  %18 = add nsw i32 %17, 9
  br label %19

19:                                               ; preds = %15, %9
  %20 = phi i32 [ %18, %15 ], [ %14, %9 ]
  store i32 %20, i32* %2, align 4, !tbaa !4
  %21 = load i32, i32* %1, align 4, !tbaa !4
  %22 = add nsw i32 %21, 7
  store i32 %22, i32* %1, align 4, !tbaa !4
  %23 = mul nsw i32 %20, 6
  store i32 %23, i32* %2, align 4, !tbaa !4
  %24 = icmp sgt i32 %23, 6
  br i1 %24, label %61, label %25

25:                                               ; preds = %19
  %26 = icmp sgt i32 %21, 2
  br i1 %26, label %27, label %46

27:                                               ; preds = %25
  %28 = add nsw i32 %21, 14
  store i32 %28, i32* %1, align 4, !tbaa !4
  %29 = mul i32 %20, 36
  store i32 %29, i32* %2, align 4, !tbaa !4
  %30 = icmp eq i32 %22, 10
  br i1 %30, label %56, label %31

31:                                               ; preds = %27
  %32 = icmp sgt i32 %29, 15
  br i1 %32, label %33, label %36

33:                                               ; preds = %31
  %34 = mul nsw i32 %28, 7
  store i32 %34, i32* %1, align 4, !tbaa !4
  %35 = mul i32 %20, 144
  br label %41

36:                                               ; preds = %31
  %37 = mul nsw i32 %28, 5
  %38 = add nsw i32 %37, 4
  store i32 %38, i32* %1, align 4, !tbaa !4
  %39 = mul i32 %20, 144
  %40 = or i32 %39, 3
  br label %41

41:                                               ; preds = %36, %33
  %42 = phi i32 [ %40, %36 ], [ %35, %33 ]
  store i32 %42, i32* %2, align 4, !tbaa !4
  %43 = load i32, i32* %1, align 4, !tbaa !4
  %44 = add nsw i32 %43, %42
  store i32 %44, i32* %1, align 4, !tbaa !4
  %45 = mul nsw i32 %44, %42
  store i32 %45, i32* %2, align 4, !tbaa !4
  br label %61

46:                                               ; preds = %25
  %47 = add nsw i32 %21, 12
  store i32 %47, i32* %1, align 4, !tbaa !4
  %48 = mul i32 %20, 36
  store i32 %48, i32* %2, align 4, !tbaa !4
  %49 = icmp sgt i32 %48, 16
  br i1 %49, label %50, label %53

50:                                               ; preds = %46
  %51 = add nsw i32 %21, 17
  store i32 %51, i32* %1, align 4, !tbaa !4
  %52 = add nsw i32 %48, 7
  store i32 %52, i32* %2, align 4, !tbaa !4
  br label %56

53:                                               ; preds = %46
  %54 = shl nsw i32 %47, 2
  store i32 %54, i32* %1, align 4, !tbaa !4
  %55 = mul i32 %20, 216
  store i32 %55, i32* %2, align 4, !tbaa !4
  br label %56

56:                                               ; preds = %50, %53, %27
  %57 = load i32, i32* %1, align 4, !tbaa !4
  %58 = add nsw i32 %57, 7
  store i32 %58, i32* %1, align 4, !tbaa !4
  %59 = load i32, i32* %2, align 4, !tbaa !4
  %60 = add nsw i32 %59, 6
  store i32 %60, i32* %2, align 4, !tbaa !4
  br label %61

61:                                               ; preds = %56, %41, %19
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #6
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #6
  ret i32 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn mustprogress
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

declare nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16), i32* nonnull align 4 dereferenceable(4)) local_unnamed_addr #0

; Function Attrs: argmemonly nofree nosync nounwind willreturn mustprogress
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #5 section ".text.startup" {
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %1 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* nonnull @__dso_handle) #6
  ret void
}

attributes #0 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind }
attributes #3 = { norecurse uwtable mustprogress "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nofree nosync nounwind willreturn mustprogress }
attributes #5 = { uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{!"clang version 13.0.0 (https://github.com/HPSSA-LLVM/llvm-project 131343d35bf2ce55001fdd9c4cdf2965b56f26d8)"}
!4 = !{!5, !5, i64 0}
!5 = !{!"int", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C++ TBAA"}
