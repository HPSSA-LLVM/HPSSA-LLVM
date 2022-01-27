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
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %i = bitcast i32* %a to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %i) #6
  %i1 = bitcast i32* %b to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %i1) #6
  %call = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) @_ZSt3cin, i32* nonnull align 4 dereferenceable(4) %a)
  %call1 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %call, i32* nonnull align 4 dereferenceable(4) %b)
  %i2 = load i32, i32* %a, align 4, !tbaa !4
  %cmp = icmp sgt i32 %i2, 5
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %mul = mul nsw i32 %i2, 9
  %add = add nsw i32 %mul, 6
  store i32 %add, i32* %a, align 4, !tbaa !4
  %i3 = load i32, i32* %b, align 4, !tbaa !4
  %mul2 = mul nsw i32 %i3, 3
  %add3 = add nsw i32 %mul2, 1
  br label %if.end

if.else:                                          ; preds = %entry
  %add4 = add nsw i32 %i2, 8
  store i32 %add4, i32* %a, align 4, !tbaa !4
  %i4 = load i32, i32* %b, align 4, !tbaa !4
  %add5 = add nsw i32 %i4, 9
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %storemerge = phi i32 [ %add5, %if.else ], [ %add3, %if.then ]
  store i32 %storemerge, i32* %b, align 4, !tbaa !4
  %i5 = load i32, i32* %a, align 4, !tbaa !4
  %add6 = add nsw i32 %i5, 7
  store i32 %add6, i32* %a, align 4, !tbaa !4
  %mul7 = mul nsw i32 %storemerge, 6
  store i32 %mul7, i32* %b, align 4, !tbaa !4
  %cmp8 = icmp sgt i32 %mul7, 6
  br i1 %cmp8, label %end_label, label %if.else10

if.else10:                                        ; preds = %if.end
  %cmp11 = icmp sgt i32 %i5, 2
  br i1 %cmp11, label %if.then12, label %if.else30

if.then12:                                        ; preds = %if.else10
  %add13 = add nsw i32 %i5, 14
  store i32 %add13, i32* %a, align 4, !tbaa !4
  %mul14 = mul i32 %storemerge, 36
  store i32 %mul14, i32* %b, align 4, !tbaa !4
  %cmp15 = icmp eq i32 %add6, 10
  br i1 %cmp15, label %new_label, label %if.end17

if.end17:                                         ; preds = %if.then12
  %cmp18 = icmp sgt i32 %mul14, 15
  br i1 %cmp18, label %if.then19, label %if.else22

if.then19:                                        ; preds = %if.end17
  %mul20 = mul nsw i32 %add13, 7
  store i32 %mul20, i32* %a, align 4, !tbaa !4
  %mul21 = mul i32 %storemerge, 144
  br label %if.end27

if.else22:                                        ; preds = %if.end17
  %mul23 = mul nsw i32 %add13, 5
  %add24 = add nsw i32 %mul23, 4
  store i32 %add24, i32* %a, align 4, !tbaa !4
  %mul25 = mul i32 %storemerge, 144
  %add26 = or i32 %mul25, 3
  br label %if.end27

if.end27:                                         ; preds = %if.else22, %if.then19
  %storemerge48 = phi i32 [ %add26, %if.else22 ], [ %mul21, %if.then19 ]
  store i32 %storemerge48, i32* %b, align 4, !tbaa !4
  %i6 = load i32, i32* %a, align 4, !tbaa !4
  %add28 = add nsw i32 %i6, %storemerge48
  store i32 %add28, i32* %a, align 4, !tbaa !4
  %mul29 = mul nsw i32 %add28, %storemerge48
  store i32 %mul29, i32* %b, align 4, !tbaa !4
  br label %end_label

if.else30:                                        ; preds = %if.else10
  %add31 = add nsw i32 %i5, 12
  store i32 %add31, i32* %a, align 4, !tbaa !4
  %mul32 = mul i32 %storemerge, 36
  store i32 %mul32, i32* %b, align 4, !tbaa !4
  %cmp33 = icmp sgt i32 %mul32, 16
  br i1 %cmp33, label %if.then34, label %if.else37

if.then34:                                        ; preds = %if.else30
  %add35 = add nsw i32 %i5, 17
  store i32 %add35, i32* %a, align 4, !tbaa !4
  %add36 = add nsw i32 %mul32, 7
  store i32 %add36, i32* %b, align 4, !tbaa !4
  br label %new_label

if.else37:                                        ; preds = %if.else30
  %mul38 = shl nsw i32 %add31, 2
  store i32 %mul38, i32* %a, align 4, !tbaa !4
  %mul39 = mul i32 %storemerge, 216
  store i32 %mul39, i32* %b, align 4, !tbaa !4
  br label %new_label

new_label:                                        ; preds = %if.then34, %if.else37, %if.then12
  %i7 = load i32, i32* %a, align 4, !tbaa !4
  %add41 = add nsw i32 %i7, 7
  store i32 %add41, i32* %a, align 4, !tbaa !4
  %i8 = load i32, i32* %b, align 4, !tbaa !4
  %add42 = add nsw i32 %i8, 6
  store i32 %add42, i32* %b, align 4, !tbaa !4
  br label %end_label

end_label:                                        ; preds = %new_label, %if.end27, %if.end
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %i1) #6
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %i) #6
  ret i32 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

declare nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16), i32* nonnull align 4 dereferenceable(4)) local_unnamed_addr #0

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #5 section ".text.startup" {
entry:
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
!3 = !{!"clang version 13.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)"}
!4 = !{!5, !5, i64 0}
!5 = !{!"int", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C++ TBAA"}
