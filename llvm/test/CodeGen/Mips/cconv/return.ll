; RUN: llc -march=mips -relocation-model=static < %s | FileCheck --check-prefix=ALL --check-prefix=O32 %s
; RUN: llc -march=mipsel -relocation-model=static < %s | FileCheck --check-prefix=ALL --check-prefix=O32 %s

; RUN-TODO: llc -march=mips64 -relocation-model=static -mattr=-n64,+o32 < %s | FileCheck --check-prefix=ALL --check-prefix=O32 %s
; RUN-TODO: llc -march=mips64el -relocation-model=static -mattr=-n64,+o32 < %s | FileCheck --check-prefix=ALL --check-prefix=O32 %s

; RUN: llc -march=mips64 -relocation-model=static -mattr=-n64,+n32 < %s | FileCheck --check-prefix=ALL --check-prefix=N32 %s
; RUN: llc -march=mips64el -relocation-model=static -mattr=-n64,+n32 < %s | FileCheck --check-prefix=ALL --check-prefix=N32 %s

; RUN: llc -march=mips64 -relocation-model=static -mattr=-n64,+n64 < %s | FileCheck --check-prefix=ALL --check-prefix=N64 %s
; RUN: llc -march=mips64el -relocation-model=static -mattr=-n64,+n64 < %s | FileCheck --check-prefix=ALL --check-prefix=N64 %s

; Test the integer returns for all ABI's and byte orders as specified by
; section 5 of MD00305 (MIPS ABIs Described).
;
@byte = global i8 zeroinitializer
@word = global i32 zeroinitializer
@dword = global i64 zeroinitializer
@float = global float zeroinitializer
@double = global double zeroinitializer

define i8 @reti8() nounwind {
entry:
        %0 = load volatile i8* @byte
        ret i8 %0
}

; ALL-LABEL: reti8:
; O32-DAG:           lui [[R1:\$[0-9]+]], %hi(byte)
; O32-DAG:           lbu $2, %lo(byte)([[R1]])
; N32-DAG:           lui [[R1:\$[0-9]+]], %hi(byte)
; N32-DAG:           lbu $2, %lo(byte)([[R1]])
; N64-DAG:           ld  [[R1:\$[0-9]+]], %got_disp(byte)($1)
; N64-DAG:           lbu $2, 0([[R1]])

define i32 @reti32() nounwind {
entry:
        %0 = load volatile i32* @word
        ret i32 %0
}

; ALL-LABEL: reti32:
; O32-DAG:           lui [[R1:\$[0-9]+]], %hi(word)
; O32-DAG:           lw $2, %lo(word)([[R1]])
; N32-DAG:           lui [[R1:\$[0-9]+]], %hi(word)
; N32-DAG:           lw $2, %lo(word)([[R1]])
; N64-DAG:           ld  [[R1:\$[0-9]+]], %got_disp(word)($1)
; N64-DAG:           lw $2, 0([[R1]])

define i64 @reti64() nounwind {
entry:
        %0 = load volatile i64* @dword
        ret i64 %0
}

; ALL-LABEL: reti64:
; On O32, we must use v0 and v1 for the return value
; O32-DAG:           lw $2, %lo(dword)([[R1:\$[0-9]+]])
; O32-DAG:           addiu [[R2:\$[0-9]+]], [[R1]], %lo(dword)
; O32-DAG:           lw $3, 4([[R2]])
; N32-DAG:           ld $2, %lo(dword)([[R1:\$[0-9]+]])
; N64-DAG:           ld  [[R1:\$[0-9]+]], %got_disp(dword)([[R1:\$[0-9]+]])
; N64-DAG:           ld $2, 0([[R1]])
