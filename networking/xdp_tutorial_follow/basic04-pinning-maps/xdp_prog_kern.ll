; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [6 x i32]*, i32*, %struct.datarec*, [5 x i32]* }
%struct.datarec = type { i64, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }

@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !0
@xdp_stats_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !18
@llvm.compiler.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_abort_func to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_drop_func to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_pass_func to i8*), i8* bitcast (%struct.anon* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_pass_func(%struct.xdp_md* nocapture noundef readonly %0) #0 section "xdp" !dbg !63 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !76, metadata !DIExpression()), !dbg !78
  call void @llvm.dbg.value(metadata i32 2, metadata !77, metadata !DIExpression()), !dbg !78
  %3 = bitcast i32* %2 to i8*, !dbg !79
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3), !dbg !79
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !84, metadata !DIExpression()) #3, !dbg !79
  call void @llvm.dbg.value(metadata i32 2, metadata !85, metadata !DIExpression()) #3, !dbg !79
  store i32 2, i32* %2, align 4, !tbaa !91
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !95
  %5 = load i32, i32* %4, align 4, !dbg !95, !tbaa !96
  call void @llvm.dbg.value(metadata i32 %5, metadata !86, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !79
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !98
  %7 = load i32, i32* %6, align 4, !dbg !98, !tbaa !99
  call void @llvm.dbg.value(metadata i32 %7, metadata !87, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !79
  call void @llvm.dbg.value(metadata i32* %2, metadata !85, metadata !DIExpression(DW_OP_deref)) #3, !dbg !79
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon* @xdp_stats_map to i8*), i8* noundef nonnull %3) #3, !dbg !100
  call void @llvm.dbg.value(metadata i8* %8, metadata !88, metadata !DIExpression()) #3, !dbg !79
  %9 = icmp eq i8* %8, null, !dbg !101
  br i1 %9, label %22, label %10, !dbg !103

10:                                               ; preds = %1
  %11 = zext i32 %7 to i64, !dbg !104
  call void @llvm.dbg.value(metadata i64 %11, metadata !87, metadata !DIExpression()) #3, !dbg !79
  %12 = zext i32 %5 to i64, !dbg !105
  call void @llvm.dbg.value(metadata i64 %12, metadata !86, metadata !DIExpression()) #3, !dbg !79
  call void @llvm.dbg.value(metadata i8* %8, metadata !88, metadata !DIExpression()) #3, !dbg !79
  %13 = sub nsw i64 %12, %11, !dbg !106
  call void @llvm.dbg.value(metadata i64 %13, metadata !89, metadata !DIExpression()) #3, !dbg !79
  %14 = bitcast i8* %8 to i64*, !dbg !107
  %15 = load i64, i64* %14, align 8, !dbg !108, !tbaa !109
  %16 = add i64 %15, 1, !dbg !108
  store i64 %16, i64* %14, align 8, !dbg !108, !tbaa !109
  %17 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !112
  %18 = bitcast i8* %17 to i64*, !dbg !112
  %19 = load i64, i64* %18, align 8, !dbg !113, !tbaa !114
  %20 = add i64 %13, %19, !dbg !113
  store i64 %20, i64* %18, align 8, !dbg !113, !tbaa !114
  %21 = load i32, i32* %2, align 4, !dbg !115, !tbaa !91
  call void @llvm.dbg.value(metadata i32 %21, metadata !85, metadata !DIExpression()) #3, !dbg !79
  br label %22

22:                                               ; preds = %1, %10
  %23 = phi i32 [ %21, %10 ], [ 0, %1 ], !dbg !79
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3), !dbg !116
  ret i32 %23, !dbg !117
}

; Function Attrs: nounwind
define dso_local i32 @xdp_drop_func(%struct.xdp_md* nocapture noundef readonly %0) #0 section "xdp" !dbg !118 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !120, metadata !DIExpression()), !dbg !122
  call void @llvm.dbg.value(metadata i32 1, metadata !121, metadata !DIExpression()), !dbg !122
  %3 = bitcast i32* %2 to i8*, !dbg !123
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3), !dbg !123
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !84, metadata !DIExpression()) #3, !dbg !123
  call void @llvm.dbg.value(metadata i32 1, metadata !85, metadata !DIExpression()) #3, !dbg !123
  store i32 1, i32* %2, align 4, !tbaa !91
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !125
  %5 = load i32, i32* %4, align 4, !dbg !125, !tbaa !96
  call void @llvm.dbg.value(metadata i32 %5, metadata !86, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !123
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !126
  %7 = load i32, i32* %6, align 4, !dbg !126, !tbaa !99
  call void @llvm.dbg.value(metadata i32 %7, metadata !87, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !123
  call void @llvm.dbg.value(metadata i32* %2, metadata !85, metadata !DIExpression(DW_OP_deref)) #3, !dbg !123
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon* @xdp_stats_map to i8*), i8* noundef nonnull %3) #3, !dbg !127
  call void @llvm.dbg.value(metadata i8* %8, metadata !88, metadata !DIExpression()) #3, !dbg !123
  %9 = icmp eq i8* %8, null, !dbg !128
  br i1 %9, label %22, label %10, !dbg !129

10:                                               ; preds = %1
  %11 = zext i32 %7 to i64, !dbg !130
  call void @llvm.dbg.value(metadata i64 %11, metadata !87, metadata !DIExpression()) #3, !dbg !123
  %12 = zext i32 %5 to i64, !dbg !131
  call void @llvm.dbg.value(metadata i64 %12, metadata !86, metadata !DIExpression()) #3, !dbg !123
  call void @llvm.dbg.value(metadata i8* %8, metadata !88, metadata !DIExpression()) #3, !dbg !123
  %13 = sub nsw i64 %12, %11, !dbg !132
  call void @llvm.dbg.value(metadata i64 %13, metadata !89, metadata !DIExpression()) #3, !dbg !123
  %14 = bitcast i8* %8 to i64*, !dbg !133
  %15 = load i64, i64* %14, align 8, !dbg !134, !tbaa !109
  %16 = add i64 %15, 1, !dbg !134
  store i64 %16, i64* %14, align 8, !dbg !134, !tbaa !109
  %17 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !135
  %18 = bitcast i8* %17 to i64*, !dbg !135
  %19 = load i64, i64* %18, align 8, !dbg !136, !tbaa !114
  %20 = add i64 %13, %19, !dbg !136
  store i64 %20, i64* %18, align 8, !dbg !136, !tbaa !114
  %21 = load i32, i32* %2, align 4, !dbg !137, !tbaa !91
  call void @llvm.dbg.value(metadata i32 %21, metadata !85, metadata !DIExpression()) #3, !dbg !123
  br label %22

22:                                               ; preds = %1, %10
  %23 = phi i32 [ %21, %10 ], [ 0, %1 ], !dbg !123
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3), !dbg !138
  ret i32 %23, !dbg !139
}

; Function Attrs: nounwind
define dso_local i32 @xdp_abort_func(%struct.xdp_md* nocapture noundef readonly %0) #0 section "xdp" !dbg !140 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !142, metadata !DIExpression()), !dbg !144
  call void @llvm.dbg.value(metadata i32 0, metadata !143, metadata !DIExpression()), !dbg !144
  %3 = bitcast i32* %2 to i8*, !dbg !145
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3), !dbg !145
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !84, metadata !DIExpression()) #3, !dbg !145
  call void @llvm.dbg.value(metadata i32 0, metadata !85, metadata !DIExpression()) #3, !dbg !145
  store i32 0, i32* %2, align 4, !tbaa !91
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !147
  %5 = load i32, i32* %4, align 4, !dbg !147, !tbaa !96
  call void @llvm.dbg.value(metadata i32 %5, metadata !86, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !145
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !148
  %7 = load i32, i32* %6, align 4, !dbg !148, !tbaa !99
  call void @llvm.dbg.value(metadata i32 %7, metadata !87, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !145
  call void @llvm.dbg.value(metadata i32* %2, metadata !85, metadata !DIExpression(DW_OP_deref)) #3, !dbg !145
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon* @xdp_stats_map to i8*), i8* noundef nonnull %3) #3, !dbg !149
  call void @llvm.dbg.value(metadata i8* %8, metadata !88, metadata !DIExpression()) #3, !dbg !145
  %9 = icmp eq i8* %8, null, !dbg !150
  br i1 %9, label %22, label %10, !dbg !151

10:                                               ; preds = %1
  %11 = zext i32 %7 to i64, !dbg !152
  call void @llvm.dbg.value(metadata i64 %11, metadata !87, metadata !DIExpression()) #3, !dbg !145
  %12 = zext i32 %5 to i64, !dbg !153
  call void @llvm.dbg.value(metadata i64 %12, metadata !86, metadata !DIExpression()) #3, !dbg !145
  call void @llvm.dbg.value(metadata i8* %8, metadata !88, metadata !DIExpression()) #3, !dbg !145
  %13 = sub nsw i64 %12, %11, !dbg !154
  call void @llvm.dbg.value(metadata i64 %13, metadata !89, metadata !DIExpression()) #3, !dbg !145
  %14 = bitcast i8* %8 to i64*, !dbg !155
  %15 = load i64, i64* %14, align 8, !dbg !156, !tbaa !109
  %16 = add i64 %15, 1, !dbg !156
  store i64 %16, i64* %14, align 8, !dbg !156, !tbaa !109
  %17 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !157
  %18 = bitcast i8* %17 to i64*, !dbg !157
  %19 = load i64, i64* %18, align 8, !dbg !158, !tbaa !114
  %20 = add i64 %13, %19, !dbg !158
  store i64 %20, i64* %18, align 8, !dbg !158, !tbaa !114
  %21 = load i32, i32* %2, align 4, !dbg !159, !tbaa !91
  call void @llvm.dbg.value(metadata i32 %21, metadata !85, metadata !DIExpression()) #3, !dbg !145
  br label %22

22:                                               ; preds = %1, %10
  %23 = phi i32 [ %21, %10 ], [ 0, %1 ], !dbg !145
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3), !dbg !160
  ret i32 %23, !dbg !161
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nofree nosync nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!58, !59, !60, !61}
!llvm.ident = !{!62}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 76, type: !54, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/meherrushi/Meher/learning/ebpf/networking/xdp_tutorial_follow/basic04-pinning-maps", checksumkind: CSK_MD5, checksum: "0e893abdf5d2d33f94a2cc0f4daae795")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 5431, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "5ad8bc925dae1ec87bbb04b3148b183b")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !{!15, !16}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!17 = !{!0, !18, !46}
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 16, type: !20, isLocal: false, isDefinition: true)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 11, size: 256, elements: !21)
!21 = !{!22, !28, !32, !41}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !20, file: !3, line: 12, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 192, elements: !26)
!25 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!26 = !{!27}
!27 = !DISubrange(count: 6)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !20, file: !3, line: 13, baseType: !29, size: 64, offset: 64)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !31, line: 27, baseType: !7)
!31 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!32 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !20, file: !3, line: 14, baseType: !33, size: 64, offset: 128)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !35, line: 8, size: 128, elements: !36)
!35 = !DIFile(filename: "./common_kern_user.h", directory: "/home/meherrushi/Meher/learning/ebpf/networking/xdp_tutorial_follow/basic04-pinning-maps", checksumkind: CSK_MD5, checksum: "af04273c734158c41bba4bd0b2216829")
!36 = !{!37, !40}
!37 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !34, file: !35, line: 9, baseType: !38, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !31, line: 31, baseType: !39)
!39 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !34, file: !35, line: 10, baseType: !38, size: 64, offset: 64)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !20, file: !3, line: 15, baseType: !42, size: 64, offset: 192)
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!43 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 160, elements: !44)
!44 = !{!45}
!45 = !DISubrange(count: 5)
!46 = !DIGlobalVariableExpression(var: !47, expr: !DIExpression())
!47 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !48, line: 56, type: !49, isLocal: true, isDefinition: true)
!48 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/meherrushi/Meher/learning/ebpf/networking/xdp_tutorial_follow/basic04-pinning-maps", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!50 = !DISubroutineType(types: !51)
!51 = !{!15, !15, !52}
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!54 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 32, elements: !56)
!55 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!56 = !{!57}
!57 = !DISubrange(count: 4)
!58 = !{i32 7, !"Dwarf Version", i32 5}
!59 = !{i32 2, !"Debug Info Version", i32 3}
!60 = !{i32 1, !"wchar_size", i32 4}
!61 = !{i32 7, !"frame-pointer", i32 2}
!62 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!63 = distinct !DISubprogram(name: "xdp_pass_func", scope: !3, file: !3, line: 53, type: !64, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !75)
!64 = !DISubroutineType(types: !65)
!65 = !{!25, !66}
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 5442, size: 192, elements: !68)
!68 = !{!69, !70, !71, !72, !73, !74}
!69 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !67, file: !6, line: 5443, baseType: !30, size: 32)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !67, file: !6, line: 5444, baseType: !30, size: 32, offset: 32)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !67, file: !6, line: 5445, baseType: !30, size: 32, offset: 64)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !67, file: !6, line: 5447, baseType: !30, size: 32, offset: 96)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !67, file: !6, line: 5448, baseType: !30, size: 32, offset: 128)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !67, file: !6, line: 5450, baseType: !30, size: 32, offset: 160)
!75 = !{!76, !77}
!76 = !DILocalVariable(name: "ctx", arg: 1, scope: !63, file: !3, line: 53, type: !66)
!77 = !DILocalVariable(name: "action", scope: !63, file: !3, line: 55, type: !30)
!78 = !DILocation(line: 0, scope: !63)
!79 = !DILocation(line: 0, scope: !80, inlinedAt: !90)
!80 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 26, type: !81, scopeLine: 27, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !83)
!81 = !DISubroutineType(types: !82)
!82 = !{!30, !66, !30}
!83 = !{!84, !85, !86, !87, !88, !89}
!84 = !DILocalVariable(name: "ctx", arg: 1, scope: !80, file: !3, line: 26, type: !66)
!85 = !DILocalVariable(name: "action", arg: 2, scope: !80, file: !3, line: 26, type: !30)
!86 = !DILocalVariable(name: "data_end", scope: !80, file: !3, line: 28, type: !15)
!87 = !DILocalVariable(name: "data", scope: !80, file: !3, line: 29, type: !15)
!88 = !DILocalVariable(name: "rec", scope: !80, file: !3, line: 35, type: !33)
!89 = !DILocalVariable(name: "bytes", scope: !80, file: !3, line: 40, type: !38)
!90 = distinct !DILocation(line: 57, column: 9, scope: !63)
!91 = !{!92, !92, i64 0}
!92 = !{!"int", !93, i64 0}
!93 = !{!"omnipotent char", !94, i64 0}
!94 = !{!"Simple C/C++ TBAA"}
!95 = !DILocation(line: 28, column: 38, scope: !80, inlinedAt: !90)
!96 = !{!97, !92, i64 4}
!97 = !{!"xdp_md", !92, i64 0, !92, i64 4, !92, i64 8, !92, i64 12, !92, i64 16, !92, i64 20}
!98 = !DILocation(line: 29, column: 38, scope: !80, inlinedAt: !90)
!99 = !{!97, !92, i64 0}
!100 = !DILocation(line: 35, column: 24, scope: !80, inlinedAt: !90)
!101 = !DILocation(line: 36, column: 7, scope: !102, inlinedAt: !90)
!102 = distinct !DILexicalBlock(scope: !80, file: !3, line: 36, column: 6)
!103 = !DILocation(line: 36, column: 6, scope: !80, inlinedAt: !90)
!104 = !DILocation(line: 29, column: 27, scope: !80, inlinedAt: !90)
!105 = !DILocation(line: 28, column: 27, scope: !80, inlinedAt: !90)
!106 = !DILocation(line: 40, column: 25, scope: !80, inlinedAt: !90)
!107 = !DILocation(line: 46, column: 7, scope: !80, inlinedAt: !90)
!108 = !DILocation(line: 46, column: 17, scope: !80, inlinedAt: !90)
!109 = !{!110, !111, i64 0}
!110 = !{!"datarec", !111, i64 0, !111, i64 8}
!111 = !{!"long long", !93, i64 0}
!112 = !DILocation(line: 47, column: 7, scope: !80, inlinedAt: !90)
!113 = !DILocation(line: 47, column: 16, scope: !80, inlinedAt: !90)
!114 = !{!110, !111, i64 8}
!115 = !DILocation(line: 49, column: 9, scope: !80, inlinedAt: !90)
!116 = !DILocation(line: 50, column: 1, scope: !80, inlinedAt: !90)
!117 = !DILocation(line: 57, column: 2, scope: !63)
!118 = distinct !DISubprogram(name: "xdp_drop_func", scope: !3, file: !3, line: 61, type: !64, scopeLine: 62, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !119)
!119 = !{!120, !121}
!120 = !DILocalVariable(name: "ctx", arg: 1, scope: !118, file: !3, line: 61, type: !66)
!121 = !DILocalVariable(name: "action", scope: !118, file: !3, line: 63, type: !30)
!122 = !DILocation(line: 0, scope: !118)
!123 = !DILocation(line: 0, scope: !80, inlinedAt: !124)
!124 = distinct !DILocation(line: 65, column: 9, scope: !118)
!125 = !DILocation(line: 28, column: 38, scope: !80, inlinedAt: !124)
!126 = !DILocation(line: 29, column: 38, scope: !80, inlinedAt: !124)
!127 = !DILocation(line: 35, column: 24, scope: !80, inlinedAt: !124)
!128 = !DILocation(line: 36, column: 7, scope: !102, inlinedAt: !124)
!129 = !DILocation(line: 36, column: 6, scope: !80, inlinedAt: !124)
!130 = !DILocation(line: 29, column: 27, scope: !80, inlinedAt: !124)
!131 = !DILocation(line: 28, column: 27, scope: !80, inlinedAt: !124)
!132 = !DILocation(line: 40, column: 25, scope: !80, inlinedAt: !124)
!133 = !DILocation(line: 46, column: 7, scope: !80, inlinedAt: !124)
!134 = !DILocation(line: 46, column: 17, scope: !80, inlinedAt: !124)
!135 = !DILocation(line: 47, column: 7, scope: !80, inlinedAt: !124)
!136 = !DILocation(line: 47, column: 16, scope: !80, inlinedAt: !124)
!137 = !DILocation(line: 49, column: 9, scope: !80, inlinedAt: !124)
!138 = !DILocation(line: 50, column: 1, scope: !80, inlinedAt: !124)
!139 = !DILocation(line: 65, column: 2, scope: !118)
!140 = distinct !DISubprogram(name: "xdp_abort_func", scope: !3, file: !3, line: 69, type: !64, scopeLine: 70, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !141)
!141 = !{!142, !143}
!142 = !DILocalVariable(name: "ctx", arg: 1, scope: !140, file: !3, line: 69, type: !66)
!143 = !DILocalVariable(name: "action", scope: !140, file: !3, line: 71, type: !30)
!144 = !DILocation(line: 0, scope: !140)
!145 = !DILocation(line: 0, scope: !80, inlinedAt: !146)
!146 = distinct !DILocation(line: 73, column: 9, scope: !140)
!147 = !DILocation(line: 28, column: 38, scope: !80, inlinedAt: !146)
!148 = !DILocation(line: 29, column: 38, scope: !80, inlinedAt: !146)
!149 = !DILocation(line: 35, column: 24, scope: !80, inlinedAt: !146)
!150 = !DILocation(line: 36, column: 7, scope: !102, inlinedAt: !146)
!151 = !DILocation(line: 36, column: 6, scope: !80, inlinedAt: !146)
!152 = !DILocation(line: 29, column: 27, scope: !80, inlinedAt: !146)
!153 = !DILocation(line: 28, column: 27, scope: !80, inlinedAt: !146)
!154 = !DILocation(line: 40, column: 25, scope: !80, inlinedAt: !146)
!155 = !DILocation(line: 46, column: 7, scope: !80, inlinedAt: !146)
!156 = !DILocation(line: 46, column: 17, scope: !80, inlinedAt: !146)
!157 = !DILocation(line: 47, column: 7, scope: !80, inlinedAt: !146)
!158 = !DILocation(line: 47, column: 16, scope: !80, inlinedAt: !146)
!159 = !DILocation(line: 49, column: 9, scope: !80, inlinedAt: !146)
!160 = !DILocation(line: 50, column: 1, scope: !80, inlinedAt: !146)
!161 = !DILocation(line: 73, column: 2, scope: !140)
