; ModuleID = 'IR/BC/test.bc'
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
bb:
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  %i2 = bitcast i32* %i to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %i2) #6
  %i3 = bitcast i32* %i1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %i3) #6
  %i4 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) @_ZSt3cin, i32* nonnull align 4 dereferenceable(4) %i)
  %i5 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %i4, i32* nonnull align 4 dereferenceable(4) %i1)
  %i6 = load i32, i32* %i, align 4, !tbaa !4
  %i7 = icmp sgt i32 %i6, 5
  br i1 %i7, label %bb8, label %bb14

bb8:                                              ; preds = %bb
  %i9 = mul nsw i32 %i6, 9
  %i10 = add nsw i32 %i9, 6
  store i32 %i10, i32* %i, align 4, !tbaa !4
  %i11 = load i32, i32* %i1, align 4, !tbaa !4
  %i12 = mul nsw i32 %i11, 3
  %i13 = add nsw i32 %i12, 1
  br label %bb18

bb14:                                             ; preds = %bb
  %i15 = add nsw i32 %i6, 8
  store i32 %i15, i32* %i, align 4, !tbaa !4
  %i16 = load i32, i32* %i1, align 4, !tbaa !4
  %i17 = add nsw i32 %i16, 9
  br label %bb18

bb18:                                             ; preds = %bb14, %bb8
  %i19 = phi i32 [ %i17, %bb14 ], [ %i13, %bb8 ]
  store i32 %i19, i32* %i1, align 4, !tbaa !4
  %i20 = load i32, i32* %i, align 4, !tbaa !4
  %i21 = add nsw i32 %i20, 7
  store i32 %i21, i32* %i, align 4, !tbaa !4
  %i22 = mul nsw i32 %i19, 6
  store i32 %i22, i32* %i1, align 4, !tbaa !4
  %i23 = icmp sgt i32 %i22, 6
  br i1 %i23, label %bb60, label %bb24

bb24:                                             ; preds = %bb18
  %i25 = icmp sgt i32 %i20, 2
  br i1 %i25, label %bb26, label %bb45

bb26:                                             ; preds = %bb24
  %i27 = add nsw i32 %i20, 14
  store i32 %i27, i32* %i, align 4, !tbaa !4
  %i28 = mul i32 %i19, 36
  store i32 %i28, i32* %i1, align 4, !tbaa !4
  %i29 = icmp eq i32 %i21, 10
  br i1 %i29, label %bb55, label %bb30

bb30:                                             ; preds = %bb26
  %i31 = icmp sgt i32 %i28, 15
  br i1 %i31, label %bb32, label %bb35

bb32:                                             ; preds = %bb30
  %i33 = mul nsw i32 %i27, 7
  store i32 %i33, i32* %i, align 4, !tbaa !4
  %i34 = mul i32 %i19, 144
  br label %bb40

bb35:                                             ; preds = %bb30
  %i36 = mul nsw i32 %i27, 5
  %i37 = add nsw i32 %i36, 4
  store i32 %i37, i32* %i, align 4, !tbaa !4
  %i38 = mul i32 %i19, 144
  %i39 = or i32 %i38, 3
  br label %bb40

bb40:                                             ; preds = %bb35, %bb32
  %i41 = phi i32 [ %i39, %bb35 ], [ %i34, %bb32 ]
  store i32 %i41, i32* %i1, align 4, !tbaa !4
  %i42 = load i32, i32* %i, align 4, !tbaa !4
  %i43 = add nsw i32 %i42, %i41
  store i32 %i43, i32* %i, align 4, !tbaa !4
  %i44 = mul nsw i32 %i43, %i41
  store i32 %i44, i32* %i1, align 4, !tbaa !4
  br label %bb60

bb45:                                             ; preds = %bb24
  %i46 = add nsw i32 %i20, 12
  store i32 %i46, i32* %i, align 4, !tbaa !4
  %i47 = mul i32 %i19, 36
  store i32 %i47, i32* %i1, align 4, !tbaa !4
  %i48 = icmp sgt i32 %i47, 16
  br i1 %i48, label %bb49, label %bb52

bb49:                                             ; preds = %bb45
  %i50 = add nsw i32 %i20, 17
  store i32 %i50, i32* %i, align 4, !tbaa !4
  %i51 = add nsw i32 %i47, 7
  store i32 %i51, i32* %i1, align 4, !tbaa !4
  br label %bb55

bb52:                                             ; preds = %bb45
  %i53 = shl nsw i32 %i46, 2
  store i32 %i53, i32* %i, align 4, !tbaa !4
  %i54 = mul i32 %i19, 216
  store i32 %i54, i32* %i1, align 4, !tbaa !4
  br label %bb55

bb55:                                             ; preds = %bb49, %bb52, %bb26
  %i56 = load i32, i32* %i, align 4, !tbaa !4
  %i57 = add nsw i32 %i56, 7
  store i32 %i57, i32* %i, align 4, !tbaa !4
  %i58 = load i32, i32* %i1, align 4, !tbaa !4
  %i59 = add nsw i32 %i58, 6
  store i32 %i59, i32* %i1, align 4, !tbaa !4
  br label %bb60

bb60:                                             ; preds = %bb55, %bb40, %bb18
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %i3) #6
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %i2) #6
  ret i32 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

declare nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16), i32* nonnull align 4 dereferenceable(4)) local_unnamed_addr #0

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #5 section ".text.startup" {
bb:
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %i = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* nonnull @__dso_handle) #6
  ret void
}

attributes #0 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind }
attributes #3 = { norecurse uwtable mustprogress "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nofree nosync nounwind willreturn }
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
