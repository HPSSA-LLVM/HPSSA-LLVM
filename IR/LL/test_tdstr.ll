; ModuleID = 'IR/LL/test_hpssa.ll'
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
  %call = call i64 @time(i64* null) #7
  %conv = trunc i64 %call to i32
  call void @srand(i32 %conv) #7
  %call2 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 undef)
  %i = bitcast %"class.std::basic_ostream"* %call2 to i8**
  %vtable.i = load i8*, i8** %i, align 8, !tbaa !4
  %vbase.offset.ptr.i = getelementptr i8, i8* %vtable.i, i64 -24
  %i1 = bitcast i8* %vbase.offset.ptr.i to i64*
  %vbase.offset.i = load i64, i64* %i1, align 8
  %i2 = bitcast %"class.std::basic_ostream"* %call2 to i8*
  %add.ptr.i = getelementptr inbounds i8, i8* %i2, i64 %vbase.offset.i
  %_M_ctype.i.i = getelementptr inbounds i8, i8* %add.ptr.i, i64 240
  %i3 = bitcast i8* %_M_ctype.i.i to %"class.std::ctype"**
  %i4 = load %"class.std::ctype"*, %"class.std::ctype"** %i3, align 8, !tbaa !7
  %tobool.not.i.i.i = icmp eq %"class.std::ctype"* %i4, null
  br i1 %tobool.not.i.i.i, label %if.then.i.i.i, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i

if.then.i.i.i:                                    ; preds = %entry
  call void @_ZSt16__throw_bad_castv() #8
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i: ; preds = %entry
  %_M_widen_ok.i.i.i = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i4, i64 0, i32 8
  %i5 = load i8, i8* %_M_widen_ok.i.i.i, align 8, !tbaa !12
  %tobool.not.i3.i.i = icmp eq i8 %i5, 0
  br i1 %tobool.not.i3.i.i, label %if.end.i.i.i, label %if.then.i4.i.i

if.then.i4.i.i:                                   ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i
  %arrayidx.i.i.i = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i4, i64 0, i32 9, i64 10
  %i6 = load i8, i8* %arrayidx.i.i.i, align 1, !tbaa !14
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit

if.end.i.i.i:                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i4)
  %i7 = bitcast %"class.std::ctype"* %i4 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %i7, align 8, !tbaa !4
  %vfn.i.i.i = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i, i64 6
  %i8 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i, align 8
  %call.i.i.i = call signext i8 %i8(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i4, i8 signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit: ; preds = %if.end.i.i.i, %if.then.i4.i.i
  %retval.0.i.i.i = phi i8 [ %i6, %if.then.i4.i.i ], [ %call.i.i.i, %if.end.i.i.i ]
  %call1.i = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call2, i8 signext %retval.0.i.i.i)
  %call.i.i = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i)
  %call4 = call i32 @rand() #7
  %rem = srem i32 %call4, 10
  %cmp5 = icmp eq i32 %rem, 5
  br i1 %cmp5, label %if.else9, label %if.else14

if.else9:                                         ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit
  %call10 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 undef)
  %call11 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call10, i32 undef)
  %i9 = bitcast %"class.std::basic_ostream"* %call11 to i8**
  %vtable.i66 = load i8*, i8** %i9, align 8, !tbaa !4
  %vbase.offset.ptr.i67 = getelementptr i8, i8* %vtable.i66, i64 -24
  %i10 = bitcast i8* %vbase.offset.ptr.i67 to i64*
  %vbase.offset.i68 = load i64, i64* %i10, align 8
  %i11 = bitcast %"class.std::basic_ostream"* %call11 to i8*
  %add.ptr.i69 = getelementptr inbounds i8, i8* %i11, i64 %vbase.offset.i68
  %_M_ctype.i.i70 = getelementptr inbounds i8, i8* %add.ptr.i69, i64 240
  %i12 = bitcast i8* %_M_ctype.i.i70 to %"class.std::ctype"**
  %i13 = load %"class.std::ctype"*, %"class.std::ctype"** %i12, align 8, !tbaa !7
  %tobool.not.i.i.i71 = icmp eq %"class.std::ctype"* %i13, null
  br i1 %tobool.not.i.i.i71, label %if.then.i.i.i72, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i75

if.then.i.i.i72:                                  ; preds = %if.else9
  call void @_ZSt16__throw_bad_castv() #8
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i75: ; preds = %if.else9
  %_M_widen_ok.i.i.i73 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i13, i64 0, i32 8
  %i14 = load i8, i8* %_M_widen_ok.i.i.i73, align 8, !tbaa !12
  %tobool.not.i3.i.i74 = icmp eq i8 %i14, 0
  br i1 %tobool.not.i3.i.i74, label %if.end.i.i.i81, label %if.then.i4.i.i77

if.then.i4.i.i77:                                 ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i75
  %arrayidx.i.i.i76 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i13, i64 0, i32 9, i64 10
  %i15 = load i8, i8* %arrayidx.i.i.i76, align 1, !tbaa !14
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit85

if.end.i.i.i81:                                   ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i75
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i13)
  %i16 = bitcast %"class.std::ctype"* %i13 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i78 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %i16, align 8, !tbaa !4
  %vfn.i.i.i79 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i78, i64 6
  %i17 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i79, align 8
  %call.i.i.i80 = call signext i8 %i17(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i13, i8 signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit85

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit85: ; preds = %if.end.i.i.i81, %if.then.i4.i.i77
  %retval.0.i.i.i82 = phi i8 [ %i15, %if.then.i4.i.i77 ], [ %call.i.i.i80, %if.end.i.i.i81 ]
  %call1.i83 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call11, i8 signext %retval.0.i.i.i82)
  br label %if.end33.sink.split

if.else14:                                        ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit
  %call15 = call i32 @rand() #7
  %rem16 = srem i32 %call15, 100
  %cmp17 = icmp eq i32 %rem16, 10
  br i1 %cmp17, label %if.then18, label %if.end33

if.then18:                                        ; preds = %if.else14
  %call20 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 undef)
  %call21 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call20, i32 undef)
  %i18 = bitcast %"class.std::basic_ostream"* %call21 to i8**
  %vtable.i86 = load i8*, i8** %i18, align 8, !tbaa !4
  %vbase.offset.ptr.i87 = getelementptr i8, i8* %vtable.i86, i64 -24
  %i19 = bitcast i8* %vbase.offset.ptr.i87 to i64*
  %vbase.offset.i88 = load i64, i64* %i19, align 8
  %i20 = bitcast %"class.std::basic_ostream"* %call21 to i8*
  %add.ptr.i89 = getelementptr inbounds i8, i8* %i20, i64 %vbase.offset.i88
  %_M_ctype.i.i90 = getelementptr inbounds i8, i8* %add.ptr.i89, i64 240
  %i21 = bitcast i8* %_M_ctype.i.i90 to %"class.std::ctype"**
  %i22 = load %"class.std::ctype"*, %"class.std::ctype"** %i21, align 8, !tbaa !7
  %tobool.not.i.i.i91 = icmp eq %"class.std::ctype"* %i22, null
  br i1 %tobool.not.i.i.i91, label %if.then.i.i.i92, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i95

if.then.i.i.i92:                                  ; preds = %if.then18
  call void @_ZSt16__throw_bad_castv() #8
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i95: ; preds = %if.then18
  %_M_widen_ok.i.i.i93 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i22, i64 0, i32 8
  %i23 = load i8, i8* %_M_widen_ok.i.i.i93, align 8, !tbaa !12
  %tobool.not.i3.i.i94 = icmp eq i8 %i23, 0
  br i1 %tobool.not.i3.i.i94, label %if.end.i.i.i101, label %if.then.i4.i.i97

if.then.i4.i.i97:                                 ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i95
  %arrayidx.i.i.i96 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i22, i64 0, i32 9, i64 10
  %i24 = load i8, i8* %arrayidx.i.i.i96, align 1, !tbaa !14
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit105

if.end.i.i.i101:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i95
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i22)
  %i25 = bitcast %"class.std::ctype"* %i22 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i98 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %i25, align 8, !tbaa !4
  %vfn.i.i.i99 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i98, i64 6
  %i26 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i99, align 8
  %call.i.i.i100 = call signext i8 %i26(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i22, i8 signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit105

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit105: ; preds = %if.end.i.i.i101, %if.then.i4.i.i97
  %retval.0.i.i.i102 = phi i8 [ %i24, %if.then.i4.i.i97 ], [ %call.i.i.i100, %if.end.i.i.i101 ]
  %call1.i103 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call21, i8 signext %retval.0.i.i.i102)
  br label %if.end33.sink.split

if.end33.sink.split:                              ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit105, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit85
  %call1.i103.sink = phi %"class.std::basic_ostream"* [ %call1.i103, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit105 ], [ %call1.i83, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit85 ]
  %call.i.i104 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i103.sink)
  br label %if.end33

if.end33:                                         ; preds = %if.end33.sink.split, %if.else14
  %call34 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 undef)
  %i27 = bitcast %"class.std::basic_ostream"* %call34 to i8**
  %vtable.i106 = load i8*, i8** %i27, align 8, !tbaa !4
  %vbase.offset.ptr.i107 = getelementptr i8, i8* %vtable.i106, i64 -24
  %i28 = bitcast i8* %vbase.offset.ptr.i107 to i64*
  %vbase.offset.i108 = load i64, i64* %i28, align 8
  %i29 = bitcast %"class.std::basic_ostream"* %call34 to i8*
  %add.ptr.i109 = getelementptr inbounds i8, i8* %i29, i64 %vbase.offset.i108
  %_M_ctype.i.i110 = getelementptr inbounds i8, i8* %add.ptr.i109, i64 240
  %i30 = bitcast i8* %_M_ctype.i.i110 to %"class.std::ctype"**
  %i31 = load %"class.std::ctype"*, %"class.std::ctype"** %i30, align 8, !tbaa !7
  %tobool.not.i.i.i111 = icmp eq %"class.std::ctype"* %i31, null
  br i1 %tobool.not.i.i.i111, label %if.then.i.i.i112, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i115

if.then.i.i.i112:                                 ; preds = %if.end33
  call void @_ZSt16__throw_bad_castv() #8
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i115: ; preds = %if.end33
  %_M_widen_ok.i.i.i113 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i31, i64 0, i32 8
  %i32 = load i8, i8* %_M_widen_ok.i.i.i113, align 8, !tbaa !12
  %tobool.not.i3.i.i114 = icmp eq i8 %i32, 0
  br i1 %tobool.not.i3.i.i114, label %if.end.i.i.i121, label %if.then.i4.i.i117

if.then.i4.i.i117:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i115
  %arrayidx.i.i.i116 = getelementptr inbounds %"class.std::ctype", %"class.std::ctype"* %i31, i64 0, i32 9, i64 10
  %i33 = load i8, i8* %arrayidx.i.i.i116, align 1, !tbaa !14
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit125

if.end.i.i.i121:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i115
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i31)
  %i34 = bitcast %"class.std::ctype"* %i31 to i8 (%"class.std::ctype"*, i8)***
  %vtable.i.i.i118 = load i8 (%"class.std::ctype"*, i8)**, i8 (%"class.std::ctype"*, i8)*** %i34, align 8, !tbaa !4
  %vfn.i.i.i119 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vtable.i.i.i118, i64 6
  %i35 = load i8 (%"class.std::ctype"*, i8)*, i8 (%"class.std::ctype"*, i8)** %vfn.i.i.i119, align 8
  %call.i.i.i120 = call signext i8 %i35(%"class.std::ctype"* nonnull align 8 dereferenceable(570) %i31, i8 signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit125

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit125: ; preds = %if.end.i.i.i121, %if.then.i4.i.i117
  %retval.0.i.i.i122 = phi i8 [ %i33, %if.then.i4.i.i117 ], [ %call.i.i.i120, %if.end.i.i.i121 ]
  %call1.i123 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call34, i8 signext %retval.0.i.i.i122)
  %call.i.i124 = call nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8) %call1.i123)
  ret i32 0
}

; Function Attrs: nounwind
declare void @srand(i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare i64 @time(i64*) local_unnamed_addr #1

declare nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i32) local_unnamed_addr #0

; Function Attrs: nounwind
declare i32 @rand() local_unnamed_addr #1

declare nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8), i8 signext) local_unnamed_addr #0

declare nonnull align 8 dereferenceable(8) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* nonnull align 8 dereferenceable(8)) local_unnamed_addr #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() local_unnamed_addr #4

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* nonnull align 8 dereferenceable(570)) local_unnamed_addr #0

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

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{!"clang version 14.0.0 (https://github.com/HPSSA-LLVM/llvm-project.git ddda52ce3cf2936d9ee05e06ed70e7d270cfcd73)"}
!4 = !{!5, !5, i64 0}
!5 = !{!"vtable pointer", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{!8, !9, i64 240}
!8 = !{!"_ZTSSt9basic_iosIcSt11char_traitsIcEE", !9, i64 216, !10, i64 224, !11, i64 225, !9, i64 232, !9, i64 240, !9, i64 248, !9, i64 256}
!9 = !{!"any pointer", !10, i64 0}
!10 = !{!"omnipotent char", !6, i64 0}
!11 = !{!"bool", !10, i64 0}
!12 = !{!13, !10, i64 56}
!13 = !{!"_ZTSSt5ctypeIcE", !9, i64 16, !11, i64 24, !9, i64 32, !9, i64 40, !9, i64 48, !10, i64 56, !10, i64 57, !10, i64 313, !10, i64 569}
!14 = !{!10, !10, i64 0}
