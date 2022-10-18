.globl rc6_128_key_schedule @ void rc6_128_key_schedule(unsigned char key[176])
.globl rc6_192_key_schedule @ void rc6_192_key_schedule(unsigned char key[176])
.globl rc6_256_key_schedule @ void rc6_256_key_schedule(unsigned char key[176])
.globl rc6_encrypt          @ void rc6_encrypt(unsigned char buffer[16], const unsigned char key[176])
.globl rc6_decrypt          @ void rc6_decrypt(unsigned char buffer[16], const unsigned char key[176])

.section .text,"ax",%progbits

.balign 4

rc6_128_key_schedule:
    stmdb   sp!, {r4-r8}
    ldmia   r0, {r1-r4}
    stmdb   sp!, {r1-r4}
    mov     r7, #4
    b       .Lrc6_key_schedule

rc6_192_key_schedule:
    stmdb   sp!, {r4-r8}
    ldmia   r0, {r1-r6}
    stmdb   sp!, {r1-r6}
    mov     r7, #6
    b       .Lrc6_key_schedule

rc6_256_key_schedule:
    stmdb   sp!, {r4-r8}
    ldmia   r0, {r1-r8}
    stmdb   sp!, {r1-r8}
    mov     r7, #8
    b       .Lrc6_key_schedule

.Lrc6_key_schedule:
    mov     r1, #0
    orr     r1, #99
    orr     r1, #20736
    orr     r1, #14745600
    orr     r1, #3070230528
    mov     r2, #0
    orr     r2, #185
    orr     r2, #30976
    orr     r2, #3604480
    orr     r2, #2650800128
    mov     r3, #44
.Lrc6_key_schedule_init:
    str     r1, [r0], #4
    add     r1, r2
    subs    r3, #1
    bne     .Lrc6_key_schedule_init
    sub     r0, #176
    mov     r1, #0
    mov     r2, #0
    mov     r5, #0
    mov     r6, #0
    mov     r8, #132
.Lrc6_key_schedule_loop:
    ldr     r3, [r0, r5, LSL #2]
    add     r1, r2
    add     r3, r1
    mov     r3, r3, ROR #29
    mov     r1, r3
    str     r3, [r0, r5, LSL #2]
    ldr     r4, [sp, r6, LSL #2]
    add     r2, r1
    add     r4, r2
    rsb     r2, #0
    mov     r4, r4, ROR r2
    mov     r2, r4
    str     r4, [sp, r6, LSL #2]
    add     r5, #1
    teq     r5, #44
    moveq   r5, #0
    add     r6, #1
    teq     r6, r7
    moveq   r6, #0
    subs    r8, #1
    bne     .Lrc6_key_schedule_loop
    add     sp, r7, LSL #2
    ldmia   sp!, {r4-r8}
    mov     pc, lr

rc6_encrypt:
    stmdb   sp!, {r4-r9}
    ldmia   r0, {r4-r7}
    ldmia   r1!, {r2-r3}
    subs    r0, #0
    add     r5, r2
    add     r7, r3
    mov     r12, #20
.Lrc6_encrypt_loop:
    adc     r2, r5, r5
    adc     r3, r7, r7
    mul     r2, r5, r2
    mul     r3, r7, r3
    mov     r2, r2, ROR #27
    mov     r3, r3, ROR #27
    eor     r4, r2
    eor     r6, r3
    rsb     r2, #0
    rsb     r3, #0
    ldmia   r1!, {r8-r9}
    add     r4, r8, r4, ROR r3
    add     r6, r9, r6, ROR r2
    mov     r3, r4
    mov     r4, r5
    mov     r5, r6
    mov     r6, r7
    mov     r7, r3
    subs    r12, #1
    bne     .Lrc6_encrypt_loop
    ldmia   r1!, {r2-r3}
    add     r4, r2
    add     r6, r3
    stmia   r0, {r4-r7}
    ldmia   sp!, {r4-r9}
    mov     pc, lr

rc6_decrypt:
    add     r1, #176
    stmdb   sp!, {r4-r9}
    ldmia   r0, {r4-r7}
    ldmdb   r1!, {r2-r3}
    subs    r0, #0
    sub     r4, r2
    sub     r6, r3
    mov     r12, #20
.Lrc6_decrypt_loop:
    mov     r3, r7
    mov     r7, r6
    mov     r6, r5
    mov     r5, r4
    mov     r4, r3
    adc     r2, r5, r5
    adc     r3, r7, r7
    mul     r2, r5, r2
    mul     r3, r7, r3
    mov     r2, r2, ROR #27
    mov     r3, r3, ROR #27
    ldmdb   r1!, {r8-r9}
    sub     r4, r8
    sub     r6, r9
    eor     r4, r2, r4, ROR r3
    eor     r6, r3, r6, ROR r2
    subs    r12, #1
    bne     .Lrc6_decrypt_loop
    ldmdb   r1!, {r2-r3}
    sub     r5, r2
    sub     r7, r3
    stmia   r0, {r4-r7}
    ldmia   sp!, {r4-r9}
    mov     pc, lr
