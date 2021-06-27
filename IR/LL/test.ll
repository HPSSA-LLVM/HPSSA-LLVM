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

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1, !dbg !0
@__dso_handle = external hidden global i8
@_ZSt3cin = external global %"class.std::basic_istream", align 8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_test.cpp, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nofree nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) local_unnamed_addr #2

; Function Attrs: norecurse uwtable mustprogress
define i32 @main() local_unnamed_addr #3 !dbg !985 {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %0 = bitcast i32* %a to i8*, !dbg !995
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0) #8, !dbg !995
  %1 = bitcast i32* %b to i8*, !dbg !995
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %1) #8, !dbg !995
  call void @llvm.dbg.value(metadata i32* %a, metadata !987, metadata !DIExpression(DW_OP_deref)), !dbg !996
  %call = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) @_ZSt3cin, i32* nonnull align 4 dereferenceable(4) %a), !dbg !997
  call void @llvm.dbg.value(metadata i32* %b, metadata !988, metadata !DIExpression(DW_OP_deref)), !dbg !996
  %call1 = call nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16) %call, i32* nonnull align 4 dereferenceable(4) %b), !dbg !998
  %2 = load i32, i32* %a, align 4, !dbg !999, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %2, metadata !987, metadata !DIExpression()), !dbg !996
  %cmp = icmp sgt i32 %2, 5, !dbg !1005
  br i1 %cmp, label %if.then, label %if.else, !dbg !1006

if.then:                                          ; preds = %entry
  %mul = mul nsw i32 %2, 9, !dbg !1007
  %add = add nsw i32 %mul, 6, !dbg !1009
  call void @llvm.dbg.value(metadata i32 %add, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %add, i32* %a, align 4, !dbg !1010, !tbaa !1001
  %3 = load i32, i32* %b, align 4, !dbg !1011, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %3, metadata !988, metadata !DIExpression()), !dbg !996
  %mul2 = mul nsw i32 %3, 3, !dbg !1012
  %add3 = add nsw i32 %mul2, 1, !dbg !1013
  call void @llvm.dbg.value(metadata i32 %add3, metadata !988, metadata !DIExpression()), !dbg !996
  br label %if.end, !dbg !1014

if.else:                                          ; preds = %entry
  %add4 = add nsw i32 %2, 8, !dbg !1015
  call void @llvm.dbg.value(metadata i32 %add4, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %add4, i32* %a, align 4, !dbg !1017, !tbaa !1001
  %4 = load i32, i32* %b, align 4, !dbg !1018, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %4, metadata !988, metadata !DIExpression()), !dbg !996
  %add5 = add nsw i32 %4, 9, !dbg !1019
  call void @llvm.dbg.value(metadata i32 %add5, metadata !988, metadata !DIExpression()), !dbg !996
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %storemerge = phi i32 [ %add5, %if.else ], [ %add3, %if.then ], !dbg !1020
  store i32 %storemerge, i32* %b, align 4, !dbg !1020, !tbaa !1001
  %5 = load i32, i32* %a, align 4, !dbg !1021, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %5, metadata !987, metadata !DIExpression()), !dbg !996
  %add6 = add nsw i32 %5, 7, !dbg !1022
  call void @llvm.dbg.value(metadata i32 %add6, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %add6, i32* %a, align 4, !dbg !1023, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %storemerge, metadata !988, metadata !DIExpression()), !dbg !996
  %mul7 = mul nsw i32 %storemerge, 6, !dbg !1024
  call void @llvm.dbg.value(metadata i32 %mul7, metadata !988, metadata !DIExpression()), !dbg !996
  store i32 %mul7, i32* %b, align 4, !dbg !1025, !tbaa !1001
  %cmp8 = icmp sgt i32 %mul7, 6, !dbg !1026
  br i1 %cmp8, label %end_label, label %if.else10, !dbg !1027

if.else10:                                        ; preds = %if.end
  call void @llvm.dbg.value(metadata i32 %add6, metadata !987, metadata !DIExpression()), !dbg !996
  %cmp11 = icmp sgt i32 %5, 2, !dbg !1028
  br i1 %cmp11, label %if.then12, label %if.else30, !dbg !1029

if.then12:                                        ; preds = %if.else10
  %add13 = add nsw i32 %5, 14, !dbg !1030
  call void @llvm.dbg.value(metadata i32 %add13, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %add13, i32* %a, align 4, !dbg !1032, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %mul7, metadata !988, metadata !DIExpression()), !dbg !996
  %mul14 = mul i32 %storemerge, 36, !dbg !1033
  call void @llvm.dbg.value(metadata i32 %mul14, metadata !988, metadata !DIExpression()), !dbg !996
  store i32 %mul14, i32* %b, align 4, !dbg !1034, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %add13, metadata !987, metadata !DIExpression()), !dbg !996
  %cmp15 = icmp eq i32 %add6, 10, !dbg !1035
  br i1 %cmp15, label %new_label, label %if.end17, !dbg !1037

if.end17:                                         ; preds = %if.then12
  %cmp18 = icmp sgt i32 %mul14, 15, !dbg !1038
  br i1 %cmp18, label %if.then19, label %if.else22, !dbg !1040

if.then19:                                        ; preds = %if.end17
  %mul20 = mul nsw i32 %add13, 7, !dbg !1041
  call void @llvm.dbg.value(metadata i32 %mul20, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %mul20, i32* %a, align 4, !dbg !1043, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %mul14, metadata !988, metadata !DIExpression()), !dbg !996
  %mul21 = mul i32 %storemerge, 144, !dbg !1044
  call void @llvm.dbg.value(metadata i32 %mul21, metadata !988, metadata !DIExpression()), !dbg !996
  br label %if.end27, !dbg !1045

if.else22:                                        ; preds = %if.end17
  %mul23 = mul nsw i32 %add13, 5, !dbg !1046
  %add24 = add nsw i32 %mul23, 4, !dbg !1048
  call void @llvm.dbg.value(metadata i32 %add24, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %add24, i32* %a, align 4, !dbg !1049, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %mul14, metadata !988, metadata !DIExpression()), !dbg !996
  %mul25 = mul i32 %storemerge, 144, !dbg !1050
  %add26 = or i32 %mul25, 3, !dbg !1051
  call void @llvm.dbg.value(metadata i32 %add26, metadata !988, metadata !DIExpression()), !dbg !996
  br label %if.end27

if.end27:                                         ; preds = %if.else22, %if.then19
  %storemerge48 = phi i32 [ %add26, %if.else22 ], [ %mul21, %if.then19 ], !dbg !1052
  store i32 %storemerge48, i32* %b, align 4, !dbg !1052, !tbaa !1001
  %6 = load i32, i32* %a, align 4, !dbg !1053, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %6, metadata !987, metadata !DIExpression()), !dbg !996
  call void @llvm.dbg.value(metadata i32 %storemerge48, metadata !988, metadata !DIExpression()), !dbg !996
  %add28 = add nsw i32 %6, %storemerge48, !dbg !1054
  call void @llvm.dbg.value(metadata i32 %add28, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %add28, i32* %a, align 4, !dbg !1055, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %storemerge48, metadata !988, metadata !DIExpression()), !dbg !996
  %mul29 = mul nsw i32 %add28, %storemerge48, !dbg !1056
  call void @llvm.dbg.value(metadata i32 %mul29, metadata !988, metadata !DIExpression()), !dbg !996
  store i32 %mul29, i32* %b, align 4, !dbg !1057, !tbaa !1001
  br label %end_label, !dbg !1058

if.else30:                                        ; preds = %if.else10
  %add31 = add nsw i32 %5, 12, !dbg !1059
  call void @llvm.dbg.value(metadata i32 %add31, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %add31, i32* %a, align 4, !dbg !1060, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %mul7, metadata !988, metadata !DIExpression()), !dbg !996
  %mul32 = mul i32 %storemerge, 36, !dbg !1061
  call void @llvm.dbg.value(metadata i32 %mul32, metadata !988, metadata !DIExpression()), !dbg !996
  store i32 %mul32, i32* %b, align 4, !dbg !1062, !tbaa !1001
  %cmp33 = icmp sgt i32 %mul32, 16, !dbg !1063
  call void @llvm.dbg.value(metadata i32 %add31, metadata !987, metadata !DIExpression()), !dbg !996
  call void @llvm.dbg.value(metadata i32 %add31, metadata !987, metadata !DIExpression()), !dbg !996
  br i1 %cmp33, label %if.then34, label %if.else37, !dbg !1065

if.then34:                                        ; preds = %if.else30
  %add35 = add nsw i32 %5, 17, !dbg !1066
  call void @llvm.dbg.value(metadata i32 %add35, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %add35, i32* %a, align 4, !dbg !1068, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %mul32, metadata !988, metadata !DIExpression()), !dbg !996
  %add36 = add nsw i32 %mul32, 7, !dbg !1069
  call void @llvm.dbg.value(metadata i32 %add36, metadata !988, metadata !DIExpression()), !dbg !996
  store i32 %add36, i32* %b, align 4, !dbg !1070, !tbaa !1001
  br label %new_label, !dbg !1071

if.else37:                                        ; preds = %if.else30
  %mul38 = shl nsw i32 %add31, 2, !dbg !1072
  call void @llvm.dbg.value(metadata i32 %mul38, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %mul38, i32* %a, align 4, !dbg !1074, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %mul32, metadata !988, metadata !DIExpression()), !dbg !996
  %mul39 = mul i32 %storemerge, 216, !dbg !1075
  call void @llvm.dbg.value(metadata i32 %mul39, metadata !988, metadata !DIExpression()), !dbg !996
  store i32 %mul39, i32* %b, align 4, !dbg !1076, !tbaa !1001
  br label %new_label

new_label:                                        ; preds = %if.then34, %if.else37, %if.then12
  call void @llvm.dbg.label(metadata !989), !dbg !1077
  %7 = load i32, i32* %a, align 4, !dbg !1078, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %7, metadata !987, metadata !DIExpression()), !dbg !996
  %add41 = add nsw i32 %7, 7, !dbg !1079
  call void @llvm.dbg.value(metadata i32 %add41, metadata !987, metadata !DIExpression()), !dbg !996
  store i32 %add41, i32* %a, align 4, !dbg !1080, !tbaa !1001
  %8 = load i32, i32* %b, align 4, !dbg !1081, !tbaa !1001
  call void @llvm.dbg.value(metadata i32 %8, metadata !988, metadata !DIExpression()), !dbg !996
  %add42 = add nsw i32 %8, 6, !dbg !1082
  call void @llvm.dbg.value(metadata i32 %add42, metadata !988, metadata !DIExpression()), !dbg !996
  store i32 %add42, i32* %b, align 4, !dbg !1083, !tbaa !1001
  br label %end_label

end_label:                                        ; preds = %new_label, %if.end27, %if.end
  call void @llvm.dbg.label(metadata !994), !dbg !1084
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %1) #8, !dbg !1085
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0) #8, !dbg !1085
  ret i32 0, !dbg !1086
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn mustprogress
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

declare nonnull align 8 dereferenceable(16) %"class.std::basic_istream"* @_ZNSirsERi(%"class.std::basic_istream"* nonnull align 8 dereferenceable(16), i32* nonnull align 4 dereferenceable(4)) local_unnamed_addr #0

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn mustprogress
declare void @llvm.dbg.label(metadata) #5

; Function Attrs: argmemonly nofree nosync nounwind willreturn mustprogress
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #6 section ".text.startup" !dbg !1087 {
entry:
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit), !dbg !1089
  %0 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* nonnull @__dso_handle) #8, !dbg !1093
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #7

attributes #0 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind }
attributes #3 = { norecurse uwtable mustprogress "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nofree nosync nounwind willreturn mustprogress }
attributes #5 = { nofree nosync nounwind readnone speculatable willreturn mustprogress }
attributes #6 = { uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #8 = { nounwind }

!llvm.dbg.cu = !{!28}
!llvm.module.flags = !{!979, !980, !981, !982, !983}
!llvm.ident = !{!984}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "__ioinit", linkageName: "_ZStL8__ioinit", scope: !2, file: !3, line: 74, type: !4, isLocal: true, isDefinition: true)
!2 = !DINamespace(name: "std", scope: null)
!3 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/iostream", directory: "")
!4 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "Init", scope: !6, file: !5, line: 603, size: 8, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !7, identifier: "_ZTSNSt8ios_base4InitE")
!5 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/ios_base.h", directory: "")
!6 = !DICompositeType(tag: DW_TAG_class_type, name: "ios_base", scope: !2, file: !5, line: 228, size: 1728, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt8ios_base")
!7 = !{!8, !12, !14, !18, !19, !24}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "_S_refcount", scope: !4, file: !5, line: 616, baseType: !9, flags: DIFlagStaticMember)
!9 = !DIDerivedType(tag: DW_TAG_typedef, name: "_Atomic_word", file: !10, line: 32, baseType: !11)
!10 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/x86_64-linux-gnu/c++/9/bits/atomic_word.h", directory: "")
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "_S_synced_with_stdio", scope: !4, file: !5, line: 617, baseType: !13, flags: DIFlagStaticMember)
!13 = !DIBasicType(name: "bool", size: 8, encoding: DW_ATE_boolean)
!14 = !DISubprogram(name: "Init", scope: !4, file: !5, line: 607, type: !15, scopeLine: 607, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17}
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!18 = !DISubprogram(name: "~Init", scope: !4, file: !5, line: 608, type: !15, scopeLine: 608, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!19 = !DISubprogram(name: "Init", scope: !4, file: !5, line: 611, type: !20, scopeLine: 611, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!20 = !DISubroutineType(types: !21)
!21 = !{null, !17, !22}
!22 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4)
!24 = !DISubprogram(name: "operator=", linkageName: "_ZNSt8ios_base4InitaSERKS0_", scope: !4, file: !5, line: 612, type: !25, scopeLine: 612, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!25 = !DISubroutineType(types: !26)
!26 = !{!27, !17, !22}
!27 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !4, size: 64)
!28 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !29, producer: "clang version 13.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !30, globals: !31, imports: !32, splitDebugInlining: false, nameTableKind: None)
!29 = !DIFile(filename: "tests/test.cpp", directory: "/home/muzzammil/HPSSA/HPSSA-LLVM")
!30 = !{}
!31 = !{!0}
!32 = !{!33, !52, !55, !60, !125, !133, !137, !144, !148, !152, !154, !156, !160, !169, !173, !179, !185, !187, !191, !195, !199, !203, !214, !216, !220, !224, !228, !230, !235, !239, !243, !245, !247, !251, !259, !263, !267, !271, !273, !279, !281, !288, !293, !297, !301, !305, !309, !313, !315, !317, !321, !325, !329, !331, !335, !339, !341, !343, !347, !353, !358, !363, !364, !365, !366, !367, !368, !369, !370, !371, !372, !373, !428, !432, !436, !441, !445, !448, !451, !454, !456, !458, !460, !463, !466, !469, !472, !475, !477, !482, !485, !488, !491, !493, !495, !497, !499, !502, !505, !508, !511, !514, !516, !520, !524, !529, !535, !537, !539, !541, !543, !545, !547, !549, !551, !553, !555, !557, !559, !561, !564, !566, !570, !574, !580, !584, !588, !593, !595, !600, !604, !608, !619, !621, !625, !629, !633, !637, !641, !645, !649, !653, !657, !661, !665, !667, !671, !675, !679, !685, !689, !693, !695, !699, !703, !709, !711, !715, !719, !723, !727, !731, !735, !739, !740, !741, !742, !744, !745, !746, !747, !748, !749, !750, !754, !760, !765, !769, !771, !773, !775, !777, !784, !788, !792, !796, !800, !804, !809, !813, !815, !819, !825, !829, !834, !836, !839, !843, !847, !849, !851, !853, !855, !859, !861, !863, !867, !871, !875, !879, !883, !887, !889, !893, !897, !901, !905, !907, !909, !913, !917, !918, !919, !920, !921, !922, !928, !931, !932, !934, !936, !938, !940, !944, !946, !948, !950, !952, !954, !956, !958, !960, !964, !968, !970, !974, !978}
!33 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !34, file: !51, line: 64)
!34 = !DIDerivedType(tag: DW_TAG_typedef, name: "mbstate_t", file: !35, line: 6, baseType: !36)
!35 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/mbstate_t.h", directory: "")
!36 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mbstate_t", file: !37, line: 21, baseType: !38)
!37 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h", directory: "")
!38 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !37, line: 13, size: 64, flags: DIFlagTypePassByValue, elements: !39, identifier: "_ZTS11__mbstate_t")
!39 = !{!40, !41}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "__count", scope: !38, file: !37, line: 15, baseType: !11, size: 32)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "__value", scope: !38, file: !37, line: 20, baseType: !42, size: 32, offset: 32)
!42 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !38, file: !37, line: 16, size: 32, flags: DIFlagTypePassByValue, elements: !43, identifier: "_ZTSN11__mbstate_tUt_E")
!43 = !{!44, !46}
!44 = !DIDerivedType(tag: DW_TAG_member, name: "__wch", scope: !42, file: !37, line: 18, baseType: !45, size: 32)
!45 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "__wchb", scope: !42, file: !37, line: 19, baseType: !47, size: 32)
!47 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 32, elements: !49)
!48 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!49 = !{!50}
!50 = !DISubrange(count: 4)
!51 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cwchar", directory: "")
!52 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !53, file: !51, line: 141)
!53 = !DIDerivedType(tag: DW_TAG_typedef, name: "wint_t", file: !54, line: 20, baseType: !45)
!54 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/wint_t.h", directory: "")
!55 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !56, file: !51, line: 143)
!56 = !DISubprogram(name: "btowc", scope: !57, file: !57, line: 318, type: !58, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!57 = !DIFile(filename: "/usr/include/wchar.h", directory: "")
!58 = !DISubroutineType(types: !59)
!59 = !{!53, !11}
!60 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !61, file: !51, line: 144)
!61 = !DISubprogram(name: "fgetwc", scope: !57, file: !57, line: 726, type: !62, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!62 = !DISubroutineType(types: !63)
!63 = !{!53, !64}
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = !DIDerivedType(tag: DW_TAG_typedef, name: "__FILE", file: !66, line: 5, baseType: !67)
!66 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__FILE.h", directory: "")
!67 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !68, line: 49, size: 1728, flags: DIFlagTypePassByValue, elements: !69, identifier: "_ZTS8_IO_FILE")
!68 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h", directory: "")
!69 = !{!70, !71, !73, !74, !75, !76, !77, !78, !79, !80, !81, !82, !83, !86, !88, !89, !90, !94, !96, !98, !102, !105, !107, !110, !113, !114, !116, !120, !121}
!70 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !67, file: !68, line: 51, baseType: !11, size: 32)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !67, file: !68, line: 54, baseType: !72, size: 64, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !67, file: !68, line: 55, baseType: !72, size: 64, offset: 128)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !67, file: !68, line: 56, baseType: !72, size: 64, offset: 192)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !67, file: !68, line: 57, baseType: !72, size: 64, offset: 256)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !67, file: !68, line: 58, baseType: !72, size: 64, offset: 320)
!77 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !67, file: !68, line: 59, baseType: !72, size: 64, offset: 384)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !67, file: !68, line: 60, baseType: !72, size: 64, offset: 448)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !67, file: !68, line: 61, baseType: !72, size: 64, offset: 512)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !67, file: !68, line: 64, baseType: !72, size: 64, offset: 576)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !67, file: !68, line: 65, baseType: !72, size: 64, offset: 640)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !67, file: !68, line: 66, baseType: !72, size: 64, offset: 704)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !67, file: !68, line: 68, baseType: !84, size: 64, offset: 768)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !68, line: 36, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS10_IO_marker")
!86 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !67, file: !68, line: 70, baseType: !87, size: 64, offset: 832)
!87 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !67, file: !68, line: 72, baseType: !11, size: 32, offset: 896)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !67, file: !68, line: 73, baseType: !11, size: 32, offset: 928)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !67, file: !68, line: 74, baseType: !91, size: 64, offset: 960)
!91 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !92, line: 152, baseType: !93)
!92 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "")
!93 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !67, file: !68, line: 77, baseType: !95, size: 16, offset: 1024)
!95 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !67, file: !68, line: 78, baseType: !97, size: 8, offset: 1040)
!97 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !67, file: !68, line: 79, baseType: !99, size: 8, offset: 1048)
!99 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 8, elements: !100)
!100 = !{!101}
!101 = !DISubrange(count: 1)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !67, file: !68, line: 81, baseType: !103, size: 64, offset: 1088)
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !68, line: 43, baseType: null)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !67, file: !68, line: 89, baseType: !106, size: 64, offset: 1152)
!106 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !92, line: 153, baseType: !93)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !67, file: !68, line: 91, baseType: !108, size: 64, offset: 1216)
!108 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !109, size: 64)
!109 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !68, line: 37, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS11_IO_codecvt")
!110 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !67, file: !68, line: 92, baseType: !111, size: 64, offset: 1280)
!111 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 64)
!112 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !68, line: 38, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS13_IO_wide_data")
!113 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !67, file: !68, line: 93, baseType: !87, size: 64, offset: 1344)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !67, file: !68, line: 94, baseType: !115, size: 64, offset: 1408)
!115 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !67, file: !68, line: 95, baseType: !117, size: 64, offset: 1472)
!117 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !118, line: 46, baseType: !119)
!118 = !DIFile(filename: "llvm-project/build/lib/clang/13.0.0/include/stddef.h", directory: "/home/muzzammil/HPSSA")
!119 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !67, file: !68, line: 96, baseType: !11, size: 32, offset: 1536)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !67, file: !68, line: 98, baseType: !122, size: 160, offset: 1568)
!122 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 160, elements: !123)
!123 = !{!124}
!124 = !DISubrange(count: 20)
!125 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !126, file: !51, line: 145)
!126 = !DISubprogram(name: "fgetws", scope: !57, file: !57, line: 755, type: !127, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!127 = !DISubroutineType(types: !128)
!128 = !{!129, !131, !11, !132}
!129 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !130, size: 64)
!130 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!131 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !129)
!132 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !64)
!133 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !134, file: !51, line: 146)
!134 = !DISubprogram(name: "fputwc", scope: !57, file: !57, line: 740, type: !135, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!135 = !DISubroutineType(types: !136)
!136 = !{!53, !130, !64}
!137 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !138, file: !51, line: 147)
!138 = !DISubprogram(name: "fputws", scope: !57, file: !57, line: 762, type: !139, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!139 = !DISubroutineType(types: !140)
!140 = !{!11, !141, !132}
!141 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !142)
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !143, size: 64)
!143 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !130)
!144 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !145, file: !51, line: 148)
!145 = !DISubprogram(name: "fwide", scope: !57, file: !57, line: 573, type: !146, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!146 = !DISubroutineType(types: !147)
!147 = !{!11, !64, !11}
!148 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !149, file: !51, line: 149)
!149 = !DISubprogram(name: "fwprintf", scope: !57, file: !57, line: 580, type: !150, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!150 = !DISubroutineType(types: !151)
!151 = !{!11, !132, !141, null}
!152 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !153, file: !51, line: 150)
!153 = !DISubprogram(name: "fwscanf", linkageName: "__isoc99_fwscanf", scope: !57, file: !57, line: 640, type: !150, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!154 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !155, file: !51, line: 151)
!155 = !DISubprogram(name: "getwc", scope: !57, file: !57, line: 727, type: !62, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !157, file: !51, line: 152)
!157 = !DISubprogram(name: "getwchar", scope: !57, file: !57, line: 733, type: !158, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!158 = !DISubroutineType(types: !159)
!159 = !{!53}
!160 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !161, file: !51, line: 153)
!161 = !DISubprogram(name: "mbrlen", scope: !57, file: !57, line: 329, type: !162, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!162 = !DISubroutineType(types: !163)
!163 = !{!117, !164, !117, !167}
!164 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !165)
!165 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !166, size: 64)
!166 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !48)
!167 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !168)
!168 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!169 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !170, file: !51, line: 154)
!170 = !DISubprogram(name: "mbrtowc", scope: !57, file: !57, line: 296, type: !171, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!171 = !DISubroutineType(types: !172)
!172 = !{!117, !131, !164, !117, !167}
!173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !174, file: !51, line: 155)
!174 = !DISubprogram(name: "mbsinit", scope: !57, file: !57, line: 292, type: !175, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!175 = !DISubroutineType(types: !176)
!176 = !{!11, !177}
!177 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !178, size: 64)
!178 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !34)
!179 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !180, file: !51, line: 156)
!180 = !DISubprogram(name: "mbsrtowcs", scope: !57, file: !57, line: 337, type: !181, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!181 = !DISubroutineType(types: !182)
!182 = !{!117, !131, !183, !117, !167}
!183 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !184)
!184 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !165, size: 64)
!185 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !186, file: !51, line: 157)
!186 = !DISubprogram(name: "putwc", scope: !57, file: !57, line: 741, type: !135, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!187 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !188, file: !51, line: 158)
!188 = !DISubprogram(name: "putwchar", scope: !57, file: !57, line: 747, type: !189, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!189 = !DISubroutineType(types: !190)
!190 = !{!53, !130}
!191 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !192, file: !51, line: 160)
!192 = !DISubprogram(name: "swprintf", scope: !57, file: !57, line: 590, type: !193, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!193 = !DISubroutineType(types: !194)
!194 = !{!11, !131, !117, !141, null}
!195 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !196, file: !51, line: 162)
!196 = !DISubprogram(name: "swscanf", linkageName: "__isoc99_swscanf", scope: !57, file: !57, line: 647, type: !197, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!197 = !DISubroutineType(types: !198)
!198 = !{!11, !141, !141, null}
!199 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !200, file: !51, line: 163)
!200 = !DISubprogram(name: "ungetwc", scope: !57, file: !57, line: 770, type: !201, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!201 = !DISubroutineType(types: !202)
!202 = !{!53, !53, !64}
!203 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !204, file: !51, line: 164)
!204 = !DISubprogram(name: "vfwprintf", scope: !57, file: !57, line: 598, type: !205, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!205 = !DISubroutineType(types: !206)
!206 = !{!11, !132, !141, !207}
!207 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !208, size: 64)
!208 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", size: 192, flags: DIFlagTypePassByValue, elements: !209, identifier: "_ZTS13__va_list_tag")
!209 = !{!210, !211, !212, !213}
!210 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !208, file: !29, baseType: !45, size: 32)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !208, file: !29, baseType: !45, size: 32, offset: 32)
!212 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !208, file: !29, baseType: !115, size: 64, offset: 64)
!213 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !208, file: !29, baseType: !115, size: 64, offset: 128)
!214 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !215, file: !51, line: 166)
!215 = !DISubprogram(name: "vfwscanf", linkageName: "__isoc99_vfwscanf", scope: !57, file: !57, line: 693, type: !205, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!216 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !217, file: !51, line: 169)
!217 = !DISubprogram(name: "vswprintf", scope: !57, file: !57, line: 611, type: !218, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!218 = !DISubroutineType(types: !219)
!219 = !{!11, !131, !117, !141, !207}
!220 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !221, file: !51, line: 172)
!221 = !DISubprogram(name: "vswscanf", linkageName: "__isoc99_vswscanf", scope: !57, file: !57, line: 700, type: !222, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!222 = !DISubroutineType(types: !223)
!223 = !{!11, !141, !141, !207}
!224 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !225, file: !51, line: 174)
!225 = !DISubprogram(name: "vwprintf", scope: !57, file: !57, line: 606, type: !226, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!226 = !DISubroutineType(types: !227)
!227 = !{!11, !141, !207}
!228 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !229, file: !51, line: 176)
!229 = !DISubprogram(name: "vwscanf", linkageName: "__isoc99_vwscanf", scope: !57, file: !57, line: 697, type: !226, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!230 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !231, file: !51, line: 178)
!231 = !DISubprogram(name: "wcrtomb", scope: !57, file: !57, line: 301, type: !232, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!232 = !DISubroutineType(types: !233)
!233 = !{!117, !234, !130, !167}
!234 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !72)
!235 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !236, file: !51, line: 179)
!236 = !DISubprogram(name: "wcscat", scope: !57, file: !57, line: 97, type: !237, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!237 = !DISubroutineType(types: !238)
!238 = !{!129, !131, !141}
!239 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !240, file: !51, line: 180)
!240 = !DISubprogram(name: "wcscmp", scope: !57, file: !57, line: 106, type: !241, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!241 = !DISubroutineType(types: !242)
!242 = !{!11, !142, !142}
!243 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !244, file: !51, line: 181)
!244 = !DISubprogram(name: "wcscoll", scope: !57, file: !57, line: 131, type: !241, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !246, file: !51, line: 182)
!246 = !DISubprogram(name: "wcscpy", scope: !57, file: !57, line: 87, type: !237, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!247 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !248, file: !51, line: 183)
!248 = !DISubprogram(name: "wcscspn", scope: !57, file: !57, line: 187, type: !249, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!249 = !DISubroutineType(types: !250)
!250 = !{!117, !142, !142}
!251 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !252, file: !51, line: 184)
!252 = !DISubprogram(name: "wcsftime", scope: !57, file: !57, line: 834, type: !253, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!253 = !DISubroutineType(types: !254)
!254 = !{!117, !131, !117, !141, !255}
!255 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !256)
!256 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!257 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !258)
!258 = !DICompositeType(tag: DW_TAG_structure_type, name: "tm", file: !57, line: 83, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS2tm")
!259 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !260, file: !51, line: 185)
!260 = !DISubprogram(name: "wcslen", scope: !57, file: !57, line: 222, type: !261, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!261 = !DISubroutineType(types: !262)
!262 = !{!117, !142}
!263 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !264, file: !51, line: 186)
!264 = !DISubprogram(name: "wcsncat", scope: !57, file: !57, line: 101, type: !265, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!265 = !DISubroutineType(types: !266)
!266 = !{!129, !131, !141, !117}
!267 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !268, file: !51, line: 187)
!268 = !DISubprogram(name: "wcsncmp", scope: !57, file: !57, line: 109, type: !269, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!269 = !DISubroutineType(types: !270)
!270 = !{!11, !142, !142, !117}
!271 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !272, file: !51, line: 188)
!272 = !DISubprogram(name: "wcsncpy", scope: !57, file: !57, line: 92, type: !265, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!273 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !274, file: !51, line: 189)
!274 = !DISubprogram(name: "wcsrtombs", scope: !57, file: !57, line: 343, type: !275, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!275 = !DISubroutineType(types: !276)
!276 = !{!117, !234, !277, !117, !167}
!277 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !278)
!278 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !142, size: 64)
!279 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !280, file: !51, line: 190)
!280 = !DISubprogram(name: "wcsspn", scope: !57, file: !57, line: 191, type: !249, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!281 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !282, file: !51, line: 191)
!282 = !DISubprogram(name: "wcstod", scope: !57, file: !57, line: 377, type: !283, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!283 = !DISubroutineType(types: !284)
!284 = !{!285, !141, !286}
!285 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!286 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !287)
!287 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !129, size: 64)
!288 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !289, file: !51, line: 193)
!289 = !DISubprogram(name: "wcstof", scope: !57, file: !57, line: 382, type: !290, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!290 = !DISubroutineType(types: !291)
!291 = !{!292, !141, !286}
!292 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!293 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !294, file: !51, line: 195)
!294 = !DISubprogram(name: "wcstok", scope: !57, file: !57, line: 217, type: !295, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!295 = !DISubroutineType(types: !296)
!296 = !{!129, !131, !141, !286}
!297 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !298, file: !51, line: 196)
!298 = !DISubprogram(name: "wcstol", scope: !57, file: !57, line: 428, type: !299, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!299 = !DISubroutineType(types: !300)
!300 = !{!93, !141, !286, !11}
!301 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !302, file: !51, line: 197)
!302 = !DISubprogram(name: "wcstoul", scope: !57, file: !57, line: 433, type: !303, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!303 = !DISubroutineType(types: !304)
!304 = !{!119, !141, !286, !11}
!305 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !306, file: !51, line: 198)
!306 = !DISubprogram(name: "wcsxfrm", scope: !57, file: !57, line: 135, type: !307, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!307 = !DISubroutineType(types: !308)
!308 = !{!117, !131, !141, !117}
!309 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !310, file: !51, line: 199)
!310 = !DISubprogram(name: "wctob", scope: !57, file: !57, line: 324, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!311 = !DISubroutineType(types: !312)
!312 = !{!11, !53}
!313 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !314, file: !51, line: 200)
!314 = !DISubprogram(name: "wmemcmp", scope: !57, file: !57, line: 258, type: !269, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!315 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !316, file: !51, line: 201)
!316 = !DISubprogram(name: "wmemcpy", scope: !57, file: !57, line: 262, type: !265, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!317 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !318, file: !51, line: 202)
!318 = !DISubprogram(name: "wmemmove", scope: !57, file: !57, line: 267, type: !319, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!319 = !DISubroutineType(types: !320)
!320 = !{!129, !129, !142, !117}
!321 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !322, file: !51, line: 203)
!322 = !DISubprogram(name: "wmemset", scope: !57, file: !57, line: 271, type: !323, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!323 = !DISubroutineType(types: !324)
!324 = !{!129, !129, !130, !117}
!325 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !326, file: !51, line: 204)
!326 = !DISubprogram(name: "wprintf", scope: !57, file: !57, line: 587, type: !327, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!327 = !DISubroutineType(types: !328)
!328 = !{!11, !141, null}
!329 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !330, file: !51, line: 205)
!330 = !DISubprogram(name: "wscanf", linkageName: "__isoc99_wscanf", scope: !57, file: !57, line: 644, type: !327, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!331 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !332, file: !51, line: 206)
!332 = !DISubprogram(name: "wcschr", scope: !57, file: !57, line: 164, type: !333, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!333 = !DISubroutineType(types: !334)
!334 = !{!129, !142, !130}
!335 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !336, file: !51, line: 207)
!336 = !DISubprogram(name: "wcspbrk", scope: !57, file: !57, line: 201, type: !337, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!337 = !DISubroutineType(types: !338)
!338 = !{!129, !142, !142}
!339 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !340, file: !51, line: 208)
!340 = !DISubprogram(name: "wcsrchr", scope: !57, file: !57, line: 174, type: !333, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!341 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !342, file: !51, line: 209)
!342 = !DISubprogram(name: "wcsstr", scope: !57, file: !57, line: 212, type: !337, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!343 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !344, file: !51, line: 210)
!344 = !DISubprogram(name: "wmemchr", scope: !57, file: !57, line: 253, type: !345, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!345 = !DISubroutineType(types: !346)
!346 = !{!129, !142, !130, !117}
!347 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !349, file: !51, line: 251)
!348 = !DINamespace(name: "__gnu_cxx", scope: null)
!349 = !DISubprogram(name: "wcstold", scope: !57, file: !57, line: 384, type: !350, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!350 = !DISubroutineType(types: !351)
!351 = !{!352, !141, !286}
!352 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!353 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !354, file: !51, line: 260)
!354 = !DISubprogram(name: "wcstoll", scope: !57, file: !57, line: 441, type: !355, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!355 = !DISubroutineType(types: !356)
!356 = !{!357, !141, !286, !11}
!357 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!358 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !359, file: !51, line: 261)
!359 = !DISubprogram(name: "wcstoull", scope: !57, file: !57, line: 448, type: !360, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!360 = !DISubroutineType(types: !361)
!361 = !{!362, !141, !286, !11}
!362 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!363 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !349, file: !51, line: 267)
!364 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !354, file: !51, line: 268)
!365 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !359, file: !51, line: 269)
!366 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !289, file: !51, line: 283)
!367 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !215, file: !51, line: 286)
!368 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !221, file: !51, line: 289)
!369 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !229, file: !51, line: 292)
!370 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !349, file: !51, line: 296)
!371 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !354, file: !51, line: 297)
!372 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !359, file: !51, line: 298)
!373 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !374, file: !375, line: 57)
!374 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "exception_ptr", scope: !376, file: !375, line: 79, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !377, identifier: "_ZTSNSt15__exception_ptr13exception_ptrE")
!375 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/exception_ptr.h", directory: "")
!376 = !DINamespace(name: "__exception_ptr", scope: !2)
!377 = !{!378, !379, !383, !386, !387, !392, !393, !397, !403, !407, !411, !414, !415, !418, !421}
!378 = !DIDerivedType(tag: DW_TAG_member, name: "_M_exception_object", scope: !374, file: !375, line: 81, baseType: !115, size: 64)
!379 = !DISubprogram(name: "exception_ptr", scope: !374, file: !375, line: 83, type: !380, scopeLine: 83, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!380 = !DISubroutineType(types: !381)
!381 = !{null, !382, !115}
!382 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !374, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!383 = !DISubprogram(name: "_M_addref", linkageName: "_ZNSt15__exception_ptr13exception_ptr9_M_addrefEv", scope: !374, file: !375, line: 85, type: !384, scopeLine: 85, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!384 = !DISubroutineType(types: !385)
!385 = !{null, !382}
!386 = !DISubprogram(name: "_M_release", linkageName: "_ZNSt15__exception_ptr13exception_ptr10_M_releaseEv", scope: !374, file: !375, line: 86, type: !384, scopeLine: 86, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!387 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt15__exception_ptr13exception_ptr6_M_getEv", scope: !374, file: !375, line: 88, type: !388, scopeLine: 88, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!388 = !DISubroutineType(types: !389)
!389 = !{!115, !390}
!390 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !391, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!391 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !374)
!392 = !DISubprogram(name: "exception_ptr", scope: !374, file: !375, line: 96, type: !384, scopeLine: 96, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!393 = !DISubprogram(name: "exception_ptr", scope: !374, file: !375, line: 98, type: !394, scopeLine: 98, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!394 = !DISubroutineType(types: !395)
!395 = !{null, !382, !396}
!396 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !391, size: 64)
!397 = !DISubprogram(name: "exception_ptr", scope: !374, file: !375, line: 101, type: !398, scopeLine: 101, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!398 = !DISubroutineType(types: !399)
!399 = !{null, !382, !400}
!400 = !DIDerivedType(tag: DW_TAG_typedef, name: "nullptr_t", scope: !2, file: !401, line: 258, baseType: !402)
!401 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/x86_64-linux-gnu/c++/9/bits/c++config.h", directory: "")
!402 = !DIBasicType(tag: DW_TAG_unspecified_type, name: "decltype(nullptr)")
!403 = !DISubprogram(name: "exception_ptr", scope: !374, file: !375, line: 105, type: !404, scopeLine: 105, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!404 = !DISubroutineType(types: !405)
!405 = !{null, !382, !406}
!406 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !374, size: 64)
!407 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__exception_ptr13exception_ptraSERKS0_", scope: !374, file: !375, line: 118, type: !408, scopeLine: 118, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!408 = !DISubroutineType(types: !409)
!409 = !{!410, !382, !396}
!410 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !374, size: 64)
!411 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__exception_ptr13exception_ptraSEOS0_", scope: !374, file: !375, line: 122, type: !412, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!412 = !DISubroutineType(types: !413)
!413 = !{!410, !382, !406}
!414 = !DISubprogram(name: "~exception_ptr", scope: !374, file: !375, line: 129, type: !384, scopeLine: 129, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!415 = !DISubprogram(name: "swap", linkageName: "_ZNSt15__exception_ptr13exception_ptr4swapERS0_", scope: !374, file: !375, line: 132, type: !416, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!416 = !DISubroutineType(types: !417)
!417 = !{null, !382, !410}
!418 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt15__exception_ptr13exception_ptrcvbEv", scope: !374, file: !375, line: 144, type: !419, scopeLine: 144, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!419 = !DISubroutineType(types: !420)
!420 = !{!13, !390}
!421 = !DISubprogram(name: "__cxa_exception_type", linkageName: "_ZNKSt15__exception_ptr13exception_ptr20__cxa_exception_typeEv", scope: !374, file: !375, line: 153, type: !422, scopeLine: 153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: DISPFlagOptimized)
!422 = !DISubroutineType(types: !423)
!423 = !{!424, !390}
!424 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !425, size: 64)
!425 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !426)
!426 = !DICompositeType(tag: DW_TAG_class_type, name: "type_info", scope: !2, file: !427, line: 88, size: 128, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSSt9type_info")
!427 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/typeinfo", directory: "")
!428 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !376, entity: !429, file: !375, line: 73)
!429 = !DISubprogram(name: "rethrow_exception", linkageName: "_ZSt17rethrow_exceptionNSt15__exception_ptr13exception_ptrE", scope: !2, file: !375, line: 69, type: !430, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!430 = !DISubroutineType(types: !431)
!431 = !{null, !374}
!432 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !433, entity: !434, file: !435, line: 58)
!433 = !DINamespace(name: "__gnu_debug", scope: null)
!434 = !DINamespace(name: "__debug", scope: !2)
!435 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/debug/debug.h", directory: "")
!436 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !437, file: !440, line: 47)
!437 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !438, line: 24, baseType: !439)
!438 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "")
!439 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !92, line: 37, baseType: !97)
!440 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdint", directory: "")
!441 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !442, file: !440, line: 48)
!442 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !438, line: 25, baseType: !443)
!443 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !92, line: 39, baseType: !444)
!444 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!445 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !446, file: !440, line: 49)
!446 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !438, line: 26, baseType: !447)
!447 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !92, line: 41, baseType: !11)
!448 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !449, file: !440, line: 50)
!449 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !438, line: 27, baseType: !450)
!450 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !92, line: 44, baseType: !93)
!451 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !452, file: !440, line: 52)
!452 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !453, line: 58, baseType: !97)
!453 = !DIFile(filename: "/usr/include/stdint.h", directory: "")
!454 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !455, file: !440, line: 53)
!455 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !453, line: 60, baseType: !93)
!456 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !457, file: !440, line: 54)
!457 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !453, line: 61, baseType: !93)
!458 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !459, file: !440, line: 55)
!459 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !453, line: 62, baseType: !93)
!460 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !461, file: !440, line: 57)
!461 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !453, line: 43, baseType: !462)
!462 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least8_t", file: !92, line: 52, baseType: !439)
!463 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !464, file: !440, line: 58)
!464 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !453, line: 44, baseType: !465)
!465 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least16_t", file: !92, line: 54, baseType: !443)
!466 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !467, file: !440, line: 59)
!467 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !453, line: 45, baseType: !468)
!468 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least32_t", file: !92, line: 56, baseType: !447)
!469 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !470, file: !440, line: 60)
!470 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !453, line: 46, baseType: !471)
!471 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least64_t", file: !92, line: 58, baseType: !450)
!472 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !473, file: !440, line: 62)
!473 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !453, line: 101, baseType: !474)
!474 = !DIDerivedType(tag: DW_TAG_typedef, name: "__intmax_t", file: !92, line: 72, baseType: !93)
!475 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !476, file: !440, line: 63)
!476 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !453, line: 87, baseType: !93)
!477 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !478, file: !440, line: 65)
!478 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !479, line: 24, baseType: !480)
!479 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "")
!480 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !92, line: 38, baseType: !481)
!481 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!482 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !483, file: !440, line: 66)
!483 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !479, line: 25, baseType: !484)
!484 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !92, line: 40, baseType: !95)
!485 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !486, file: !440, line: 67)
!486 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !479, line: 26, baseType: !487)
!487 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !92, line: 42, baseType: !45)
!488 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !489, file: !440, line: 68)
!489 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !479, line: 27, baseType: !490)
!490 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !92, line: 45, baseType: !119)
!491 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !492, file: !440, line: 70)
!492 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !453, line: 71, baseType: !481)
!493 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !494, file: !440, line: 71)
!494 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !453, line: 73, baseType: !119)
!495 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !496, file: !440, line: 72)
!496 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !453, line: 74, baseType: !119)
!497 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !498, file: !440, line: 73)
!498 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !453, line: 75, baseType: !119)
!499 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !500, file: !440, line: 75)
!500 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !453, line: 49, baseType: !501)
!501 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least8_t", file: !92, line: 53, baseType: !480)
!502 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !503, file: !440, line: 76)
!503 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !453, line: 50, baseType: !504)
!504 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least16_t", file: !92, line: 55, baseType: !484)
!505 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !506, file: !440, line: 77)
!506 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !453, line: 51, baseType: !507)
!507 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least32_t", file: !92, line: 57, baseType: !487)
!508 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !509, file: !440, line: 78)
!509 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !453, line: 52, baseType: !510)
!510 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least64_t", file: !92, line: 59, baseType: !490)
!511 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !512, file: !440, line: 80)
!512 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !453, line: 102, baseType: !513)
!513 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uintmax_t", file: !92, line: 73, baseType: !119)
!514 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !515, file: !440, line: 81)
!515 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !453, line: 90, baseType: !119)
!516 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !517, file: !519, line: 53)
!517 = !DICompositeType(tag: DW_TAG_structure_type, name: "lconv", file: !518, line: 51, size: 768, flags: DIFlagFwdDecl, identifier: "_ZTS5lconv")
!518 = !DIFile(filename: "/usr/include/locale.h", directory: "")
!519 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/clocale", directory: "")
!520 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !521, file: !519, line: 54)
!521 = !DISubprogram(name: "setlocale", scope: !518, file: !518, line: 122, type: !522, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!522 = !DISubroutineType(types: !523)
!523 = !{!72, !11, !165}
!524 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !525, file: !519, line: 55)
!525 = !DISubprogram(name: "localeconv", scope: !518, file: !518, line: 125, type: !526, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!526 = !DISubroutineType(types: !527)
!527 = !{!528}
!528 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !517, size: 64)
!529 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !530, file: !534, line: 64)
!530 = !DISubprogram(name: "isalnum", scope: !531, file: !531, line: 108, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!531 = !DIFile(filename: "/usr/include/ctype.h", directory: "")
!532 = !DISubroutineType(types: !533)
!533 = !{!11, !11}
!534 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cctype", directory: "")
!535 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !536, file: !534, line: 65)
!536 = !DISubprogram(name: "isalpha", scope: !531, file: !531, line: 109, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!537 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !538, file: !534, line: 66)
!538 = !DISubprogram(name: "iscntrl", scope: !531, file: !531, line: 110, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!539 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !540, file: !534, line: 67)
!540 = !DISubprogram(name: "isdigit", scope: !531, file: !531, line: 111, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!541 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !542, file: !534, line: 68)
!542 = !DISubprogram(name: "isgraph", scope: !531, file: !531, line: 113, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!543 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !544, file: !534, line: 69)
!544 = !DISubprogram(name: "islower", scope: !531, file: !531, line: 112, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!545 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !546, file: !534, line: 70)
!546 = !DISubprogram(name: "isprint", scope: !531, file: !531, line: 114, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!547 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !548, file: !534, line: 71)
!548 = !DISubprogram(name: "ispunct", scope: !531, file: !531, line: 115, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!549 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !550, file: !534, line: 72)
!550 = !DISubprogram(name: "isspace", scope: !531, file: !531, line: 116, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!551 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !552, file: !534, line: 73)
!552 = !DISubprogram(name: "isupper", scope: !531, file: !531, line: 117, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!553 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !554, file: !534, line: 74)
!554 = !DISubprogram(name: "isxdigit", scope: !531, file: !531, line: 118, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!555 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !556, file: !534, line: 75)
!556 = !DISubprogram(name: "tolower", scope: !531, file: !531, line: 122, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!557 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !558, file: !534, line: 76)
!558 = !DISubprogram(name: "toupper", scope: !531, file: !531, line: 125, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!559 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !560, file: !534, line: 87)
!560 = !DISubprogram(name: "isblank", scope: !531, file: !531, line: 130, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!561 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !562, file: !563, line: 44)
!562 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", scope: !2, file: !401, line: 254, baseType: !119)
!563 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/ext/new_allocator.h", directory: "")
!564 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !565, file: !563, line: 45)
!565 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", scope: !2, file: !401, line: 255, baseType: !93)
!566 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !567, file: !569, line: 52)
!567 = !DISubprogram(name: "abs", scope: !568, file: !568, line: 840, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!568 = !DIFile(filename: "/usr/include/stdlib.h", directory: "")
!569 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/std_abs.h", directory: "")
!570 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !571, file: !573, line: 127)
!571 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !568, line: 62, baseType: !572)
!572 = !DICompositeType(tag: DW_TAG_structure_type, file: !568, line: 58, size: 64, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!573 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdlib", directory: "")
!574 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !575, file: !573, line: 128)
!575 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !568, line: 70, baseType: !576)
!576 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !568, line: 66, size: 128, flags: DIFlagTypePassByValue, elements: !577, identifier: "_ZTS6ldiv_t")
!577 = !{!578, !579}
!578 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !576, file: !568, line: 68, baseType: !93, size: 64)
!579 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !576, file: !568, line: 69, baseType: !93, size: 64, offset: 64)
!580 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !581, file: !573, line: 130)
!581 = !DISubprogram(name: "abort", scope: !568, file: !568, line: 591, type: !582, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!582 = !DISubroutineType(types: !583)
!583 = !{null}
!584 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !585, file: !573, line: 132)
!585 = !DISubprogram(name: "aligned_alloc", scope: !568, file: !568, line: 586, type: !586, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!586 = !DISubroutineType(types: !587)
!587 = !{!115, !117, !117}
!588 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !589, file: !573, line: 134)
!589 = !DISubprogram(name: "atexit", scope: !568, file: !568, line: 595, type: !590, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!590 = !DISubroutineType(types: !591)
!591 = !{!11, !592}
!592 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !582, size: 64)
!593 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !594, file: !573, line: 137)
!594 = !DISubprogram(name: "at_quick_exit", scope: !568, file: !568, line: 600, type: !590, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!595 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !596, file: !573, line: 140)
!596 = !DISubprogram(name: "atof", scope: !597, file: !597, line: 25, type: !598, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!597 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdlib-float.h", directory: "")
!598 = !DISubroutineType(types: !599)
!599 = !{!285, !165}
!600 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !601, file: !573, line: 141)
!601 = !DISubprogram(name: "atoi", scope: !568, file: !568, line: 361, type: !602, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!602 = !DISubroutineType(types: !603)
!603 = !{!11, !165}
!604 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !605, file: !573, line: 142)
!605 = !DISubprogram(name: "atol", scope: !568, file: !568, line: 366, type: !606, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!606 = !DISubroutineType(types: !607)
!607 = !{!93, !165}
!608 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !609, file: !573, line: 143)
!609 = !DISubprogram(name: "bsearch", scope: !610, file: !610, line: 20, type: !611, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!610 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdlib-bsearch.h", directory: "")
!611 = !DISubroutineType(types: !612)
!612 = !{!115, !613, !613, !117, !117, !615}
!613 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !614, size: 64)
!614 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!615 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !568, line: 808, baseType: !616)
!616 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !617, size: 64)
!617 = !DISubroutineType(types: !618)
!618 = !{!11, !613, !613}
!619 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !620, file: !573, line: 144)
!620 = !DISubprogram(name: "calloc", scope: !568, file: !568, line: 542, type: !586, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!621 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !622, file: !573, line: 145)
!622 = !DISubprogram(name: "div", scope: !568, file: !568, line: 852, type: !623, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!623 = !DISubroutineType(types: !624)
!624 = !{!571, !11, !11}
!625 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !626, file: !573, line: 146)
!626 = !DISubprogram(name: "exit", scope: !568, file: !568, line: 617, type: !627, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!627 = !DISubroutineType(types: !628)
!628 = !{null, !11}
!629 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !630, file: !573, line: 147)
!630 = !DISubprogram(name: "free", scope: !568, file: !568, line: 565, type: !631, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!631 = !DISubroutineType(types: !632)
!632 = !{null, !115}
!633 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !634, file: !573, line: 148)
!634 = !DISubprogram(name: "getenv", scope: !568, file: !568, line: 634, type: !635, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!635 = !DISubroutineType(types: !636)
!636 = !{!72, !165}
!637 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !638, file: !573, line: 149)
!638 = !DISubprogram(name: "labs", scope: !568, file: !568, line: 841, type: !639, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!639 = !DISubroutineType(types: !640)
!640 = !{!93, !93}
!641 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !642, file: !573, line: 150)
!642 = !DISubprogram(name: "ldiv", scope: !568, file: !568, line: 854, type: !643, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!643 = !DISubroutineType(types: !644)
!644 = !{!575, !93, !93}
!645 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !646, file: !573, line: 151)
!646 = !DISubprogram(name: "malloc", scope: !568, file: !568, line: 539, type: !647, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!647 = !DISubroutineType(types: !648)
!648 = !{!115, !117}
!649 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !650, file: !573, line: 153)
!650 = !DISubprogram(name: "mblen", scope: !568, file: !568, line: 922, type: !651, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!651 = !DISubroutineType(types: !652)
!652 = !{!11, !165, !117}
!653 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !654, file: !573, line: 154)
!654 = !DISubprogram(name: "mbstowcs", scope: !568, file: !568, line: 933, type: !655, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!655 = !DISubroutineType(types: !656)
!656 = !{!117, !131, !164, !117}
!657 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !658, file: !573, line: 155)
!658 = !DISubprogram(name: "mbtowc", scope: !568, file: !568, line: 925, type: !659, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!659 = !DISubroutineType(types: !660)
!660 = !{!11, !131, !164, !117}
!661 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !662, file: !573, line: 157)
!662 = !DISubprogram(name: "qsort", scope: !568, file: !568, line: 830, type: !663, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!663 = !DISubroutineType(types: !664)
!664 = !{null, !115, !117, !117, !615}
!665 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !666, file: !573, line: 160)
!666 = !DISubprogram(name: "quick_exit", scope: !568, file: !568, line: 623, type: !627, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!667 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !668, file: !573, line: 163)
!668 = !DISubprogram(name: "rand", scope: !568, file: !568, line: 453, type: !669, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!669 = !DISubroutineType(types: !670)
!670 = !{!11}
!671 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !672, file: !573, line: 164)
!672 = !DISubprogram(name: "realloc", scope: !568, file: !568, line: 550, type: !673, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!673 = !DISubroutineType(types: !674)
!674 = !{!115, !115, !117}
!675 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !676, file: !573, line: 165)
!676 = !DISubprogram(name: "srand", scope: !568, file: !568, line: 455, type: !677, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!677 = !DISubroutineType(types: !678)
!678 = !{null, !45}
!679 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !680, file: !573, line: 166)
!680 = !DISubprogram(name: "strtod", scope: !568, file: !568, line: 117, type: !681, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!681 = !DISubroutineType(types: !682)
!682 = !{!285, !164, !683}
!683 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !684)
!684 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!685 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !686, file: !573, line: 167)
!686 = !DISubprogram(name: "strtol", scope: !568, file: !568, line: 176, type: !687, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!687 = !DISubroutineType(types: !688)
!688 = !{!93, !164, !683, !11}
!689 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !690, file: !573, line: 168)
!690 = !DISubprogram(name: "strtoul", scope: !568, file: !568, line: 180, type: !691, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!691 = !DISubroutineType(types: !692)
!692 = !{!119, !164, !683, !11}
!693 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !694, file: !573, line: 169)
!694 = !DISubprogram(name: "system", scope: !568, file: !568, line: 784, type: !602, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!695 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !696, file: !573, line: 171)
!696 = !DISubprogram(name: "wcstombs", scope: !568, file: !568, line: 936, type: !697, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!697 = !DISubroutineType(types: !698)
!698 = !{!117, !234, !141, !117}
!699 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !700, file: !573, line: 172)
!700 = !DISubprogram(name: "wctomb", scope: !568, file: !568, line: 929, type: !701, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!701 = !DISubroutineType(types: !702)
!702 = !{!11, !72, !130}
!703 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !704, file: !573, line: 200)
!704 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !568, line: 80, baseType: !705)
!705 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !568, line: 76, size: 128, flags: DIFlagTypePassByValue, elements: !706, identifier: "_ZTS7lldiv_t")
!706 = !{!707, !708}
!707 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !705, file: !568, line: 78, baseType: !357, size: 64)
!708 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !705, file: !568, line: 79, baseType: !357, size: 64, offset: 64)
!709 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !710, file: !573, line: 206)
!710 = !DISubprogram(name: "_Exit", scope: !568, file: !568, line: 629, type: !627, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!711 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !712, file: !573, line: 210)
!712 = !DISubprogram(name: "llabs", scope: !568, file: !568, line: 844, type: !713, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!713 = !DISubroutineType(types: !714)
!714 = !{!357, !357}
!715 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !716, file: !573, line: 216)
!716 = !DISubprogram(name: "lldiv", scope: !568, file: !568, line: 858, type: !717, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!717 = !DISubroutineType(types: !718)
!718 = !{!704, !357, !357}
!719 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !720, file: !573, line: 227)
!720 = !DISubprogram(name: "atoll", scope: !568, file: !568, line: 373, type: !721, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!721 = !DISubroutineType(types: !722)
!722 = !{!357, !165}
!723 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !724, file: !573, line: 228)
!724 = !DISubprogram(name: "strtoll", scope: !568, file: !568, line: 200, type: !725, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!725 = !DISubroutineType(types: !726)
!726 = !{!357, !164, !683, !11}
!727 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !728, file: !573, line: 229)
!728 = !DISubprogram(name: "strtoull", scope: !568, file: !568, line: 205, type: !729, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!729 = !DISubroutineType(types: !730)
!730 = !{!362, !164, !683, !11}
!731 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !732, file: !573, line: 231)
!732 = !DISubprogram(name: "strtof", scope: !568, file: !568, line: 123, type: !733, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!733 = !DISubroutineType(types: !734)
!734 = !{!292, !164, !683}
!735 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !736, file: !573, line: 232)
!736 = !DISubprogram(name: "strtold", scope: !568, file: !568, line: 126, type: !737, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!737 = !DISubroutineType(types: !738)
!738 = !{!352, !164, !683}
!739 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !704, file: !573, line: 240)
!740 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !710, file: !573, line: 242)
!741 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !712, file: !573, line: 244)
!742 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !743, file: !573, line: 245)
!743 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !348, file: !573, line: 213, type: !717, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!744 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !716, file: !573, line: 246)
!745 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !720, file: !573, line: 248)
!746 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !732, file: !573, line: 249)
!747 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !724, file: !573, line: 250)
!748 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !728, file: !573, line: 251)
!749 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !736, file: !573, line: 252)
!750 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !751, file: !753, line: 98)
!751 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !752, line: 7, baseType: !67)
!752 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "")
!753 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cstdio", directory: "")
!754 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !755, file: !753, line: 99)
!755 = !DIDerivedType(tag: DW_TAG_typedef, name: "fpos_t", file: !756, line: 84, baseType: !757)
!756 = !DIFile(filename: "/usr/include/stdio.h", directory: "")
!757 = !DIDerivedType(tag: DW_TAG_typedef, name: "__fpos_t", file: !758, line: 14, baseType: !759)
!758 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h", directory: "")
!759 = !DICompositeType(tag: DW_TAG_structure_type, name: "_G_fpos_t", file: !758, line: 10, size: 128, flags: DIFlagFwdDecl, identifier: "_ZTS9_G_fpos_t")
!760 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !761, file: !753, line: 101)
!761 = !DISubprogram(name: "clearerr", scope: !756, file: !756, line: 757, type: !762, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!762 = !DISubroutineType(types: !763)
!763 = !{null, !764}
!764 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !751, size: 64)
!765 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !766, file: !753, line: 102)
!766 = !DISubprogram(name: "fclose", scope: !756, file: !756, line: 213, type: !767, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!767 = !DISubroutineType(types: !768)
!768 = !{!11, !764}
!769 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !770, file: !753, line: 103)
!770 = !DISubprogram(name: "feof", scope: !756, file: !756, line: 759, type: !767, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!771 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !772, file: !753, line: 104)
!772 = !DISubprogram(name: "ferror", scope: !756, file: !756, line: 761, type: !767, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!773 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !774, file: !753, line: 105)
!774 = !DISubprogram(name: "fflush", scope: !756, file: !756, line: 218, type: !767, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!775 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !776, file: !753, line: 106)
!776 = !DISubprogram(name: "fgetc", scope: !756, file: !756, line: 485, type: !767, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!777 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !778, file: !753, line: 107)
!778 = !DISubprogram(name: "fgetpos", scope: !756, file: !756, line: 731, type: !779, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!779 = !DISubroutineType(types: !780)
!780 = !{!11, !781, !782}
!781 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !764)
!782 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !783)
!783 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !755, size: 64)
!784 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !785, file: !753, line: 108)
!785 = !DISubprogram(name: "fgets", scope: !756, file: !756, line: 564, type: !786, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!786 = !DISubroutineType(types: !787)
!787 = !{!72, !234, !11, !781}
!788 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !789, file: !753, line: 109)
!789 = !DISubprogram(name: "fopen", scope: !756, file: !756, line: 246, type: !790, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!790 = !DISubroutineType(types: !791)
!791 = !{!764, !164, !164}
!792 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !793, file: !753, line: 110)
!793 = !DISubprogram(name: "fprintf", scope: !756, file: !756, line: 326, type: !794, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!794 = !DISubroutineType(types: !795)
!795 = !{!11, !781, !164, null}
!796 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !797, file: !753, line: 111)
!797 = !DISubprogram(name: "fputc", scope: !756, file: !756, line: 521, type: !798, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!798 = !DISubroutineType(types: !799)
!799 = !{!11, !11, !764}
!800 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !801, file: !753, line: 112)
!801 = !DISubprogram(name: "fputs", scope: !756, file: !756, line: 626, type: !802, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!802 = !DISubroutineType(types: !803)
!803 = !{!11, !164, !781}
!804 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !805, file: !753, line: 113)
!805 = !DISubprogram(name: "fread", scope: !756, file: !756, line: 646, type: !806, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!806 = !DISubroutineType(types: !807)
!807 = !{!117, !808, !117, !117, !781}
!808 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !115)
!809 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !810, file: !753, line: 114)
!810 = !DISubprogram(name: "freopen", scope: !756, file: !756, line: 252, type: !811, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!811 = !DISubroutineType(types: !812)
!812 = !{!764, !164, !164, !781}
!813 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !814, file: !753, line: 115)
!814 = !DISubprogram(name: "fscanf", linkageName: "__isoc99_fscanf", scope: !756, file: !756, line: 407, type: !794, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!815 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !816, file: !753, line: 116)
!816 = !DISubprogram(name: "fseek", scope: !756, file: !756, line: 684, type: !817, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!817 = !DISubroutineType(types: !818)
!818 = !{!11, !764, !93, !11}
!819 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !820, file: !753, line: 117)
!820 = !DISubprogram(name: "fsetpos", scope: !756, file: !756, line: 736, type: !821, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!821 = !DISubroutineType(types: !822)
!822 = !{!11, !764, !823}
!823 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !824, size: 64)
!824 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !755)
!825 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !826, file: !753, line: 118)
!826 = !DISubprogram(name: "ftell", scope: !756, file: !756, line: 689, type: !827, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!827 = !DISubroutineType(types: !828)
!828 = !{!93, !764}
!829 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !830, file: !753, line: 119)
!830 = !DISubprogram(name: "fwrite", scope: !756, file: !756, line: 652, type: !831, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!831 = !DISubroutineType(types: !832)
!832 = !{!117, !833, !117, !117, !781}
!833 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !613)
!834 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !835, file: !753, line: 120)
!835 = !DISubprogram(name: "getc", scope: !756, file: !756, line: 486, type: !767, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!836 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !837, file: !753, line: 121)
!837 = !DISubprogram(name: "getchar", scope: !838, file: !838, line: 47, type: !669, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!838 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdio.h", directory: "")
!839 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !840, file: !753, line: 126)
!840 = !DISubprogram(name: "perror", scope: !756, file: !756, line: 775, type: !841, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!841 = !DISubroutineType(types: !842)
!842 = !{null, !165}
!843 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !844, file: !753, line: 127)
!844 = !DISubprogram(name: "printf", scope: !756, file: !756, line: 332, type: !845, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!845 = !DISubroutineType(types: !846)
!846 = !{!11, !164, null}
!847 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !848, file: !753, line: 128)
!848 = !DISubprogram(name: "putc", scope: !756, file: !756, line: 522, type: !798, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!849 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !850, file: !753, line: 129)
!850 = !DISubprogram(name: "putchar", scope: !838, file: !838, line: 82, type: !532, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!851 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !852, file: !753, line: 130)
!852 = !DISubprogram(name: "puts", scope: !756, file: !756, line: 632, type: !602, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!853 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !854, file: !753, line: 131)
!854 = !DISubprogram(name: "remove", scope: !756, file: !756, line: 146, type: !602, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!855 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !856, file: !753, line: 132)
!856 = !DISubprogram(name: "rename", scope: !756, file: !756, line: 148, type: !857, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!857 = !DISubroutineType(types: !858)
!858 = !{!11, !165, !165}
!859 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !860, file: !753, line: 133)
!860 = !DISubprogram(name: "rewind", scope: !756, file: !756, line: 694, type: !762, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!861 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !862, file: !753, line: 134)
!862 = !DISubprogram(name: "scanf", linkageName: "__isoc99_scanf", scope: !756, file: !756, line: 410, type: !845, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!863 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !864, file: !753, line: 135)
!864 = !DISubprogram(name: "setbuf", scope: !756, file: !756, line: 304, type: !865, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!865 = !DISubroutineType(types: !866)
!866 = !{null, !781, !234}
!867 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !868, file: !753, line: 136)
!868 = !DISubprogram(name: "setvbuf", scope: !756, file: !756, line: 308, type: !869, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!869 = !DISubroutineType(types: !870)
!870 = !{!11, !781, !234, !11, !117}
!871 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !872, file: !753, line: 137)
!872 = !DISubprogram(name: "sprintf", scope: !756, file: !756, line: 334, type: !873, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!873 = !DISubroutineType(types: !874)
!874 = !{!11, !234, !164, null}
!875 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !876, file: !753, line: 138)
!876 = !DISubprogram(name: "sscanf", linkageName: "__isoc99_sscanf", scope: !756, file: !756, line: 412, type: !877, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!877 = !DISubroutineType(types: !878)
!878 = !{!11, !164, !164, null}
!879 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !880, file: !753, line: 139)
!880 = !DISubprogram(name: "tmpfile", scope: !756, file: !756, line: 173, type: !881, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!881 = !DISubroutineType(types: !882)
!882 = !{!764}
!883 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !884, file: !753, line: 141)
!884 = !DISubprogram(name: "tmpnam", scope: !756, file: !756, line: 187, type: !885, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!885 = !DISubroutineType(types: !886)
!886 = !{!72, !72}
!887 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !888, file: !753, line: 143)
!888 = !DISubprogram(name: "ungetc", scope: !756, file: !756, line: 639, type: !798, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!889 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !890, file: !753, line: 144)
!890 = !DISubprogram(name: "vfprintf", scope: !756, file: !756, line: 341, type: !891, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!891 = !DISubroutineType(types: !892)
!892 = !{!11, !781, !164, !207}
!893 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !894, file: !753, line: 145)
!894 = !DISubprogram(name: "vprintf", scope: !838, file: !838, line: 39, type: !895, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!895 = !DISubroutineType(types: !896)
!896 = !{!11, !164, !207}
!897 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !898, file: !753, line: 146)
!898 = !DISubprogram(name: "vsprintf", scope: !756, file: !756, line: 349, type: !899, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!899 = !DISubroutineType(types: !900)
!900 = !{!11, !234, !164, !207}
!901 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !902, file: !753, line: 175)
!902 = !DISubprogram(name: "snprintf", scope: !756, file: !756, line: 354, type: !903, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!903 = !DISubroutineType(types: !904)
!904 = !{!11, !234, !117, !164, null}
!905 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !906, file: !753, line: 176)
!906 = !DISubprogram(name: "vfscanf", linkageName: "__isoc99_vfscanf", scope: !756, file: !756, line: 451, type: !891, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!907 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !908, file: !753, line: 177)
!908 = !DISubprogram(name: "vscanf", linkageName: "__isoc99_vscanf", scope: !756, file: !756, line: 456, type: !895, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!909 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !910, file: !753, line: 178)
!910 = !DISubprogram(name: "vsnprintf", scope: !756, file: !756, line: 358, type: !911, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!911 = !DISubroutineType(types: !912)
!912 = !{!11, !234, !117, !164, !207}
!913 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !348, entity: !914, file: !753, line: 179)
!914 = !DISubprogram(name: "vsscanf", linkageName: "__isoc99_vsscanf", scope: !756, file: !756, line: 459, type: !915, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!915 = !DISubroutineType(types: !916)
!916 = !{!11, !164, !164, !207}
!917 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !902, file: !753, line: 185)
!918 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !906, file: !753, line: 186)
!919 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !908, file: !753, line: 187)
!920 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !910, file: !753, line: 188)
!921 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !914, file: !753, line: 189)
!922 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !923, file: !927, line: 82)
!923 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctrans_t", file: !924, line: 48, baseType: !925)
!924 = !DIFile(filename: "/usr/include/wctype.h", directory: "")
!925 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !926, size: 64)
!926 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !447)
!927 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/cwctype", directory: "")
!928 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !929, file: !927, line: 83)
!929 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctype_t", file: !930, line: 38, baseType: !119)
!930 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/wctype-wchar.h", directory: "")
!931 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !53, file: !927, line: 84)
!932 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !933, file: !927, line: 86)
!933 = !DISubprogram(name: "iswalnum", scope: !930, file: !930, line: 95, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!934 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !935, file: !927, line: 87)
!935 = !DISubprogram(name: "iswalpha", scope: !930, file: !930, line: 101, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!936 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !937, file: !927, line: 89)
!937 = !DISubprogram(name: "iswblank", scope: !930, file: !930, line: 146, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!938 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !939, file: !927, line: 91)
!939 = !DISubprogram(name: "iswcntrl", scope: !930, file: !930, line: 104, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!940 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !941, file: !927, line: 92)
!941 = !DISubprogram(name: "iswctype", scope: !930, file: !930, line: 159, type: !942, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!942 = !DISubroutineType(types: !943)
!943 = !{!11, !53, !929}
!944 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !945, file: !927, line: 93)
!945 = !DISubprogram(name: "iswdigit", scope: !930, file: !930, line: 108, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!946 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !947, file: !927, line: 94)
!947 = !DISubprogram(name: "iswgraph", scope: !930, file: !930, line: 112, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!948 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !949, file: !927, line: 95)
!949 = !DISubprogram(name: "iswlower", scope: !930, file: !930, line: 117, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!950 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !951, file: !927, line: 96)
!951 = !DISubprogram(name: "iswprint", scope: !930, file: !930, line: 120, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!952 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !953, file: !927, line: 97)
!953 = !DISubprogram(name: "iswpunct", scope: !930, file: !930, line: 125, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!954 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !955, file: !927, line: 98)
!955 = !DISubprogram(name: "iswspace", scope: !930, file: !930, line: 130, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!956 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !957, file: !927, line: 99)
!957 = !DISubprogram(name: "iswupper", scope: !930, file: !930, line: 135, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!958 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !959, file: !927, line: 100)
!959 = !DISubprogram(name: "iswxdigit", scope: !930, file: !930, line: 140, type: !311, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!960 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !961, file: !927, line: 101)
!961 = !DISubprogram(name: "towctrans", scope: !924, file: !924, line: 55, type: !962, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!962 = !DISubroutineType(types: !963)
!963 = !{!53, !53, !923}
!964 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !965, file: !927, line: 102)
!965 = !DISubprogram(name: "towlower", scope: !930, file: !930, line: 166, type: !966, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!966 = !DISubroutineType(types: !967)
!967 = !{!53, !53}
!968 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !969, file: !927, line: 103)
!969 = !DISubprogram(name: "towupper", scope: !930, file: !930, line: 169, type: !966, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!970 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !971, file: !927, line: 104)
!971 = !DISubprogram(name: "wctrans", scope: !924, file: !924, line: 52, type: !972, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!972 = !DISubroutineType(types: !973)
!973 = !{!923, !165}
!974 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !2, entity: !975, file: !927, line: 105)
!975 = !DISubprogram(name: "wctype", scope: !930, file: !930, line: 155, type: !976, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!976 = !DISubroutineType(types: !977)
!977 = !{!929, !165}
!978 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !28, entity: !2, file: !29, line: 3)
!979 = !{i32 7, !"Dwarf Version", i32 4}
!980 = !{i32 2, !"Debug Info Version", i32 3}
!981 = !{i32 1, !"wchar_size", i32 4}
!982 = !{i32 7, !"PIC Level", i32 2}
!983 = !{i32 7, !"uwtable", i32 1}
!984 = !{!"clang version 13.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)"}
!985 = distinct !DISubprogram(name: "main", scope: !29, file: !29, line: 5, type: !669, scopeLine: 5, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !28, retainedNodes: !986)
!986 = !{!987, !988, !989, !994}
!987 = !DILocalVariable(name: "a", scope: !985, file: !29, line: 6, type: !11)
!988 = !DILocalVariable(name: "b", scope: !985, file: !29, line: 6, type: !11)
!989 = !DILabel(scope: !990, name: "new_label", file: !29, line: 52)
!990 = distinct !DILexicalBlock(scope: !991, file: !29, line: 40, column: 12)
!991 = distinct !DILexicalBlock(scope: !992, file: !29, line: 23, column: 9)
!992 = distinct !DILexicalBlock(scope: !993, file: !29, line: 22, column: 10)
!993 = distinct !DILexicalBlock(scope: !985, file: !29, line: 20, column: 7)
!994 = !DILabel(scope: !985, name: "end_label", file: !29, line: 58)
!995 = !DILocation(line: 6, column: 3, scope: !985)
!996 = !DILocation(line: 0, scope: !985)
!997 = !DILocation(line: 7, column: 7, scope: !985)
!998 = !DILocation(line: 7, column: 12, scope: !985)
!999 = !DILocation(line: 9, column: 7, scope: !1000)
!1000 = distinct !DILexicalBlock(scope: !985, file: !29, line: 9, column: 7)
!1001 = !{!1002, !1002, i64 0}
!1002 = !{!"int", !1003, i64 0}
!1003 = !{!"omnipotent char", !1004, i64 0}
!1004 = !{!"Simple C++ TBAA"}
!1005 = !DILocation(line: 9, column: 9, scope: !1000)
!1006 = !DILocation(line: 9, column: 7, scope: !985)
!1007 = !DILocation(line: 10, column: 11, scope: !1008)
!1008 = distinct !DILexicalBlock(scope: !1000, file: !29, line: 9, column: 14)
!1009 = !DILocation(line: 10, column: 15, scope: !1008)
!1010 = !DILocation(line: 10, column: 7, scope: !1008)
!1011 = !DILocation(line: 11, column: 9, scope: !1008)
!1012 = !DILocation(line: 11, column: 11, scope: !1008)
!1013 = !DILocation(line: 11, column: 15, scope: !1008)
!1014 = !DILocation(line: 12, column: 3, scope: !1008)
!1015 = !DILocation(line: 13, column: 11, scope: !1016)
!1016 = distinct !DILexicalBlock(scope: !1000, file: !29, line: 12, column: 10)
!1017 = !DILocation(line: 13, column: 7, scope: !1016)
!1018 = !DILocation(line: 14, column: 9, scope: !1016)
!1019 = !DILocation(line: 14, column: 11, scope: !1016)
!1020 = !DILocation(line: 0, scope: !1000)
!1021 = !DILocation(line: 17, column: 7, scope: !985)
!1022 = !DILocation(line: 17, column: 9, scope: !985)
!1023 = !DILocation(line: 17, column: 5, scope: !985)
!1024 = !DILocation(line: 18, column: 9, scope: !985)
!1025 = !DILocation(line: 18, column: 5, scope: !985)
!1026 = !DILocation(line: 20, column: 9, scope: !993)
!1027 = !DILocation(line: 20, column: 7, scope: !985)
!1028 = !DILocation(line: 23, column: 11, scope: !991)
!1029 = !DILocation(line: 23, column: 9, scope: !992)
!1030 = !DILocation(line: 24, column: 13, scope: !1031)
!1031 = distinct !DILexicalBlock(scope: !991, file: !29, line: 23, column: 16)
!1032 = !DILocation(line: 24, column: 9, scope: !1031)
!1033 = !DILocation(line: 25, column: 13, scope: !1031)
!1034 = !DILocation(line: 25, column: 9, scope: !1031)
!1035 = !DILocation(line: 27, column: 13, scope: !1036)
!1036 = distinct !DILexicalBlock(scope: !1031, file: !29, line: 27, column: 11)
!1037 = !DILocation(line: 27, column: 11, scope: !1031)
!1038 = !DILocation(line: 30, column: 13, scope: !1039)
!1039 = distinct !DILexicalBlock(scope: !1031, file: !29, line: 30, column: 11)
!1040 = !DILocation(line: 30, column: 11, scope: !1031)
!1041 = !DILocation(line: 31, column: 15, scope: !1042)
!1042 = distinct !DILexicalBlock(scope: !1039, file: !29, line: 30, column: 19)
!1043 = !DILocation(line: 31, column: 11, scope: !1042)
!1044 = !DILocation(line: 32, column: 15, scope: !1042)
!1045 = !DILocation(line: 33, column: 7, scope: !1042)
!1046 = !DILocation(line: 34, column: 15, scope: !1047)
!1047 = distinct !DILexicalBlock(scope: !1039, file: !29, line: 33, column: 14)
!1048 = !DILocation(line: 34, column: 19, scope: !1047)
!1049 = !DILocation(line: 34, column: 11, scope: !1047)
!1050 = !DILocation(line: 35, column: 15, scope: !1047)
!1051 = !DILocation(line: 35, column: 19, scope: !1047)
!1052 = !DILocation(line: 0, scope: !1039)
!1053 = !DILocation(line: 38, column: 11, scope: !1031)
!1054 = !DILocation(line: 38, column: 13, scope: !1031)
!1055 = !DILocation(line: 38, column: 9, scope: !1031)
!1056 = !DILocation(line: 39, column: 13, scope: !1031)
!1057 = !DILocation(line: 39, column: 9, scope: !1031)
!1058 = !DILocation(line: 40, column: 5, scope: !1031)
!1059 = !DILocation(line: 41, column: 13, scope: !990)
!1060 = !DILocation(line: 41, column: 9, scope: !990)
!1061 = !DILocation(line: 42, column: 13, scope: !990)
!1062 = !DILocation(line: 42, column: 9, scope: !990)
!1063 = !DILocation(line: 44, column: 13, scope: !1064)
!1064 = distinct !DILexicalBlock(scope: !990, file: !29, line: 44, column: 11)
!1065 = !DILocation(line: 44, column: 11, scope: !990)
!1066 = !DILocation(line: 45, column: 15, scope: !1067)
!1067 = distinct !DILexicalBlock(scope: !1064, file: !29, line: 44, column: 19)
!1068 = !DILocation(line: 45, column: 11, scope: !1067)
!1069 = !DILocation(line: 46, column: 15, scope: !1067)
!1070 = !DILocation(line: 46, column: 11, scope: !1067)
!1071 = !DILocation(line: 47, column: 7, scope: !1067)
!1072 = !DILocation(line: 48, column: 15, scope: !1073)
!1073 = distinct !DILexicalBlock(scope: !1064, file: !29, line: 47, column: 14)
!1074 = !DILocation(line: 48, column: 11, scope: !1073)
!1075 = !DILocation(line: 49, column: 15, scope: !1073)
!1076 = !DILocation(line: 49, column: 11, scope: !1073)
!1077 = !DILocation(line: 52, column: 5, scope: !990)
!1078 = !DILocation(line: 53, column: 11, scope: !990)
!1079 = !DILocation(line: 53, column: 13, scope: !990)
!1080 = !DILocation(line: 53, column: 9, scope: !990)
!1081 = !DILocation(line: 54, column: 11, scope: !990)
!1082 = !DILocation(line: 54, column: 13, scope: !990)
!1083 = !DILocation(line: 54, column: 9, scope: !990)
!1084 = !DILocation(line: 58, column: 1, scope: !985)
!1085 = !DILocation(line: 60, column: 1, scope: !985)
!1086 = !DILocation(line: 59, column: 3, scope: !985)
!1087 = distinct !DISubprogram(linkageName: "_GLOBAL__sub_I_test.cpp", scope: !29, file: !29, type: !1088, flags: DIFlagArtificial | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !28, retainedNodes: !30)
!1088 = !DISubroutineType(types: !30)
!1089 = !DILocation(line: 74, column: 25, scope: !1090, inlinedAt: !1092)
!1090 = !DILexicalBlockFile(scope: !1091, file: !3, discriminator: 0)
!1091 = distinct !DISubprogram(name: "__cxx_global_var_init", scope: !29, file: !29, type: !582, flags: DIFlagArtificial | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !28, retainedNodes: !30)
!1092 = distinct !DILocation(line: 0, scope: !1087)
!1093 = !DILocation(line: 0, scope: !1091, inlinedAt: !1092)
