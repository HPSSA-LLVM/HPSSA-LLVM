; ModuleID = 'IR/LL/test_mem2reg.ll'
source_filename = "tests/test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@_ZSt4cout = external dso_local global %"class.std::basic_ostream", align 8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_test.cpp, i8* null }]

declare dso_local void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #0

; Function Attrs: nounwind
declare dso_local void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local i32 @__cxa_atexit(void (i8*)*, i8*, i8*) local_unnamed_addr #2

; Function Attrs: mustprogress norecurse uwtable
define dso_local i32 @main() local_unnamed_addr #3 {
entry:
  %call = call i64 @time(i64* null) #7
  %conv = trunc i64 %call to i32
  call void @srand(i32 %conv) #7
  %call2 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 undef)
  %i = bitcast %"class.std::basic_ostream"* %call2 to i8**
  %vtable.i = load i8*, i8** %i, align 8, !tbaa !3
  %vbase.offset.ptr.i = getelementptr i8, i8* %vtable.i, i64 -24
  %i1 = bitcast i8* %vbase.offset.ptr.i to i64*
  %vbase.offset.i = load i64, i64* %i1, align 8
  %i2 = bitcast %"class.std::basic_ostream"* %call2 to i8*
  %add.ptr.i = getelementptr inbounds i8, i8* %i2, i64 %vbase.offset.i
  %_M_ctype.i.i = getelementptr inbounds i8, i8* %add.ptr.i, i64 240
  %i3 = bitcast i8* %_M_ctype.i.i to %"class.std::ctype"**
  %i4 = load %"class.std::ctype"*, %"class.std::ctype"** %i3, align 8, !tbaa !6
  %tobool.not.i.i.i = icmp eq %"class.std::ctype"* %i4, null
  br i1 %tobool.not.i.i.i, label %if.then.i.i.i, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i

if.then.i.i.i:                                    ; preds = %entry
  call void @_ZSt16__throw_bad_castv() #8
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i: ; preds = %entry
  %_M_widen_ok.i.i.i = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i4, i64 0, i32 8
  %i5 = load i8, i8* %_M_widen_ok.i.i.i, align 8, !tbaa !11
  %tobool.not.i3.i.i = icmp eq i8 %i5, 0
  br i1 %tobool.not.i3.i.i, label %if.end.i.i.i, label %if.then.i4.i.i

if.then.i4.i.i:                                   ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i
  %arrayidx.i.i.i = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i4, i64 0, i32 9, i64 10
  %i6 = load i8, i8* %arrayidx.i.i.i, align 1, !tbaa !13
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit

if.end.i.i.i:                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i4)
  %i7 = bitcast %"class.std::ctype"* %i4 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %i7, align 8, !tbaa !3
  %vfn.i.i.i = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i, i64 6
  %i8 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i, align 8
  %call.i.i.i = call signext i8 %i8(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i4, i8 signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit: ; preds = %if.end.i.i.i, %if.then.i4.i.i
  %retval.0.i.i.i = phi i8 [ %i6, %if.then.i4.i.i ], [ %call.i.i.i, %if.end.i.i.i ]
  %tau = call i8 (...) @llvm.tau.i8(i8 %retval.0.i.i.i, i8 %i6)
  %call1.i = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call2, i8 signext %tau)
  %call.i.i = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i)
  %call4 = call i32 @rand() #7
  %rem = srem i32 %call4, 100
  %cmp5 = icmp eq i32 %rem, 10
  br i1 %cmp5, label %if.then6, label %if.end20

if.then6:                                         ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit
  %call8 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 undef)
  %call9 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call8, i32 undef)
  %i9 = bitcast %"class.std::basic_ostream"* %call9 to i8**
  %vtable.i44 = load i8*, i8** %i9, align 8, !tbaa !3
  %vbase.offset.ptr.i45 = getelementptr i8, i8* %vtable.i44, i64 -24
  %i10 = bitcast i8* %vbase.offset.ptr.i45 to i64*
  %vbase.offset.i46 = load i64, i64* %i10, align 8
  %i11 = bitcast %"class.std::basic_ostream"* %call9 to i8*
  %add.ptr.i47 = getelementptr inbounds i8, i8* %i11, i64 %vbase.offset.i46
  %_M_ctype.i.i48 = getelementptr inbounds i8, i8* %add.ptr.i47, i64 240
  %i12 = bitcast i8* %_M_ctype.i.i48 to %"class.std::ctype"**
  %i13 = load %"class.std::ctype"*, %"class.std::ctype"** %i12, align 8, !tbaa !6
  %tobool.not.i.i.i49 = icmp eq %"class.std::ctype"* %i13, null
  br i1 %tobool.not.i.i.i49, label %if.then.i.i.i50, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i53

if.then.i.i.i50:                                  ; preds = %if.then6
  call void @_ZSt16__throw_bad_castv() #8
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i53: ; preds = %if.then6
  %_M_widen_ok.i.i.i51 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i13, i64 0, i32 8
  %i14 = load i8, i8* %_M_widen_ok.i.i.i51, align 8, !tbaa !11
  %tobool.not.i3.i.i52 = icmp eq i8 %i14, 0
  br i1 %tobool.not.i3.i.i52, label %if.end.i.i.i59, label %if.then.i4.i.i55

if.then.i4.i.i55:                                 ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i53
  %arrayidx.i.i.i54 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i13, i64 0, i32 9, i64 10
  %i15 = load i8, i8* %arrayidx.i.i.i54, align 1, !tbaa !13
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit63

if.end.i.i.i59:                                   ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i53
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i13)
  %i16 = bitcast %"class.std::ctype"* %i13 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i56 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %i16, align 8, !tbaa !3
  %vfn.i.i.i57 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i56, i64 6
  %i17 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i57, align 8
  %call.i.i.i58 = call signext i8 %i17(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i13, i8 signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit63

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit63: ; preds = %if.end.i.i.i59, %if.then.i4.i.i55
  %retval.0.i.i.i60 = phi i8 [ %i15, %if.then.i4.i.i55 ], [ %call.i.i.i58, %if.end.i.i.i59 ]
  %call1.i61 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call9, i8 signext %retval.0.i.i.i60)
  %call.i.i62 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i61)
  br label %if.end20

if.end20:                                         ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit63, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit
  %call21 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 undef)
  %i18 = bitcast %"class.std::basic_ostream"* %call21 to i8**
  %vtable.i64 = load i8*, i8** %i18, align 8, !tbaa !3
  %vbase.offset.ptr.i65 = getelementptr i8, i8* %vtable.i64, i64 -24
  %i19 = bitcast i8* %vbase.offset.ptr.i65 to i64*
  %vbase.offset.i66 = load i64, i64* %i19, align 8
  %i20 = bitcast %"class.std::basic_ostream"* %call21 to i8*
  %add.ptr.i67 = getelementptr inbounds i8, i8* %i20, i64 %vbase.offset.i66
  %_M_ctype.i.i68 = getelementptr inbounds i8, i8* %add.ptr.i67, i64 240
  %i21 = bitcast i8* %_M_ctype.i.i68 to %"class.std::ctype"**
  %i22 = load %"class.std::ctype"*, %"class.std::ctype"** %i21, align 8, !tbaa !6
  %tobool.not.i.i.i69 = icmp eq %"class.std::ctype"* %i22, null
  br i1 %tobool.not.i.i.i69, label %if.then.i.i.i70, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i73

if.then.i.i.i70:                                  ; preds = %if.end20
  call void @_ZSt16__throw_bad_castv() #8
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i73: ; preds = %if.end20
  %_M_widen_ok.i.i.i71 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i22, i64 0, i32 8
  %i23 = load i8, i8* %_M_widen_ok.i.i.i71, align 8, !tbaa !11
  %tobool.not.i3.i.i72 = icmp eq i8 %i23, 0
  br i1 %tobool.not.i3.i.i72, label %if.end.i.i.i79, label %if.then.i4.i.i75

if.then.i4.i.i75:                                 ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i73
  %arrayidx.i.i.i74 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i22, i64 0, i32 9, i64 10
  %i24 = load i8, i8* %arrayidx.i.i.i74, align 1, !tbaa !13
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit83

if.end.i.i.i79:                                   ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i73
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i22)
  %i25 = bitcast %"class.std::ctype"* %i22 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i76 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %i25, align 8, !tbaa !3
  %vfn.i.i.i77 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i76, i64 6
  %i26 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i77, align 8
  %call.i.i.i78 = call signext i8 %i26(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i22, i8 signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit83

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit83: ; preds = %if.end.i.i.i79, %if.then.i4.i.i75
  %retval.0.i.i.i80 = phi i8 [ %i24, %if.then.i4.i.i75 ], [ %call.i.i.i78, %if.end.i.i.i79 ]
  %call1.i81 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call21, i8 signext %retval.0.i.i.i80)
  %call.i.i82 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i81)
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local void @srand(i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i64 @time(i64*) local_unnamed_addr #1

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i32) local_unnamed_addr #0

; Function Attrs: nounwind
declare dso_local i32 @rand() local_unnamed_addr #1

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8 signext) local_unnamed_addr #0

declare dso_local nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8)) local_unnamed_addr #0

; Function Attrs: noreturn
declare dso_local void @_ZSt16__throw_bad_castv() local_unnamed_addr #4

declare dso_local void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570)) local_unnamed_addr #0

; Function Attrs: uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #5 section ".text.startup" {
entry:
  call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %i = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init", %"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* nonnull @__dso_handle) #7
  ret void
}

; Function Attrs: nofree nosync nounwind willreturn
declare i8 @llvm.tau.i8(...) #6

attributes #0 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind }
attributes #3 = { mustprogress norecurse uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nosync nounwind willreturn }
attributes #7 = { nounwind }
attributes #8 = { noreturn }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"vtable pointer", !5, i64 0}
!5 = !{!"Simple C++ TBAA"}
!6 = !{!7, !8, i64 240}
!7 = !{!"_ZTSSt9basic_iosIcSt11char_traitsIcEE", !8, i64 216, !9, i64 224, !10, i64 225, !8, i64 232, !8, i64 240, !8, i64 248, !8, i64 256}
!8 = !{!"any pointer", !9, i64 0}
!9 = !{!"omnipotent char", !5, i64 0}
!10 = !{!"bool", !9, i64 0}
!11 = !{!12, !9, i64 56}
!12 = !{!"_ZTSSt5ctypeIcE", !8, i64 16, !10, i64 24, !8, i64 32, !8, i64 40, !8, i64 48, !9, i64 56, !9, i64 57, !9, i64 313, !9, i64 569}
!13 = !{!9, !9, i64 0}
