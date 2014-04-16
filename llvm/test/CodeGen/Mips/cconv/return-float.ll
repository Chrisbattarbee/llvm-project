; RUN: llc -march=mips -soft-float -relocation-model=static < %s | FileCheck --check-prefix=ALL --check-prefix=O32 %s
; RUN: llc -march=mipsel -soft-float -relocation-model=static < %s | FileCheck --check-prefix=ALL --check-prefix=O32 %s

; RUN-TODO: llc -march=mips64 -soft-float -relocation-model=static -mattr=-n64,+o32 < %s | FileCheck --check-prefix=ALL --check-prefix=O32 %s
; RUN-TODO: llc -march=mips64el -soft-float -relocation-model=static -mattr=-n64,+o32 < %s | FileCheck --check-prefix=ALL --check-prefix=O32 %s

; RUN: llc -march=mips64 -soft-float -relocation-model=static -mattr=-n64,+n32 < %s | FileCheck --check-prefix=ALL --check-prefix=N32 %s
; RUN: llc -march=mips64el -soft-float -relocation-model=static -mattr=-n64,+n32 < %s | FileCheck --check-prefix=ALL --check-prefix=N32 %s

; RUN: llc -march=mips64 -soft-float -relocation-model=static -mattr=-n64,+n64 < %s | FileCheck --check-prefix=ALL --check-prefix=N64 %s
; RUN: llc -march=mips64el -soft-float -relocation-model=static -mattr=-n64,+n64 < %s | FileCheck --check-prefix=ALL --check-prefix=N64 %s

; Test the float returns for all ABI's and byte orders as specified by
; section 5 of MD00305 (MIPS ABIs Described).

@float = global float zeroinitializer
@double = global double zeroinitializer

define float @retfloat() nounwind {
entry:
        %0 = load volatile float* @float
        ret float %0
}

; ALL-LABEL: retfloat:
; O32-DAG:           lui [[R1:\$[0-9]+]], %hi(float)
; O32-DAG:           lw $2, %lo(float)([[R1]])
; N32-DAG:           lui [[R1:\$[0-9]+]], %hi(float)
; N32-DAG:           lw $2, %lo(float)([[R1]])
; N64-DAG:           ld  [[R1:\$[0-9]+]], %got_disp(float)($1)
; N64-DAG:           lw $2, 0([[R1]])

define double @retdouble() nounwind {
entry:
        %0 = load volatile double* @double
        ret double %0
}

; ALL-LABEL: retdouble:
; O32-DAG:           lw $2, %lo(double)([[R1:\$[0-9]+]])
; O32-DAG:           addiu [[R2:\$[0-9]+]], [[R1]], %lo(double)
; O32-DAG:           lw $3, 4([[R2]])
; N32-DAG:           ld $2, %lo(double)([[R1:\$[0-9]+]])
; N64-DAG:           ld  [[R1:\$[0-9]+]], %got_disp(double)($1)
; N64-DAG:           ld $2, 0([[R1]])
