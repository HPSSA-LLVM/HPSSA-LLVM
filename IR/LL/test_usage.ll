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
@_ZSt3cin = external global %"class.std::basic_istream", align 8
@_ZSt4cout = external global %"class.std::basic_ostream", align 8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_test.cpp, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nofree nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) local_unnamed_addr #2

; Function Attrs: mustprogress norecurse uwtable
define i32 @main() local_unnamed_addr #3 {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %i = bitcast i32* %a to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %i) #7
  %i1 = bitcast i32* %b to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %i1) #7
  %i2 = bitcast i32* %c to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %i2) #7
  %i3 = bitcast i32* %d to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %i3) #7
  %call = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) @_ZSt3cin, i32* nonnull align 4 dereferenceable(4) %a)
  %call1 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %call, i32* nonnull align 4 dereferenceable(4) %b)
  %call2 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %call1, i32* nonnull align 4 dereferenceable(4) %c)
  %call3 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %call2, i32* nonnull align 4 dereferenceable(4) %d)
  %call4 = call i32 @rand() #7
  %rem = srem i32 %call4, 100
  %cmp = icmp sgt i32 %rem, 89
  br i1 %cmp, label %if.then, label %if.else12

if.then:                                          ; preds = %entry
  %call5 = call i32 @rand() #7
  %rem6 = srem i32 %call5, 50
  %i4 = load i32, i32* %a, align 4, !tbaa !4
  %mul = shl nsw i32 %i4, 1
  %cmp7.not = icmp slt i32 %rem6, %mul
  br i1 %cmp7.not, label %if.else, label %if.then8

if.then8:                                         ; preds = %if.then
  %i5 = load i32, i32* %b, align 4, !tbaa !4
  %sub = sub nsw i32 %i4, %i5
  store i32 137, i32* %b, align 4, !tbaa !4
  br label %if.end

if.else:                                          ; preds = %if.then
  %i6 = load i32, i32* %c, align 4, !tbaa !4
  %sub9 = sub nsw i32 111, %i6
  %i7 = load i32, i32* %b, align 4, !tbaa !4
  %sub10 = sub nsw i32 %i7, %i6
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then8
  %y.0 = phi i32 [ 63, %if.then8 ], [ %sub10, %if.else ]
  %x.0 = phi i32 [ %sub, %if.then8 ], [ %sub9, %if.else ]
  %tau1 = call i32 (...) @llvm.tau.i32(i32 %x.0, i32 %sub9)
  %tau = call i32 (...) @llvm.tau.i32(i32 %y.0, i32 %sub10)
  %add11 = add nsw i32 %tau1, 9354
  br label %if.end26

if.else12:                                        ; preds = %entry
  %i8 = load i32, i32* %a, align 4, !tbaa !4
  %call15 = call i32 @rand() #7
  %rem16 = srem i32 %call15, 70
  %i9 = load i32, i32* %a, align 4, !tbaa !4
  %mul17 = shl nsw i32 %i9, 1
  %cmp18.not = icmp slt i32 %rem16, %mul17
  br i1 %cmp18.not, label %if.else21, label %if.then19

if.then19:                                        ; preds = %if.else12
  %add14 = add nsw i32 %i8, 887
  %i10 = load i32, i32* %b, align 4, !tbaa !4
  %add20 = add nsw i32 %i10, %i9
  store i32 8568, i32* %b, align 4, !tbaa !4
  br label %if.end24

if.else21:                                        ; preds = %if.else12
  %i11 = load i32, i32* %c, align 4, !tbaa !4
  %add22 = add nsw i32 %i11, 932
  %i12 = load i32, i32* %b, align 4, !tbaa !4
  %add23 = add nsw i32 %i12, %i11
  br label %if.end24

if.end24:                                         ; preds = %if.else21, %if.then19
  %y.1 = phi i32 [ %add14, %if.then19 ], [ %add23, %if.else21 ]
  %x.1 = phi i32 [ %add20, %if.then19 ], [ %add22, %if.else21 ]
  %add25 = add nsw i32 %x.1, 1145
  br label %if.end26

if.end26:                                         ; preds = %if.end24, %if.end
  %storemerge = phi i32 [ %add25, %if.end24 ], [ %add11, %if.end ]
  %y.2 = phi i32 [ %y.1, %if.end24 ], [ %tau, %if.end ]
  %x.2 = phi i32 [ %x.1, %if.end24 ], [ %tau1, %if.end ]
  store i32 %storemerge, i32* %a, align 4, !tbaa !4
  %i13 = load i32, i32* %d, align 4, !tbaa !4
  %add29 = add nsw i32 %i13, %storemerge
  %call30 = call i32 @rand() #7
  %rem31 = srem i32 %call30, 60
  %cmp32 = icmp sgt i32 %add29, %rem31
  %i14 = load i32, i32* %a, align 4, !tbaa !4
  %add27 = add i32 %y.2, %storemerge
  %add28 = select i1 %cmp32, i32 %add27, i32 0
  %y.3.v = add i32 %x.2, %add28
  %y.3 = add i32 %i14, %y.3.v
  %add38 = add i32 %y.3, %x.2
  %add39 = add i32 %add38, %i14
  %call40 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 %add39)
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %i3) #7
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %i2) #7
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %i1) #7
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %i) #7
  ret i32 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

declare nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16), i32* nonnull align 4 dereferenceable(4)) local_unnamed_addr #0

; Function Attrs: nounwind
declare i32 @rand() local_unnamed_addr #1

declare nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i32) local_unnamed_addr #0

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #5 section ".text.startup" {
entry:
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %i = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* nonnull @__dso_handle) #7
  ret void
}

; Function Attrs: nofree nosync nounwind willreturn
declare i32 @llvm.tau.i32(...) #6

attributes #0 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind }
attributes #3 = { mustprogress norecurse uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nofree nosync nounwind willreturn }
attributes #5 = { uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nosync nounwind willreturn }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{!"clang version 14.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)"}
!4 = !{!5, !5, i64 0}
!5 = !{!"int", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C++ TBAA"}
