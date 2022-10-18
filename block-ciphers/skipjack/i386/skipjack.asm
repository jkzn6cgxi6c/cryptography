.386

; void __stdcall skipjack_encrypt(unsigned char buffer[8], const unsigned char key[10])
; void __stdcall skipjack_decrypt(unsigned char buffer[8], const unsigned char key[10])

PUBLIC _skipjack_encrypt@8, _skipjack_decrypt@8

_TEXT SEGMENT DWORD EXECUTE READ FLAT ALIAS('.text') 'CODE'
ASSUME CS:FLAT, DS:FLAT, ES:FLAT, SS:FLAT

fbox db 163, 215,   9, 131, 248,  72, 246, 244, 179,  33,  21, 120, 153, 177, 175, 249
     db 231,  45,  77, 138, 206,  76, 202,  46,  82, 149, 217,  30,  78,  56,  68,  40
     db  10, 223,   2, 160,  23, 241,  96, 104,  18, 183, 122, 195, 233, 250,  61,  83
     db 150, 132, 107, 186, 242,  99, 154,  25, 124, 174, 229, 245, 247,  22, 106, 162
     db  57, 182, 123,  15, 193, 147, 129,  27, 238, 180,  26, 234, 208, 145,  47, 184
     db  85, 185, 218, 133,  63,  65, 191, 224,  90,  88, 128,  95, 102,  11, 216, 144
     db  53, 213, 192, 167,  51,   6, 101, 105,  69,   0, 148,  86, 109, 152, 155, 118
     db 151, 252, 178, 194, 176, 254, 219,  32, 225, 235, 214, 228, 221,  71,  74,  29
     db  66, 237, 158, 110,  73,  60, 205,  67,  39, 210,   7, 212, 222, 199, 103,  24
     db 137, 203,  48,  31, 141, 198, 143, 170, 200, 116, 220, 201,  93,  92,  49, 164
     db 112, 136,  97,  44, 159,  13,  43, 135,  80, 130,  84, 100,  38, 125,   3,  64
     db  52,  75,  28, 115, 209, 196, 253,  59, 204, 251, 127, 171, 230,  62,  91, 165
     db 173,   4,  35, 156,  20,  81,  34, 240,  41, 121, 113, 126, 255, 140,  14, 226
     db  12, 239, 188, 114, 117, 111,  55, 161, 236, 211, 142,  98, 139, 134,  16, 232
     db   8, 119,  17, 190, 146,  79,  36, 197,  50,  54, 157, 207, 243, 166, 187, 172
     db  94, 108, 169,  19,  87,  37, 181, 227, 189, 168,  58,   1,   5,  89,  42,  70

get_eip:
    mov     ebx, DWORD PTR [esp]
    ret

dd 2385037

_skipjack_encrypt@8:
    push    ebx                         ; save ebx
    push    esi                         ; save esi
    push    edi                         ; save edi
    push    ebp                         ; save ebp
    mov     esi, DWORD PTR [esp+20]     ; pointer to key
    xor     ecx, ecx                    ; zero ecx
    mov     edi, esi
    mov     cl, 4
    mov     ebp, esi
skipjack_encrypt_init:
    lodsw
    xchg    al, ah
    stosw
    loop    skipjack_encrypt_init
    xor     edi, edi                    ; counter
    call    get_eip
    mov     cl, 5
    mov     esi, DWORD PTR [esp+24]     ; pointer to key
    sub     ebx, 295                    ; pointer to fbox
skipjack_encrypt_a:
    mov     edx, DWORD PTR [ebp]
    call    g_permutation
    mov     eax, DWORD PTR [ebp+4]
    inc     edi
    mov     DWORD PTR [ebp+2], edx
    mov     WORD PTR [ebp+6], ax
    shr     eax, 16
    xor     eax, edi
    xor     eax, edx
    mov     WORD PTR [ebp], ax
    cmp     edi, 8
    jne     skipjack_encrypt_a
skipjack_encrypt_b:
    mov     eax, DWORD PTR [ebp]
    inc     edi
    mov     edx, eax
    xor     eax, edi
    shl     eax, 16
    call    g_permutation
    sub     al, al
    xor     edx, eax
    mov     eax, DWORD PTR [ebp+4]
    mov     DWORD PTR [ebp+2], edx
    mov     WORD PTR [ebp+6], ax
    shr     eax, 16
    mov     WORD PTR [ebp], ax
    cmp     edi, 16
    jne     skipjack_encrypt_b
skipjack_encrypt_c:
    mov     edx, DWORD PTR [ebp]
    call    g_permutation
    mov     eax, DWORD PTR [ebp+4]
    inc     edi
    mov     DWORD PTR [ebp+2], edx
    mov     WORD PTR [ebp+6], ax
    shr     eax, 16
    xor     eax, edi
    xor     eax, edx
    mov     WORD PTR [ebp], ax
    cmp     edi, 24
    jne     skipjack_encrypt_c
skipjack_encrypt_d:
    mov     eax, DWORD PTR [ebp]
    inc     edi
    mov     edx, eax
    xor     eax, edi
    shl     eax, 16
    call    g_permutation
    sub     al, al
    xor     edx, eax
    mov     eax, DWORD PTR [ebp+4]
    mov     DWORD PTR [ebp+2], edx
    mov     WORD PTR [ebp+6], ax
    shr     eax, 16
    mov     WORD PTR [ebp], ax
    cmp     edi, 32
    jne     skipjack_encrypt_d
    mov     esi, ebp
    mov     cl, 4
    mov     edi, ebp
skipjack_encrypt_finish:
    lodsw
    xchg    al, ah
    stosw
    loop    skipjack_encrypt_finish
    pop     ebp                         ; restore ebp
    pop     edi                         ; restore edi
    pop     esi                         ; restore esi
    pop     ebx                         ; restore ebx
    ret     8
dw 65419
g_permutation:
    call    g_half_round
    loop    g_permutation_a
    sub     esi, 10
    mov     cl, 5
g_permutation_a:
    call    g_half_round
    loop    g_permutation_b
    sub     esi, 10
    mov     cl, 5
g_permutation_b:
    ret
db 141, 73, 0
g_half_round:
    lodsb
    xor     al, dl
    xlatb
    xor     dh, al
    lodsb
    xor     al, dh
    xlatb
    xor     dl, al
    ret

db 141, 73, 0

_skipjack_decrypt@8:
    push    ebx                         ; save ebx
    push    esi                         ; save esi
    push    edi                         ; save edi
    push    ebp                         ; save ebp
    mov     esi, DWORD PTR [esp+20]     ; pointer to key
    xor     ecx, ecx                    ; zero ecx
    mov     edi, esi
    mov     cl, 4
    mov     ebp, esi
skipjack_decrypt_init:
    lodsw
    xchg    al, ah
    stosw
    loop    skipjack_decrypt_init
    xor     edi, edi                    ; counter
    call    get_eip
    mov     cl, 4
    mov     esi, DWORD PTR [esp+24]     ; pointer to key
    add     edi, 32
    sub     ebx, 559                    ; pointer to fbox
    add     esi, 7
    std
skipjack_decrypt_a:
    mov     edx, DWORD PTR [ebp]
    rol     edx, 16
    call    h_permutation
    mov     eax, DWORD PTR [ebp+4]
    xor     ax, dx
    xor     eax, edi
    mov     WORD PTR [ebp], dx
    dec     edi
    mov     DWORD PTR [ebp+2], eax
    shr     edx, 16
    mov     WORD PTR [ebp+6], dx
    cmp     edi, 24
    jne     skipjack_decrypt_a
skipjack_decrypt_b:
    mov     eax, DWORD PTR [ebp+2]
    mov     edx, eax
    xor     eax, edi
    xor     ax, WORD PTR [ebp]
    shl     eax, 16
    dec     edi
    call    h_permutation
    mov     DWORD PTR [ebp], edx
    mov     ax, WORD PTR [ebp+6]
    mov     DWORD PTR [ebp+4], eax
    cmp     edi, 16
    jne     skipjack_decrypt_b
skipjack_decrypt_c:
    mov     edx, DWORD PTR [ebp]
    rol     edx, 16
    call    h_permutation
    mov     eax, DWORD PTR [ebp+4]
    xor     ax, dx
    xor     eax, edi
    mov     WORD PTR [ebp], dx
    dec     edi
    mov     DWORD PTR [ebp+2], eax
    shr     edx, 16
    mov     WORD PTR [ebp+6], dx
    cmp     edi, 8
    jne     skipjack_decrypt_c
skipjack_decrypt_d:
    mov     eax, DWORD PTR [ebp+2]
    mov     edx, eax
    xor     eax, edi
    xor     ax, WORD PTR [ebp]
    shl     eax, 16
    dec     edi
    call    h_permutation
    mov     DWORD PTR [ebp], edx
    mov     ax, WORD PTR [ebp+6]
    mov     DWORD PTR [ebp+4], eax
    cmp     edi, 0
    jne     skipjack_decrypt_d
    mov     esi, ebp
    cld
    mov     cl, 4
    mov     edi, ebp
skipjack_decrypt_finish:
    lodsw
    xchg    al, ah
    stosw
    loop    skipjack_decrypt_finish
    pop     ebp                         ; restore ebp
    pop     edi                         ; restore edi
    pop     esi                         ; restore esi
    pop     ebx                         ; restore ebx
    ret     8
dd 2385037
h_permutation:
    call    h_half_round
    loop    h_permutation_a
    add     esi, 10
    mov     cl, 5
h_permutation_a:
    call    h_half_round
    loop    h_permutation_b
    add     esi, 10
    mov     cl, 5
h_permutation_b:
    ret
db 141, 73, 0
h_half_round:
    lodsb
    xor     al, dh
    xlatb
    xor     dl, al
    lodsb
    xor     al, dl
    xlatb
    xor     dh, al
    ret

db 141, 73, 0

_TEXT ENDS

END