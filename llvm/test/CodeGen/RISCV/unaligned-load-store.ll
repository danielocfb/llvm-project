; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=BOTH,RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=BOTH,RV64I %s

; A collection of cases showing codegen for unaligned loads and stores

define i8 @load_i8(i8* %p) {
; BOTH-LABEL: load_i8:
; BOTH:       # %bb.0:
; BOTH-NEXT:    lb a0, 0(a0)
; BOTH-NEXT:    ret
  %res = load i8, i8* %p, align 1
  ret i8 %res
}

define i16 @load_i16(i16* %p) {
; BOTH-LABEL: load_i16:
; BOTH:       # %bb.0:
; BOTH-NEXT:    lb a1, 1(a0)
; BOTH-NEXT:    lbu a0, 0(a0)
; BOTH-NEXT:    slli a1, a1, 8
; BOTH-NEXT:    or a0, a1, a0
; BOTH-NEXT:    ret
  %res = load i16, i16* %p, align 1
  ret i16 %res
}

define i24 @load_i24(i24* %p) {
; BOTH-LABEL: load_i24:
; BOTH:       # %bb.0:
; BOTH-NEXT:    lbu a1, 1(a0)
; BOTH-NEXT:    lbu a2, 0(a0)
; BOTH-NEXT:    lb a0, 2(a0)
; BOTH-NEXT:    slli a1, a1, 8
; BOTH-NEXT:    or a1, a1, a2
; BOTH-NEXT:    slli a0, a0, 16
; BOTH-NEXT:    or a0, a1, a0
; BOTH-NEXT:    ret
  %res = load i24, i24* %p, align 1
  ret i24 %res
}

define i32 @load_i32(i32* %p) {
; RV32I-LABEL: load_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lbu a1, 1(a0)
; RV32I-NEXT:    lbu a2, 0(a0)
; RV32I-NEXT:    lbu a3, 3(a0)
; RV32I-NEXT:    lbu a0, 2(a0)
; RV32I-NEXT:    slli a1, a1, 8
; RV32I-NEXT:    or a1, a1, a2
; RV32I-NEXT:    slli a2, a3, 8
; RV32I-NEXT:    or a0, a2, a0
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: load_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lbu a1, 1(a0)
; RV64I-NEXT:    lbu a2, 0(a0)
; RV64I-NEXT:    lb a3, 3(a0)
; RV64I-NEXT:    lbu a0, 2(a0)
; RV64I-NEXT:    slli a1, a1, 8
; RV64I-NEXT:    or a1, a1, a2
; RV64I-NEXT:    slli a2, a3, 8
; RV64I-NEXT:    or a0, a2, a0
; RV64I-NEXT:    slli a0, a0, 16
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret
  %res = load i32, i32* %p, align 1
  ret i32 %res
}

define i64 @load_i64(i64* %p) {
; RV32I-LABEL: load_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lbu a1, 1(a0)
; RV32I-NEXT:    lbu a2, 0(a0)
; RV32I-NEXT:    lbu a3, 3(a0)
; RV32I-NEXT:    lbu a4, 2(a0)
; RV32I-NEXT:    slli a1, a1, 8
; RV32I-NEXT:    or a1, a1, a2
; RV32I-NEXT:    slli a2, a3, 8
; RV32I-NEXT:    or a2, a2, a4
; RV32I-NEXT:    slli a2, a2, 16
; RV32I-NEXT:    or a2, a2, a1
; RV32I-NEXT:    lbu a1, 5(a0)
; RV32I-NEXT:    lbu a3, 4(a0)
; RV32I-NEXT:    lbu a4, 7(a0)
; RV32I-NEXT:    lbu a0, 6(a0)
; RV32I-NEXT:    slli a1, a1, 8
; RV32I-NEXT:    or a1, a1, a3
; RV32I-NEXT:    slli a3, a4, 8
; RV32I-NEXT:    or a0, a3, a0
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    or a1, a0, a1
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: load_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lbu a1, 1(a0)
; RV64I-NEXT:    lbu a2, 0(a0)
; RV64I-NEXT:    lbu a3, 3(a0)
; RV64I-NEXT:    lbu a4, 2(a0)
; RV64I-NEXT:    slli a1, a1, 8
; RV64I-NEXT:    or a1, a1, a2
; RV64I-NEXT:    slli a2, a3, 8
; RV64I-NEXT:    or a2, a2, a4
; RV64I-NEXT:    slli a2, a2, 16
; RV64I-NEXT:    or a1, a2, a1
; RV64I-NEXT:    lbu a2, 5(a0)
; RV64I-NEXT:    lbu a3, 4(a0)
; RV64I-NEXT:    lbu a4, 7(a0)
; RV64I-NEXT:    lbu a0, 6(a0)
; RV64I-NEXT:    slli a2, a2, 8
; RV64I-NEXT:    or a2, a2, a3
; RV64I-NEXT:    slli a3, a4, 8
; RV64I-NEXT:    or a0, a3, a0
; RV64I-NEXT:    slli a0, a0, 16
; RV64I-NEXT:    or a0, a0, a2
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret
  %res = load i64, i64* %p, align 1
  ret i64 %res
}

define void @store_i8(i8* %p, i8 %v) {
; BOTH-LABEL: store_i8:
; BOTH:       # %bb.0:
; BOTH-NEXT:    sb a1, 0(a0)
; BOTH-NEXT:    ret
  store i8 %v, i8* %p, align 1
  ret void
}

define void @store_i16(i16* %p, i16 %v) {
; BOTH-LABEL: store_i16:
; BOTH:       # %bb.0:
; BOTH-NEXT:    sb a1, 0(a0)
; BOTH-NEXT:    srli a1, a1, 8
; BOTH-NEXT:    sb a1, 1(a0)
; BOTH-NEXT:    ret
  store i16 %v, i16* %p, align 1
  ret void
}

define void @store_i24(i24* %p, i24 %v) {
; BOTH-LABEL: store_i24:
; BOTH:       # %bb.0:
; BOTH-NEXT:    sb a1, 0(a0)
; BOTH-NEXT:    srli a2, a1, 8
; BOTH-NEXT:    sb a2, 1(a0)
; BOTH-NEXT:    srli a1, a1, 16
; BOTH-NEXT:    sb a1, 2(a0)
; BOTH-NEXT:    ret
  store i24 %v, i24* %p, align 1
  ret void
}

define void @store_i32(i32* %p, i32 %v) {
; BOTH-LABEL: store_i32:
; BOTH:       # %bb.0:
; BOTH-NEXT:    sb a1, 0(a0)
; BOTH-NEXT:    srli a2, a1, 24
; BOTH-NEXT:    sb a2, 3(a0)
; BOTH-NEXT:    srli a2, a1, 16
; BOTH-NEXT:    sb a2, 2(a0)
; BOTH-NEXT:    srli a1, a1, 8
; BOTH-NEXT:    sb a1, 1(a0)
; BOTH-NEXT:    ret
  store i32 %v, i32* %p, align 1
  ret void
}

define void @store_i64(i64* %p, i64 %v) {
; RV32I-LABEL: store_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sb a2, 4(a0)
; RV32I-NEXT:    sb a1, 0(a0)
; RV32I-NEXT:    srli a3, a2, 24
; RV32I-NEXT:    sb a3, 7(a0)
; RV32I-NEXT:    srli a3, a2, 16
; RV32I-NEXT:    sb a3, 6(a0)
; RV32I-NEXT:    srli a2, a2, 8
; RV32I-NEXT:    sb a2, 5(a0)
; RV32I-NEXT:    srli a2, a1, 24
; RV32I-NEXT:    sb a2, 3(a0)
; RV32I-NEXT:    srli a2, a1, 16
; RV32I-NEXT:    sb a2, 2(a0)
; RV32I-NEXT:    srli a1, a1, 8
; RV32I-NEXT:    sb a1, 1(a0)
; RV32I-NEXT:    ret
;
; RV64I-LABEL: store_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sb a1, 0(a0)
; RV64I-NEXT:    srli a2, a1, 56
; RV64I-NEXT:    sb a2, 7(a0)
; RV64I-NEXT:    srli a2, a1, 48
; RV64I-NEXT:    sb a2, 6(a0)
; RV64I-NEXT:    srli a2, a1, 40
; RV64I-NEXT:    sb a2, 5(a0)
; RV64I-NEXT:    srli a2, a1, 32
; RV64I-NEXT:    sb a2, 4(a0)
; RV64I-NEXT:    srli a2, a1, 24
; RV64I-NEXT:    sb a2, 3(a0)
; RV64I-NEXT:    srli a2, a1, 16
; RV64I-NEXT:    sb a2, 2(a0)
; RV64I-NEXT:    srli a1, a1, 8
; RV64I-NEXT:    sb a1, 1(a0)
; RV64I-NEXT:    ret
  store i64 %v, i64* %p, align 1
  ret void
}


