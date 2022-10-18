.globl chacha_key_prepare @ void chacha_key_prepare(unsigned char out[64], const unsigned char key[32], const unsigned char nonce[12], const unsigned char counter[4])
.globl chacha_crypto      @ void chacha_crypto(unsigned char out[64], const unsigned char in[64])

@ struct block {unsigned char constant[16]; unsigned char key[32]; unsigned char counter[4]; unsigned char nonce[12];}

.section .text,"ax",%progbits

.ascii "expand 32-byte k"

chacha_key_prepare:
    stmdb   sp!, {r4-r7}
    sub     r12, pc, #28                @ pointer to "expand 32-byte k"
    ldmia   r12!, {r4-r7}               @ load "expand 32-byte k"
    stmia   r0!, {r4-r7}                @ store "expand 32-byte k"
    ldmia   r1!, {r4-r7}                @ load 1st 16 bytes of key
    stmia   r0!, {r4-r7}                @ store 1st 16 bytes of key
    ldmia   r1!, {r4-r7}                @ load 2nd 16 bytes of key
    stmia   r0!, {r4-r7}                @ store 2nd 16 bytes of key
    ldmia   r2!, {r5-r7}                @ load nonce
    ldmia   r3!, {r4}                   @ load counter
    stmia   r0!, {r4-r7}                @ store counter & nonce
    ldmia   sp!, {r4-r7}
    mov     pc, lr

chacha_crypto:
    stmdb   sp!, {r4-r5, lr}
    mov     r12, r1                     @ pointer to input block
    mov     r5, #10                     @ number of rounds
    ldmia   r12!, {r1-r4}               @ load 1st 16 bytes of block
    stmia   r0!, {r1-r4}                @ store 1st 16 bytes of block
    ldmia   r12!, {r1-r4}               @ load 2nd 16 bytes of block
    stmia   r0!, {r1-r4}                @ store 2nd 16 bytes of block
    ldmia   r12!, {r1-r4}               @ load 3rd 16 bytes of block
    stmia   r0!, {r1-r4}                @ store 3rd 16 bytes of block
    ldmia   r12!, {r1-r4}               @ load 4th 16 bytes of block
    stmia   r0!, {r1-r4}                @ store 4th 16 bytes of block
    sub     r0, #64                     @ pointer to output block
    sub     r12, #64                    @ pointer to input block
.Lchacha_round:
    ldr     r1, [r0,  #0]
    ldr     r2, [r0, #16]
    ldr     r3, [r0, #32]
    ldr     r4, [r0, #48]
    bl      .Lchacha_quarter_round      @ QR( 0,  4,  8, 12)
    str     r1, [r0,  #0]
    str     r2, [r0, #16]
    str     r3, [r0, #32]
    str     r4, [r0, #48]
    ldr     r1, [r0,  #4]
    ldr     r2, [r0, #20]
    ldr     r3, [r0, #36]
    ldr     r4, [r0, #52]
    bl      .Lchacha_quarter_round      @ QR( 1,  5,  9, 13)
    str     r1, [r0,  #4]
    str     r2, [r0, #20]
    str     r3, [r0, #36]
    str     r4, [r0, #52]
    ldr     r1, [r0,  #8]
    ldr     r2, [r0, #24]
    ldr     r3, [r0, #40]
    ldr     r4, [r0, #56]
    bl      .Lchacha_quarter_round      @ QR( 2,  6, 10, 14)
    str     r1, [r0,  #8]
    str     r2, [r0, #24]
    str     r3, [r0, #40]
    str     r4, [r0, #56]
    ldr     r1, [r0, #12]
    ldr     r2, [r0, #28]
    ldr     r3, [r0, #44]
    ldr     r4, [r0, #60]
    bl      .Lchacha_quarter_round      @ QR( 3,  7, 11, 15)
    str     r1, [r0, #12]
    str     r2, [r0, #28]
    str     r3, [r0, #44]
    str     r4, [r0, #60]
    ldr     r1, [r0,  #0]
    ldr     r2, [r0, #20]
    ldr     r3, [r0, #40]
    ldr     r4, [r0, #60]
    bl      .Lchacha_quarter_round      @ QR( 0,  5, 10, 15)
    str     r1, [r0,  #0]
    str     r2, [r0, #20]
    str     r3, [r0, #40]
    str     r4, [r0, #60]
    ldr     r1, [r0,  #4]
    ldr     r2, [r0, #24]
    ldr     r3, [r0, #44]
    ldr     r4, [r0, #48]
    bl      .Lchacha_quarter_round      @ QR( 1,  6, 11, 12)
    str     r1, [r0,  #4]
    str     r2, [r0, #24]
    str     r3, [r0, #44]
    str     r4, [r0, #48]
    ldr     r1, [r0,  #8]
    ldr     r2, [r0, #28]
    ldr     r3, [r0, #32]
    ldr     r4, [r0, #52]
    bl      .Lchacha_quarter_round      @ QR( 2,  7,  8, 13)
    str     r1, [r0,  #8]
    str     r2, [r0, #28]
    str     r3, [r0, #32]
    str     r4, [r0, #52]
    ldr     r1, [r0, #12]
    ldr     r2, [r0, #16]
    ldr     r3, [r0, #36]
    ldr     r4, [r0, #56]
    bl      .Lchacha_quarter_round      @ QR( 3,  4,  9, 14)
    str     r1, [r0, #12]
    str     r2, [r0, #16]
    str     r3, [r0, #36]
    str     r4, [r0, #56]
    subs    r5, #1
    bne     .Lchacha_round
    mov     r3, #16                     @ number of words in block
.Lchacha_final_add:
    ldr     r1, [r0], #4                @ out[i]
    ldr     r2, [r12], #4               @ in[i]
    add     r1, r2                      @ out[i] + in[i]
    str     r1, [r0, #-4]               @ out[i] = out[i] + in[i]
    subs    r3, #1
    bne     .Lchacha_final_add
    ldmia   sp!, {r4-r5, pc}
.Lchacha_quarter_round:
    add     r1, r2                      @ a += b
    eor     r4, r1                      @ d ^= a
    mov     r4, r4, ROR #16             @ d <<<= 16
    add     r3, r4                      @ c += d
    eor     r2, r3                      @ b ^= c
    mov     r2, r2, ROR #20             @ b <<<= 12
    add     r1, r2                      @ a += b
    eor     r4, r1                      @ d ^= a
    mov     r4, r4, ROR #24             @ d <<<= 8
    add     r3, r4                      @ c += d
    eor     r2, r3                      @ b ^= c
    mov     r2, r2, ROR #25             @ b <<<= 7
    mov     pc, lr
