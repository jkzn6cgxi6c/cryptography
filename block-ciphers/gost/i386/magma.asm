.386

; void __stdcall gost_key_schedule(unsigned char key[128])
; void __stdcall gost_encrypt(unsigned char buffer[8], const unsigned char key[128])
; void __stdcall gost_decrypt(unsigned char buffer[8], const unsigned char key[128])

PUBLIC _gost_key_schedule@4, _gost_encrypt@8, _gost_decrypt@8

_TEXT SEGMENT DWORD EXECUTE READ FLAT ALIAS('.text') 'CODE'
ASSUME CS:FLAT, DS:FLAT, ES:FLAT, SS:FLAT

pi db 12,  4,  6,  2, 10,  5, 11,  9, 14,  8, 13,  7,  0,  3, 15,  1
   db  6,  8,  2,  3,  9, 10,  5, 12,  1, 14,  4,  7, 11, 13,  0, 15
   db 11,  3,  5,  8,  2, 15, 10, 13, 14,  1,  7,  4, 12,  9,  6,  0
   db 12,  8,  2,  1, 13,  4, 15,  6,  7,  0, 10,  5,  3, 14,  9, 11
   db  7, 15,  5, 10,  8,  1,  6, 13,  0,  9,  3, 14, 11,  4,  2, 12
   db  5, 13, 15,  6,  9,  2, 12, 10, 11,  7,  8,  1,  4,  3, 14,  0
   db  8, 14,  2,  5,  6,  9,  1, 12, 15,  4, 11,  0, 13, 10,  3,  7
   db  1,  7, 14, 13,  0,  5,  8,  3,  4, 15, 10,  6,  9, 12, 11,  2

_gost_key_schedule@4:
    push    esi
    mov     esi, DWORD PTR [esp+8]
    lodsd
    xchg    al, ah
    rol     eax, 16
    xchg    al, ah
    mov     DWORD PTR [esi-4], eax
    mov     DWORD PTR [esi+28], eax
    mov     DWORD PTR [esi+60], eax
    mov     DWORD PTR [esi+120], eax
    lodsd
    xchg    al, ah
    rol     eax, 16
    xchg    al, ah
    mov     DWORD PTR [esi-4], eax
    mov     DWORD PTR [esi+28], eax
    mov     DWORD PTR [esi+60], eax
    mov     DWORD PTR [esi+112], eax
    lodsd
    xchg    al, ah
    rol     eax, 16
    xchg    al, ah
    mov     DWORD PTR [esi-4], eax
    mov     DWORD PTR [esi+28], eax
    mov     DWORD PTR [esi+60], eax
    mov     DWORD PTR [esi+104], eax
    lodsd
    xchg    al, ah
    rol     eax, 16
    xchg    al, ah
    mov     DWORD PTR [esi-4], eax
    mov     DWORD PTR [esi+28], eax
    mov     DWORD PTR [esi+60], eax
    mov     DWORD PTR [esi+96], eax
    lodsd
    xchg    al, ah
    rol     eax, 16
    xchg    al, ah
    mov     DWORD PTR [esi-4], eax
    mov     DWORD PTR [esi+28], eax
    mov     DWORD PTR [esi+60], eax
    mov     DWORD PTR [esi+88], eax
    lodsd
    xchg    al, ah
    rol     eax, 16
    xchg    al, ah
    mov     DWORD PTR [esi-4], eax
    mov     DWORD PTR [esi+28], eax
    mov     DWORD PTR [esi+60], eax
    mov     DWORD PTR [esi+80], eax
    lodsd
    xchg    al, ah
    rol     eax, 16
    xchg    al, ah
    mov     DWORD PTR [esi-4], eax
    mov     DWORD PTR [esi+28], eax
    mov     DWORD PTR [esi+60], eax
    mov     DWORD PTR [esi+72], eax
    lodsd
    xchg    al, ah
    rol     eax, 16
    xchg    al, ah
    mov     DWORD PTR [esi-4], eax
    mov     DWORD PTR [esi+28], eax
    mov     DWORD PTR [esi+60], eax
    mov     DWORD PTR [esi+64], eax
    pop     esi
    ret     4

db 141, 73, 0

get_eip:
    mov     ebx, DWORD PTR [esp]
    ret

dd 2385037

_gost_encrypt@8:
    xor     eax, eax
    jmp     gost
_gost_decrypt@8:
    mov     al, 124
db 38
    std
gost:
    and     eax, 127
    push    ebx
    push    esi
    push    edi
    push    ebp
    call    get_eip
    add     eax, DWORD PTR [esp+24]
    xor     ecx, ecx
    mov     ebp, DWORD PTR [esp+20]
    mov     esi, eax
    mov     eax, DWORD PTR [ebp+0]
    sub     ebx, 328
    mov     edx, DWORD PTR [ebp+4]
    mov     ebp, 32
    xchg    al, ah
    rol     dx, 8
    rol     eax, 16
    rol     edx, 16
    xchg    al, ah
    rol     dx, 8
gost_loop:
    mov     cl, 8
    push    eax                         ; L
    lodsd                               ; K
    add     eax, edx                    ; R+K
s_box:
    mov     edi, eax                    ; R+K
    and     eax, -16
    and     edi, 15
    or      al, BYTE PTR [ebx+edi]      ; Si
    ror     eax, 4
    add     ebx, 16
    loop    s_box
    pop     edi                         ; L
    rol     eax, 11                     ; f(R,K)
    add     ebx, -128                   ; Pi0
    xor     eax, edi                    ; f(R,K)+L
    dec     ebp
    xchg    eax, edx                    ; L', R'
    jne     gost_loop
    mov     ebp, DWORD PTR [esp+20]
    xchg    al, ah
    rol     dx, 8
    rol     eax, 16
    rol     edx, 16
    xchg    al, ah
    rol     dx, 8
    mov     DWORD PTR [ebp+0], edx
    mov     DWORD PTR [ebp+4], eax
    pop     ebp
    pop     edi
    pop     esi
    pop     ebx
    cld
    ret     8

db 141, 73, 0

_TEXT ENDS

END