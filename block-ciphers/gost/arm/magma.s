.globl gost_key_schedule @ void gost_key_schedule(unsigned char key[128])
.globl gost_encrypt      @ void gost_encrypt(unsigned char buffer[8], const unsigned char key[128])
.globl gost_decrypt      @ void gost_decrypt(unsigned char buffer[8], const unsigned char key[128])

.section .text,"ax",%progbits

.balign 64

pi: .byte 12,  4,  6,  2, 10,  5, 11,  9, 14,  8, 13,  7,  0,  3, 15,  1
    .byte  6,  8,  2,  3,  9, 10,  5, 12,  1, 14,  4,  7, 11, 13,  0, 15
    .byte 11,  3,  5,  8,  2, 15, 10, 13, 14,  1,  7,  4, 12,  9,  6,  0
    .byte 12,  8,  2,  1, 13,  4, 15,  6,  7,  0, 10,  5,  3, 14,  9, 11
    .byte  7, 15,  5, 10,  8,  1,  6, 13,  0,  9,  3, 14, 11,  4,  2, 12
    .byte  5, 13, 15,  6,  9,  2, 12, 10, 11,  7,  8,  1,  4,  3, 14,  0
    .byte  8, 14,  2,  5,  6,  9,  1, 12, 15,  4, 11,  0, 13, 10,  3,  7
    .byte  1,  7, 14, 13,  0,  5,  8,  3,  4, 15, 10,  6,  9, 12, 11,  2

gost_key_schedule:
    add     r3, r0, #128
    mov     r12, #8
.Lgost_key_schedule_loop:
    ldr     r1, [r0], #4
    eor     r2, r1, r1, ROR #16
    bic     r2, #16711680
    mov     r1, r1, ROR #8
    eor     r1, r2, LSR #8
    str     r1, [r0, #-4]
    str     r1, [r0, #28]
    str     r1, [r0, #60]
    str     r1, [r3, #-4]!
    subs    r12, #1
    bne     .Lgost_key_schedule_loop
    mov     pc, lr

gost_encrypt:
    mov     r12, #4
    b       .Lgost_crypto
gost_decrypt:
    mov     r12, #-4
    add     r1, #124
.Lgost_crypto:
    ldmia   r0, {r2-r3}
    stmdb   sp!, {r4-r8}
    eor     r4, r2, r2, ROR #16
    bic     r4, #16711680
    mov     r2, r2, ROR #8
    eor     r2, r4, LSR #8
    eor     r4, r3, r3, ROR #16
    bic     r4, #16711680
    mov     r3, r3, ROR #8
    eor     r3, r4, LSR #8
    sub     r6, pc, #248
    mov     r8, #32
.Lgost_crypto_round:
    ldr     r4, [r1]
    add     r4, r3
    mov     r7, #8
.Lgost_crypto_round_loop:
    and     r5, r4, #15
    ldrb    r5, [r6, r5]
    mov     r4, r4, LSR #4
    orr     r4, r5, LSL #28
    add     r6, #16
    subs    r7, #1
    bne     .Lgost_crypto_round_loop
    eor     r4, r2, r4, ROR #21
    add     r1, r12
    mov     r2, r3
    mov     r3, r4
    sub     r6, #128
    subs    r8, #1
    bne     .Lgost_crypto_round
    ldmia   sp!, {r4-r8}
    eor     r1, r2, r2, ROR #16
    bic     r1, #16711680
    mov     r2, r2, ROR #8
    eor     r2, r1, LSR #8
    eor     r1, r3, r3, ROR #16
    bic     r1, #16711680
    mov     r3, r3, ROR #8
    eor     r1, r3, r1, LSR #8
    stmia   r0, {r1-r2}
    mov     pc, lr
