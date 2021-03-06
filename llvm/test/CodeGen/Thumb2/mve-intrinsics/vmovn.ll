; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve -verify-machineinstrs -o - %s | FileCheck --check-prefix=LE %s
; RUN: llc -mtriple=thumbebv8.1m.main -mattr=+mve -verify-machineinstrs -o - %s | FileCheck --check-prefix=BE %s

define arm_aapcs_vfpcc <16 x i8> @test_vmovnbq_s16(<16 x i8> %a, <8 x i16> %b) {
; LE-LABEL: test_vmovnbq_s16:
; LE:       @ %bb.0: @ %entry
; LE-NEXT:    vmovnb.i16 q0, q1
; LE-NEXT:    bx lr
;
; BE-LABEL: test_vmovnbq_s16:
; BE:       @ %bb.0: @ %entry
; BE-NEXT:    vrev64.16 q2, q1
; BE-NEXT:    vrev64.8 q1, q0
; BE-NEXT:    vmovnb.i16 q1, q2
; BE-NEXT:    vrev64.8 q0, q1
; BE-NEXT:    bx lr
entry:
  %0 = shufflevector <16 x i8> %a, <16 x i8> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  %1 = tail call <8 x i16> @llvm.arm.mve.vreinterpretq.v8i16.v16i8(<16 x i8> %0)
  %2 = shufflevector <8 x i16> %b, <8 x i16> %1, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  %3 = trunc <16 x i16> %2 to <16 x i8>
  ret <16 x i8> %3
}

define arm_aapcs_vfpcc <8 x i16> @test_vmovnbq_s32(<8 x i16> %a, <4 x i32> %b) {
; LE-LABEL: test_vmovnbq_s32:
; LE:       @ %bb.0: @ %entry
; LE-NEXT:    vmovnb.i32 q0, q1
; LE-NEXT:    bx lr
;
; BE-LABEL: test_vmovnbq_s32:
; BE:       @ %bb.0: @ %entry
; BE-NEXT:    vrev64.32 q2, q1
; BE-NEXT:    vrev64.16 q1, q0
; BE-NEXT:    vmovnb.i32 q1, q2
; BE-NEXT:    vrev64.16 q0, q1
; BE-NEXT:    bx lr
entry:
  %0 = shufflevector <8 x i16> %a, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %1 = tail call <4 x i32> @llvm.arm.mve.vreinterpretq.v4i32.v8i16(<8 x i16> %0)
  %2 = shufflevector <4 x i32> %b, <4 x i32> %1, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  %3 = trunc <8 x i32> %2 to <8 x i16>
  ret <8 x i16> %3
}

define arm_aapcs_vfpcc <16 x i8> @test_vmovnbq_u16(<16 x i8> %a, <8 x i16> %b) {
; LE-LABEL: test_vmovnbq_u16:
; LE:       @ %bb.0: @ %entry
; LE-NEXT:    vmovnb.i16 q0, q1
; LE-NEXT:    bx lr
;
; BE-LABEL: test_vmovnbq_u16:
; BE:       @ %bb.0: @ %entry
; BE-NEXT:    vrev64.16 q2, q1
; BE-NEXT:    vrev64.8 q1, q0
; BE-NEXT:    vmovnb.i16 q1, q2
; BE-NEXT:    vrev64.8 q0, q1
; BE-NEXT:    bx lr
entry:
  %0 = shufflevector <16 x i8> %a, <16 x i8> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  %1 = tail call <8 x i16> @llvm.arm.mve.vreinterpretq.v8i16.v16i8(<16 x i8> %0)
  %2 = shufflevector <8 x i16> %b, <8 x i16> %1, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  %3 = trunc <16 x i16> %2 to <16 x i8>
  ret <16 x i8> %3
}

define arm_aapcs_vfpcc <8 x i16> @test_vmovnbq_u32(<8 x i16> %a, <4 x i32> %b) {
; LE-LABEL: test_vmovnbq_u32:
; LE:       @ %bb.0: @ %entry
; LE-NEXT:    vmovnb.i32 q0, q1
; LE-NEXT:    bx lr
;
; BE-LABEL: test_vmovnbq_u32:
; BE:       @ %bb.0: @ %entry
; BE-NEXT:    vrev64.32 q2, q1
; BE-NEXT:    vrev64.16 q1, q0
; BE-NEXT:    vmovnb.i32 q1, q2
; BE-NEXT:    vrev64.16 q0, q1
; BE-NEXT:    bx lr
entry:
  %0 = shufflevector <8 x i16> %a, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %1 = tail call <4 x i32> @llvm.arm.mve.vreinterpretq.v4i32.v8i16(<8 x i16> %0)
  %2 = shufflevector <4 x i32> %b, <4 x i32> %1, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  %3 = trunc <8 x i32> %2 to <8 x i16>
  ret <8 x i16> %3
}

define arm_aapcs_vfpcc <16 x i8> @test_vmovntq_s16(<16 x i8> %a, <8 x i16> %b) {
; LE-LABEL: test_vmovntq_s16:
; LE:       @ %bb.0: @ %entry
; LE-NEXT:    vmovnt.i16 q0, q1
; LE-NEXT:    bx lr
;
; BE-LABEL: test_vmovntq_s16:
; BE:       @ %bb.0: @ %entry
; BE-NEXT:    vrev64.16 q2, q1
; BE-NEXT:    vrev64.8 q1, q0
; BE-NEXT:    vmovnt.i16 q1, q2
; BE-NEXT:    vrev64.8 q0, q1
; BE-NEXT:    bx lr
entry:
  %0 = tail call <8 x i16> @llvm.arm.mve.vreinterpretq.v8i16.v16i8(<16 x i8> %a)
  %1 = shufflevector <8 x i16> %0, <8 x i16> %b, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  %2 = trunc <16 x i16> %1 to <16 x i8>
  ret <16 x i8> %2
}

define arm_aapcs_vfpcc <8 x i16> @test_vmovntq_s32(<8 x i16> %a, <4 x i32> %b) {
; LE-LABEL: test_vmovntq_s32:
; LE:       @ %bb.0: @ %entry
; LE-NEXT:    vmovnt.i32 q0, q1
; LE-NEXT:    bx lr
;
; BE-LABEL: test_vmovntq_s32:
; BE:       @ %bb.0: @ %entry
; BE-NEXT:    vrev64.32 q2, q1
; BE-NEXT:    vrev64.16 q1, q0
; BE-NEXT:    vmovnt.i32 q1, q2
; BE-NEXT:    vrev64.16 q0, q1
; BE-NEXT:    bx lr
entry:
  %0 = tail call <4 x i32> @llvm.arm.mve.vreinterpretq.v4i32.v8i16(<8 x i16> %a)
  %1 = shufflevector <4 x i32> %0, <4 x i32> %b, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  %2 = trunc <8 x i32> %1 to <8 x i16>
  ret <8 x i16> %2
}

define arm_aapcs_vfpcc <16 x i8> @test_vmovntq_u16(<16 x i8> %a, <8 x i16> %b) {
; LE-LABEL: test_vmovntq_u16:
; LE:       @ %bb.0: @ %entry
; LE-NEXT:    vmovnt.i16 q0, q1
; LE-NEXT:    bx lr
;
; BE-LABEL: test_vmovntq_u16:
; BE:       @ %bb.0: @ %entry
; BE-NEXT:    vrev64.16 q2, q1
; BE-NEXT:    vrev64.8 q1, q0
; BE-NEXT:    vmovnt.i16 q1, q2
; BE-NEXT:    vrev64.8 q0, q1
; BE-NEXT:    bx lr
entry:
  %0 = tail call <8 x i16> @llvm.arm.mve.vreinterpretq.v8i16.v16i8(<16 x i8> %a)
  %1 = shufflevector <8 x i16> %0, <8 x i16> %b, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  %2 = trunc <16 x i16> %1 to <16 x i8>
  ret <16 x i8> %2
}

define arm_aapcs_vfpcc <8 x i16> @test_vmovntq_u32(<8 x i16> %a, <4 x i32> %b) {
; LE-LABEL: test_vmovntq_u32:
; LE:       @ %bb.0: @ %entry
; LE-NEXT:    vmovnt.i32 q0, q1
; LE-NEXT:    bx lr
;
; BE-LABEL: test_vmovntq_u32:
; BE:       @ %bb.0: @ %entry
; BE-NEXT:    vrev64.32 q2, q1
; BE-NEXT:    vrev64.16 q1, q0
; BE-NEXT:    vmovnt.i32 q1, q2
; BE-NEXT:    vrev64.16 q0, q1
; BE-NEXT:    bx lr
entry:
  %0 = tail call <4 x i32> @llvm.arm.mve.vreinterpretq.v4i32.v8i16(<8 x i16> %a)
  %1 = shufflevector <4 x i32> %0, <4 x i32> %b, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  %2 = trunc <8 x i32> %1 to <8 x i16>
  ret <8 x i16> %2
}

declare <8 x i16> @llvm.arm.mve.vreinterpretq.v8i16.v16i8(<16 x i8>)
declare <4 x i32> @llvm.arm.mve.vreinterpretq.v4i32.v8i16(<8 x i16>)
