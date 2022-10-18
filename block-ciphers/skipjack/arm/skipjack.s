.globl skipjack_encrypt @ void skipjack_encrypt(unsigned char buffer[8], const unsigned char key[10])
.globl skipjack_decrypt @ void skipjack_decrypt(unsigned char buffer[8], const unsigned char key[10])

.section .text,"ax",%progbits

.balign 64

fbox: .byte 163, 215,   9, 131, 248,  72, 246, 244, 179,  33,  21, 120, 153, 177, 175, 249
      .byte 231,  45,  77, 138, 206,  76, 202,  46,  82, 149, 217,  30,  78,  56,  68,  40
      .byte  10, 223,   2, 160,  23, 241,  96, 104,  18, 183, 122, 195, 233, 250,  61,  83
      .byte 150, 132, 107, 186, 242,  99, 154,  25, 124, 174, 229, 245, 247,  22, 106, 162
      .byte  57, 182, 123,  15, 193, 147, 129,  27, 238, 180,  26, 234, 208, 145,  47, 184
      .byte  85, 185, 218, 133,  63,  65, 191, 224,  90,  88, 128,  95, 102,  11, 216, 144
      .byte  53, 213, 192, 167,  51,   6, 101, 105,  69,   0, 148,  86, 109, 152, 155, 118
      .byte 151, 252, 178, 194, 176, 254, 219,  32, 225, 235, 214, 228, 221,  71,  74,  29
      .byte  66, 237, 158, 110,  73,  60, 205,  67,  39, 210,   7, 212, 222, 199, 103,  24
      .byte 137, 203,  48,  31, 141, 198, 143, 170, 200, 116, 220, 201,  93,  92,  49, 164
      .byte 112, 136,  97,  44, 159,  13,  43, 135,  80, 130,  84, 100,  38, 125,   3,  64
      .byte  52,  75,  28, 115, 209, 196, 253,  59, 204, 251, 127, 171, 230,  62,  91, 165
      .byte 173,   4,  35, 156,  20,  81,  34, 240,  41, 121, 113, 126, 255, 140,  14, 226
      .byte  12, 239, 188, 114, 117, 111,  55, 161, 236, 211, 142,  98, 139, 134,  16, 232
      .byte   8, 119,  17, 190, 146,  79,  36, 197,  50,  54, 157, 207, 243, 166, 187, 172
      .byte  94, 108, 169,  19,  87,  37, 181, 227, 189, 168,  58,   1,   5,  89,  42,  70

.Lskipjack_g:
    and     r7, r2, #255                @ g2
    mov     r8, r2, LSR #8              @ g1
    ldrb    r9, [r1, r10]               @ cv4k
    adds    r10, #1
    eor     r9, r7
    ldrb    r9, [r12, r9]               @ f
    eor     r8, r9
    ldrb    r9, [r1, r10]               @ cv4k+1
    adds    r10, #1
    eor     r9, r8
    ldrb    r9, [r12, r9]               @ f
    eor     r7, r9
    subpl   r10, #10
    ldrb    r9, [r1, r10]               @ cv4k+2
    adds    r10, #1
    eor     r9, r7
    ldrb    r9, [r12, r9]               @ f
    eor     r8, r9
    ldrb    r9, [r1, r10]               @ cv4k+3
    adds    r10, #1
    eor     r9, r8
    ldrb    r9, [r12, r9]               @ f
    eor     r7, r9
    subpl   r10, #10
    orr     r7, r8, LSL #8              @ g5||g6
    mov     pc, lr

.Lskipjack_h:
    and     r7, r3, #255                @ g6
    mov     r8, r3, LSR #8              @ g5
    ldrb    r9, [r1, r10]               @ cv4k+3
    subs    r10, #1
    eor     r9, r8
    ldrb    r9, [r12, r9]               @ f
    eor     r7, r9
    ldrb    r9, [r1, r10]               @ cv4k+2
    subs    r10, #1
    eor     r9, r7
    ldrb    r9, [r12, r9]               @ f
    eor     r8, r9
    addmi   r10, #10
    ldrb    r9, [r1, r10]               @ cv4k+1
    subs    r10, #1
    eor     r9, r8
    ldrb    r9, [r12, r9]               @ f
    eor     r7, r9
    ldrb    r9, [r1, r10]               @ cv4k
    subs    r10, #1
    eor     r9, r7
    ldrb    r9, [r12, r9]               @ f
    eor     r8, r9
    addmi   r10, #10
    orr     r7, r8, LSL #8              @ g1||g2
    mov     pc, lr

skipjack_encrypt:
    stmdb   sp!, {r4-r10, lr}
    sub     r12, pc, #476               @ pointer to f
    add     r1, #10
    mov     r6, #0                      @ counter
    mov     r10, #-10                   @ k
    ldmia   r0, {r3, r5}                @ w1, w2, w3, w4
    eor     r2, r3, r3, ROR #16
    eor     r4, r5, r5, ROR #16
    bic     r2, #16711680
    bic     r4, #16711680
    mov     r3, r3, ROR #8
    mov     r5, r5, ROR #8
    eor     r3, r2, LSR #8
    eor     r5, r4, LSR #8
    mov     r2, r3, LSR #16
    mov     r4, r5, LSR #16
    eor     r3, r2, LSL #16
    eor     r5, r4, LSL #16
.Lskipjack_encrypt_a:
    add     r6, #1                      @ next counter
    bl      .Lskipjack_g                @ G(w1)
    eor     r2, r6, r7                  @ G(w1) + counter
    eor     r2, r5                      @ w1' = G(w1) + w4 + counter
    mov     r5, r4                      @ w4' = w3
    mov     r4, r3                      @ w3' = w2
    mov     r3, r7                      @ w2' = G(w1)
    teq     r6, #8
    bne     .Lskipjack_encrypt_a
.Lskipjack_encrypt_b:
    add     r6, #1                      @ next counter
    bl      .Lskipjack_g                @ G(w1)
    eor     r3, r2                      @ w1 + w2
    mov     r2, r5                      @ w1' = w4
    mov     r5, r4                      @ w4' = w3
    eor     r4, r3, r6                  @ w3' = w1 + w2 + counter
    mov     r3, r7                      @ w2' = G(w1)
    teq     r6, #16
    bne     .Lskipjack_encrypt_b
.Lskipjack_encrypt_c:
    add     r6, #1                      @ next counter
    bl      .Lskipjack_g                @ G(w1)
    eor     r2, r6, r7                  @ G(w1) + counter
    eor     r2, r5                      @ w1' = G(w1) + w4 + counter
    mov     r5, r4                      @ w4' = w3
    mov     r4, r3                      @ w3' = w2
    mov     r3, r7                      @ w2' = G(w1)
    teq     r6, #24
    bne     .Lskipjack_encrypt_c
.Lskipjack_encrypt_d:
    add     r6, #1                      @ next counter
    bl      .Lskipjack_g                @ G(w1)
    eor     r3, r2                      @ w1 + w2
    mov     r2, r5                      @ w1' = w4
    mov     r5, r4                      @ w4' = w3
    eor     r4, r3, r6                  @ w3' = w1 + w2 + counter
    mov     r3, r7                      @ w2' = G(w1)
    teq     r6, #32
    bne     .Lskipjack_encrypt_d
    orr     r3, r2, LSL #16
    orr     r5, r4, LSL #16
    eor     r2, r3, r3, ROR #16
    eor     r4, r5, r5, ROR #16
    bic     r2, #16711680
    bic     r4, #16711680
    mov     r3, r3, ROR #8
    mov     r5, r5, ROR #8
    eor     r3, r2, LSR #8
    eor     r5, r4, LSR #8
    stmia   r0, {r3, r5}
    ldmia   sp!, {r4-r10, pc}

skipjack_decrypt:
    stmdb   sp!, {r4-r10, lr}
    sub     r12, pc, #740               @ pointer to f
    mov     r6, #32                     @ counter
    mov     r10, #7                     @ k
    ldmia   r0, {r3, r5}                @ w1, w2, w3, w4
    eor     r2, r3, r3, ROR #16
    eor     r4, r5, r5, ROR #16
    bic     r2, #16711680
    bic     r4, #16711680
    mov     r3, r3, ROR #8
    mov     r5, r5, ROR #8
    eor     r3, r2, LSR #8
    eor     r5, r4, LSR #8
    mov     r2, r3, LSR #16
    mov     r4, r5, LSR #16
    eor     r3, r2, LSL #16
    eor     r5, r4, LSL #16
.Lskipjack_decrypt_a:
    bl      .Lskipjack_h                @ G-1(w2)
    eor     r3, r6, r7                  @ G-1(w2) + counter
    eor     r3, r4                      @ w2' = G-1(w2) + w3 + counter
    mov     r4, r5                      @ w3' = w4
    mov     r5, r2                      @ w4' = w1
    mov     r2, r7                      @ w1' = G-1(w2)
    sub     r6, #1                      @ next counter
    teq     r6, #24
    bne     .Lskipjack_decrypt_a
.Lskipjack_decrypt_b:
    bl      .Lskipjack_h                @ G-1(w2)
    eor     r2, r3                      @ w1 + w2
    mov     r3, r4                      @ w2' = w3
    mov     r4, r5                      @ w3' = w4
    eor     r5, r2, r6                  @ w4' = w1 + w2 + counter
    mov     r2, r7                      @ w1' = G-1(w2)
    sub     r6, #1                      @ next counter
    teq     r6, #16
    bne     .Lskipjack_decrypt_b
.Lskipjack_decrypt_c:
    bl      .Lskipjack_h                @ G-1(w2)
    eor     r3, r6, r7                  @ G-1(w2) + counter
    eor     r3, r4                      @ w2' = G-1(w2) + w3 + counter
    mov     r4, r5                      @ w3' = w4
    mov     r5, r2                      @ w4' = w1
    mov     r2, r7                      @ w1' = G-1(w2)
    sub     r6, #1                      @ next counter
    teq     r6, #8
    bne     .Lskipjack_decrypt_c
.Lskipjack_decrypt_d:
    bl      .Lskipjack_h                @ G-1(w2)
    eor     r2, r3                      @ w1 + w2
    mov     r3, r4                      @ w2' = w3
    mov     r4, r5                      @ w3' = w4
    eor     r5, r2, r6                  @ w4' = w1 + w2 + counter
    mov     r2, r7                      @ w1' = G-1(w2)
    sub     r6, #1                      @ next counter
    teq     r6, #0
    bne     .Lskipjack_decrypt_d
    orr     r3, r2, LSL #16
    orr     r5, r4, LSL #16
    eor     r2, r3, r3, ROR #16
    eor     r4, r5, r5, ROR #16
    bic     r2, #16711680
    bic     r4, #16711680
    mov     r3, r3, ROR #8
    mov     r5, r5, ROR #8
    eor     r3, r2, LSR #8
    eor     r5, r4, LSR #8
    stmia   r0, {r3, r5}
    ldmia   sp!, {r4-r10, pc}
