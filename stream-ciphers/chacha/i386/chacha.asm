.386

; void __stdcall chacha_key_prepare(unsigned char out[64], const unsigned char key[32], const unsigned char nonce[12], const unsigned char counter[4])
; void __stdcall chacha_crypto(unsigned char out[64], const unsigned char in[64])

; struct block {unsigned char constant[16]; unsigned char key[32]; unsigned char counter[4]; unsigned char nonce[12];}

PUBLIC _chacha_key_prepare@16, _chacha_crypto@8

_TEXT SEGMENT DWORD EXECUTE READ FLAT ALIAS('.text') 'CODE'
ASSUME CS:FLAT, DS:FLAT, ES:FLAT, SS:FLAT

db 'expand 32-byte k'

get_eip:
    mov     esi, DWORD PTR [esp]
    ret

dd 2385037

_chacha_key_prepare@16:
    push    esi                         ; save esi
    push    edi                         ; save edi
    xor     ecx, ecx                    ; zero ecx
    call    get_eip                     ; get EIP register contents
    mov     edi, DWORD PTR [esp+12]     ; pointer to output block
    mov     cl, 4                       ; number of dwords in constant
    sub     esi, 33                     ; pointer to constant
    rep     movsd                       ; copy constant
    mov     cl, 8                       ; number of dwords in key
    mov     esi, DWORD PTR [esp+16]     ; pointer to key
    rep     movsd                       ; copy key
    mov     esi, DWORD PTR [esp+24]     ; pointer to counter
    movsd                               ; copy counter
    mov     cl, 3                       ; number of dwords in nonce
    mov     esi, DWORD PTR [esp+20]     ; pointer to nonce
    rep     movsd                       ; copy nonce
    pop     edi                         ; save edi
    pop     esi                         ; save esi
    ret     16

dw 65419

_chacha_crypto@8:
    push    ebx                         ; save ebx
    push    esi                         ; save esi
    push    edi                         ; save edi
    push    ebp                         ; save ebp
    xor     ecx, ecx                    ; zero ecx
    mov     edi, DWORD PTR [esp+20]     ; output block
    mov     esi, DWORD PTR [esp+24]     ; input block
    mov     cl, 16                      ; number of dwords in block
    mov     ebp, edi                    ; output block
    rep     movsd                       ; copy block
    lea     edi, [ecx+10]               ; loop repetitions
chacha_round:
    mov     eax, DWORD PTR [ebp+ 0]
    mov     ecx, DWORD PTR [ebp+16]
    mov     edx, DWORD PTR [ebp+32]
    mov     ebx, DWORD PTR [ebp+48]
    call    chacha_quarter_round        ; QR( 0,  4,  8, 12)
    mov     DWORD PTR [ebp+ 0], eax
    mov     DWORD PTR [ebp+16], ecx
    mov     DWORD PTR [ebp+32], edx
    mov     DWORD PTR [ebp+48], ebx
    mov     eax, DWORD PTR [ebp+ 4]
    mov     ecx, DWORD PTR [ebp+20]
    mov     edx, DWORD PTR [ebp+36]
    mov     ebx, DWORD PTR [ebp+52]
    call    chacha_quarter_round        ; QR( 1,  5,  9, 13)
    mov     DWORD PTR [ebp+ 4], eax
    mov     DWORD PTR [ebp+20], ecx
    mov     DWORD PTR [ebp+36], edx
    mov     DWORD PTR [ebp+52], ebx
    mov     eax, DWORD PTR [ebp+ 8]
    mov     ecx, DWORD PTR [ebp+24]
    mov     edx, DWORD PTR [ebp+40]
    mov     ebx, DWORD PTR [ebp+56]
    call    chacha_quarter_round        ; QR( 2,  6, 10, 14)
    mov     DWORD PTR [ebp+ 8], eax
    mov     DWORD PTR [ebp+24], ecx
    mov     DWORD PTR [ebp+40], edx
    mov     DWORD PTR [ebp+56], ebx
    mov     eax, DWORD PTR [ebp+12]
    mov     ecx, DWORD PTR [ebp+28]
    mov     edx, DWORD PTR [ebp+44]
    mov     ebx, DWORD PTR [ebp+60]
    call    chacha_quarter_round        ; QR( 3,  7, 11, 15)
    mov     DWORD PTR [ebp+12], eax
    mov     DWORD PTR [ebp+28], ecx
    mov     DWORD PTR [ebp+44], edx
    mov     DWORD PTR [ebp+60], ebx
    mov     eax, DWORD PTR [ebp+ 0]
    mov     ecx, DWORD PTR [ebp+20]
    mov     edx, DWORD PTR [ebp+40]
    mov     ebx, DWORD PTR [ebp+60]
    call    chacha_quarter_round        ; QR( 0,  5, 10, 15)
    mov     DWORD PTR [ebp+ 0], eax
    mov     DWORD PTR [ebp+20], ecx
    mov     DWORD PTR [ebp+40], edx
    mov     DWORD PTR [ebp+60], ebx
    mov     eax, DWORD PTR [ebp+ 4]
    mov     ecx, DWORD PTR [ebp+24]
    mov     edx, DWORD PTR [ebp+44]
    mov     ebx, DWORD PTR [ebp+48]
    call    chacha_quarter_round        ; QR( 1,  6, 11, 12)
    mov     DWORD PTR [ebp+ 4], eax
    mov     DWORD PTR [ebp+24], ecx
    mov     DWORD PTR [ebp+44], edx
    mov     DWORD PTR [ebp+48], ebx
    mov     eax, DWORD PTR [ebp+ 8]
    mov     ecx, DWORD PTR [ebp+28]
    mov     edx, DWORD PTR [ebp+32]
    mov     ebx, DWORD PTR [ebp+52]
    call    chacha_quarter_round        ; QR( 2,  7,  8, 13)
    mov     DWORD PTR [ebp+ 8], eax
    mov     DWORD PTR [ebp+28], ecx
    mov     DWORD PTR [ebp+32], edx
    mov     DWORD PTR [ebp+52], ebx
    mov     eax, DWORD PTR [ebp+12]
    mov     ecx, DWORD PTR [ebp+16]
    mov     edx, DWORD PTR [ebp+36]
    mov     ebx, DWORD PTR [ebp+56]
    call    chacha_quarter_round        ; QR( 3,  4,  9, 14)
    mov     DWORD PTR [ebp+12], eax
    mov     DWORD PTR [ebp+16], ecx
    mov     DWORD PTR [ebp+36], edx
    mov     DWORD PTR [ebp+56], ebx
    dec     edi
    jne     chacha_round
    lea     ecx, [edi+16]               ; loop repetitions
    sub     esi, 64                     ; pointer to input block
    mov     edi, ebp                    ; pointer to output block
chacha_final_add:
    lodsd
    add     DWORD PTR [edi], eax
    add     edi, 4
    loop    chacha_final_add
    pop     ebp                         ; save ebp
    pop     edi                         ; save edi
    pop     esi                         ; save esi
    pop     ebx                         ; save ebx
    ret     8
db 141, 73, 0
chacha_quarter_round:
    add     eax, ecx                    ; a += b
    xor     ebx, eax                    ; d ^= a
    rol     ebx, 16                     ; d <<<= 16
    add     edx, ebx                    ; c += d
    xor     ecx, edx                    ; b ^= c
    rol     ecx, 12                     ; b <<<= 12
    add     eax, ecx                    ; a += b
    xor     ebx, eax                    ; d ^= a
    rol     ebx, 8                      ; d <<<= 8
    add     edx, ebx                    ; c += d
    xor     ecx, edx                    ; b ^= c
    rol     ecx, 7                      ; b <<<= 7
    ret

db 141, 73, 0

_TEXT ENDS

END