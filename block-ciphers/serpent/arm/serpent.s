.globl serpent_128_key_schedule @ void serpent_128_key_schedule(unsigned char key[528])
.globl serpent_192_key_schedule @ void serpent_192_key_schedule(unsigned char key[528])
.globl serpent_256_key_schedule @ void serpent_256_key_schedule(unsigned char key[528])
.globl serpent_encrypt          @ void serpent_encrypt(unsigned char buffer[16], const unsigned char key[528])
.globl serpent_decrypt          @ void serpent_decrypt(unsigned char buffer[16], const unsigned char key[528])

.section .text,"ax",%progbits

.balign 4

S0:
    b       .LS0
S1:
    b       .LS1
S2:
    b       .LS2
S3:
    b       .LS3
S4:
    b       .LS4
S5:
    b       .LS5
S6:
    b       .LS6
S7:
    b       .LS7
InvS0:
    b       .LInvS0
InvS1:
    b       .LInvS1
InvS2:
    b       .LInvS2
InvS3:
    b       .LInvS3
InvS4:
    b       .LInvS4
InvS5:
    b       .LInvS5
InvS6:
    b       .LInvS6
InvS7:
    b       .LInvS7

.LS0:
    eor     r5, r2
    mov     r6, r3
    and     r3, r5
    eor     r6, r4
    eor     r3, r2
    orr     r2, r5
    eor     r2, r6
    eor     r6, r5
    eor     r5, r4
    orr     r4, r3
    eor     r4, r6
    mvn     r6, r6
    orr     r6, r3
    eor     r3, r5
    eor     r3, r6
    orr     r5, r2
    eor     r3, r5
    eor     r6, r5
    mov     r5, r2
    mov     r2, r3
    mov     r3, r6
    mov     pc, lr
.LS1:
    mvn     r2, r2
    mvn     r4, r4
    mov     r6, r2
    and     r2, r3
    eor     r4, r2
    orr     r2, r5
    eor     r5, r4
    eor     r3, r2
    eor     r2, r6
    orr     r6, r3
    eor     r3, r5
    orr     r4, r2
    and     r4, r6
    eor     r2, r3
    and     r3, r4
    eor     r3, r2
    and     r2, r4
    eor     r2, r6
    mov     r6, r2
    mov     r2, r4
    mov     r4, r5
    mov     r5, r3
    mov     r3, r6
    mov     pc, lr
.LS2:
    mov     r6, r2
    and     r2, r4
    eor     r2, r5
    eor     r4, r3
    eor     r4, r2
    orr     r5, r6
    eor     r5, r3
    eor     r6, r4
    mov     r3, r5
    orr     r5, r6
    eor     r5, r2
    and     r2, r3
    eor     r6, r2
    eor     r3, r5
    eor     r3, r6
    mvn     r6, r6
    mov     r2, r4
    mov     r4, r3
    mov     r3, r5
    mov     r5, r6
    mov     pc, lr
.LS3:
    mov     r6, r2
    orr     r2, r5
    eor     r5, r3
    and     r3, r6
    eor     r6, r4
    eor     r4, r5
    and     r5, r2
    orr     r6, r3
    eor     r5, r6
    eor     r2, r3
    and     r6, r2
    eor     r3, r5
    eor     r6, r4
    orr     r3, r2
    eor     r3, r4
    eor     r2, r5
    mov     r4, r3
    orr     r3, r5
    eor     r3, r2
    mov     r2, r3
    mov     r3, r4
    mov     r4, r5
    mov     r5, r6
    mov     pc, lr
.LS4:
    eor     r3, r5
    mvn     r5, r5
    eor     r4, r5
    eor     r5, r2
    mov     r6, r3
    and     r3, r5
    eor     r3, r4
    eor     r6, r5
    eor     r2, r6
    and     r4, r6
    eor     r4, r2
    and     r2, r3
    eor     r5, r2
    orr     r6, r3
    eor     r6, r2
    orr     r2, r5
    eor     r2, r4
    and     r4, r5
    mvn     r2, r2
    eor     r6, r4
    mov     r4, r2
    mov     r2, r3
    mov     r3, r6
    mov     pc, lr
.LS5:
    eor     r2, r3
    eor     r3, r5
    mvn     r5, r5
    mov     r6, r3
    and     r3, r2
    eor     r4, r5
    eor     r3, r4
    orr     r4, r6
    eor     r6, r5
    and     r5, r3
    eor     r5, r2
    eor     r6, r3
    eor     r6, r4
    eor     r4, r2
    and     r2, r5
    mvn     r4, r4
    eor     r2, r6
    orr     r6, r5
    eor     r4, r6
    mov     r6, r2
    mov     r2, r3
    mov     r3, r5
    mov     r5, r4
    mov     r4, r6
    mov     pc, lr
.LS6:
    mvn     r4, r4
    mov     r6, r5
    and     r5, r2
    eor     r2, r6
    eor     r5, r4
    orr     r4, r6
    eor     r3, r5
    eor     r4, r2
    orr     r2, r3
    eor     r4, r3
    eor     r6, r2
    orr     r2, r5
    eor     r2, r4
    eor     r6, r5
    eor     r6, r2
    mvn     r5, r5
    and     r4, r6
    eor     r4, r5
    mov     r5, r4
    mov     r4, r6
    mov     pc, lr
.LS7:
    mov     r6, r3
    orr     r3, r4
    eor     r3, r5
    eor     r6, r4
    eor     r4, r3
    orr     r5, r6
    and     r5, r2
    eor     r6, r4
    eor     r5, r3
    orr     r3, r6
    eor     r3, r2
    orr     r2, r6
    eor     r2, r4
    eor     r3, r6
    eor     r4, r3
    and     r3, r2
    eor     r3, r6
    mvn     r4, r4
    orr     r4, r2
    eor     r6, r4
    mov     r4, r3
    mov     r3, r5
    mov     r5, r2
    mov     r2, r6
    mov     pc, lr
.LInvS0:
    mvn     r4, r4
    mov     r6, r3
    orr     r3, r2
    mvn     r6, r6
    eor     r3, r4
    orr     r4, r6
    eor     r3, r5
    eor     r2, r6
    eor     r4, r2
    and     r2, r5
    eor     r6, r2
    orr     r2, r3
    eor     r2, r4
    eor     r5, r6
    eor     r4, r3
    eor     r5, r2
    eor     r5, r3
    and     r4, r5
    eor     r6, r4
    mov     r4, r3
    mov     r3, r6
    mov     pc, lr
.LInvS1:
    mov     r6, r3
    eor     r3, r5
    and     r5, r3
    eor     r6, r4
    eor     r5, r2
    orr     r2, r3
    eor     r4, r5
    eor     r2, r6
    orr     r2, r4
    eor     r3, r5
    eor     r2, r3
    orr     r3, r5
    eor     r3, r2
    mvn     r6, r6
    eor     r6, r3
    orr     r3, r2
    eor     r3, r2
    orr     r3, r6
    eor     r5, r3
    mov     r3, r2
    mov     r2, r6
    mov     r6, r4
    mov     r4, r5
    mov     r5, r6
    mov     pc, lr
.LInvS2:
    eor     r4, r5
    eor     r5, r2
    mov     r6, r5
    and     r5, r4
    eor     r5, r3
    orr     r3, r4
    eor     r3, r6
    and     r6, r5
    eor     r4, r5
    and     r6, r2
    eor     r6, r4
    and     r4, r3
    orr     r4, r2
    mvn     r5, r5
    eor     r4, r5
    eor     r2, r5
    and     r2, r3
    eor     r5, r6
    eor     r5, r2
    mov     r2, r3
    mov     r3, r6
    mov     pc, lr
.LInvS3:
    mov     r6, r4
    eor     r4, r3
    eor     r2, r4
    and     r6, r4
    eor     r6, r2
    and     r2, r3
    eor     r3, r5
    orr     r5, r6
    eor     r4, r5
    eor     r2, r5
    eor     r3, r6
    and     r5, r4
    eor     r5, r3
    eor     r3, r2
    orr     r3, r4
    eor     r2, r5
    eor     r3, r6
    eor     r2, r3
    mov     r6, r2
    mov     r2, r4
    mov     r4, r5
    mov     r5, r6
    mov     pc, lr
.LInvS4:
    mov     r6, r4
    and     r4, r5
    eor     r4, r3
    orr     r3, r5
    and     r3, r2
    eor     r6, r4
    eor     r6, r3
    and     r3, r4
    mvn     r2, r2
    eor     r5, r6
    eor     r3, r5
    and     r5, r2
    eor     r5, r4
    eor     r2, r3
    and     r4, r2
    eor     r5, r2
    eor     r4, r6
    orr     r4, r5
    eor     r5, r2
    eor     r4, r3
    mov     r3, r5
    mov     r5, r6
    mov     pc, lr
.LInvS5:
    mvn     r3, r3
    mov     r6, r5
    eor     r4, r3
    orr     r5, r2
    eor     r5, r4
    orr     r4, r3
    and     r4, r2
    eor     r6, r5
    eor     r4, r6
    orr     r6, r2
    eor     r6, r3
    and     r3, r4
    eor     r3, r5
    eor     r6, r4
    and     r5, r6
    eor     r6, r3
    eor     r5, r6
    mvn     r6, r6
    eor     r5, r2
    mov     r2, r3
    mov     r3, r6
    mov     r6, r4
    mov     r4, r5
    mov     r5, r6
    mov     pc, lr
.LInvS6:
    eor     r2, r4
    mov     r6, r4
    and     r4, r2
    eor     r6, r5
    mvn     r4, r4
    eor     r5, r3
    eor     r4, r5
    orr     r6, r2
    eor     r2, r4
    eor     r5, r6
    eor     r6, r3
    and     r3, r5
    eor     r3, r2
    eor     r2, r5
    orr     r2, r4
    eor     r5, r3
    eor     r6, r2
    mov     r2, r3
    mov     r3, r4
    mov     r4, r6
    mov     pc, lr
.LInvS7:
    mov     r6, r4
    eor     r4, r2
    and     r2, r5
    orr     r6, r5
    mvn     r4, r4
    eor     r5, r3
    orr     r3, r2
    eor     r2, r4
    and     r4, r6
    and     r5, r6
    eor     r3, r4
    eor     r4, r2
    orr     r2, r4
    eor     r6, r3
    eor     r2, r5
    eor     r5, r6
    orr     r6, r2
    eor     r5, r4
    eor     r6, r4
    mov     r4, r3
    mov     r3, r2
    mov     r2, r5
    mov     r5, r6
    mov     pc, lr

serpent_128_key_schedule:
    add     r1, r0, #16
    mov     r2, #15
    b       .Lserpent_key_schedule_extend
serpent_192_key_schedule:
    add     r1, r0, #24
    mov     r2, #7
.Lserpent_key_schedule_extend:
    mov     r3, #1
    str     r3, [r1], #4
    mov     r3, #0
.Lserpent_key_schedule_extend_loop:
    str     r3, [r1], #4
    subs    r2, #1
    bne     .Lserpent_key_schedule_extend_loop
serpent_256_key_schedule:
    stmdb   sp!, {r4-r10, lr}
    mov     r12, #0
    mov     r10, #0
    ldmia   r0, {r1-r8}
    orr     r12, #185
    orr     r12, #30976
    orr     r12, #3604480
    orr     r12, #2650800128
.Lserpent_key_schedule_prekey:
    eor     r9, r10, r12
    eor     r9, r1
    eor     r9, r4
    eor     r9, r6
    eor     r9, r8
    mov     r9, r9, ROR #21
    str     r9, [r0], #4
    mov     r1, r2
    mov     r2, r3
    mov     r3, r4
    mov     r4, r5
    mov     r5, r6
    mov     r6, r7
    mov     r7, r8
    mov     r8, r9
    add     r10, #1
    teq     r10, #132
    bne     .Lserpent_key_schedule_prekey
    sub     r0, #528
    mov     r1, #4
    sub     r10, pc, #1712
    mov     r12, #33
.Lserpent_key_schedule_loop:
    sub     r1, #1
    ldmia   r0, {r2-r5}
    and     r1, #7
    mov     lr, pc
    add     pc, r10, r1, LSL #2
    stmia   r0!, {r2-r5}
    subs    r12, #1
    bne     .Lserpent_key_schedule_loop
    ldmia   sp!, {r4-r10, pc}

serpent_encrypt:
    stmdb   sp!, {r4-r11, lr}
    sub     r11, pc, #1760
    mov     r10, #0
    mov     r12, #32
    ldmia   r0, {r2-r5}
    b       .Lserpent_encrypt_loop_init
.Lserpent_encrypt_loop:
    mov     r2, r2, ROR #19
    mov     r4, r4, ROR #29
    eor     r3, r2
    eor     r3, r4
    eor     r5, r2, LSL #3
    eor     r5, r4
    mov     r3, r3, ROR #31
    mov     r5, r5, ROR #25
    eor     r2, r3
    eor     r2, r5
    eor     r4, r3, LSL #7
    eor     r4, r5
    mov     r2, r2, ROR #27
    mov     r4, r4, ROR #10
.Lserpent_encrypt_loop_init:
    ldmia   r1!, {r6-r9}
    eor     r2, r6
    eor     r3, r7
    eor     r4, r8
    eor     r5, r9
    mov     lr, pc
    add     pc, r11, r10, LSL #2
    add     r10, #1
    and     r10, #7
    subs    r12, #1
    bne     .Lserpent_encrypt_loop
    ldmia   r1!, {r6-r9}
    eor     r2, r6
    eor     r3, r7
    eor     r4, r8
    eor     r5, r9
    stmia   r0, {r2-r5}
    ldmia   sp!, {r4-r11, pc}

serpent_decrypt:
    stmdb   sp!, {r4-r11, lr}
    mov     r10, #0
    mov     r12, #32
    sub     r11, pc, #1888
    ldmia   r0, {r2-r5}
    add     r1, #528
    ldmdb   r1!, {r6-r9}
    eor     r2, r6
    eor     r3, r7
    eor     r4, r8
    eor     r5, r9
    b       .Lserpent_decrypt_loop_init
.Lserpent_decrypt_loop:
    mov     r4, r4, ROR #22
    mov     r2, r2, ROR #5
    eor     r4, r3, LSL #7
    eor     r4, r5
    eor     r2, r3
    eor     r2, r5
    mov     r5, r5, ROR #7
    mov     r3, r3, ROR #1
    eor     r5, r2, LSL #3
    eor     r5, r4
    eor     r3, r2
    eor     r3, r4
    mov     r4, r4, ROR #3
    mov     r2, r2, ROR #13
.Lserpent_decrypt_loop_init:
    sub     r10, #1
    and     r10, #7
    mov     lr, pc
    add     pc, r11, r10, LSL #2
    ldmdb   r1!, {r6-r9}
    eor     r2, r6
    eor     r3, r7
    eor     r4, r8
    eor     r5, r9
    subs    r12, #1
    bne     .Lserpent_decrypt_loop
    stmia   r0, {r2-r5}
    ldmia   sp!, {r4-r11, pc}
