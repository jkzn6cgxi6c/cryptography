.386

; void __stdcall serpent_128_key_schedule(unsigned char key[528])
; void __stdcall serpent_192_key_schedule(unsigned char key[528])
; void __stdcall serpent_256_key_schedule(unsigned char key[528])
; void __stdcall serpent_encrypt(unsigned char buffer[16], const unsigned char key[528])
; void __stdcall serpent_decrypt(unsigned char buffer[16], const unsigned char key[528])

PUBLIC _serpent_128_key_schedule@4, _serpent_192_key_schedule@4, _serpent_256_key_schedule@4
PUBLIC _serpent_encrypt@8, _serpent_decrypt@8

_TEXT SEGMENT DWORD EXECUTE READ FLAT ALIAS('.text') 'CODE'
ASSUME CS:FLAT, DS:FLAT, ES:FLAT, SS:FLAT

S0:
    db      233
    dd      LS0 - $-4
    db      141, 73, 0
S1:
    jmp     LS1
    db      141, 73, 0
S2:
    jmp     LS2
    db      141, 73, 0
S3:
    jmp     LS3
    db      141, 73, 0
S4:
    jmp     LS4
    db      141, 73, 0
S5:
    jmp     LS5
    db      141, 73, 0
S6:
    jmp     LS6
    db      141, 73, 0
S7:
    jmp     LS7
    db      141, 73, 0
InvS0:
    jmp     LInvS0
    db      141, 73, 0
InvS1:
    jmp     LInvS1
    db      141, 73, 0
InvS2:
    jmp     LInvS2
    db      141, 73, 0
InvS3:
    jmp     LInvS3
    db      141, 73, 0
InvS4:
    jmp     LInvS4
    db      141, 73, 0
InvS5:
    jmp     LInvS5
    db      141, 73, 0
InvS6:
    jmp     LInvS6
    db      141, 73, 0
InvS7:
    jmp     LInvS7
    db      141, 73, 0

get_eip:
    mov     eax, DWORD PTR [esp]        ; get eip
    ret

dd 2385037

LS0:
    xor     ebp, ecx
    mov     eax, edx
    and     edx, ebp
    xor     eax, ebx
    xor     edx, ecx
    or      ecx, ebp
    xor     ecx, eax
    xor     eax, ebp
    xor     ebp, ebx
    or      ebx, edx
    xor     ebx, eax
    not     eax
    or      eax, edx
    xor     edx, ebp
    xor     edx, eax
    or      ebp, ecx
    xor     edx, ebp
    xor     ebp, eax
    mov     eax, edx
    mov     edx, ebx
    mov     ebx, ecx
    mov     ecx, ebp
    ret

db 141, 73, 0

LS1:
    not     ecx
    not     ebx
    mov     eax, ecx
    and     ecx, edx
    xor     ebx, ecx
    or      ecx, ebp
    xor     ebp, ebx
    xor     edx, ecx
    xor     ecx, eax
    or      eax, edx
    xor     edx, ebp
    or      ebx, ecx
    and     ebx, eax
    xor     ecx, edx
    and     edx, ebx
    xor     edx, ecx
    and     ecx, ebx
    xor     ecx, eax
    mov     eax, ebx
    mov     ebx, edx
    mov     edx, ebp
    ret

db 144

LS2:
    mov     eax, ecx
    and     ecx, ebx
    xor     ecx, ebp
    xor     ebx, edx
    xor     ebx, ecx
    or      ebp, eax
    xor     ebp, edx
    xor     eax, ebx
    mov     edx, ebp
    or      ebp, eax
    xor     ebp, ecx
    and     ecx, edx
    xor     eax, ecx
    xor     edx, ebp
    xor     edx, eax
    not     eax
    mov     ecx, eax
    mov     eax, ebx
    mov     ebx, ecx
    mov     ecx, ebp
    ret

db 141, 73, 0

LS3:
    mov     eax, ecx
    or      ecx, ebp
    xor     ebp, edx
    and     edx, eax
    xor     eax, ebx
    xor     ebx, ebp
    and     ebp, ecx
    or      eax, edx
    xor     ebp, eax
    xor     ecx, edx
    and     eax, ecx
    xor     edx, ebp
    xor     eax, ebx
    or      edx, ecx
    xor     edx, ebx
    xor     ecx, ebp
    mov     ebx, edx
    or      edx, ebp
    xor     edx, ecx
    mov     ecx, ebx
    mov     ebx, eax
    mov     eax, edx
    mov     edx, ebp
    ret

db 144

LS4:
    xor     edx, ebp
    not     ebp
    xor     ebx, ebp
    xor     ebp, ecx
    mov     eax, edx
    and     edx, ebp
    xor     edx, ebx
    xor     eax, ebp
    xor     ecx, eax
    and     ebx, eax
    xor     ebx, ecx
    and     ecx, edx
    xor     ebp, ecx
    or      eax, edx
    xor     eax, ecx
    or      ecx, ebp
    xor     ecx, ebx
    and     ebx, ebp
    not     ecx
    xor     ebx, eax
    mov     eax, edx
    mov     edx, ecx
    mov     ecx, ebx
    mov     ebx, ebp
    ret

db 141, 73, 0

LS5:
    xor     ecx, edx
    xor     edx, ebp
    not     ebp
    mov     eax, edx
    and     edx, ecx
    xor     ebx, ebp
    xor     edx, ebx
    or      ebx, eax
    xor     eax, ebp
    and     ebp, edx
    xor     ebp, ecx
    xor     eax, edx
    xor     eax, ebx
    xor     ebx, ecx
    and     ecx, ebp
    not     ebx
    xor     ecx, eax
    or      eax, ebp
    xor     ebx, eax
    mov     eax, edx
    mov     edx, ecx
    mov     ecx, ebp
    ret

db 141, 73, 0

LS6:
    not     ebx
    mov     eax, ebp
    and     ebp, ecx
    xor     ecx, eax
    xor     ebp, ebx
    or      ebx, eax
    xor     edx, ebp
    xor     ebx, ecx
    or      ecx, edx
    xor     ebx, edx
    xor     eax, ecx
    or      ecx, ebp
    xor     ecx, ebx
    xor     eax, ebp
    xor     eax, ecx
    not     ebp
    and     ebx, eax
    xor     ebx, ebp
    mov     ebp, eax
    mov     eax, ecx
    mov     ecx, edx
    mov     edx, ebp
    ret

db 141, 73, 0

LS7:
    mov     eax, edx
    or      edx, ebx
    xor     edx, ebp
    xor     eax, ebx
    xor     ebx, edx
    or      ebp, eax
    and     ebp, ecx
    xor     eax, ebx
    xor     ebp, edx
    or      edx, eax
    xor     edx, ecx
    or      ecx, eax
    xor     ecx, ebx
    xor     edx, eax
    xor     ebx, edx
    and     edx, ecx
    xor     edx, eax
    not     ebx
    or      ebx, ecx
    xor     eax, ebx
    mov     ebx, ecx
    mov     ecx, ebp
    ret

db 141, 73, 0

LInvS0:
    not     ebx
    mov     eax, edx
    or      edx, ecx
    not     eax
    xor     edx, ebx
    or      ebx, eax
    xor     edx, ebp
    xor     ecx, eax
    xor     ebx, ecx
    and     ecx, ebp
    xor     eax, ecx
    or      ecx, edx
    xor     ecx, ebx
    xor     ebp, eax
    xor     ebx, edx
    xor     ebp, ecx
    xor     ebp, edx
    and     ebx, ebp
    xor     eax, ebx
    mov     ebx, edx
    mov     edx, eax
    ret

db 144

LInvS1:
    mov     eax, edx
    xor     edx, ebp
    and     ebp, edx
    xor     eax, ebx
    xor     ebp, ecx
    or      ecx, edx
    xor     ebx, ebp
    xor     ecx, eax
    or      ecx, ebx
    xor     edx, ebp
    xor     ecx, edx
    or      edx, ebp
    xor     edx, ecx
    not     eax
    xor     eax, edx
    or      edx, ecx
    xor     edx, ecx
    or      edx, eax
    xor     ebp, edx
    mov     edx, ecx
    mov     ecx, eax
    mov     eax, ebx
    mov     ebx, ebp
    mov     ebp, eax
    ret

db 141, 73, 0

LInvS2:
    xor     ebx, ebp
    xor     ebp, ecx
    mov     eax, ebp
    and     ebp, ebx
    xor     ebp, edx
    or      edx, ebx
    xor     edx, eax
    and     eax, ebp
    xor     ebx, ebp
    and     eax, ecx
    xor     eax, ebx
    and     ebx, edx
    or      ebx, ecx
    not     ebp
    xor     ebx, ebp
    xor     ecx, ebp
    and     ecx, edx
    xor     ebp, eax
    xor     ebp, ecx
    mov     ecx, edx
    mov     edx, eax
    ret

db 144

LInvS3:
    mov     eax, ebx
    xor     ebx, edx
    xor     ecx, ebx
    and     eax, ebx
    xor     eax, ecx
    and     ecx, edx
    xor     edx, ebp
    or      ebp, eax
    xor     ebx, ebp
    xor     ecx, ebp
    xor     edx, eax
    and     ebp, ebx
    xor     ebp, edx
    xor     edx, ecx
    or      edx, ebx
    xor     ecx, ebp
    xor     edx, eax
    xor     ecx, edx
    mov     eax, ecx
    mov     ecx, ebx
    mov     ebx, ebp
    mov     ebp, eax
    ret

db 141, 73, 0

LInvS4:
    mov     eax, ebx
    and     ebx, ebp
    xor     ebx, edx
    or      edx, ebp
    and     edx, ecx
    xor     eax, ebx
    xor     eax, edx
    and     edx, ebx
    not     ecx
    xor     ebp, eax
    xor     edx, ebp
    and     ebp, ecx
    xor     ebp, ebx
    xor     ecx, edx
    and     ebx, ecx
    xor     ebp, ecx
    xor     ebx, eax
    or      ebx, ebp
    xor     ebp, ecx
    xor     ebx, edx
    mov     edx, ebp
    mov     ebp, eax
    ret

db 141, 73, 0

LInvS5:
    not     edx
    mov     eax, ebp
    xor     ebx, edx
    or      ebp, ecx
    xor     ebp, ebx
    or      ebx, edx
    and     ebx, ecx
    xor     eax, ebp
    xor     ebx, eax
    or      eax, ecx
    xor     eax, edx
    and     edx, ebx
    xor     edx, ebp
    xor     eax, ebx
    and     ebp, eax
    xor     eax, edx
    xor     ebp, eax
    not     eax
    xor     ebp, ecx
    mov     ecx, edx
    mov     edx, eax
    mov     eax, ebx
    mov     ebx, ebp
    mov     ebp, eax
    ret

db 141, 73, 0

LInvS6:
    xor     ecx, ebx
    mov     eax, ebx
    and     ebx, ecx
    xor     eax, ebp
    not     ebx
    xor     ebp, edx
    xor     ebx, ebp
    or      eax, ecx
    xor     ecx, ebx
    xor     ebp, eax
    xor     eax, edx
    and     edx, ebp
    xor     edx, ecx
    xor     ecx, ebp
    or      ecx, ebx
    xor     ebp, edx
    xor     eax, ecx
    mov     ecx, edx
    mov     edx, ebx
    mov     ebx, eax
    ret

db 141, 73, 0

LInvS7:
    mov     eax, ebx
    xor     ebx, ecx
    and     ecx, ebp
    or      eax, ebp
    not     ebx
    xor     ebp, edx
    or      edx, ecx
    xor     ecx, ebx
    and     ebx, eax
    and     ebp, eax
    xor     edx, ebx
    xor     ebx, ecx
    or      ecx, ebx
    xor     eax, edx
    xor     ecx, ebp
    xor     ebp, eax
    or      eax, ecx
    xor     ebp, ebx
    xor     eax, ebx
    mov     ebx, edx
    mov     edx, ecx
    mov     ecx, ebp
    mov     ebp, eax
    ret

db 144

_serpent_128_key_schedule@4:
    mov     cl, 16                      ; number of bytes to append
    jmp     serpent_key_schedule
_serpent_192_key_schedule@4:
    mov     cl, 8                       ; number of bytes to append
    jmp     serpent_key_schedule
_serpent_256_key_schedule@4:
    mov     cl, 0                       ; number of bytes to append
    jmp     serpent_key_schedule
serpent_key_schedule:
    push    edi                         ; save edi
    xor     eax, eax                    ; eax = 0
    mov     edi, DWORD PTR [esp+8]      ; pointer to key
    and     ecx, 127                    ; number of dwords to append
    add     edi, 32                     ; pointer to end of appended key
    inc     eax                         ; eax = 1
    sub     edi, ecx                    ; pointer to end of key
    xor     edx, edx                    ; edx = 0
    shr     cl, 2                       ; number of dwords to append
    stosd                               ; append to key
    dec     eax                         ; eax = 0
    rep     stosd                       ; append to key
    sub     edi, 4                      ; pointer to 1st pre key
    mov     dl, 8                       ; number of prekeys to calculate
    mov     eax, DWORD PTR [edi-4]      ; w[i-1]
    call    serpent_key_schedule_prekey ; calculate 8 prekeys
    push    esi                         ; save esi
    sub     edi, 64                     ; pointer to key
    lea     esi, [edi+32]               ; pointer to 1st prekey
    rep     movsd                       ; move 8 prekeys
    mov     dl, 132                     ; number of prekeys to calculate
    mov     cl, 8                       ; number of current prekey
    call    serpent_key_schedule_prekey ; calculate 124 prekeys
    push    ebx                         ; save ebx
    push    ebp                         ; save ebp
    call    get_eip                     ; get eip
    sub     eax, 971                    ; address of s-box jumps
    push    edi                         ; address to compare
    push    eax                         ; address of s-box jumps
    push    BYTE PTR 32                 ; (1st s-box (3) + 1) * 8
    sub     edi, 528                    ; pointer to key
    mov     esi, edi                    ; pointer to key
serpent_key_schedule_loop:
    lodsd                               ; w0
    mov     ecx, eax                    ; w0
    lodsd                               ; w1
    mov     edx, eax                    ; w1
    lodsd                               ; w2
    mov     ebx, eax                    ; w2
    lodsd                               ; w3
    mov     ebp, eax                    ; w3
    pop     eax                         ; (s-box number + 1) * 8
    sub     eax, 8
    and     eax, 63                     ; s-box number * 8
    push    eax                         ; s-box number * 8
    add     eax, DWORD PTR [esp+4]      ; address of jump to s-box
    call    eax                         ; s-box
    stosd                               ; k0
    mov     eax, ecx
    stosd                               ; k1
    mov     eax, edx
    stosd                               ; k2
    mov     eax, ebx
    stosd                               ; k3
    cmp     esi, DWORD PTR [esp+8]      ; loop control
    jne     serpent_key_schedule_loop
    add     esp, 12
    pop     ebp                         ; restore ebp
    pop     ebx                         ; restore ebx
    pop     esi                         ; restore esi
    pop     edi                         ; restore edi
    ret     4
serpent_key_schedule_prekey:
    xor     eax, DWORD PTR [edi-32]     ; w[i-8]
    xor     eax, DWORD PTR [edi-20]     ; w[i-5]
    xor     eax, DWORD PTR [edi-12]     ; w[i-3]
    xor     eax, ecx                    ; i
    xor     eax, 2654435769             ; 0x9E3779B9
    rol     eax, 11
    stosd                               ; store prekey
    inc     ecx                         ; next i
    cmp     ecx, edx                    ; check loop end
    jne     serpent_key_schedule_prekey
    ret

dw 65419

_serpent_encrypt@8:
    push    ebx                         ; save ebx
    push    esi                         ; save esi
    push    edi                         ; save edi
    push    ebp                         ; save ebp
    mov     esi, DWORD PTR [esp+24]     ; pointer to key
    mov     ebp, DWORD PTR [esp+20]     ; pointer to plaintext
    push    BYTE PTR 32                 ; number of main rounds
    call    get_eip                     ; get_eip
    sub     eax, 1087                   ; address of s-box jumps
    mov     edi, eax                    ; address of s-box jumps
    mov     ecx, DWORD PTR [ebp+ 0]     ; B0
    mov     edx, DWORD PTR [ebp+ 4]     ; B1
    mov     ebx, DWORD PTR [ebp+ 8]     ; B2
    mov     ebp, DWORD PTR [ebp+12]     ; B3
    push    BYTE PTR 56                 ; (1st s-box (0) - 1) * 8
    jmp     serpent_encrypt_loop_init
serpent_encrypt_loop:
    rol     eax, 13
    rol     edx, 3
    xor     ecx, eax
    mov     ebp, eax
    xor     ecx, edx
    shl     ebp, 3
    xor     ebx, edx
    xor     ebp, ebx
    rol     ecx, 1
    rol     ebp, 7
    xor     eax, ecx
    mov     ebx, ecx
    xor     eax, ebp
    shl     ebx, 7
    xor     edx, ebp
    xor     ebx, edx
    rol     eax, 5
    rol     ebx, 22
    mov     edx, ecx
    mov     ecx, eax
serpent_encrypt_loop_init:
    lodsd
    xor     ecx, eax
    lodsd
    xor     edx, eax
    lodsd
    xor     ebx, eax
    lodsd
    xor     ebp, eax
    pop     eax                         ; (s-box number - 1) * 8
    add     eax, 8                      ; s-box number * 8
    and     eax, 63                     ; s-box number * 8
    push    eax                         ; s-box number * 8
    add     eax, edi                    ; address of jump to s-box
    call    eax                         ; s-box
    dec     BYTE PTR [esp+4]
    jne     serpent_encrypt_loop
    add     esp, 8
    mov     edi, eax                    ; B0
    mov     ebp, DWORD PTR [esp+20]
    lodsd
    xor     edi, eax                    ; B0
    lodsd
    xor     ecx, eax                    ; B1
    lodsd
    xor     edx, eax                    ; B2
    lodsd
    xor     ebx, eax                    ; B3
    mov     DWORD PTR [ebp+ 0], edi     ; B0
    mov     DWORD PTR [ebp+ 4], ecx     ; B1
    mov     DWORD PTR [ebp+ 8], edx     ; B2
    mov     DWORD PTR [ebp+12], ebx     ; B3
    pop     ebp                         ; restore ebp
    pop     edi                         ; restore edi
    pop     esi                         ; restore esi
    pop     ebx                         ; restore ebx
    ret     8

db 144

_serpent_decrypt@8:
    push    ebx                         ; save ebx
    push    esi                         ; save esi
    push    edi                         ; save edi
    push    ebp                         ; save ebp
    mov     esi, DWORD PTR [esp+24]     ; pointer to key
    std
    mov     ebp, DWORD PTR [esp+20]     ; pointer to ciphertext
    add     esi, 524                    ; pointer to last dword of key
    push    BYTE PTR 32                 ; number of main rounds
    call    get_eip                     ; get_eip
    sub     eax, 1190                   ; address of s-box jumps
    mov     edi, eax                    ; address of s-box jumps
    mov     ecx, DWORD PTR [ebp+ 0]     ; B0
    mov     edx, DWORD PTR [ebp+ 4]     ; B1
    mov     ebx, DWORD PTR [ebp+ 8]     ; B2
    mov     ebp, DWORD PTR [ebp+12]     ; B3
    lodsd
    xor     ebp, eax                    ; B3
    lodsd
    xor     ebx, eax                    ; B2
    lodsd
    xor     edx, eax                    ; B1
    lodsd
    xor     ecx, eax                    ; B0
    push    BYTE PTR 0                  ; (1st s-box (7) + 1) * 8
    jmp     serpent_decrypt_loop_init
serpent_decrypt_loop:
    ror     ebx, 22
    mov     eax, edx
    ror     ecx, 5
    shl     eax, 7
    xor     ebx, ebp
    xor     ebx, eax
    xor     ecx, ebp
    xor     ecx, edx
    ror     ebp, 7
    mov     eax, ecx
    ror     edx, 1
    shl     eax, 3
    xor     ebp, ebx
    xor     edx, ecx
    xor     ebp, eax
    xor     edx, ebx
    ror     ecx, 13
    ror     ebx, 3
serpent_decrypt_loop_init:
    pop     eax                         ; (s-box number + 1) * 8
    sub     eax, 8                      ; s-box number * 8
    and     eax, 63                     ; s-box number * 8
    push    eax                         ; s-box number * 8
    add     eax, edi                    ; address of jump to s-box
    call    eax                         ; s-box
    lodsd
    xor     ebp, eax
    lodsd
    xor     ebx, eax
    lodsd
    xor     edx, eax
    lodsd
    xor     ecx, eax
    dec     BYTE PTR [esp+4]
    jne     serpent_decrypt_loop
    add     esp, 8
    mov     edi, DWORD PTR [esp+20]
    mov     DWORD PTR [edi+ 0], ecx     ; B0
    mov     DWORD PTR [edi+ 4], edx     ; B1
    mov     DWORD PTR [edi+ 8], ebx     ; B2
    mov     DWORD PTR [edi+12], ebp     ; B3
    pop     ebp                         ; restore ebp
    pop     edi                         ; restore edi
    pop     esi                         ; restore esi
    pop     ebx                         ; restore ebx
    cld
    ret     8

dd 2385037

_TEXT ENDS

END