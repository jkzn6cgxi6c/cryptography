.globl mars_128_key_schedule @ void mars_128_key_schedule(unsigned char key[160])
.globl mars_192_key_schedule @ void mars_192_key_schedule(unsigned char key[160])
.globl mars_256_key_schedule @ void mars_256_key_schedule(unsigned char key[160])
.globl mars_encrypt          @ void mars_encrypt(unsigned char buffer[16], const unsigned char key[160])
.globl mars_decrypt          @ void mars_decrypt(unsigned char buffer[16], const unsigned char key[160])

.section .text,"ax",%progbits

.balign 64

sbox: .long 0x09D0C479, 0x28C8FFE0, 0x84AA6C39, 0x9DAD7287, 0x7DFF9BE3, 0xD4268361, 0xC96DA1D4, 0x7974CC93, 0x85D0582E, 0x2A4B5705
      .long 0x1CA16A62, 0xC3BD279D, 0x0F1F25E5, 0x5160372F, 0xC695C1FB, 0x4D7FF1E4, 0xAE5F6BF4, 0x0D72EE46, 0xFF23DE8A, 0xB1CF8E83
      .long 0xF14902E2, 0x3E981E42, 0x8BF53EB6, 0x7F4BF8AC, 0x83631F83, 0x25970205, 0x76AFE784, 0x3A7931D4, 0x4F846450, 0x5C64C3F6
      .long 0x210A5F18, 0xC6986A26, 0x28F4E826, 0x3A60A81C, 0xD340A664, 0x7EA820C4, 0x526687C5, 0x7EDDD12B, 0x32A11D1D, 0x9C9EF086
      .long 0x80F6E831, 0xAB6F04AD, 0x56FB9B53, 0x8B2E095C, 0xB68556AE, 0xD2250B0D, 0x294A7721, 0xE21FB253, 0xAE136749, 0xE82AAE86
      .long 0x93365104, 0x99404A66, 0x78A784DC, 0xB69BA84B, 0x04046793, 0x23DB5C1E, 0x46CAE1D6, 0x2FE28134, 0x5A223942, 0x1863CD5B
      .long 0xC190C6E3, 0x07DFB846, 0x6EB88816, 0x2D0DCC4A, 0xA4CCAE59, 0x3798670D, 0xCBFA9493, 0x4F481D45, 0xEAFC8CA8, 0xDB1129D6
      .long 0xB0449E20, 0x0F5407FB, 0x6167D9A8, 0xD1F45763, 0x4DAA96C3, 0x3BEC5958, 0xABABA014, 0xB6CCD201, 0x38D6279F, 0x02682215
      .long 0x8F376CD5, 0x092C237E, 0xBFC56593, 0x32889D2C, 0x854B3E95, 0x05BB9B43, 0x7DCD5DCD, 0xA02E926C, 0xFAE527E5, 0x36A1C330
      .long 0x3412E1AE, 0xF257F462, 0x3C4F1D71, 0x30A2E809, 0x68E5F551, 0x9C61BA44, 0x5DED0AB8, 0x75CE09C8, 0x9654F93E, 0x698C0CCA
      .long 0x243CB3E4, 0x2B062B97, 0x0F3B8D9E, 0x00E050DF, 0xFC5D6166, 0xE35F9288, 0xC079550D, 0x0591AEE8, 0x8E531E74, 0x75FE3578
      .long 0x2F6D829A, 0xF60B21AE, 0x95E8EB8D, 0x6699486B, 0x901D7D9B, 0xFD6D6E31, 0x1090ACEF, 0xE0670DD8, 0xDAB2E692, 0xCD6D4365
      .long 0xE5393514, 0x3AF345F0, 0x6241FC4D, 0x460DA3A3, 0x7BCF3729, 0x8BF1D1E0, 0x14AAC070, 0x1587ED55, 0x3AFD7D3E, 0xD2F29E01
      .long 0x29A9D1F6, 0xEFB10C53, 0xCF3B870F, 0xB414935C, 0x664465ED, 0x024ACAC7, 0x59A744C1, 0x1D2936A7, 0xDC580AA6, 0xCF574CA8
      .long 0x040A7A10, 0x6CD81807, 0x8A98BE4C, 0xACCEA063, 0xC33E92B5, 0xD1E0E03D, 0xB322517E, 0x2092BD13, 0x386B2C4A, 0x52E8DD58
      .long 0x58656DFB, 0x50820371, 0x41811896, 0xE337EF7E, 0xD39FB119, 0xC97F0DF6, 0x68FEA01B, 0xA150A6E5, 0x55258962, 0xEB6FF41B
      .long 0xD7C9CD7A, 0xA619CD9E, 0xBCF09576, 0x2672C073, 0xF003FB3C, 0x4AB7A50B, 0x1484126A, 0x487BA9B1, 0xA64FC9C6, 0xF6957D49
      .long 0x38B06A75, 0xDD805FCD, 0x63D094CF, 0xF51C999E, 0x1AA4D343, 0xB8495294, 0xCE9F8E99, 0xBFFCD770, 0xC7C275CC, 0x378453A7
      .long 0x7B21BE33, 0x397F41BD, 0x4E94D131, 0x92CC1F98, 0x5915EA51, 0x99F861B7, 0xC9980A88, 0x1D74FD5F, 0xB0A495F8, 0x614DEED0
      .long 0xB5778EEA, 0x5941792D, 0xFA90C1F8, 0x33F824B4, 0xC4965372, 0x3FF6D550, 0x4CA5FEC0, 0x8630E964, 0x5B3FBBD6, 0x7DA26A48
      .long 0xB203231A, 0x04297514, 0x2D639306, 0x2EB13149, 0x16A45272, 0x532459A0, 0x8E5F4872, 0xF966C7D9, 0x07128DC0, 0x0D44DB62
      .long 0xAFC8D52D, 0x06316131, 0xD838E7CE, 0x1BC41D00, 0x3A2E8C0F, 0xEA83837E, 0xB984737D, 0x13BA4891, 0xC4F8B949, 0xA6D6ACB3
      .long 0xA215CDCE, 0x8359838B, 0x6BD1AA31, 0xF579DD52, 0x21B93F93, 0xF5176781, 0x187DFDDE, 0xE94AEB76, 0x2B38FD54, 0x431DE1DA
      .long 0xAB394825, 0x9AD3048F, 0xDFEA32AA, 0x659473E3, 0x623F7863, 0xF3346C59, 0xAB3AB685, 0x3346A90B, 0x6B56443E, 0xC6DE01F8
      .long 0x8D421FC0, 0x9B0ED10C, 0x88F1A1E9, 0x54C1F029, 0x7DEAD57B, 0x8D7BA426, 0x4CF5178A, 0x551A7CCA, 0x1A9A5F08, 0xFCD651B9
      .long 0x25605182, 0xE11FC6C3, 0xB6FD9676, 0x337B3027, 0xB7C8EB14, 0x9E5FD030, 0x6B57E354, 0xAD913CF7, 0x7E16688D, 0x58872A69
      .long 0x2C2FC7DF, 0xE389CCC6, 0x30738DF1, 0x0824A734, 0xE1797A8B, 0xA4A8D57B, 0x5B5D193B, 0xC8A8309B, 0x73F9A978, 0x73398D32
      .long 0x0F59573E, 0xE9DF2B03, 0xE8A5B6C8, 0x848D0704, 0x98DF93C2, 0x720A1DC3, 0x684F259A, 0x943BA848, 0xA6370152, 0x863B5EA3
      .long 0xD17B978B, 0x6D9B58EF, 0x0A700DD4, 0xA73D36BF, 0x8E6A0829, 0x8695BC14, 0xE35B3447, 0x933AC568, 0x8894B022, 0x2F511C27
      .long 0xDDFBCC3C, 0x006662B6, 0x117C83FE, 0x4E12B414, 0xC2BCA766, 0x3A2FEC10, 0xF4562420, 0x55792E2A, 0x46F5D857, 0xCEDA25CE
      .long 0xC3601D3B, 0x6C00AB46, 0xEFAC9C28, 0xB3C35047, 0x611DFEE3, 0x257C3207, 0xFDD58482, 0x3B14D84F, 0x23BECB64, 0xA075F3A3
      .long 0x088F8EAD, 0x07ADF158, 0x7796943C, 0xFACABF3D, 0xC09730CD, 0xF7679969, 0xDA44E9ED, 0x2C854C12, 0x35935FA3, 0x2F057D9F
      .long 0x690624F8, 0x1CB0BAFD, 0x7B0DBDC6, 0x810F23BB, 0xFA929A1A, 0x6D969A17, 0x6742979B, 0x74AC7D05, 0x010E65C4, 0x86A3D963
      .long 0xF907B5A0, 0xD0042BD3, 0x158D7D03, 0x287A8255, 0xBBA8366F, 0x096EDC33, 0x21916A7B, 0x77B56B86, 0x951622F9, 0xA6C5E650
      .long 0x8CEA17D1, 0xCD8C62BC, 0xA3D63433, 0x358A68FD, 0x0F9B9D3C, 0xD6AA295B, 0xFE33384A, 0xC000738E, 0xCD67EB2F, 0xE2EB6DC2
      .long 0x97338B02, 0x06C9F246, 0x419CF1AD, 0x2B83C045, 0x3723F18A, 0xCB5B3089, 0x160BEAD7, 0x5D494656, 0x35F8A74B, 0x1E4E6C9E
      .long 0x000399BD, 0x67466880, 0xB4174831, 0xACF423B2, 0xCA815AB3, 0x5A6395E7, 0x302A67C5, 0x8BDB446B, 0x108F8FA4, 0x10223EDA
      .long 0x92B8B48B, 0x7F38D0EE, 0xAB2701D4, 0x0262D415, 0xAF224A30, 0xB3D88ABA, 0xF8B2C3AF, 0xDAF7EF70, 0xCC97D3B7, 0xE9614B6C
      .long 0x2BAEBFF4, 0x70F687CF, 0x386C9156, 0xCE092EE5, 0x01E87DA6, 0x6CE91E6A, 0xBB7BCC84, 0xC7922C20, 0x9D3B71FD, 0x060E41C6
      .long 0xD7590F15, 0x4E03BB47, 0x183C198E, 0x63EEB240, 0x2DDBF49A, 0x6D5CBA54, 0x923750AF, 0xF9E14236, 0x7838162B, 0x59726C72
      .long 0x81B66760, 0xBB2926C1, 0x48A0CE0D, 0xA6C0496D, 0xAD43507B, 0x718D496A, 0x9DF057AF, 0x44B1BDE6, 0x054356DC, 0xDE7CED35
      .long 0xD51A138B, 0x62088CC9, 0x35830311, 0xC96EFCA2, 0x686F86EC, 0x8E77CB68, 0x63E1D6B8, 0xC80F9778, 0x79C491FD, 0x1B4C67F2
      .long 0x72698D7D, 0x5E368C31, 0xF7D95E2E, 0xA1D3493F, 0xDCD9433E, 0x896F1552, 0x4BC4CA7A, 0xA6D1BAF4, 0xA5A96DCC, 0x0BEF8B46
      .long 0xA169FDA7, 0x74DF40B7, 0x4E208804, 0x9A756607, 0x038E87C8, 0x20211E44, 0x8B7AD4BF, 0xC6403F35, 0x1848E36D, 0x80BDB038
      .long 0x1E62891C, 0x643D2107, 0xBF04D6F8, 0x21092C8C, 0xF644F389, 0x0778404E, 0x7B78ADB8, 0xA2C52D53, 0x42157ABE, 0xA2253E2E
      .long 0x7BF3F4AE, 0x80F594F9, 0x953194E7, 0x77EB92ED, 0xB3816930, 0xDA8D9336, 0xBF447469, 0xF26D9483, 0xEE6FAED5, 0x71371235
      .long 0xDE425F73, 0xB4E59F43, 0x7DBE2D4E, 0x2D37B185, 0x49DC9A63, 0x98C39D98, 0x1301C9A2, 0x389B1BBF, 0x0C18588D, 0xA421C1BA
      .long 0x7AA3865C, 0x71E08558, 0x3C5CFCAA, 0x7D239CA4, 0x0297D9DD, 0xD7DC2830, 0x4B37802B, 0x7428AB54, 0xAEEE0347, 0x4B3FBB85
      .long 0x692F2F08, 0x134E578E, 0x36D9E0BF, 0xAE8B5FCF, 0xEDB93ECF, 0x2B27248E, 0x170EB1EF, 0x7DC57FD6, 0x1E760F16, 0xB1136601
      .long 0x864E1B9B, 0xD7EA7319, 0x3AB871BD, 0xCFA4D76F, 0xE31BD782, 0x0DBEB469, 0xABB96061, 0x5370F85D, 0xFFB07E37, 0xDA30D0FB
      .long 0xEBC977B6, 0x0B98B40F, 0x3A4D0FE6, 0xDF4FC26B, 0x159CF22A, 0xC298D6E2, 0x2B78EF6A, 0x61A94AC0, 0xAB561187, 0x14EEA0F0
      .long 0xDF0D4164, 0x19AF70EE

b:    .long 0xA4A8D57B, 0x5B5D193B, 0xC8A8309B, 0x73F9A978

mars_128_key_schedule:
    mov     r1, #4                      @ n
    b       .Lmars_key_schedule
mars_192_key_schedule:
    mov     r1, #6                      @ n
    b       .Lmars_key_schedule
mars_256_key_schedule:
    mov     r1, #8                      @ n
    b       .Lmars_key_schedule
.Lmars_key_schedule:
    stmdb   sp!, {r4-r5}
    mov     r12, #0                     @ j
    rsb     r2, r1, #14                 @ n + 1 ... 14
.Lmars_key_scheduleinitialize_t_with_the_original_key_data_k_A:
    str     r12, [sp, #-4]!             @ T[n + 1 ... 14] = 0
    subs    r2, #1
    bne     .Lmars_key_scheduleinitialize_t_with_the_original_key_data_k_A
    str     r1, [sp, #-4]!              @ T[n] = n
    add     r0, r1, LSL #2              @ &k[n]
.Lmars_key_scheduleinitialize_t_with_the_original_key_data_k_B:
    ldr     r2, [r0, #-4]!              @ k[0 ... n - 1]
    str     r2, [sp, #-4]!              @ T[0 ... n - 1]
    subs    r1, #1
    bne     .Lmars_key_scheduleinitialize_t_with_the_original_key_data_k_B
    sub     r5, pc, #2144               @ &S
.Lmars_key_schedule_loop:
    mov     r1, #0                      @ i
.Lmars_key_schedule_linear_keyword_expansion:
    subs    r2, r1, #7                  @ i - 7
    addlo   r2, #15                     @ i - 7 mod 15
    ldr     r2, [sp, r2, LSL #2]        @ T[i - 7 mod 15]
    subs    r3, r1, #2                  @ i - 2
    addlo   r3, #15                     @ i - 2 mod 15
    ldr     r3, [sp, r3, LSL #2]        @ T[i - 2 mod 15]
    eor     r4, r3, r2                  @ T[i - 7 mod 15] + T[i - 2 mod 15]
    ldr     r3, [sp, r1, LSL #2]        @ T[i]
    eor     r2, r3, r4, ROR #29         @ T[i] + ((T[i - 7 mod 15] + T[i - 2 mod 15]) <<< 3)
    add     r3, r12, r1, LSL #2         @ 4i + j
    eor     r4, r3, r2                  @ T[i] + ((T[i - 7 mod 15] + T[i - 2 mod 15]) <<< 3) + (4i + j)
    str     r4, [sp, r1, LSL #2]
    add     r1, #1                      @ i
    teq     r1, #15
    bne     .Lmars_key_schedule_linear_keyword_expansion
    mov     r1, #4
.Lmars_key_schedule_sbox_based_stirring_of_keywords:
    mov     r2, #0                      @ i
.Lmars_key_schedule_sbox_based_stirring_of_keywords_internal:
    subs    r3, r2, #1                  @ i - 1
    movlo   r3, #14                     @ i - 1 mod 15
    ldr     r3, [sp, r3, LSL #2]        @ T[i - 1 mod 15]
    mov     r3, r3, LSL #23
    ldr     r3, [r5, r3, LSR #21]       @ S[T[i - 1 mod 15] ^ 511]
    ldr     r4, [sp, r2, LSL #2]        @ T[i]
    add     r3, r4                      @ T[i] + S[T[i - 1 mod 15] ^ 511]
    mov     r3, r3, ROR #23             @ (T[i] + S[T[i - 1 mod 15] ^ 511]) <<< 9
    str     r3, [sp, r2, LSL #2]
    add     r2, #1                      @ i
    teq     r2, #15
    bne     .Lmars_key_schedule_sbox_based_stirring_of_keywords_internal
    subs    r1, #1
    bne     .Lmars_key_schedule_sbox_based_stirring_of_keywords
.Lmars_key_schedule_store_next_10_keywords_into_k:
    ldr     r2, [sp, r1, LSL #2]        @ T[4i mod 15]
    str     r2, [r0], #4                @ K[10j + i]
    add     r1, #4
    cmp     r1, #15
    subhs   r1, #15                     @ 4i mod 15
    teq     r1, #10
    bne     .Lmars_key_schedule_store_next_10_keywords_into_k
    add     r12, #1                     @ j
    teq     r12, #4
    bne     .Lmars_key_schedule_loop
    add     sp, #60
    sub     r0, #140                    @ &K[5]
    add     r5, #2048                   @ &B
    mov     r12, #16
.Lmars_key_schedule_modifying_multiplication_keywords:
    ldr     r3, [r0]                    @ K[i]
    and     r4, r3, #3                  @ j
    orr     r3, #3                      @ w
    mvn     r1, r3
    eor     r1, r3, LSR #1
    bic     r1, #2147483648
    mov     r2, r1
    and     r1, r2, LSR #1
    and     r1, r2, LSR #2
    mov     r2, r1
    and     r1, r2, LSR #3
    and     r1, r2, LSR #6
    mov     r1, r1, LSL #1
    orr     r1, r1, LSL #1
    orr     r1, r1, LSL #2
    orr     r1, r1, LSL #4
    bic     r1, #3                      @ M
    ldr     r2, [r0, #-4]               @ K[i - 1] / r
    rsb     r2, #0
    ldr     r4, [r5, r4, LSL #2]        @ B[j]
    and     r1, r4, ROR r2              @ p ^ M / B[j] <<< r ^ M
    eor     r1, r3                      @ w + (p ^ M)
    str     r1, [r0], #8
    subs    r12, #1
    bne     .Lmars_key_schedule_modifying_multiplication_keywords
    ldmia   sp!, {r4-r5}
    mov     pc, lr

mars_encrypt:
    stmdb   sp!, {r4-r9}
    ldmia   r0, {r2-r5}
    ldmia   r1!, {r6-r9}
    add     r2, r6
    add     r3, r7
    add     r4, r8
    add     r5, r9
    mov     r7, #255
    sub     r8, pc, #1440               @ S1
    sub     r8, #8
    sub     r9, r8, #1024               @ S0
    mov     r12, #8
.Lmars_encrypt_forward_mixing:
    and     r6, r7, r2
    ldr     r6, [r9, r6, LSL #2]        @ S0[A]
    eor     r3, r6                      @ B ^ S0[A]
    and     r6, r7, r2, ROR #8
    ldr     r6, [r8, r6, LSL #2]        @ S1[A >>> 8]
    add     r3, r6                      @ B = B ^ S0[A] + S1[A >>> 8]
    and     r6, r7, r2, ROR #16
    ldr     r6, [r9, r6, LSL #2]        @ S0[A >>> 16]
    add     r4, r6                      @ C = C + S0[A >>> 16]
    and     r6, r7, r2, ROR #24
    ldr     r6, [r8, r6, LSL #2]        @ S1[A >>> 24]
    eor     r5, r6                      @ D = D ^ S1[A >>> 24]
    mov     r2, r2, ROR #24             @ A >>> 24
    teq     r12, #3
    addeq   r2, r3
    teq     r12, #7
    addeq   r2, r3
    teq     r12, #4
    addeq   r2, r5
    teq     r12, #8
    addeq   r2, r5                      @ A = A + B(if i = 1, 5) + D(if i = 0, 4)
    mov     r6, r2
    mov     r2, r3
    mov     r3, r4
    mov     r4, r5
    mov     r5, r6
    subs    r12, #1
    bne     .Lmars_encrypt_forward_mixing
    mov     r12, #16
.Lmars_encrypt_cryptographic_core:
    ldmia   r1!, {r6-r7}
    add     r6, r2                      @ A + K ` M >>> r
    mov     r2, r2, ROR #19             @ A = A <<< 13
    mul     r7, r2, r7                  @ (A <<< 13) * K'
    mov     r7, r7, ROR #27             @ ((A <<< 13) * K') <<< 5 ` R >>> 5
    rsb     r8, r7, #0
    add     r4, r6, ROR r8              @ C = C + M
    mov     r6, r6, LSL #23
    ldr     r6, [r9, r6, LSR #21]       @ S[M]
    eor     r6, r7                      @ S[M] ^ (R >>> 5)
    mov     r7, r7, ROR #27             @ R = ((A <<< 13) * K') <<< 10
    eor     r6, r7                      @ S[M] ^ (R >>> 5) ^ R
    rsb     r8, r7, #0
    mov     r6, r6, ROR r8              @ L = (S[M] ^ (R >>> 5) ^ R) <<< R
    cmp     r12, #8
    addhi   r3, r6
    eorls   r3, r7                      @ B = B + L(if i < 8) ^ R(if i >= 8)
    addls   r5, r6
    eorhi   r5, r7                      @ D = D ^ R(if i < 8) + L(if i >= 8)
    mov     r8, r2
    mov     r2, r3
    mov     r3, r4
    mov     r4, r5
    mov     r5, r8
    subs    r12, #1
    bne     .Lmars_encrypt_cryptographic_core
    mov     r7, #255
    add     r8, r9, #1024
    mov     r12, #8
.Lmars_encrypt_backwards_mixing:
    teq     r12, #1
    subeq   r2, r3
    teq     r12, #5
    subeq   r2, r3
    teq     r12, #2
    subeq   r2, r5
    teq     r12, #6
    subeq   r2, r5                      @ A = A - B(if i = 3, 7) - D(if i = 2, 6)
    and     r6, r7, r2
    ldr     r6, [r8, r6, LSL #2]        @ S1[A]
    eor     r3, r6                      @ B = B ^ S1[A]
    and     r6, r7, r2, ROR #24
    ldr     r6, [r9, r6, LSL #2]        @ S0[A <<< 8]
    sub     r4, r6                      @ C = C - S0[A <<< 8]
    and     r6, r7, r2, ROR #16
    ldr     r6, [r8, r6, LSL #2]        @ S1[A <<< 16]
    sub     r5, r6                      @ D - S1[A <<< 16]
    and     r6, r7, r2, ROR #8
    ldr     r6, [r9, r6, LSL #2]        @ S0[A <<< 24]
    eor     r5, r6                      @ D = D - S1[A <<< 16] ^ S0[A <<< 24]
    mov     r6, r2, ROR #8              @ A <<< 24
    mov     r2, r3
    mov     r3, r4
    mov     r4, r5
    mov     r5, r6
    subs    r12, #1
    bne     .Lmars_encrypt_backwards_mixing
    ldmia   r1!, {r6-r9}
    sub     r2, r6
    sub     r3, r7
    sub     r4, r8
    sub     r5, r9
    stmia   r0, {r2-r5}
    ldmia   sp!, {r4-r9}
    mov     pc, lr

mars_decrypt:
    add     r1, #160
    stmdb   sp!, {r4-r9}
    ldmia   r0, {r2-r5}
    ldmdb   r1!, {r6-r9}
    add     r2, r6
    add     r3, r7
    add     r4, r8
    add     r5, r9
    mov     r7, #255
    sub     r8, pc, #1872               @ S1
    sub     r9, r8, #1024               @ S0
    mov     r12, #8
.Lmars_decrypt_forward_mixing:
    mov     r6, r5
    mov     r5, r4
    mov     r4, r3
    mov     r3, r2
    mov     r2, r6, ROR #24
    and     r6, r7, r2, ROR #8
    ldr     r6, [r9, r6, LSL #2]        @ S0[A <<< 24]
    eor     r5, r6                      @ D ^ S0[A <<< 24]
    and     r6, r7, r2, ROR #16
    ldr     r6, [r8, r6, LSL #2]        @ S1[A <<< 16]
    add     r5, r6                      @ D = D ^ S0[A <<< 24] + S1[A <<< 16]
    and     r6, r7, r2, ROR #24
    ldr     r6, [r9, r6, LSL #2]        @ S0[A <<< 8]
    add     r4, r6                      @ C = C + S0[A <<< 8]
    and     r6, r7, r2
    ldr     r6, [r8, r6, LSL #2]        @ S1[A]
    eor     r3, r6                      @ B = B ^ S1[A]
    teq     r12, #4
    addeq   r2, r3
    teq     r12, #8
    addeq   r2, r3
    teq     r12, #3
    addeq   r2, r5
    teq     r12, #7
    addeq   r2, r5                      @ A = A + B(if i = 3, 7) + D(if i = 2, 6)
    subs    r12, #1
    bne     .Lmars_decrypt_forward_mixing
    mov     r12, #16
.Lmars_decrypt_cryptographic_core:
    ldmdb   r1!, {r6-r7}
    mov     r8, r5
    mov     r5, r4
    mov     r4, r3
    mov     r3, r2
    mov     r2, r8
    add     r6, r2, ROR #13             @ A + K ` M >>> r
    mul     r7, r2, r7                  @ (A <<< 13) * K'
    mov     r2, r2, ROR #13             @ A = A >>> 13
    mov     r7, r7, ROR #27             @ ((A <<< 13) * K') <<< 5 ` R >>> 5
    rsb     r8, r7, #0
    sub     r4, r6, ROR r8              @ C = C - M
    mov     r6, r6, LSL #23
    ldr     r6, [r9, r6, LSR #21]       @ S[M]
    eor     r6, r7                      @ S[M] ^ (R >>> 5)
    mov     r7, r7, ROR #27             @ R = ((A <<< 13) * K') <<< 10
    eor     r6, r7                      @ S[M] ^ (R >>> 5) ^ R
    rsb     r8, r7, #0
    mov     r6, r6, ROR r8              @ L = (S[M] ^ (R >>> 5) ^ R) <<< R
    cmp     r12, #8
    subls   r3, r6
    eorhi   r3, r7                      @ B = B - L(if i < 8) ^ R(if i >= 8)
    subhi   r5, r6
    eorls   r5, r7                      @ D = D ^ R(if i < 8) - L(if i >= 8)
    subs    r12, #1
    bne     .Lmars_decrypt_cryptographic_core
    mov     r7, #255
    add     r8, r9, #1024
    mov     r12, #8
.Lmars_decrypt_backwards_mixing:
    mov     r6, r5
    mov     r5, r4
    mov     r4, r3
    mov     r3, r2
    mov     r2, r6
    teq     r12, #2
    subeq   r2, r3
    teq     r12, #6
    subeq   r2, r3
    teq     r12, #1
    subeq   r2, r5
    teq     r12, #5
    subeq   r2, r5                      @ A = A - B(if i = 1, 5) - D(if i = 0, 4)
    mov     r2, r2, ROR #8              @ A = A <<< 24
    and     r6, r7, r2, ROR #24
    ldr     r6, [r8, r6, LSL #2]        @ S1[A >>> 24]
    eor     r5, r6                      @ D = D ^ S1[A >>> 24]
    and     r6, r7, r2, ROR #16
    ldr     r6, [r9, r6, LSL #2]        @ S0[A >>> 16]
    sub     r4, r6                      @ C = C - S0[A >>> 16]
    and     r6, r7, r2, ROR #8
    ldr     r6, [r8, r6, LSL #2]        @ S1[A >>> 8]
    sub     r3, r6                      @ B - S1[A >>> 8]
    and     r6, r7, r2
    ldr     r6, [r9, r6, LSL #2]        @ S0[A]
    eor     r3, r6                      @ B = B - S1[A >>> 8] ^ S0[A]
    subs    r12, #1
    bne     .Lmars_decrypt_backwards_mixing
    ldmdb   r1!, {r6-r9}
    sub     r2, r6
    sub     r3, r7
    sub     r4, r8
    sub     r5, r9
    stmia   r0, {r2-r5}
    ldmia   sp!, {r4-r9}
    mov     pc, lr
