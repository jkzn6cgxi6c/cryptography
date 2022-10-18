.globl camellia_128_key_schedule @ void camellia_128_key_schedule(unsigned char key[208])
.globl camellia_192_key_schedule @ void camellia_192_key_schedule(unsigned char key[272])
.globl camellia_256_key_schedule @ void camellia_256_key_schedule(unsigned char key[272])
.globl camellia_128_encrypt      @ void camellia_128_encrypt(unsigned char buffer[16], const unsigned char key[208])
.globl camellia_192_encrypt      @ void camellia_192_encrypt(unsigned char buffer[16], const unsigned char key[272])
.globl camellia_256_encrypt      @ void camellia_256_encrypt(unsigned char buffer[16], const unsigned char key[272])
.globl camellia_128_decrypt      @ void camellia_128_decrypt(unsigned char buffer[16], const unsigned char key[208])
.globl camellia_192_decrypt      @ void camellia_192_decrypt(unsigned char buffer[16], const unsigned char key[272])
.globl camellia_256_decrypt      @ void camellia_256_decrypt(unsigned char buffer[16], const unsigned char key[272])

.section .text,"ax",%progbits

.balign 64

sbox1: .byte 112, 130,  44, 236, 179,  39, 192, 229, 228, 133,  87,  53, 234,  12, 174,  65
       .byte  35, 239, 107, 147,  69,  25, 165,  33, 237,  14,  79,  78,  29, 101, 146, 189
       .byte 134, 184, 175, 143, 124, 235,  31, 206,  62,  48, 220,  95,  94, 197,  11,  26
       .byte 166, 225,  57, 202, 213,  71,  93,  61, 217,   1,  90, 214,  81,  86, 108,  77
       .byte 139,  13, 154, 102, 251, 204, 176,  45, 116,  18,  43,  32, 240, 177, 132, 153
       .byte 223,  76, 203, 194,  52, 126, 118,   5, 109, 183, 169,  49, 209,  23,   4, 215
       .byte  20,  88,  58,  97, 222,  27,  17,  28,  50,  15, 156,  22,  83,  24, 242,  34
       .byte 254,  68, 207, 178, 195, 181, 122, 145,  36,   8, 232, 168,  96, 252, 105,  80
       .byte 170, 208, 160, 125, 161, 137,  98, 151,  84,  91,  30, 149, 224, 255, 100, 210
       .byte  16, 196,   0,  72, 163, 247, 117, 219, 138,   3, 230, 218,   9,  63, 221, 148
       .byte 135,  92, 131,   2, 205,  74, 144,  51, 115, 103, 246, 243, 157, 127, 191, 226
       .byte  82, 155, 216,  38, 200,  55, 198,  59, 129, 150, 111,  75,  19, 190,  99,  46
       .byte 233, 121, 167, 140, 159, 110, 188, 142,  41, 245, 249, 182,  47, 253, 180,  89
       .byte 120, 152,   6, 106, 231,  70, 113, 186, 212,  37, 171,  66, 136, 162, 141, 250
       .byte 114,   7, 185,  85, 248, 238, 172,  10,  54,  73,  42, 104,  60,  56, 241, 164
       .byte  64,  40, 211, 123, 187, 201,  67, 193,  21, 227, 173, 244, 119, 199, 128, 158
sbox2: .byte 224,   5,  88, 217, 103,  78, 129, 203, 201,  11, 174, 106, 213,  24,  93, 130
       .byte  70, 223, 214,  39, 138,  50,  75,  66, 219,  28, 158, 156,  58, 202,  37, 123
       .byte  13, 113,  95,  31, 248, 215,  62, 157, 124,  96, 185, 190, 188, 139,  22,  52
       .byte  77, 195, 114, 149, 171, 142, 186, 122, 179,   2, 180, 173, 162, 172, 216, 154
       .byte  23,  26,  53, 204, 247, 153,  97,  90, 232,  36,  86,  64, 225,  99,   9,  51
       .byte 191, 152, 151, 133, 104, 252, 236,  10, 218, 111,  83,  98, 163,  46,   8, 175
       .byte  40, 176, 116, 194, 189,  54,  34,  56, 100,  30,  57,  44, 166,  48, 229,  68
       .byte 253, 136, 159, 101, 135, 107, 244,  35,  72,  16, 209,  81, 192, 249, 210, 160
       .byte  85, 161,  65, 250,  67,  19, 196,  47, 168, 182,  60,  43, 193, 255, 200, 165
       .byte  32, 137,   0, 144,  71, 239, 234, 183,  21,   6, 205, 181,  18, 126, 187,  41
       .byte  15, 184,   7,   4, 155, 148,  33, 102, 230, 206, 237, 231,  59, 254, 127, 197
       .byte 164,  55, 177,  76, 145, 110, 141, 118,   3,  45, 222, 150,  38, 125, 198,  92
       .byte 211, 242,  79,  25,  63, 220, 121,  29,  82, 235, 243, 109,  94, 251, 105, 178
       .byte 240,  49,  12, 212, 207, 140, 226, 117, 169,  74,  87, 132,  17,  69,  27, 245
       .byte 228,  14, 115, 170, 241, 221,  89,  20, 108, 146,  84, 208, 120, 112, 227,  73
       .byte 128,  80, 167, 246, 119, 147, 134, 131,  42, 199,  91, 233, 238, 143,   1,  61
sbox3: .byte  56,  65,  22, 118, 217, 147,  96, 242, 114, 194, 171, 154, 117,   6,  87, 160
       .byte 145, 247, 181, 201, 162, 140, 210, 144, 246,   7, 167,  39, 142, 178,  73, 222
       .byte  67,  92, 215, 199,  62, 245, 143, 103,  31,  24, 110, 175,  47, 226, 133,  13
       .byte  83, 240, 156, 101, 234, 163, 174, 158, 236, 128,  45, 107, 168,  43,  54, 166
       .byte 197, 134,  77,  51, 253, 102,  88, 150,  58,   9, 149,  16, 120, 216,  66, 204
       .byte 239,  38, 229,  97,  26,  63,  59, 130, 182, 219, 212, 152, 232, 139,   2, 235
       .byte  10,  44,  29, 176, 111, 141, 136,  14,  25, 135,  78,  11, 169,  12, 121,  17
       .byte 127,  34, 231,  89, 225, 218,  61, 200,  18,   4, 116,  84,  48, 126, 180,  40
       .byte  85, 104,  80, 190, 208, 196,  49, 203,  42, 173,  15, 202, 112, 255,  50, 105
       .byte   8,  98,   0,  36, 209, 251, 186, 237,  69, 129, 115, 109, 132, 159, 238,  74
       .byte 195,  46, 193,   1, 230,  37,  72, 153, 185, 179, 123, 249, 206, 191, 223, 113
       .byte  41, 205, 108,  19, 100, 155,  99, 157, 192,  75, 183, 165, 137,  95, 177,  23
       .byte 244, 188, 211,  70, 207,  55,  94,  71, 148, 250, 252,  91, 151, 254,  90, 172
       .byte  60,  76,   3,  53, 243,  35, 184,  93, 106, 146, 213,  33,  68,  81, 198, 125
       .byte  57, 131, 220, 170, 124, 119,  86,   5,  27, 164,  21,  52,  30,  28, 248,  82
       .byte  32,  20, 233, 189, 221, 228, 161, 224, 138, 241, 214, 122, 187, 227,  64,  79
sbox4: .byte 112,  44, 179, 192, 228,  87, 234, 174,  35, 107,  69, 165, 237,  79,  29, 146
       .byte 134, 175, 124,  31,  62, 220,  94,  11, 166,  57, 213,  93, 217,  90,  81, 108
       .byte 139, 154, 251, 176, 116,  43, 240, 132, 223, 203,  52, 118, 109, 169, 209,   4
       .byte  20,  58, 222,  17,  50, 156,  83, 242, 254, 207, 195, 122,  36, 232,  96, 105
       .byte 170, 160, 161,  98,  84,  30, 224, 100,  16,   0, 163, 117, 138, 230,   9, 221
       .byte 135, 131, 205, 144, 115, 246, 157, 191,  82, 216, 200, 198, 129, 111,  19,  99
       .byte 233, 167, 159, 188,  41, 249,  47, 180, 120,   6, 231, 113, 212, 171, 136, 141
       .byte 114, 185, 248, 172,  54,  42,  60, 241,  64, 211, 187,  67,  21, 173, 119, 128
       .byte 130, 236,  39, 229, 133,  53,  12,  65, 239, 147,  25,  33,  14,  78, 101, 189
       .byte 184, 143, 235, 206,  48,  95, 197,  26, 225, 202,  71,  61,   1, 214,  86,  77
       .byte  13, 102, 204,  45,  18,  32, 177, 153,  76, 194, 126,   5, 183,  49,  23, 215
       .byte  88,  97,  27,  28,  15,  22,  24,  34,  68, 178, 181, 145,   8, 168, 252,  80
       .byte 208, 125, 137, 151,  91, 149, 255, 210, 196,  72, 247, 219,   3, 218,  63, 148
       .byte  92,   2,  74,  51, 103, 243, 127, 226, 155,  38,  55,  59, 150,  75, 190,  46
       .byte 121, 140, 110, 142, 245, 182, 253,  89, 152, 106,  70, 186,  37,  66, 162, 250
       .byte   7,  85, 238,  10,  73, 104,  56, 164,  40, 123, 201, 193, 227, 244, 199, 158

sigma1: .byte 0x7F, 0x66, 0x9E, 0xA0, 0x8B, 0x90, 0xCC, 0x3B
sigma2: .byte 0x58, 0xE8, 0x7A, 0xB6, 0xB2, 0x73, 0xAA, 0x4C
sigma3: .byte 0x2F, 0x37, 0xEF, 0xC6, 0xBE, 0x82, 0x4F, 0xE9
sigma4: .byte 0xA5, 0x53, 0xFF, 0x54, 0x1C, 0x6F, 0xD3, 0xF1
sigma5: .byte 0xFA, 0x27, 0xE5, 0x10, 0x1D, 0x2D, 0x68, 0xDE
sigma6: .byte 0xC2, 0x88, 0x56, 0xB0, 0xFD, 0xC1, 0xE6, 0xB3

camellia_128_key_schedule:
    stmdb   sp!, {r4-r11, lr}
    ldmia   r0, {r8-r11}                @ KL
    bl      .Lswap_endianness
    stmia   r0!, {r8-r11}               @ KL <<<   0 L, KL <<<   0 R
    add     r0, #16
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KL <<<  15 L, KL <<<  15 R
    add     r0, #32
    bl      .Lrotate_15_left
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KL <<<  45 L, KL <<<  45 R
    add     r0, #8
    bl      .Lrotate_15_left
    stmia   r0!, {r10-r11}              @               KL <<<  60 R
    add     r0, #16
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KL <<<  77 L, KL <<<  77 R
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KL <<<  94 L, KL <<<  94 R
    add     r0, #16
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KL <<< 111 L, KL <<< 111 R
    sub     r12, pc, #1168              @ &sbox1
    sub     r0, #192
    bl      .Lrotate_17_left
    add     r1, r12, #1024              @ &sigma1
    mov     r2, #8
    bl      .Ltwo_f_rounds
    ldmia   r0!, {r4-r7}
    eor     r8, r4
    eor     r9, r5
    eor     r10, r6
    eor     r11, r7
    bl      .Ltwo_f_rounds
    stmia   r0!, {r8-r11}               @ KA <<<   0 L, KA <<<   0 R
    add     r0, #16
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KA <<<  15 L, KA <<<  15 R
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KA <<<  30 L, KA <<<  30 R
    add     r0, #16
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r9}                @ KA <<<  45 L
    add     r0, #8
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KA <<<  60 L, KA <<<  60 R
    add     r0, #32
    bl      .Lrotate_17_left
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KA <<<  94 L, KA <<<  94 R
    add     r0, #16
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KA <<< 111 L, KA <<< 111 R
    ldmia   sp!, {r4-r11, pc}

camellia_192_key_schedule:
    add     r0, #16
    ldmia   r0!, {r1-r2}
    mvn     r1, r1
    mvn     r2, r2
    stmia   r0, {r1-r2}                 @ KRR = ~KRL
    sub     r0, #24

camellia_256_key_schedule:
    stmdb   sp!, {r4-r11, lr}
    ldmia   r0, {r8-r11}                @ KL
    bl      .Lswap_endianness
    stmia   r0!, {r8-r11}               @ KL <<<   0 L, KL <<<   0 R
    add     r0, #80
    bl      .Lrotate_15_left
    bl      .Lrotate_15_left
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KL <<<  45 L, KL <<<  45 R
    add     r0, #16
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KL <<<  60 L, KL <<<  60 R
    add     r0, #32
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KL <<<  77 L, KL <<<  77 R
    add     r0, #48
    bl      .Lrotate_17_left
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KL <<<  77 L, KL <<<  77 R
    sub     r0, #240
    bl      .Lrotate_17_left
    mov     r4, r8
    mov     r5, r9
    mov     r6, r10
    mov     r7, r11
    ldmia   r0, {r8-r11}                @ KR
    bl      .Lswap_endianness
    stmia   r0!, {r8-r11}
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KR <<<  15 L, KR <<<  15 R
    add     r0, #16
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KR <<<  30 L, KR <<<  30 R
    add     r0, #64
    bl      .Lrotate_15_left
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KR <<<  60 L, KR <<<  60 R
    add     r0, #48
    bl      .Lrotate_17_left
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KR <<<  94 L, KR <<<  94 R
    sub     r0, #224
    bl      .Lrotate_17_left
    bl      .Lrotate_17_left
    eor     r8, r4
    eor     r9, r5
    sub     r12, pc, #1504              @ &sbox1
    eor     r10, r6
    eor     r11, r7
    add     r1, r12, #1024              @ &sigma1
    mov     r2, #8
    bl      .Ltwo_f_rounds
    ldmia   r0!, {r4-r7}                @ KL
    eor     r8, r4
    eor     r9, r5
    eor     r10, r6
    eor     r11, r7
    bl      .Ltwo_f_rounds
    add     r0, #32
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KA <<<  15 L, KA <<<  15 R
    add     r0, #48
    bl      .Lrotate_15_left
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KA <<<  45 L, KA <<<  45 R
    add     r0, #64
    bl      .Lrotate_15_left
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KA <<<  77 L, KA <<<  77 R
    add     r0, #16
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KA <<<  94 L, KA <<<  94 R
    sub     r0, #224
    bl      .Lrotate_17_left
    bl      .Lrotate_17_left
    ldmia   r0, {r4-r7}                 @ KR
    eor     r8, r4
    eor     r9, r5
    eor     r10, r6
    eor     r11, r7
    mov     r2, #8
    bl      .Ltwo_f_rounds
    stmia   r0!, {r8-r11}               @ KB <<<   0 L, KB <<<   0 R
    add     r0, #48
    bl      .Lrotate_15_left
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KB <<<  30 L, KB <<<  30 R
    add     r0, #64
    bl      .Lrotate_15_left
    bl      .Lrotate_15_left
    stmia   r0!, {r8-r11}               @ KB <<<  60 L, KB <<<  60 R
    add     r0, #80
    bl      .Lrotate_17_left
    bl      .Lrotate_17_left
    bl      .Lrotate_17_left
    stmia   r0!, {r8-r11}               @ KB <<< 111 L, KB <<< 111 R
    ldmia   sp!, {r4-r11, pc}

.Lrotate_15_left:
    mov     r2, r8, LSR #17
    mov     r3, r11, LSR #17
    orr     r11, r2, r11, LSL #15
    mov     r2, r10, LSR #17
    orr     r10, r3, r10, LSL #15
    mov     r3, r9, LSR #17
    orr     r9, r2, r9, LSL #15
    mov     r2, r8, LSR #17
    orr     r8, r3, r8, LSL #15
    mov     pc, lr

.Lrotate_17_left:
    mov     r2, r8, LSR #15
    mov     r3, r11, LSR #15
    orr     r11, r2, r11, LSL #17
    mov     r2, r10, LSR #15
    orr     r10, r3, r10, LSL #17
    mov     r3, r9, LSR #15
    orr     r9, r2, r9, LSL #17
    mov     r2, r8, LSR #15
    orr     r8, r3, r8, LSL #17
    mov     pc, lr

camellia_128_encrypt:
    mov     r2, #8
    mov     r3, #3
    b       .Lcamellia_crypto

camellia_192_encrypt:
camellia_256_encrypt:
    mov     r2, #8
    mov     r3, #4
    b       .Lcamellia_crypto

camellia_128_decrypt:
    add     r1, #192
    mov     r2, #-8
    mov     r3, #3
    b       .Lcamellia_crypto

camellia_192_decrypt:
camellia_256_decrypt:
    add     r1, #256
    mov     r2, #-8
    mov     r3, #4
    b       .Lcamellia_crypto

.Lcamellia_crypto:
    stmdb   sp!, {r4-r11, lr}
    ldmia   r0, {r8-r11}
    bl      .Lswap_endianness
    mov     r12, r2, ASR #4
    add     r12, r12, LSL #1
    ldmia   r1!, {r4-r7}                @ kw
    add     r1, r12, LSL #3
    eor     r8, r4
    eor     r9, r5
    eor     r10, r6
    eor     r11, r7
    sub     r12, pc, #1888              @ &sbox1
    b       .Lcamellia_crypto_start
.Lcamellia_crypto_cycle:
    ldmia   r1, {r4-r5}                 @ kl
    add     r1, r2
    ldmia   r1, {r6-r7}                 @ kl
    add     r1, r2
    and     r4, r8
    orr     r7, r11
    eor     r9, r4, ROR #31
    eor     r10, r7
    orr     r5, r9
    and     r6, r10
    eor     r8, r5
    eor     r11, r6, ROR #31
.Lcamellia_crypto_start:
    bl      .Ltwo_f_rounds
    bl      .Ltwo_f_rounds
    bl      .Ltwo_f_rounds
    subs    r3, #1
    bne     .Lcamellia_crypto_cycle
    mov     r2, r2, ASR #4
    add     r1, r2, LSL #3
    ldmia   r1, {r4-r7}                 @ kw
    eor     r8, r6
    eor     r9, r7
    eor     r10, r4
    eor     r11, r5
    bl      .Lswap_endianness
    stmia   r0!, {r10-r11}
    stmia   r0!, {r8-r9}
    ldmia   sp!, {r4-r11, pc}

.Lswap_endianness:
    eor     r12, r8, r8, ROR #16
    bic     r12, #16711680
    mov     r8, r8, ROR #8
    eor     r8, r12, LSR #8
    eor     r12, r9, r9, ROR #16
    bic     r12, #16711680
    mov     r9, r9, ROR #8
    eor     r9, r12, LSR #8
    eor     r12, r10, r10, ROR #16
    bic     r12, #16711680
    mov     r10, r10, ROR #8
    eor     r10, r12, LSR #8
    eor     r12, r11, r11, ROR #16
    bic     r12, #16711680
    mov     r11, r11, ROR #8
    eor     r11, r12, LSR #8
    mov     pc, lr

.Ltwo_f_rounds:
    mov     r7, #2
.Lf_round:
    ldmia   r1, {r4, r5}                @ ki
    eor     r4, r8                      @ y1, y2, y3, y4
    eor     r5, r9                      @ y5, y6, y7, y8
    mov     r5, r5, ROR #8              @ y8, y5, y6, y7
    ldrb    r6, [r12, r4, LSR #24]      @ s1[y1]
    orr     r4, r6, r4, LSL #8
    ldrb    r6, [r12, r5, LSR #24]      @ s1[y8]
    orr     r5, r6, r5, LSL #8
    add     r12, #256                   @ &s2
    ldrb    r6, [r12, r4, LSR #24]      @ s2[y2]
    orr     r4, r6, r4, LSL #8
    ldrb    r6, [r12, r5, LSR #24]      @ s2[y5]
    orr     r5, r6, r5, LSL #8
    add     r12, #256                   @ &s3
    ldrb    r6, [r12, r4, LSR #24]      @ s3[y3]
    orr     r4, r6, r4, LSL #8
    ldrb    r6, [r12, r5, LSR #24]      @ s3[y6]
    orr     r5, r6, r5, LSL #8
    add     r12, #256                   @ &s4
    ldrb    r6, [r12, r4, LSR #24]      @ s4[y4]
    orr     r4, r6, r4, LSL #8
    ldrb    r6, [r12, r5, LSR #24]      @ s4[y7]
    orr     r5, r6, r5, LSL #8
    add     r12, #256                   @ &s4[256]
    mov     r5, r5, ROR #24             @ z5, z6, z7, z8
    sub     r12, #1024                  @ &s1
    eor     r4, r5, ROR #24
    eor     r5, r4, ROR #16
    eor     r4, r5, ROR #8
    eor     r5, r4, ROR #8
    eor     r4, r11
    eor     r5, r10
    mov     r11, r9
    mov     r10, r8
    mov     r9, r4
    mov     r8, r5
    add     r1, r2
    subs    r7, #1                      @ loop control variable
    bne     .Lf_round
    mov     pc, lr
