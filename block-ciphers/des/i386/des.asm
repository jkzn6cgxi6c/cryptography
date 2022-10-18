.386

; extern void __stdcall des_key_schedule(unsigned char key[96])
; extern void __stdcall des_encrypt(unsigned char buffer[8], const unsigned char key[96])
; extern void __stdcall des_decrypt(unsigned char buffer[8], const unsigned char key[96])

PUBLIC _des_key_schedule@4, _des_encrypt@8, _des_decrypt@8

_TEXT SEGMENT DWORD EXECUTE READ FLAT ALIAS('.text') 'CODE'
ASSUME CS:FLAT, DS:FLAT, ES:FLAT, SS:FLAT

sbox1 dd    4210944,          0,      16384,    4210945,    4210689,      16641,          1,      16384,        256,    4210944,    4210945,        256,    4194561,    4210689,    4194304,          1
      dd        257,    4194560,    4194560,      16640,      16640,    4210688,    4210688,    4194561,      16385,    4194305,    4194305,      16385,          0,        257,      16641,    4194304
      dd      16384,    4210945,          1,    4210688,    4210944,    4194304,    4194304,        256,    4210689,      16384,      16640,    4194305,        256,          1,    4194561,      16641
      dd    4210945,      16385,    4210688,    4194561,    4194305,        257,      16641,    4210944,        257,    4194560,    4194560,          0,      16385,      16640,          0,    4210689
sbox2 dd  537141256,  536879104,       8192,     270344,     262144,          8,  537133064,  536879112,  536870920,  537141256,  537141248,  536870912,  536879104,     262144,          8,  537133064
      dd     270336,     262152,  536879112,          0,  536870912,       8192,     270344,  537133056,     262152,  536870920,          0,     270336,       8200,  537141248,  537133056,       8200
      dd          0,     270344,  537133064,     262144,  536879112,  537133056,  537141248,       8192,  537133056,  536879104,          8,  537141256,     270344,          8,       8192,  536870912
      dd       8200,  537141248,     262144,  536870920,     262152,  536879112,  536870920,     262152,     270336,          0,  536879104,       8200,  536870912,  537133064,  537141256,     270336
sbox3 dd        130,   33587328,          0,   33587202,   33554560,          0,      32898,   33554560,      32770,   33554434,   33554434,      32768,   33587330,      32770,   33587200,        130
      dd   33554432,          2,   33587328,        128,      32896,   33587200,   33587202,      32898,   33554562,      32896,      32768,   33554562,          2,   33587330,        128,   33554432
      dd   33587328,   33554432,      32770,        130,      32768,   33587328,   33554560,          0,        128,      32770,   33587330,   33554560,   33554434,        128,          0,   33587202
      dd   33554562,      32768,   33554432,   33587330,          2,      32898,      32896,   33554434,   33587200,   33554562,        130,   33587200,      32898,          2,   33587202,      32896
sbox4 dd 1075841024, 1073743904, 1073743904,         32,    2099232, 1075839008, 1075838976, 1073743872,          0,    2099200,    2099200, 1075841056, 1073741856,          0,    2097184, 1075838976
      dd 1073741824,       2048,    2097152, 1075841024,         32,    2097152, 1073743872,       2080, 1075839008, 1073741824,       2080,    2097184,       2048,    2099232, 1075841056, 1073741856
      dd    2097184, 1075838976,    2099200, 1075841056, 1073741856,          0,          0,    2099200,       2080,    2097184, 1075839008, 1073741824, 1075841024, 1073743904, 1073743904,         32
      dd 1075841056, 1073741856, 1073741824,       2048, 1075838976, 1073743872,    2099232, 1075839008, 1073743872,       2080,    2097152, 1075841024,         32,    2097152,       2048,    2099232
sbox5 dd         64,    8519744,    8519680,  276824128,     131072,         64,  268435456,    8519680,  268566592,     131072,    8388672,  268566592,  276824128,  276955136,     131136,  268435456
      dd    8388608,  268566528,  268566528,          0,  268435520,  276955200,  276955200,    8388672,  276955136,  268435520,          0,  276824064,    8519744,    8388608,  276824064,     131136
      dd     131072,  276824128,         64,    8388608,  268435456,    8519680,  276824128,  268566592,    8388672,  268435456,  276955136,    8519744,  268566592,         64,    8388608,  276955136
      dd  276955200,     131136,  276824064,  276955200,    8519680,          0,  268566528,  276824064,     131136,    8388672,  268435520,     131072,          0,  268566528,    8519744,  268435520
sbox6 dd  134217732,  135266304,       4096,  135270404,  135266304,          4,  135270404,    1048576,  134221824,    1052676,    1048576,  134217732,    1048580,  134221824,  134217728,       4100
      dd          0,    1048580,  134221828,       4096,    1052672,  134221828,          4,  135266308,  135266308,          0,    1052676,  135270400,       4100,    1052672,  135270400,  134217728
      dd  134221824,          4,  135266308,    1052672,  135270404,    1048576,       4100,  134217732,    1048576,  134221824,  134217728,       4100,  134217732,  135270404,    1052672,  135266304
      dd    1052676,  135270400,          0,  135266308,          4,       4096,  135266304,    1052676,       4096,    1048580,  134221828,          0,  135270400,  134217728,    1048580,  134221828
sbox7 dd     524288, 2164785152, 2164261376,          0,        512, 2164261376, 2148008448,   17302016, 2164785664,     524288,          0, 2164260864, 2147483648,   16777216, 2164785152, 2147484160
      dd   16777728, 2148008448, 2148007936,   16777728, 2164260864,   17301504,   17302016, 2148007936,   17301504,        512, 2147484160, 2164785664,     524800, 2147483648,   16777216,     524800
      dd   16777216,     524800,     524288, 2164261376, 2164261376, 2164785152, 2164785152, 2147483648, 2148007936,   16777216,   16777728,     524288,   17302016, 2147484160, 2148008448,   17302016
      dd 2147484160, 2164260864, 2164785664,   17301504,     524800,          0, 2147483648, 2164785664,          0, 2148008448,   17301504,        512, 2164260864,   16777728,        512, 2148007936
sbox8 dd   67109904,       1024,      65536,   67175440,   67108864,   67109904,         16,   67108864,      65552,   67174400,   67175440,      66560,   67175424,      66576,       1024,         16
      dd   67174400,   67108880,   67109888,       1040,      66560,      65552,   67174416,   67175424,       1040,          0,          0,   67174416,   67108880,   67109888,      66576,      65536
      dd      66576,      65536,   67175424,       1024,         16,   67174416,       1024,      66576,   67109888,         16,   67108880,   67174400,   67174416,   67108864,      65536,   67109904
      dd          0,   67175440,      65552,   67108880,   67174400,   67109888,   67109904,          0,   67175440,      66560,      66560,       1040,       1040,      65552,   67108864,   67175424

pc_2 dd        0,   524288,        1,   524289,   131072,   655360,   131073,   655361,      256,   524544,      257,   524545,   131328,   655616,   131329,   655617
     dd        0,   262144,    16384,   278528,       16,   262160,    16400,   278544,       64,   262208,    16448,   278592,       80,   262224,    16464,   278608
     dd        0,        0,     4096,     4096,  2097152,  2097152,  2101248,  2101248,      512,      512,     4608,     4608,  2097664,  2097664,  2101760,  2101760
     dd        0,        2,  8388608,  8388610,    32768,    32770,  8421376,  8421378,       32,       34,  8388640,  8388642,    32800,    32802,  8421408,  8421410
     dd        0,  4194304,        0,  4194304,     1024,  4195328,     1024,  4195328,        4,  4194308,        4,  4194308,     1028,  4195332,     1028,  4195332
     dd        0,     8192,        0,     8192,     2048,    10240,     2048,    10240,  1048576,  1056768,  1048576,  1056768,  1050624,  1058816,  1050624,  1058816
     dd        0,        0,      128,      128,        8,        8,      136,      136,    65536,    65536,    65664,    65664,    65544,    65544,    65672,    65672
     dd        0,        2,   131072,   131074,  2097152,  2097154,  2228224,  2228226,        1,        3,   131073,   131075,  2097153,  2097155,  2228225,  2228227
     dd        0,     8192,      128,     8320,        0,     8192,      128,     8320,        4,     8196,      132,     8324,        4,     8196,      132,     8324
     dd        0,  1048576,        0,  1048576,      512,  1049088,      512,  1049088,    65536,  1114112,    65536,  1114112,    66048,  1114624,    66048,  1114624
     dd        0,  8388608,       16,  8388624,        0,  8388608,       16,  8388624,     2048,  8390656,     2064,  8390672,     2048,  8390656,     2064,  8390672
     dd        0,    16384,       32,    16416,   524288,   540672,   524320,   540704,     4096,    20480,     4128,    20512,   528384,   544768,   528416,   544800
     dd        0,     1024,        8,     1032,    32768,    33792,    32776,    33800,  4194304,  4195328,  4194312,  4195336,  4227072,  4228096,  4227080,  4228104
     dd        0,       64,        0,       64,   262144,   262208,   262144,   262208,      256,      320,      256,      320,   262400,   262464,   262400,   262464

get_eip:
    mov     ebx, DWORD PTR [esp]
    ret

dd 2385037

_des_key_schedule@4:
    push    ebx
    push    esi
    push    edi
    push    ebp
    call    get_eip
    lea     ebp, [ebx-913]
    mov     esi, DWORD PTR [esp+20]
    mov     edi, esi
    lodsd
    mov     edx, DWORD PTR [esi]
    mov     ecx, edx
    shr     ecx, 4
    xor     ecx, eax
    and     ecx, 252645135
    xor     eax, ecx
    shl     ecx, 4
    xor     edx, ecx
    mov     ecx, eax
    shl     ecx, 18
    xor     ecx, eax
    and     ecx, 3435921408
    xor     eax, ecx
    shr     ecx, 18
    xor     eax, ecx
    mov     ecx, edx
    shl     ecx, 18
    xor     ecx, edx
    and     ecx, 3435921408
    xor     edx, ecx
    shr     ecx, 18
    xor     edx, ecx
    mov     ecx, edx
    shr     ecx, 1
    xor     ecx, eax
    and     ecx, 1431655765
    xor     eax, ecx
    shl     ecx, 1
    xor     edx, ecx
    mov     ecx, eax
    shr     ecx, 8
    xor     ecx, edx
    and     ecx, 16711935
    xor     edx, ecx
    shl     ecx, 8
    xor     eax, ecx
    mov     ecx, edx
    shr     ecx, 1
    xor     ecx, eax
    and     ecx, 1431655765
    xor     eax, ecx
    shl     ecx, 1
    xor     edx, ecx
    xchg    dl, dh
    mov     ecx, eax
    rol     edx, 16
    shr     ecx, 28
    mov     dh, dl
    and     eax, 268435455
    mov     dl, cl
    ror     edx, 8
    push    DWORD PTR 33027
des_key_schedule_round:
    shr     eax, 1
    jnc     c_rotation_1
    or      eax, 134217728
c_rotation_1:
    shr     edx, 1
    jnc     d_rotation_1
    or      edx, 134217728
d_rotation_1:
    shr     DWORD PTR [esp], 1
    jc      d_rotation_2
    shr     eax, 1
    jnc     c_rotation_2
    or      eax, 134217728
c_rotation_2:
    shr     edx, 1
    jnc     d_rotation_2
    or      edx, 134217728
d_rotation_2:
    mov     cl, 7
    xor     ebx, ebx
des_pc_2_1:
    mov     esi, eax
    and     esi, 15
    or      ebx, DWORD PTR [ebp+esi*4]
    ror     eax, 4
    add     ebp, 64
    loop    des_pc_2_1
    mov     BYTE PTR [edi+1], bl
    shr     ebx, 8
    mov     WORD PTR [edi+2], bx
    mov     cl, 7
    xor     ebx, ebx
des_pc_2_2:
    mov     esi, edx
    and     esi, 15
    or      ebx, DWORD PTR [ebp+esi*4]
    ror     edx, 4
    add     ebp, 64
    loop    des_pc_2_2
    mov     WORD PTR [edi+4], bx
    shr     ebx, 16
    mov     BYTE PTR [edi  ], bl
    shr     eax, 4
    shr     edx, 4
    sub     ebp, 896
    add     edi, 6
    cmp     BYTE PTR [esp], 0
    jne     des_key_schedule_round
    add     esp, 4
    pop     ebp
    pop     edi
    pop     esi
    pop     ebx
    ret     4

dw 65419

des_ip:
    mov     esi, DWORD PTR [esp+12]
    lodsd
    mov     edx, DWORD PTR [esi]
    xchg    al, ah
    xchg    dl, dh
    rol     eax, 16
    rol     edx, 16
    xchg    al, ah
    xchg    dl, dh
    ror     eax, 4
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 252645135
    xor     eax, ecx
    xor     edx, ecx
    ror     eax, 12
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 65535
    xor     eax, ecx
    xor     edx, ecx
    ror     eax, 14
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 3435973836
    xor     eax, ecx
    xor     edx, ecx
    ror     eax, 26
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 4278255360
    xor     eax, ecx
    xor     edx, ecx
    ror     eax, 9
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 1431655765
    xor     eax, ecx
    xor     edx, ecx
    ror     edx, 1
    xor     esi, esi
    ret

db 144

_des_encrypt@8:
    push    esi
    call    des_ip
    push    esi
    jmp     des_crypto
db 141, 73, 0
_des_decrypt@8:
    push    esi
    call    des_ip
    push    BYTE PTR 12
    add     esi, 90
des_crypto:
    xor     ecx, ecx
    push    edi
    push    ebx
    push    ebp
    call    get_eip
    sub     ebx, 3401
    add     esi, DWORD PTR [esp+28]
    push    BYTE PTR 16
    push    eax
des_round:
    xor     ebp, ebp
    lodsd
    mov     cl, 3
    call    des_round_loop
    shr     eax, 2
    lodsw
    shl     eax, 2
    mov     cl, 5
    call    des_round_loop
    pop     eax
    sub     ebx, 2048
    sub     esi, DWORD PTR [esp+16]
    xor     eax, ebp
    dec     DWORD PTR [esp]
    push    edx
    mov     edx, eax
    jne     des_round
    pop     edx
    add     esp, 4
    pop     ebp
    pop     ebx
    mov     edi, DWORD PTR [esp+16]
    rol     edx, 1
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 1431655765
    xor     eax, ecx
    xor     edx, ecx
    rol     eax, 9
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 4278255360
    xor     eax, ecx
    xor     edx, ecx
    rol     eax, 26
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 3435973836
    xor     eax, ecx
    xor     edx, ecx
    rol     eax, 14
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 65535
    xor     eax, ecx
    xor     edx, ecx
    rol     eax, 12
    mov     ecx, edx
    xor     ecx, eax
    and     ecx, 252645135
    xor     eax, ecx
    xor     edx, ecx
    rol     eax, 4
    xchg    al, ah
    xchg    dl, dh
    rol     eax, 16
    rol     edx, 16
    xchg    al, ah
    xchg    dl, dh
    stosd
    mov     DWORD PTR [edi], edx
    pop     edi
    add     esp, 4
    pop     esi
    ret     8
dw 65419
des_round_loop:
    mov     edi, eax
    xor     edi, edx
    shr     edi, 26
    or      ebp, DWORD PTR [ebx+edi*4]
    shl     eax, 6
    rol     edx, 4
    add     ebx, 256
    loop    des_round_loop
    ret

db 141, 73, 0

_TEXT ENDS

END