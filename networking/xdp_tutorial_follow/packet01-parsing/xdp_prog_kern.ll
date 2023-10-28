; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon.3 = type { [6 x i32]*, i32*, %struct.datarec*, [5 x i32]* }
%struct.datarec = type { i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.hdr_cursor = type { i8* }
%struct.ipv6hdr = type { i8, [3 x i8], i16, i8, i8, %union.anon }
%union.anon = type { %struct.anon }
%struct.anon = type { %struct.in6_addr, %struct.in6_addr }
%struct.in6_addr = type { %union.anon.0 }
%union.anon.0 = type { [4 x i32] }
%struct.icmp6hdr = type { i8, i8, i16, %union.anon.2 }
%union.anon.2 = type { [1 x i32] }

@xdp_parser_func.____fmt = internal constant [7 x i8] c"step 1\00", align 1, !dbg !0
@xdp_parser_func.____fmt.1 = internal constant [7 x i8] c"step 2\00", align 1, !dbg !35
@xdp_parser_func.____fmt.2 = internal constant [7 x i8] c"step 3\00", align 1, !dbg !42
@xdp_parser_func.____fmt.3 = internal constant [7 x i8] c"step 4\00", align 1, !dbg !44
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !46
@xdp_stats_map = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !51
@parse_icmp6hdr.____fmt = internal constant [7 x i8] c"seq=%d\00", align 1, !dbg !84
@llvm.compiler.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_parser_func to i8*), i8* bitcast (%struct.anon.3* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_parser_func(%struct.xdp_md* nocapture noundef readonly %0) #0 section "xdp" !dbg !2 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !157, metadata !DIExpression()), !dbg !223
  %3 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !224
  %4 = load i32, i32* %3, align 4, !dbg !224, !tbaa !225
  %5 = zext i32 %4 to i64, !dbg !230
  %6 = inttoptr i64 %5 to i8*, !dbg !231
  call void @llvm.dbg.value(metadata i8* %6, metadata !158, metadata !DIExpression()), !dbg !223
  %7 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !232
  %8 = load i32, i32* %7, align 4, !dbg !232, !tbaa !233
  %9 = zext i32 %8 to i64, !dbg !234
  %10 = inttoptr i64 %9 to i8*, !dbg !235
  call void @llvm.dbg.value(metadata i8* %10, metadata !159, metadata !DIExpression()), !dbg !223
  call void @llvm.dbg.value(metadata i32 2, metadata !169, metadata !DIExpression()), !dbg !223
  call void @llvm.dbg.value(metadata i8* %10, metadata !170, metadata !DIExpression()), !dbg !223
  call void @llvm.dbg.value(metadata %struct.ethhdr** undef, metadata !160, metadata !DIExpression(DW_OP_deref)), !dbg !223
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !236, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i8* %6, metadata !242, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata %struct.ethhdr** undef, metadata !243, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i8* %10, metadata !244, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i32 14, metadata !245, metadata !DIExpression()), !dbg !246
  %11 = getelementptr i8, i8* %10, i64 14, !dbg !248
  %12 = icmp ugt i8* %11, %6, !dbg !250
  br i1 %12, label %48, label %13, !dbg !251

13:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %10, metadata !244, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i8* %11, metadata !170, metadata !DIExpression()), !dbg !223
  %14 = getelementptr inbounds i8, i8* %10, i64 12, !dbg !252
  %15 = bitcast i8* %14 to i16*, !dbg !252
  %16 = load i16, i16* %15, align 1, !dbg !252, !tbaa !253
  call void @llvm.dbg.value(metadata i16 %16, metadata !171, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !223
  %17 = icmp eq i16 %16, -8826, !dbg !256
  br i1 %17, label %18, label %48, !dbg !258

18:                                               ; preds = %13
  %19 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @xdp_parser_func.____fmt, i64 0, i64 0), i32 noundef 7) #4, !dbg !259
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !261, metadata !DIExpression()), !dbg !270
  call void @llvm.dbg.value(metadata i8* %6, metadata !267, metadata !DIExpression()), !dbg !270
  call void @llvm.dbg.value(metadata %struct.ipv6hdr** undef, metadata !268, metadata !DIExpression()), !dbg !270
  call void @llvm.dbg.value(metadata i8* %11, metadata !269, metadata !DIExpression()), !dbg !270
  %20 = getelementptr i8, i8* %10, i64 54, !dbg !272
  %21 = bitcast i8* %20 to %struct.ipv6hdr*, !dbg !272
  %22 = inttoptr i64 %5 to %struct.ipv6hdr*, !dbg !274
  %23 = icmp ugt %struct.ipv6hdr* %21, %22, !dbg !275
  br i1 %23, label %24, label %26, !dbg !276

24:                                               ; preds = %18
  call void @llvm.dbg.value(metadata %struct.ipv6hdr* %21, metadata !170, metadata !DIExpression()), !dbg !223
  call void @llvm.dbg.value(metadata i8 %28, metadata !171, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !223
  %25 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @xdp_parser_func.____fmt.1, i64 0, i64 0), i32 noundef 7) #4, !dbg !277
  br label %48, !dbg !279

26:                                               ; preds = %18
  call void @llvm.dbg.value(metadata i8* %11, metadata !269, metadata !DIExpression()), !dbg !270
  call void @llvm.dbg.value(metadata %struct.ipv6hdr* %21, metadata !170, metadata !DIExpression()), !dbg !223
  %27 = getelementptr i8, i8* %10, i64 20, !dbg !280
  %28 = load i8, i8* %27, align 2, !dbg !280, !tbaa !281
  call void @llvm.dbg.value(metadata i8 %28, metadata !171, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !223
  %29 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @xdp_parser_func.____fmt.1, i64 0, i64 0), i32 noundef 7) #4, !dbg !277
  %30 = icmp eq i8 %28, 58, !dbg !283
  br i1 %30, label %31, label %48, !dbg !279

31:                                               ; preds = %26
  call void @llvm.dbg.value(metadata i8* %20, metadata !170, metadata !DIExpression()), !dbg !223
  %32 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @xdp_parser_func.____fmt.2, i64 0, i64 0), i32 noundef 7) #4, !dbg !285
  %33 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @xdp_parser_func.____fmt.3, i64 0, i64 0), i32 noundef 7) #4, !dbg !287
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !144, metadata !DIExpression()) #4, !dbg !289
  call void @llvm.dbg.value(metadata i8* %6, metadata !145, metadata !DIExpression()) #4, !dbg !289
  call void @llvm.dbg.value(metadata %struct.icmp6hdr** undef, metadata !146, metadata !DIExpression()) #4, !dbg !289
  call void @llvm.dbg.value(metadata i8* %20, metadata !147, metadata !DIExpression()) #4, !dbg !289
  %34 = getelementptr i8, i8* %10, i64 62, !dbg !291
  %35 = bitcast i8* %34 to %struct.icmp6hdr*, !dbg !291
  %36 = inttoptr i64 %5 to %struct.icmp6hdr*, !dbg !293
  %37 = icmp ugt %struct.icmp6hdr* %35, %36, !dbg !294
  br i1 %37, label %47, label %38, !dbg !295

38:                                               ; preds = %31
  call void @llvm.dbg.value(metadata i8* %20, metadata !147, metadata !DIExpression()) #4, !dbg !289
  call void @llvm.dbg.value(metadata %struct.icmp6hdr* %35, metadata !170, metadata !DIExpression()), !dbg !223
  %39 = getelementptr i8, i8* %10, i64 60, !dbg !296
  %40 = bitcast i8* %39 to i16*, !dbg !296
  %41 = load i16, i16* %40, align 2, !dbg !296, !tbaa !297
  %42 = tail call i16 @llvm.bswap.i16(i16 %41) #4, !dbg !296
  %43 = zext i16 %42 to i32, !dbg !296
  call void @llvm.dbg.value(metadata i32 %43, metadata !148, metadata !DIExpression()) #4, !dbg !289
  %44 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @parse_icmp6hdr.____fmt, i64 0, i64 0), i32 noundef 7, i32 noundef %43) #4, !dbg !298
  call void @llvm.dbg.value(metadata i32 %43, metadata !216, metadata !DIExpression()), !dbg !223
  %45 = and i32 %43, 1, !dbg !300
  %46 = icmp eq i32 %45, 0, !dbg !300
  br i1 %46, label %48, label %47, !dbg !302

47:                                               ; preds = %31, %38
  call void @llvm.dbg.value(metadata i32 1, metadata !169, metadata !DIExpression()), !dbg !223
  br label %48, !dbg !303

48:                                               ; preds = %1, %24, %38, %26, %13, %47
  %49 = phi i32 [ 2, %13 ], [ 2, %26 ], [ 2, %38 ], [ 1, %47 ], [ 2, %24 ], [ 2, %1 ], !dbg !223
  call void @llvm.dbg.value(metadata i32 %49, metadata !169, metadata !DIExpression()), !dbg !223
  call void @llvm.dbg.label(metadata !217), !dbg !304
  %50 = bitcast i32* %2 to i8*, !dbg !305
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %50), !dbg !305
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !310, metadata !DIExpression()) #4, !dbg !305
  call void @llvm.dbg.value(metadata i32 %49, metadata !311, metadata !DIExpression()) #4, !dbg !305
  store i32 %49, i32* %2, align 4, !tbaa !314
  call void @llvm.dbg.value(metadata i32* %2, metadata !311, metadata !DIExpression(DW_OP_deref)) #4, !dbg !305
  %51 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.3* @xdp_stats_map to i8*), i8* noundef nonnull %50) #4, !dbg !315
  call void @llvm.dbg.value(metadata i8* %51, metadata !312, metadata !DIExpression()) #4, !dbg !305
  %52 = icmp eq i8* %51, null, !dbg !316
  br i1 %52, label %66, label %53, !dbg !318

53:                                               ; preds = %48
  call void @llvm.dbg.value(metadata i8* %51, metadata !312, metadata !DIExpression()) #4, !dbg !305
  %54 = bitcast i8* %51 to i64*, !dbg !319
  %55 = load i64, i64* %54, align 8, !dbg !320, !tbaa !321
  %56 = add i64 %55, 1, !dbg !320
  store i64 %56, i64* %54, align 8, !dbg !320, !tbaa !321
  %57 = load i32, i32* %3, align 4, !dbg !324, !tbaa !225
  %58 = load i32, i32* %7, align 4, !dbg !325, !tbaa !233
  %59 = sub i32 %57, %58, !dbg !326
  %60 = zext i32 %59 to i64, !dbg !327
  %61 = getelementptr inbounds i8, i8* %51, i64 8, !dbg !328
  %62 = bitcast i8* %61 to i64*, !dbg !328
  %63 = load i64, i64* %62, align 8, !dbg !329, !tbaa !330
  %64 = add i64 %63, %60, !dbg !329
  store i64 %64, i64* %62, align 8, !dbg !329, !tbaa !330
  %65 = load i32, i32* %2, align 4, !dbg !331, !tbaa !314
  call void @llvm.dbg.value(metadata i32 %65, metadata !311, metadata !DIExpression()) #4, !dbg !305
  br label %66, !dbg !332

66:                                               ; preds = %48, %53
  %67 = phi i32 [ %65, %53 ], [ 0, %48 ], !dbg !305
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %50), !dbg !333
  ret i32 %67, !dbg !334
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #2

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #2 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #3 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!20}
!llvm.module.flags = !{!218, !219, !220, !221}
!llvm.ident = !{!222}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "____fmt", scope: !2, file: !3, line: 144, type: !37, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "xdp_parser_func", scope: !3, file: !3, line: 115, type: !4, scopeLine: 116, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !156)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/meherrushi/Meher/learning/ebpf/networking/xdp_tutorial_follow/packet01-parsing", checksumkind: CSK_MD5, checksum: "86b933803e5cf009f4873562a08d6242")
!4 = !DISubroutineType(types: !5)
!5 = !{!6, !7}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !9, line: 5442, size: 192, elements: !10)
!9 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "5ad8bc925dae1ec87bbb04b3148b183b")
!10 = !{!11, !15, !16, !17, !18, !19}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !8, file: !9, line: 5443, baseType: !12, size: 32)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !13, line: 27, baseType: !14)
!13 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!14 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !8, file: !9, line: 5444, baseType: !12, size: 32, offset: 32)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !8, file: !9, line: 5445, baseType: !12, size: 32, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !8, file: !9, line: 5447, baseType: !12, size: 32, offset: 96)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !8, file: !9, line: 5448, baseType: !12, size: 32, offset: 128)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !8, file: !9, line: 5450, baseType: !12, size: 32, offset: 160)
!20 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !21, retainedTypes: !29, globals: !34, splitDebugInlining: false, nameTableKind: None)
!21 = !{!22}
!22 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !9, line: 5431, baseType: !14, size: 32, elements: !23)
!23 = !{!24, !25, !26, !27, !28}
!24 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!25 = !DIEnumerator(name: "XDP_DROP", value: 1)
!26 = !DIEnumerator(name: "XDP_PASS", value: 2)
!27 = !DIEnumerator(name: "XDP_TX", value: 3)
!28 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!29 = !{!30, !31, !32}
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!31 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!32 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !13, line: 24, baseType: !33)
!33 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!34 = !{!0, !35, !42, !44, !46, !51, !77, !84, !149}
!35 = !DIGlobalVariableExpression(var: !36, expr: !DIExpression())
!36 = distinct !DIGlobalVariable(name: "____fmt", scope: !2, file: !3, line: 183, type: !37, isLocal: true, isDefinition: true)
!37 = !DICompositeType(tag: DW_TAG_array_type, baseType: !38, size: 56, elements: !40)
!38 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !39)
!39 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!40 = !{!41}
!41 = !DISubrange(count: 7)
!42 = !DIGlobalVariableExpression(var: !43, expr: !DIExpression())
!43 = distinct !DIGlobalVariable(name: "____fmt", scope: !2, file: !3, line: 207, type: !37, isLocal: true, isDefinition: true)
!44 = !DIGlobalVariableExpression(var: !45, expr: !DIExpression())
!45 = distinct !DIGlobalVariable(name: "____fmt", scope: !2, file: !3, line: 218, type: !37, isLocal: true, isDefinition: true)
!46 = !DIGlobalVariableExpression(var: !47, expr: !DIExpression())
!47 = distinct !DIGlobalVariable(name: "_license", scope: !20, file: !3, line: 255, type: !48, isLocal: false, isDefinition: true)
!48 = !DICompositeType(tag: DW_TAG_array_type, baseType: !39, size: 32, elements: !49)
!49 = !{!50}
!50 = !DISubrange(count: 4)
!51 = !DIGlobalVariableExpression(var: !52, expr: !DIExpression())
!52 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !20, file: !53, line: 21, type: !54, isLocal: false, isDefinition: true)
!53 = !DIFile(filename: "./../common/xdp_stats_kern.h", directory: "/home/meherrushi/Meher/learning/ebpf/networking/xdp_tutorial_follow/packet01-parsing", checksumkind: CSK_MD5, checksum: "2ed732331d6abc83898e83bb58b37126")
!54 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !53, line: 16, size: 256, elements: !55)
!55 = !{!56, !61, !63, !72}
!56 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !54, file: !53, line: 17, baseType: !57, size: 64)
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !58, size: 64)
!58 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 192, elements: !59)
!59 = !{!60}
!60 = !DISubrange(count: 6)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !54, file: !53, line: 18, baseType: !62, size: 64, offset: 64)
!62 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !54, file: !53, line: 19, baseType: !64, size: 64, offset: 128)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !66, line: 10, size: 128, elements: !67)
!66 = !DIFile(filename: "./../common/xdp_stats_kern_user.h", directory: "/home/meherrushi/Meher/learning/ebpf/networking/xdp_tutorial_follow/packet01-parsing", checksumkind: CSK_MD5, checksum: "96c2435685fa7da2d24f219444d8659d")
!67 = !{!68, !71}
!68 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !65, file: !66, line: 11, baseType: !69, size: 64)
!69 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !13, line: 31, baseType: !70)
!70 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !65, file: !66, line: 12, baseType: !69, size: 64, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !54, file: !53, line: 20, baseType: !73, size: 64, offset: 192)
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !74, size: 64)
!74 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 160, elements: !75)
!75 = !{!76}
!76 = !DISubrange(count: 5)
!77 = !DIGlobalVariableExpression(var: !78, expr: !DIExpression())
!78 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !20, file: !79, line: 177, type: !80, isLocal: true, isDefinition: true)
!79 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/meherrushi/Meher/learning/ebpf/networking/xdp_tutorial_follow/packet01-parsing", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = !DISubroutineType(types: !82)
!82 = !{!31, !83, !12, null}
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!84 = !DIGlobalVariableExpression(var: !85, expr: !DIExpression())
!85 = distinct !DIGlobalVariable(name: "____fmt", scope: !86, file: !3, line: 107, type: !37, isLocal: true, isDefinition: true)
!86 = distinct !DISubprogram(name: "parse_icmp6hdr", scope: !3, file: !3, line: 92, type: !87, scopeLine: 95, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !143)
!87 = !DISubroutineType(types: !88)
!88 = !{!6, !89, !30, !93}
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !3, line: 18, size: 64, elements: !91)
!91 = !{!92}
!92 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !90, file: !3, line: 19, baseType: !30, size: 64)
!93 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !94, size: 64)
!94 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !95, size: 64)
!95 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmp6hdr", file: !96, line: 8, size: 64, elements: !97)
!96 = !DIFile(filename: "/usr/include/linux/icmpv6.h", directory: "", checksumkind: CSK_MD5, checksum: "0310ca5584e6f44f6eea6cf040ee84b9")
!97 = !{!98, !101, !102, !105}
!98 = !DIDerivedType(tag: DW_TAG_member, name: "icmp6_type", scope: !95, file: !96, line: 10, baseType: !99, size: 8)
!99 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !13, line: 21, baseType: !100)
!100 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "icmp6_code", scope: !95, file: !96, line: 11, baseType: !99, size: 8, offset: 8)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "icmp6_cksum", scope: !95, file: !96, line: 12, baseType: !103, size: 16, offset: 16)
!103 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !104, line: 31, baseType: !32)
!104 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "52ec79a38e49ac7d1dc9e146ba88a7b1")
!105 = !DIDerivedType(tag: DW_TAG_member, name: "icmp6_dataun", scope: !95, file: !96, line: 63, baseType: !106, size: 32, offset: 32)
!106 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !95, file: !96, line: 15, size: 32, elements: !107)
!107 = !{!108, !113, !118, !120, !125, !133}
!108 = !DIDerivedType(tag: DW_TAG_member, name: "un_data32", scope: !106, file: !96, line: 16, baseType: !109, size: 32)
!109 = !DICompositeType(tag: DW_TAG_array_type, baseType: !110, size: 32, elements: !111)
!110 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !104, line: 27, baseType: !12)
!111 = !{!112}
!112 = !DISubrange(count: 1)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "un_data16", scope: !106, file: !96, line: 17, baseType: !114, size: 32)
!114 = !DICompositeType(tag: DW_TAG_array_type, baseType: !115, size: 32, elements: !116)
!115 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !104, line: 25, baseType: !32)
!116 = !{!117}
!117 = !DISubrange(count: 2)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "un_data8", scope: !106, file: !96, line: 18, baseType: !119, size: 32)
!119 = !DICompositeType(tag: DW_TAG_array_type, baseType: !99, size: 32, elements: !49)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "u_echo", scope: !106, file: !96, line: 23, baseType: !121, size: 32)
!121 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmpv6_echo", file: !96, line: 20, size: 32, elements: !122)
!122 = !{!123, !124}
!123 = !DIDerivedType(tag: DW_TAG_member, name: "identifier", scope: !121, file: !96, line: 21, baseType: !115, size: 16)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "sequence", scope: !121, file: !96, line: 22, baseType: !115, size: 16, offset: 16)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "u_nd_advt", scope: !106, file: !96, line: 40, baseType: !126, size: 32)
!126 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmpv6_nd_advt", file: !96, line: 25, size: 32, elements: !127)
!127 = !{!128, !129, !130, !131, !132}
!128 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", scope: !126, file: !96, line: 27, baseType: !12, size: 5, flags: DIFlagBitField, extraData: i64 0)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "override", scope: !126, file: !96, line: 28, baseType: !12, size: 1, offset: 5, flags: DIFlagBitField, extraData: i64 0)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "solicited", scope: !126, file: !96, line: 29, baseType: !12, size: 1, offset: 6, flags: DIFlagBitField, extraData: i64 0)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "router", scope: !126, file: !96, line: 30, baseType: !12, size: 1, offset: 7, flags: DIFlagBitField, extraData: i64 0)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "reserved2", scope: !126, file: !96, line: 31, baseType: !12, size: 24, offset: 8, flags: DIFlagBitField, extraData: i64 0)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "u_nd_ra", scope: !106, file: !96, line: 61, baseType: !134, size: 32)
!134 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmpv6_nd_ra", file: !96, line: 42, size: 32, elements: !135)
!135 = !{!136, !137, !138, !139, !140, !141, !142}
!136 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !134, file: !96, line: 43, baseType: !99, size: 8)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", scope: !134, file: !96, line: 45, baseType: !99, size: 3, offset: 8, flags: DIFlagBitField, extraData: i64 8)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "router_pref", scope: !134, file: !96, line: 46, baseType: !99, size: 2, offset: 11, flags: DIFlagBitField, extraData: i64 8)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "home_agent", scope: !134, file: !96, line: 47, baseType: !99, size: 1, offset: 13, flags: DIFlagBitField, extraData: i64 8)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "other", scope: !134, file: !96, line: 48, baseType: !99, size: 1, offset: 14, flags: DIFlagBitField, extraData: i64 8)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "managed", scope: !134, file: !96, line: 49, baseType: !99, size: 1, offset: 15, flags: DIFlagBitField, extraData: i64 8)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "rt_lifetime", scope: !134, file: !96, line: 60, baseType: !115, size: 16, offset: 16)
!143 = !{!144, !145, !146, !147, !148}
!144 = !DILocalVariable(name: "nh", arg: 1, scope: !86, file: !3, line: 92, type: !89)
!145 = !DILocalVariable(name: "data_end", arg: 2, scope: !86, file: !3, line: 93, type: !30)
!146 = !DILocalVariable(name: "icmp6hdr", arg: 3, scope: !86, file: !3, line: 94, type: !93)
!147 = !DILocalVariable(name: "icmp6h", scope: !86, file: !3, line: 96, type: !94)
!148 = !DILocalVariable(name: "seq", scope: !86, file: !3, line: 106, type: !6)
!149 = !DIGlobalVariableExpression(var: !150, expr: !DIExpression())
!150 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !20, file: !79, line: 56, type: !151, isLocal: true, isDefinition: true)
!151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !152, size: 64)
!152 = !DISubroutineType(types: !153)
!153 = !{!30, !30, !154}
!154 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !155, size: 64)
!155 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!156 = !{!157, !158, !159, !160, !169, !170, !171, !172, !215, !216, !217}
!157 = !DILocalVariable(name: "ctx", arg: 1, scope: !2, file: !3, line: 115, type: !7)
!158 = !DILocalVariable(name: "data_end", scope: !2, file: !3, line: 117, type: !30)
!159 = !DILocalVariable(name: "data", scope: !2, file: !3, line: 118, type: !30)
!160 = !DILocalVariable(name: "eth", scope: !2, file: !3, line: 119, type: !161)
!161 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !162, size: 64)
!162 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !163, line: 168, size: 112, elements: !164)
!163 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "ab0320da726e75d904811ce344979934")
!164 = !{!165, !167, !168}
!165 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !162, file: !163, line: 169, baseType: !166, size: 48)
!166 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 48, elements: !59)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !162, file: !163, line: 170, baseType: !166, size: 48, offset: 48)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !162, file: !163, line: 171, baseType: !115, size: 16, offset: 96)
!169 = !DILocalVariable(name: "action", scope: !2, file: !3, line: 125, type: !12)
!170 = !DILocalVariable(name: "nh", scope: !2, file: !3, line: 128, type: !90)
!171 = !DILocalVariable(name: "nh_type", scope: !2, file: !3, line: 129, type: !6)
!172 = !DILocalVariable(name: "ip6hdr", scope: !2, file: !3, line: 179, type: !173)
!173 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !174, size: 64)
!174 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ipv6hdr", file: !175, line: 118, size: 320, elements: !176)
!175 = !DIFile(filename: "/usr/include/linux/ipv6.h", directory: "", checksumkind: CSK_MD5, checksum: "4f074a871dc410c98906d34687654389")
!176 = !{!177, !178, !179, !183, !184, !185, !186}
!177 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !174, file: !175, line: 120, baseType: !99, size: 4, flags: DIFlagBitField, extraData: i64 0)
!178 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !174, file: !175, line: 121, baseType: !99, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!179 = !DIDerivedType(tag: DW_TAG_member, name: "flow_lbl", scope: !174, file: !175, line: 128, baseType: !180, size: 24, offset: 8)
!180 = !DICompositeType(tag: DW_TAG_array_type, baseType: !99, size: 24, elements: !181)
!181 = !{!182}
!182 = !DISubrange(count: 3)
!183 = !DIDerivedType(tag: DW_TAG_member, name: "payload_len", scope: !174, file: !175, line: 130, baseType: !115, size: 16, offset: 32)
!184 = !DIDerivedType(tag: DW_TAG_member, name: "nexthdr", scope: !174, file: !175, line: 131, baseType: !99, size: 8, offset: 48)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !174, file: !175, line: 132, baseType: !99, size: 8, offset: 56)
!186 = !DIDerivedType(tag: DW_TAG_member, scope: !174, file: !175, line: 134, baseType: !187, size: 256, offset: 64)
!187 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !174, file: !175, line: 134, size: 256, elements: !188)
!188 = !{!189, !210}
!189 = !DIDerivedType(tag: DW_TAG_member, scope: !187, file: !175, line: 134, baseType: !190, size: 256)
!190 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !187, file: !175, line: 134, size: 256, elements: !191)
!191 = !{!192, !209}
!192 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !190, file: !175, line: 134, baseType: !193, size: 128)
!193 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "in6_addr", file: !194, line: 33, size: 128, elements: !195)
!194 = !DIFile(filename: "/usr/include/linux/in6.h", directory: "", checksumkind: CSK_MD5, checksum: "8bebb780b45d3fe932cc1d934fa5f5fe")
!195 = !{!196}
!196 = !DIDerivedType(tag: DW_TAG_member, name: "in6_u", scope: !193, file: !194, line: 40, baseType: !197, size: 128)
!197 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !193, file: !194, line: 34, size: 128, elements: !198)
!198 = !{!199, !203, !207}
!199 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr8", scope: !197, file: !194, line: 35, baseType: !200, size: 128)
!200 = !DICompositeType(tag: DW_TAG_array_type, baseType: !99, size: 128, elements: !201)
!201 = !{!202}
!202 = !DISubrange(count: 16)
!203 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr16", scope: !197, file: !194, line: 37, baseType: !204, size: 128)
!204 = !DICompositeType(tag: DW_TAG_array_type, baseType: !115, size: 128, elements: !205)
!205 = !{!206}
!206 = !DISubrange(count: 8)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr32", scope: !197, file: !194, line: 38, baseType: !208, size: 128)
!208 = !DICompositeType(tag: DW_TAG_array_type, baseType: !110, size: 128, elements: !49)
!209 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !190, file: !175, line: 134, baseType: !193, size: 128, offset: 128)
!210 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !187, file: !175, line: 134, baseType: !211, size: 256)
!211 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !187, file: !175, line: 134, size: 256, elements: !212)
!212 = !{!213, !214}
!213 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !211, file: !175, line: 134, baseType: !193, size: 128)
!214 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !211, file: !175, line: 134, baseType: !193, size: 128, offset: 128)
!215 = !DILocalVariable(name: "icmp6hdr", scope: !2, file: !3, line: 214, type: !94)
!216 = !DILocalVariable(name: "seq_num", scope: !2, file: !3, line: 244, type: !6)
!217 = !DILabel(scope: !2, name: "out", file: !3, line: 251)
!218 = !{i32 7, !"Dwarf Version", i32 5}
!219 = !{i32 2, !"Debug Info Version", i32 3}
!220 = !{i32 1, !"wchar_size", i32 4}
!221 = !{i32 7, !"frame-pointer", i32 2}
!222 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!223 = !DILocation(line: 0, scope: !2)
!224 = !DILocation(line: 117, column: 38, scope: !2)
!225 = !{!226, !227, i64 4}
!226 = !{!"xdp_md", !227, i64 0, !227, i64 4, !227, i64 8, !227, i64 12, !227, i64 16, !227, i64 20}
!227 = !{!"int", !228, i64 0}
!228 = !{!"omnipotent char", !229, i64 0}
!229 = !{!"Simple C/C++ TBAA"}
!230 = !DILocation(line: 117, column: 27, scope: !2)
!231 = !DILocation(line: 117, column: 19, scope: !2)
!232 = !DILocation(line: 118, column: 34, scope: !2)
!233 = !{!226, !227, i64 0}
!234 = !DILocation(line: 118, column: 23, scope: !2)
!235 = !DILocation(line: 118, column: 15, scope: !2)
!236 = !DILocalVariable(name: "nh", arg: 1, scope: !237, file: !3, line: 31, type: !89)
!237 = distinct !DISubprogram(name: "parse_ethhdr", scope: !3, file: !3, line: 31, type: !238, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !241)
!238 = !DISubroutineType(types: !239)
!239 = !{!6, !89, !30, !240}
!240 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !161, size: 64)
!241 = !{!236, !242, !243, !244, !245}
!242 = !DILocalVariable(name: "data_end", arg: 2, scope: !237, file: !3, line: 32, type: !30)
!243 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !237, file: !3, line: 33, type: !240)
!244 = !DILocalVariable(name: "eth", scope: !237, file: !3, line: 35, type: !161)
!245 = !DILocalVariable(name: "hdrsize", scope: !237, file: !3, line: 36, type: !6)
!246 = !DILocation(line: 0, scope: !237, inlinedAt: !247)
!247 = distinct !DILocation(line: 139, column: 12, scope: !2)
!248 = !DILocation(line: 41, column: 14, scope: !249, inlinedAt: !247)
!249 = distinct !DILexicalBlock(scope: !237, file: !3, line: 41, column: 6)
!250 = !DILocation(line: 41, column: 24, scope: !249, inlinedAt: !247)
!251 = !DILocation(line: 41, column: 6, scope: !237, inlinedAt: !247)
!252 = !DILocation(line: 47, column: 14, scope: !237, inlinedAt: !247)
!253 = !{!254, !255, i64 12}
!254 = !{!"ethhdr", !228, i64 0, !228, i64 6, !255, i64 12}
!255 = !{!"short", !228, i64 0}
!256 = !DILocation(line: 140, column: 14, scope: !257)
!257 = distinct !DILexicalBlock(scope: !2, file: !3, line: 140, column: 6)
!258 = !DILocation(line: 140, column: 6, scope: !2)
!259 = !DILocation(line: 144, column: 2, scope: !260)
!260 = distinct !DILexicalBlock(scope: !2, file: !3, line: 144, column: 2)
!261 = !DILocalVariable(name: "nh", arg: 1, scope: !262, file: !3, line: 51, type: !89)
!262 = distinct !DISubprogram(name: "parse_ip6hdr", scope: !3, file: !3, line: 51, type: !263, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !266)
!263 = !DISubroutineType(types: !264)
!264 = !{!6, !89, !30, !265}
!265 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !173, size: 64)
!266 = !{!261, !267, !268, !269}
!267 = !DILocalVariable(name: "data_end", arg: 2, scope: !262, file: !3, line: 52, type: !30)
!268 = !DILocalVariable(name: "ip6hdr", arg: 3, scope: !262, file: !3, line: 53, type: !265)
!269 = !DILocalVariable(name: "ip6h", scope: !262, file: !3, line: 55, type: !173)
!270 = !DILocation(line: 0, scope: !262, inlinedAt: !271)
!271 = distinct !DILocation(line: 182, column: 12, scope: !2)
!272 = !DILocation(line: 66, column: 11, scope: !273, inlinedAt: !271)
!273 = distinct !DILexicalBlock(scope: !262, file: !3, line: 66, column: 6)
!274 = !DILocation(line: 66, column: 17, scope: !273, inlinedAt: !271)
!275 = !DILocation(line: 66, column: 15, scope: !273, inlinedAt: !271)
!276 = !DILocation(line: 66, column: 6, scope: !262, inlinedAt: !271)
!277 = !DILocation(line: 183, column: 2, scope: !278)
!278 = distinct !DILexicalBlock(scope: !2, file: !3, line: 183, column: 2)
!279 = !DILocation(line: 203, column: 6, scope: !2)
!280 = !DILocation(line: 88, column: 15, scope: !262, inlinedAt: !271)
!281 = !{!282, !228, i64 6}
!282 = !{!"ipv6hdr", !228, i64 0, !228, i64 0, !228, i64 1, !255, i64 4, !228, i64 6, !228, i64 7, !228, i64 8}
!283 = !DILocation(line: 203, column: 14, scope: !284)
!284 = distinct !DILexicalBlock(scope: !2, file: !3, line: 203, column: 6)
!285 = !DILocation(line: 207, column: 2, scope: !286)
!286 = distinct !DILexicalBlock(scope: !2, file: !3, line: 207, column: 2)
!287 = !DILocation(line: 218, column: 2, scope: !288)
!288 = distinct !DILexicalBlock(scope: !2, file: !3, line: 218, column: 2)
!289 = !DILocation(line: 0, scope: !86, inlinedAt: !290)
!290 = distinct !DILocation(line: 245, column: 12, scope: !2)
!291 = !DILocation(line: 100, column: 13, scope: !292, inlinedAt: !290)
!292 = distinct !DILexicalBlock(scope: !86, file: !3, line: 100, column: 6)
!293 = !DILocation(line: 100, column: 18, scope: !292, inlinedAt: !290)
!294 = !DILocation(line: 100, column: 16, scope: !292, inlinedAt: !290)
!295 = !DILocation(line: 100, column: 6, scope: !86, inlinedAt: !290)
!296 = !DILocation(line: 106, column: 12, scope: !86, inlinedAt: !290)
!297 = !{!228, !228, i64 0}
!298 = !DILocation(line: 107, column: 2, scope: !299, inlinedAt: !290)
!299 = distinct !DILexicalBlock(scope: !86, file: !3, line: 107, column: 2)
!300 = !DILocation(line: 246, column: 16, scope: !301)
!301 = distinct !DILexicalBlock(scope: !2, file: !3, line: 246, column: 5)
!302 = !DILocation(line: 246, column: 5, scope: !2)
!303 = !DILocation(line: 249, column: 2, scope: !2)
!304 = !DILocation(line: 251, column: 1, scope: !2)
!305 = !DILocation(line: 0, scope: !306, inlinedAt: !313)
!306 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !53, file: !53, line: 24, type: !307, scopeLine: 25, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !20, retainedNodes: !309)
!307 = !DISubroutineType(types: !308)
!308 = !{!12, !7, !12}
!309 = !{!310, !311, !312}
!310 = !DILocalVariable(name: "ctx", arg: 1, scope: !306, file: !53, line: 24, type: !7)
!311 = !DILocalVariable(name: "action", arg: 2, scope: !306, file: !53, line: 24, type: !12)
!312 = !DILocalVariable(name: "rec", scope: !306, file: !53, line: 30, type: !64)
!313 = distinct !DILocation(line: 252, column: 9, scope: !2)
!314 = !{!227, !227, i64 0}
!315 = !DILocation(line: 30, column: 24, scope: !306, inlinedAt: !313)
!316 = !DILocation(line: 31, column: 7, scope: !317, inlinedAt: !313)
!317 = distinct !DILexicalBlock(scope: !306, file: !53, line: 31, column: 6)
!318 = !DILocation(line: 31, column: 6, scope: !306, inlinedAt: !313)
!319 = !DILocation(line: 38, column: 7, scope: !306, inlinedAt: !313)
!320 = !DILocation(line: 38, column: 17, scope: !306, inlinedAt: !313)
!321 = !{!322, !323, i64 0}
!322 = !{!"datarec", !323, i64 0, !323, i64 8}
!323 = !{!"long long", !228, i64 0}
!324 = !DILocation(line: 39, column: 25, scope: !306, inlinedAt: !313)
!325 = !DILocation(line: 39, column: 41, scope: !306, inlinedAt: !313)
!326 = !DILocation(line: 39, column: 34, scope: !306, inlinedAt: !313)
!327 = !DILocation(line: 39, column: 19, scope: !306, inlinedAt: !313)
!328 = !DILocation(line: 39, column: 7, scope: !306, inlinedAt: !313)
!329 = !DILocation(line: 39, column: 16, scope: !306, inlinedAt: !313)
!330 = !{!322, !323, i64 8}
!331 = !DILocation(line: 41, column: 9, scope: !306, inlinedAt: !313)
!332 = !DILocation(line: 41, column: 2, scope: !306, inlinedAt: !313)
!333 = !DILocation(line: 42, column: 1, scope: !306, inlinedAt: !313)
!334 = !DILocation(line: 252, column: 2, scope: !2)
