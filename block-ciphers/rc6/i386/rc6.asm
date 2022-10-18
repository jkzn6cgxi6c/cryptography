.386

; void __stdcall rc6_128_key_schedule(unsigned char key[176])
; void __stdcall rc6_192_key_schedule(unsigned char key[176])
; void __stdcall rc6_256_key_schedule(unsigned char key[176])
; void __stdcall rc6_encrypt(unsigned char buffer[16], const unsigned char key[176])
; void __stdcall rc6_decrypt(unsigned char buffer[16], const unsigned char key[176])

PUBLIC _rc6_128_key_schedule@4, _rc6_192_key_schedule@4, _rc6_256_key_schedule@4
PUBLIC _rc6_encrypt@8, _rc6_decrypt@8

_TEXT SEGMENT DWORD EXECUTE READ FLAT ALIAS('.text') 'CODE'
ASSUME CS:FLAT, DS:FLAT, ES:FLAT, SS:FLAT

_rc6_128_key_schedule@4:
    mov     al, 4                       ; number of dwords in key
    jmp     rc6_key_schedule

_rc6_192_key_schedule@4:
    mov     al, 6                       ; number of dwords in key
    jmp     rc6_key_schedule

_rc6_256_key_schedule@4:
    mov     al, 8                       ; number of dwords in key
    jmp     rc6_key_schedule

rc6_key_schedule:
    push    ebx                         ; save ebx
    push    esi                         ; save esi
    push    edi                         ; save edi
    push    ebp                         ; save ebp
    and     eax, 15                     ; c (number of dwords in key)
    mov     ecx, eax                    ; c
    mov     ebx, DWORD PTR [esp+20]     ; pointer to S (key)
    mov     ebp, eax                    ; c
    shl     al, 2                       ; number of bytes in key
    sub     esp, eax                    ; allocate L
    mov     esi, ebx                    ; pointer to S
    mov     edi, esp                    ; pointer to L
    rep     movsd                       ; L[i] = K[i]
    mov     eax, 3084996963             ; P
    mov     edi, ebx                    ; pointer to S
    mov     cl, 44                      ; t
rc6_key_schedule_init:
    stosd                               ; S[i] = S[i - 1] + Q
    add     eax, 2654435769             ; += Q
    loop    rc6_key_schedule_init
    xor     eax, eax                    ; B = 0
    sub     edx, edx                    ; A = 0
    xor     esi, esi                    ; i = 0
    sub     edi, edi                    ; j = 0
    mov     ch, 132                     ; max(c, t) * 3
rc6_key_schedule_loop:
    add     edx, eax                    ; ? = A + B
    add     edx, DWORD PTR [ebx+esi*4]  ; ? = S[i] + A + B
    rol     edx, 3                      ; A = (S[i] + A + B) <<< 3
    mov     DWORD PTR [ebx+esi*4], edx  ; S[i] = (S[i] + A + B) <<< 3
    add     eax, edx                    ; ? = A + B
    mov     cl, al                      ; ? = A + B
    add     eax, DWORD PTR [esp+edi*4]  ; ? = L[j] + A + B
    rol     eax, cl                     ; B = (L[j] + A + B) <<< (A + B)
    mov     DWORD PTR [esp+edi*4], eax  ; L[J] = (L[j] + A + B) <<< (A + B)
    inc     esi                         ; ? = i + 1
    inc     edi                         ; ? = j + 1
    cmp     esi, 44
    jne     rc6_key_schedule_i_no_adjust
    xor     esi, esi                    ; i = (i + 1) % t
rc6_key_schedule_i_no_adjust:
    cmp     edi, ebp
    jne     rc6_key_schedule_j_no_adjust
    xor     edi, edi                    ; j = (j + 1) % c
rc6_key_schedule_j_no_adjust:
    dec     ch
    jne     rc6_key_schedule_loop
    shl     ebp, 2                      ; number of bytes in key
    add     esp, ebp                    ; deallocate L
    pop     ebp                         ; restore ebp
    pop     edi                         ; restore edi
    pop     esi                         ; restore esi
    pop     ebx                         ; restore ebx
    ret     4

db 144

_rc6_encrypt@8:
    push    ebx                         ; save ebx
    push    esi                         ; save esi
    push    edi                         ; save edi
    push    ebp                         ; save ebp
    mov     cx, 20                      ; number of rounds
    mov     ebp, DWORD PTR [esp+20]     ; pointer to A (data)
    mov     edx, DWORD PTR [ebp   ]     ; A
    mov     esi, DWORD PTR [ebp+ 4]     ; B
    mov     ebx, DWORD PTR [ebp+ 8]     ; C
    mov     edi, DWORD PTR [ebp+12]     ; D
    mov     ebp, DWORD PTR [esp+24]     ; pointer to S (key)
    add     esi, DWORD PTR [ebp  ]      ; B = B + S[0]
    add     edi, DWORD PTR [ebp+4]      ; D = D + S[1]
rc6_encrypt_round:
    add     ebp, 8                      ; next round key
    shl     ecx, 16
    stc
    mov     eax, esi                    ; B
    adc     eax, eax                    ; B * 2 + 1
    push    edx
    mul     esi                         ; (B * 2 + 1) * B
    pop     edx
    rol     eax, 5                      ; (B * 2 + 1) * B <<< 5
    mov     ch, al                      ; (B * 2 + 1) * B <<< 5
    xor     edx, eax                    ; A ^ (B * 2 + 1) * B <<< 5
    stc
    mov     eax, edi                    ; D
    adc     eax, eax                    ; D * 2 + 1
    push    edx
    mul     edi                         ; (B * 2 + 1) * B
    pop     edx
    rol     eax, 5                      ; (D * 2 + 1) * D <<< 5
    mov     cl, al                      ; (D * 2 + 1) * D <<< 5
    xor     ebx, eax                    ; C ^ (D * 2 + 1) * D <<< 5
    rol     edx, cl                     ; (A ^ (B * 2 + 1) * B <<< 5) <<< ((D * 2 + 1) * D <<< 5)
    shr     ecx, 8
    rol     ebx, cl                     ; (C ^ (D * 2 + 1) * D <<< 5) <<< ((B * 2 + 1) * B <<< 5)
    shr     ecx, 8
    add     edx, DWORD PTR [ebp  ]      ; (A ^ (B * 2 + 1) * B <<< 5) <<< ((D * 2 + 1) * D <<< 5) + S[2i]
    add     ebx, DWORD PTR [ebp+4]      ; (C ^ (D * 2 + 1) * D <<< 5) <<< ((B * 2 + 1) * B <<< 5) + S[2i + 1]
    mov     eax, edx
    mov     edx, esi                    ; A' = B
    mov     esi, ebx                    ; B' = C
    mov     ebx, edi                    ; C' = D
    mov     edi, eax                    ; D' = A
    loop    rc6_encrypt_round
    add     edx, DWORD PTR [ebp+ 8]     ; A = A + S[2r + 2]
    add     ebx, DWORD PTR [ebp+12]     ; C = C + S[2r + 3]
    mov     ebp, DWORD PTR [esp+20]     ; pointer to A (data)
    mov     DWORD PTR [ebp   ], edx     ; A
    mov     DWORD PTR [ebp+ 4], esi     ; B
    mov     DWORD PTR [ebp+ 8], ebx     ; C
    mov     DWORD PTR [ebp+12], edi     ; D
    pop     ebp                         ; restore ebp
    pop     edi                         ; restore edi
    pop     esi                         ; restore esi
    pop     ebx                         ; restore ebx
    ret     8

db 141, 73, 0

_rc6_decrypt@8:
    push    ebx                         ; save ebx
    push    esi                         ; save esi
    push    edi                         ; save edi
    push    ebp                         ; save ebp
    mov     cx, 20                      ; number of rounds
    mov     ebp, DWORD PTR [esp+20]     ; pointer to A (data)
    mov     edx, DWORD PTR [ebp   ]     ; A
    mov     esi, DWORD PTR [ebp+ 4]     ; B
    mov     ebx, DWORD PTR [ebp+ 8]     ; C
    mov     edi, DWORD PTR [ebp+12]     ; D
    mov     ebp, DWORD PTR [esp+24]     ; pointer to S (key)
    add     ebp, 168
    sub     edx, DWORD PTR [ebp  ]      ; A = A - S[2r + 2]
    sub     ebx, DWORD PTR [ebp+4]      ; C = C - S[2r + 3]
rc6_decrypt_round:
    sub     ebp, 8                      ; next round key
    shl     ecx, 16
    mov     eax, edi
    mov     edi, ebx                    ; D' = C
    mov     ebx, esi                    ; C' = B
    mov     esi, edx                    ; B' = A
    mov     edx, eax                    ; A' = D
    sub     edx, DWORD PTR [ebp  ]      ; A - S[2i]
    sub     ebx, DWORD PTR [ebp+4]      ; C - S[2i + 1]
    stc
    mov     eax, esi                    ; B
    adc     eax, eax                    ; B * 2 + 1
    push    edx
    mul     esi                         ; (B * 2 + 1) * B
    pop     edx
    rol     eax, 5                      ; (B * 2 + 1) * B <<< 5
    mov     ch, al                      ; (B * 2 + 1) * B <<< 5
    push    eax                         ; (B * 2 + 1) * B <<< 5
    stc
    mov     eax, edi                    ; D
    adc     eax, eax                    ; D * 2 + 1
    push    edx
    mul     edi                         ; (B * 2 + 1) * B
    pop     edx
    rol     eax, 5                      ; (D * 2 + 1) * D <<< 5
    mov     cl, al                      ; (D * 2 + 1) * D <<< 5
    ror     edx, cl                     ; (A - S[2i]) >>> ((B * 2 + 1) * B <<< 5)
    shr     ecx, 8
    ror     ebx, cl                     ; (C - S[2i + 1]) >>> ((D * 2 + 1) * D <<< 5)
    shr     ecx, 8
    xor     ebx, eax                    ; (C - S[2i + 1]) >>> ((D * 2 + 1) * D <<< 5) ^ ((D * 2 + 1) * D <<< 5)
    pop     eax                         ; (B * 2 + 1) * B <<< 5
    xor     edx, eax                    ; (A - S[2i]) >>> ((B * 2 + 1) * B <<< 5) ^ ((B * 2 + 1) * B <<< 5)
    loop    rc6_decrypt_round
    sub     esi, DWORD PTR [ebp-8]      ; B = B - S[0]
    sub     edi, DWORD PTR [ebp-4]      ; D = D - S[1]
    mov     ebp, DWORD PTR [esp+20]     ; pointer to A (data)
    mov     DWORD PTR [ebp   ], edx     ; A
    mov     DWORD PTR [ebp+ 4], esi     ; B
    mov     DWORD PTR [ebp+ 8], ebx     ; C
    mov     DWORD PTR [ebp+12], edi     ; D
    pop     ebp                         ; restore ebp
    pop     edi                         ; restore edi
    pop     esi                         ; restore esi
    pop     ebx                         ; restore ebx
    ret     8

db 141, 73, 0

_TEXT ENDS

END