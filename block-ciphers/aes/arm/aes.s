.globl aes_128_key_schedule @ void aes_128_key_schedule(unsigned char key[176])
.globl aes_192_key_schedule @ void aes_192_key_schedule(unsigned char key[208])
.globl aes_256_key_schedule @ void aes_256_key_schedule(unsigned char key[240])
.globl aes_128_key_inverse  @ void aes_128_key_inverse(unsigned char key[176])
.globl aes_192_key_inverse  @ void aes_192_key_inverse(unsigned char key[208])
.globl aes_256_key_inverse  @ void aes_256_key_inverse(unsigned char key[240])
.globl aes_128_encrypt      @ void aes_128_encrypt(unsigned char buffer[16], const unsigned char key[176])
.globl aes_192_encrypt      @ void aes_192_encrypt(unsigned char buffer[16], const unsigned char key[208])
.globl aes_256_encrypt      @ void aes_256_encrypt(unsigned char buffer[16], const unsigned char key[240])
.globl aes_128_decrypt      @ void aes_128_decrypt(unsigned char buffer[16], const unsigned char key[176])
.globl aes_192_decrypt      @ void aes_192_decrypt(unsigned char buffer[16], const unsigned char key[208])
.globl aes_256_decrypt      @ void aes_256_decrypt(unsigned char buffer[16], const unsigned char key[240])

.section .text,"ax",%progbits

.balign 64

sbox:       .byte  99, 124, 119, 123, 242, 107, 111, 197,  48,   1, 103,  43, 254, 215, 171, 118
            .byte 202, 130, 201, 125, 250,  89,  71, 240, 173, 212, 162, 175, 156, 164, 114, 192
            .byte 183, 253, 147,  38,  54,  63, 247, 204,  52, 165, 229, 241, 113, 216,  49,  21
            .byte   4, 199,  35, 195,  24, 150,   5, 154,   7,  18, 128, 226, 235,  39, 178, 117
            .byte   9, 131,  44,  26,  27, 110,  90, 160,  82,  59, 214, 179,  41, 227,  47, 132
            .byte  83, 209,   0, 237,  32, 252, 177,  91, 106, 203, 190,  57,  74,  76,  88, 207
            .byte 208, 239, 170, 251,  67,  77,  51, 133,  69, 249,   2, 127,  80,  60, 159, 168
            .byte  81, 163,  64, 143, 146, 157,  56, 245, 188, 182, 218,  33,  16, 255, 243, 210
            .byte 205,  12,  19, 236,  95, 151,  68,  23, 196, 167, 126,  61, 100,  93,  25, 115
            .byte  96, 129,  79, 220,  34,  42, 144, 136,  70, 238, 184,  20, 222,  94,  11, 219
            .byte 224,  50,  58,  10,  73,   6,  36,  92, 194, 211, 172,  98, 145, 149, 228, 121
            .byte 231, 200,  55, 109, 141, 213,  78, 169, 108,  86, 244, 234, 101, 122, 174,   8
            .byte 186, 120,  37,  46,  28, 166, 180, 198, 232, 221, 116,  31,  75, 189, 139, 138
            .byte 112,  62, 181, 102,  72,   3, 246,  14,  97,  53,  87, 185, 134, 193,  29, 158
            .byte 225, 248, 152,  17, 105, 217, 142, 148, 155,  30, 135, 233, 206,  85,  40, 223
            .byte 140, 161, 137,  13, 191, 230,  66, 104,  65, 153,  45,  15, 176,  84, 187,  22
invsbox:    .byte  82,   9, 106, 213,  48,  54, 165,  56, 191,  64, 163, 158, 129, 243, 215, 251
            .byte 124, 227,  57, 130, 155,  47, 255, 135,  52, 142,  67,  68, 196, 222, 233, 203
            .byte  84, 123, 148,  50, 166, 194,  35,  61, 238,  76, 149,  11,  66, 250, 195,  78
            .byte   8,  46, 161, 102,  40, 217,  36, 178, 118,  91, 162,  73, 109, 139, 209,  37
            .byte 114, 248, 246, 100, 134, 104, 152,  22, 212, 164,  92, 204,  93, 101, 182, 146
            .byte 108, 112,  72,  80, 253, 237, 185, 218,  94,  21,  70,  87, 167, 141, 157, 132
            .byte 144, 216, 171,   0, 140, 188, 211,  10, 247, 228,  88,   5, 184, 179,  69,   6
            .byte 208,  44,  30, 143, 202,  63,  15,   2, 193, 175, 189,   3,   1,  19, 138, 107
            .byte  58, 145,  17,  65,  79, 103, 220, 234, 151, 242, 207, 206, 240, 180, 230, 115
            .byte 150, 172, 116,  34, 231, 173,  53, 133, 226, 249,  55, 232,  28, 117, 223, 110
            .byte  71, 241,  26, 113,  29,  41, 197, 137, 111, 183,  98,  14, 170,  24, 190,  27
            .byte 252,  86,  62,  75, 198, 210, 121,  32, 154, 219, 192, 254, 120, 205,  90, 244
            .byte  31, 221, 168,  51, 136,   7, 199,  49, 177,  18,  16,  89,  39, 128, 236,  95
            .byte  96,  81, 127, 169,  25, 181,  74,  13,  45, 229, 122, 159, 147, 201, 156, 239
            .byte 160, 224,  59,  77, 174,  42, 245, 176, 200, 235, 187,  60, 131,  83, 153,  97
            .byte  23,  43,   4, 126, 186, 119, 214,  38, 225, 105,  20,  99,  85,  33,  12, 125
invmatrix:  .long          0,  185403662,  370807324,  488053522,  741614648,  658058550,  976107044,  824393514, 1483229296, 1399144830, 1316117100, 1165972322, 1952214088, 2136040774, 1648787028, 1766553434
            .long 2966458592, 3151862254, 2798289660, 2915535858, 2632234200, 2548678102, 2331944644, 2180231114, 3904428176, 3820343710, 4272081548, 4121936770, 3297574056, 3481400742, 3533106868, 3650873274
            .long 2075868123, 1890988757, 1839278535, 1722556617, 1468997603, 1552029421, 1100287487, 1251476721,  601060267,  685669029,  902390199, 1053059257,  266819475,   82468509,  436028815,  317738113
            .long 3412831035, 3227951669, 3715217703, 3598495785, 3881799427, 3964831245, 4047871263, 4199060497, 2466505547, 2551114309, 2233069911, 2383738969, 3208103795, 3023752829, 2838353263, 2720062561
            .long 4134368941, 4250959779, 3765920945, 3950669247, 3663286933, 3511966619, 3426959497, 3343796615, 2919579357, 2768779219, 3089050817, 3004310991, 2184256229, 2302415851, 2485848313, 2670068215
            .long 1186850381, 1303441219, 1353184337, 1537932639, 1787413109, 1636092795, 2090061929, 2006899047,  517320253,  366520115,  147831841,   63092015,  853641733,  971801355,  620468249,  804688151
            .long 2379631990, 2262516856, 2613862250, 2428589668, 2715969870, 2867814464, 3086515026, 3170202204, 3586000134, 3736275976, 3282310938, 3366526484, 4186579262, 4068943920, 4019204898, 3835509292
            .long 1023860118,  906744984,  723308426,  538035844,  288553390,  440397984,  120122290,  203809468, 1701746150, 1852021992, 1937016826, 2021232372, 1230680542, 1113045200, 1598071746, 1414376140
            .long 4158319681, 4242007375, 3787521629, 3939366739, 3689859193, 3504587127, 3455375973, 3338261355, 2947720241, 2764025151, 3114841645, 2997206819, 2206629897, 2290845959, 2510066197, 2660342555
            .long 1191869601, 1275557295, 1360031421, 1511876531, 1799248025, 1613975959, 2099530373, 1982415755,  526529745,  342834655,  158869197,   41234371,  861278441,  945494503,  625738485,  776014843
            .long 2355222426, 2272059028, 2591802758, 2440481928, 2689987490, 2874735276, 3058688446, 3175278768, 3557400554, 3741619940, 3256061430, 3374220536, 4164795346, 4080055004, 3995576782, 3844776128
            .long 1018251130,  935087732,  715871590,  564550760,  277177154,  461924940,  111112542,  227702864, 1691946762, 1876166148, 1925389590, 2043548696, 1223502642, 1138762300, 1593260334, 1442459680
            .long   28809964,  179999714,  397248752,  480281086,  763608788,  646887386,  999926984,  815048134, 1507840668, 1389550482, 1338359936, 1154009486, 1978398372, 2129067946, 1676797112, 1761406390
            .long 2976320012, 3127509762, 2809993232, 2893025566, 2639474228, 2522752826, 2336832552, 2151953702, 3910091388, 3791801202, 4279586912, 4095236462, 3309004356, 3459673930, 3542185048, 3626794326
            .long 2047648055, 1895934009, 1813426987, 1729870373, 1446544655, 1563790337, 1076008723, 1261411869,  577038663,  694804553,  880737115, 1064563285,  240176511,   90031217,  407560035,  323475053
            .long 3403428311, 3251714265, 3703972811, 3620416197, 3873969647, 3991215329, 4042393587, 4227796733, 2461301159, 2579067049, 2226023355, 2409849525, 3196083615, 3045938321, 2828685187, 2744600205
tbox:       .long 2774754246, 2222750968, 2574743534, 2373680118,  234025727, 3177933782, 2976870366, 1422247313, 1345335392,   50397442, 2842126286, 2099981142,  436141799, 1658312629, 3870010189, 2591454956
            .long 1170918031, 2642575903, 1086966153, 2273148410,  368769775, 3948501426, 3376891790,  200339707, 3970805057, 1742001331, 4255294047, 3937382213, 3214711843, 4154762323, 2524082916, 1539358875
            .long 3266819957,  486407649, 2928907069, 1780885068, 1513502316, 1094664062,   49805301, 1338821763, 1546925160, 4104496465,  887481809,  150073849, 2473685474, 1943591083, 1395732834, 1058346282
            .long  201589768, 1388824469, 1696801606, 1589887901,  672667696, 2711000631,  251987210, 3046808111,  151455502,  907153956, 2608889883, 1038279391,  652995533, 1764173646, 3451040383, 2675275242
            .long  453576978, 2659418909, 1949051992,  773462580,  756751158, 2993581788, 3998898868, 4221608027, 4132590244, 1295727478, 1641469623, 3467883389, 2066295122, 1055122397, 1898917726, 2542044179
            .long 4115878822, 1758581177,          0,  753790401, 1612718144,  536673507, 3367088505, 3982187446, 3194645204, 1187761037, 3653156455, 1262041458, 3729410708, 3561770136, 3898103984, 1255133061
            .long 1808847035,  720367557, 3853167183,  385612781, 3309519750, 3612167578, 1429418854, 2491778321, 3477423498,  284817897,  100794884, 2172616702, 4031795360, 1144798328, 3131023141, 3819481163
            .long 4082192802, 4272137053, 3225436288, 2324664069, 2912064063, 3164445985, 1211644016,   83228145, 3753688163, 3249976951, 1977277103, 1663115586,  806359072,  452984805,  250868733, 1842533055
            .long 1288555905,  336333848,  890442534,  804056259, 3781124030, 2727843637, 3427026056,  957814574, 1472513171, 4071073621, 2189328124, 1195195770, 2892260552, 3881655738,  723065138, 2507371494
            .long 2690670784, 2558624025, 3511635870, 2145180835, 1713513028, 2116692564, 2878378043, 2206763019, 3393603212,  703524551, 3552098411, 1007948840, 2044649127, 3797835452,  487262998, 1994120109
            .long 1004593371, 1446130276, 1312438900,  503974420, 3679013266,  168166924, 1814307912, 3831258296, 1573044895, 1859376061, 4021070915, 2791465668, 2828112185, 2761266481,  937747667, 2339994098
            .long  854058965, 1137232011, 1496790894, 3077402074, 2358086913, 1691735473, 3528347292, 3769215305, 3027004632, 4199962284,  133494003,  636152527, 2942657994, 2390391540, 3920539207,  403179536
            .long 3585784431, 2289596656, 1864705354, 1915629148,  605822008, 4054230615, 3350508659, 1371981463,  602466507, 2094914977, 2624877800,  555687742, 3712699286, 3703422305, 2257292045, 2240449039
            .long 2423288032, 1111375484, 3300242801, 2858837708, 3628615824,   84083462,   32962295,  302911004, 2741068226, 1597322602, 4183250862, 3501832553, 2441512471, 1489093017,  656219450, 3114180135
            .long  954327513,  335083755, 3013122091,  856756514, 3144247762, 1893325225, 2307821063, 2811532339, 3063651117,  572399164, 2458355477,  552200649, 1238290055, 4283782570, 2015897680, 2061492133
            .long 2408352771, 4171342169, 2156497161,  386731290, 3669999461,  837215959, 3326231172, 3093850320, 3275833730, 2962856233, 1999449434,  286199582, 3417354363, 4233385128, 3602627437,  974525996
invtbox:    .long 1353184337, 1399144830, 3282310938, 2522752826, 3412831035, 4047871263, 2874735276, 2466505547, 1442459680, 4134368941, 2440481928,  625738485, 4242007375, 3620416197, 2151953702, 2409849525
            .long 1230680542, 1729870373, 2551114309, 3787521629,   41234371,  317738113, 2744600205, 3338261355, 3881799427, 2510066197, 3950669247, 3663286933,  763608788, 3542185048,  694804553, 1154009486
            .long 1787413109, 2021232372, 1799248025, 3715217703, 3058688446,  397248752, 1722556617, 3023752829,  407560035, 2184256229, 1613975959, 1165972322, 3765920945, 2226023355,  480281086, 2485848313
            .long 1483229296,  436028815, 2272059028, 3086515026,  601060267, 3791801202, 1468997603,  715871590,  120122290,   63092015, 2591802758, 2768779219, 4068943920, 2997206819, 3127509762, 1552029421
            .long  723308426, 2461301159, 4042393587, 2715969870, 3455375973, 3586000134,  526529745, 2331944644, 2639474228, 2689987490,  853641733, 1978398372,  971801355, 2867814464,  111112542, 1360031421
            .long 4186579262, 1023860118, 2919579357, 1186850381, 3045938321,   90031217, 1876166148, 4279586912,  620468249, 2548678102, 3426959497, 2006899047, 3175278768, 2290845959,  945494503, 3689859193
            .long 1191869601, 3910091388, 3374220536,          0, 2206629897, 1223502642, 2893025566, 1316117100, 4227796733, 1446544655,  517320253,  658058550, 1691946762,  564550760, 3511966619,  976107044
            .long 2976320012,  266819475, 3533106868, 2660342555, 1338359936, 2720062561, 1766553434,  370807324,  179999714, 3844776128, 1138762300,  488053522,  185403662, 2915535858, 3114841645, 3366526484
            .long 2233069911, 1275557295, 3151862254, 4250959779, 2670068215, 3170202204, 3309004356,  880737115, 1982415755, 3703972811, 1761406390, 1676797112, 3403428311,  277177154, 1076008723,  538035844
            .long 2099530373, 4164795346,  288553390, 1839278535, 1261411869, 4080055004, 3964831245, 3504587127, 1813426987, 2579067049, 4199060497,  577038663, 3297574056,  440397984, 3626794326, 4019204898
            .long 3343796615, 3251714265, 4272081548,  906744984, 3481400742,  685669029,  646887386, 2764025151, 3835509292,  227702864, 2613862250, 1648787028, 3256061430, 3904428176, 1593260334, 4121936770
            .long 3196083615, 2090061929, 2838353263, 3004310991,  999926984, 2809993232, 1852021992, 2075868123,  158869197, 4095236462,   28809964, 2828685187, 1701746150, 2129067946,  147831841, 3873969647
            .long 3650873274, 3459673930, 3557400554, 3598495785, 2947720241,  824393514,  815048134, 3227951669,  935087732, 2798289660, 2966458592,  366520115, 1251476721, 4158319681,  240176511,  804688151
            .long 2379631990, 1303441219, 1414376140, 3741619940, 3820343710,  461924940, 3089050817, 2136040774,   82468509, 1563790337, 1937016826,  776014843, 1511876531, 1389550482,  861278441,  323475053
            .long 2355222426, 2047648055, 2383738969, 2302415851, 3995576782,  902390199, 3991215329, 1018251130, 1507840668, 1064563285, 2043548696, 3208103795, 3939366739, 1537932639,  342834655, 2262516856
            .long 2180231114, 1053059257,  741614648, 1598071746, 1925389590,  203809468, 2336832552, 1100287487, 1895934009, 3736275976, 2632234200, 2428589668, 1636092795, 1890988757, 1952214088, 1113045200

aes_128_key_schedule:
    add     r0, #16                     @ pointer to key + 16
    ldr     r1, [r0, #-4]               @ W(i-1)
    sub     r12, pc, #3600              @ pointer to sbox
    mov     r3, #1                      @ 1st rcon
.Laes_128_key_schedule_loop:
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 4th byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 3rd byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[2])S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 2nd byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 1st byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[0])S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])
    eor     r1, r3, r1, ROR #8          @ S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])S(W(i-1)[0]) xor rcon
    mov     r3, r3, LSL #1              @ next rcon
    ands    r3, #255                    @ if rcon overflows ...
    moveq   r3, #27                     @ ... then adjust rcon
    ldr     r2, [r0, #-16]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])S(W(i-1)[0]) xor rcon
    str     r1, [r0], #4                @ W(i-4) xor S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])S(W(i-1)[0]) xor rcon
    ldr     r2, [r0, #-16]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    ldr     r2, [r0, #-16]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    ldr     r2, [r0, #-16]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    teq     r3, #108                    @ loop control variable
    bne     .Laes_128_key_schedule_loop
    mov     pc, lr                      @ return

aes_192_key_schedule:
    add     r0, #24                     @ pointer to key + 24
    ldr     r1, [r0, #-4]               @ W(i-1)
    mov     r3, #1                      @ 1st rcon
    sub     r12, pc, #3728              @ pointer to sbox
.Laes_192_key_schedule_loop:
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 4th byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 3rd byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[2])S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 2nd byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 1st byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[0])S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])
    eor     r1, r3, r1, ROR #8          @ S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])S(W(i-1)[0]) xor rcon
    mov     r3, r3, LSL #1              @ next rcon
    ldr     r2, [r0, #-24]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])S(W(i-1)[0]) xor rcon
    str     r1, [r0], #4                @ W(i-4) xor S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])S(W(i-1)[0]) xor rcon
    ldr     r2, [r0, #-24]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    ldr     r2, [r0, #-24]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    ldr     r2, [r0, #-24]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    teq     r3, #256                    @ loop control variable
    moveq   pc, lr                      @ return
    ldr     r2, [r0, #-24]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    ldr     r2, [r0, #-24]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    b       .Laes_192_key_schedule_loop

aes_256_key_schedule:
    sub     r12, pc, #3856              @ pointer to sbox
    add     r0, #32                     @ pointer to key + 32
    ldr     r1, [r0, #-4]               @ W(i-1)
    mov     r3, #1                      @ 1st rcon
.Laes_256_key_schedule_loop:
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 4th byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 3rd byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[2])S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 2nd byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 1st byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[0])S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])
    eor     r1, r3, r1, ROR #8          @ S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])S(W(i-1)[0]) xor rcon
    mov     r3, r3, LSL #1              @ next rcon
    ldr     r2, [r0, #-32]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])S(W(i-1)[0]) xor rcon
    str     r1, [r0], #4                @ W(i-4) xor S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])S(W(i-1)[0]) xor rcon
    ldr     r2, [r0, #-32]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    ldr     r2, [r0, #-32]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    ldr     r2, [r0, #-32]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    teq     r3, #128                    @ loop control variable
    moveq   pc, lr                      @ return
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 4th byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 3rd byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[2])S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 2nd byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])
    ldrb    r2, [r12, r1, LSR #24]      @ sbox of 1st byte of W(i-1)
    orr     r1, r2, r1, LSL #8          @ S(W(i-1)[0])S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3])
    ldr     r2, [r0, #-32]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor S(W(i-1)[0])S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3]) xor rcon
    str     r1, [r0], #4                @ W(i-4) xor S(W(i-1)[0])S(W(i-1)[1])S(W(i-1)[2])S(W(i-1)[3]) xor rcon
    ldr     r2, [r0, #-32]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    ldr     r2, [r0, #-32]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    ldr     r2, [r0, #-32]              @ W(i-4)
    eor     r1, r2                      @ W(i-4) xor W(i-1)
    str     r1, [r0], #4                @ W(i-4) xor W(i-1)
    b       .Laes_256_key_schedule_loop

aes_128_key_inverse:
    mov     r12, #36                    @ number of main rounds * 4
    b       .Laes_key_inverse

aes_192_key_inverse:
    mov     r12, #44                    @ number of main rounds * 4
    b       .Laes_key_inverse

aes_256_key_inverse:
    mov     r12, #52                    @ number of main rounds * 4
    b       .Laes_key_inverse

.Laes_key_inverse:
    add     r0, #16                     @ pointer to key + 16
    sub     r2, pc, #3568               @ pointer to invmatrix
    str     r4, [sp, #-4]!              @ save register
.Laes_key_inverse_loop:
    mov     r3, #0                      @ temporary 4 bytes for key
    ldr     r4, [r0]                    @ load next 4 bytes of key
    and     r1, r4, #255                @ 1st byte of 4 bytes of key
    ldr     r1, [r2, r1, ROR #30]       @ invmatrix1 of 1st byte
    eor     r3, r1, ROR #0              @ xor invmatrix1 of 1st byte with temp
    and     r1, r4, #65280              @ 2nd byte of 4 bytes of key
    ldr     r1, [r2, r1, ROR #6]        @ invmatrix2 of 2nd byte
    eor     r3, r1, ROR #24             @ xor invmatrix2 of 2nd byte with temp
    and     r1, r4, #16711680           @ 3rd byte of 4 bytes of key
    ldr     r1, [r2, r1, ROR #14]       @ invmatrix3 of 3rd byte
    eor     r3, r1, ROR #16             @ xor invmatrix3 of 3rd byte with temp
    and     r1, r4, #4278190080         @ 4th byte of 4 bytes of key
    ldr     r1, [r2, r1, ROR #22]       @ invmatrix4 of 4th byte
    eor     r3, r1, ROR #8              @ xor invmatrix4 of 4th byte with temp
    str     r3, [r0], #4                @ store next 4 bytes of inverted key
    subs    r12, #1                     @ loop control variable
    bne     .Laes_key_inverse_loop
    ldr     r4, [sp], #4                @ load register
    mov     pc, lr                      @ return

aes_128_encrypt:
    mov     r12, #9                     @ number of main rounds
    b       .Laes_encrypt

aes_192_encrypt:
    mov     r12, #11                    @ number of main rounds
    b       .Laes_encrypt

aes_256_encrypt:
    mov     r12, #13                    @ number of main rounds
    b       .Laes_encrypt

.Laes_encrypt:
    stmdb   sp!, {r4-r11}               @ save registers
    sub     r3, pc, #2656               @ pointer to tbox
    ldmia   r0, {r8-r11}                @ load data to r8, r9, r10 and r11
    ldmia   r1!, {r4-r7}                @ load 1st round key to r4, r5, r6 and r7
    eor     r8, r4                      @ initial round AddRoundKey
    eor     r9, r5                      @ initial round AddRoundKey
    eor     r10, r6                     @ initial round AddRoundKey
    eor     r11, r7                     @ initial round AddRoundKey
.Laes_encrypt_loop:
    ldmia   r1!, {r4-r7}                @ load next round key to r4, r5, r6 and r7
    and     r2, r8, #255                @  1st byte of data
    ldr     r2, [r3, r2, ROR #30]       @ tbox1 of  1st byte
    eor     r4, r2, ROR #0
    and     r2, r9, #255                @  5th byte of data
    ldr     r2, [r3, r2, ROR #30]       @ tbox1 of  5th byte
    eor     r5, r2, ROR #0
    and     r2, r10, #255               @  9th byte of data
    ldr     r2, [r3, r2, ROR #30]       @ tbox1 of  9th byte
    eor     r6, r2, ROR #0
    and     r2, r11, #255               @ 13th byte of data
    ldr     r2, [r3, r2, ROR #30]       @ tbox1 of 13th byte
    eor     r7, r2, ROR #0
    and     r2, r9, #65280              @  6th byte of data
    ldr     r2, [r3, r2, ROR #6]        @ tbox2 of  6th byte
    eor     r4, r2, ROR #24
    and     r2, r10, #65280             @ 10th byte of data
    ldr     r2, [r3, r2, ROR #6]        @ tbox2 of 10th byte
    eor     r5, r2, ROR #24
    and     r2, r11, #65280             @ 14th byte of data
    ldr     r2, [r3, r2, ROR #6]        @ tbox2 of 14th byte
    eor     r6, r2, ROR #24
    and     r2, r8, #65280              @  2nd byte of data
    ldr     r2, [r3, r2, ROR #6]        @ tbox2 of  2nd byte
    eor     r7, r2, ROR #24
    and     r2, r10, #16711680          @ 11th byte of data
    ldr     r2, [r3, r2, ROR #14]       @ tbox3 of 11th byte
    eor     r4, r2, ROR #16
    and     r2, r11, #16711680          @ 15th byte of data
    ldr     r2, [r3, r2, ROR #14]       @ tbox3 of 15th byte
    eor     r5, r2, ROR #16
    and     r2, r8, #16711680           @  3rd byte of data
    ldr     r2, [r3, r2, ROR #14]       @ tbox3 of  3rd byte
    eor     r6, r2, ROR #16
    and     r2, r9, #16711680           @  7th byte of data
    ldr     r2, [r3, r2, ROR #14]       @ tbox3 of  7th byte
    eor     r7, r2, ROR #16
    and     r2, r11, #4278190080        @ 16th byte of data
    ldr     r2, [r3, r2, ROR #22]       @ tbox4 of 16th byte
    eor     r4, r2, ROR #8
    and     r2, r8, #4278190080         @  4th byte of data
    ldr     r2, [r3, r2, ROR #22]       @ tbox4 of  4th byte
    eor     r5, r2, ROR #8
    and     r2, r9, #4278190080         @  8th byte of data
    ldr     r2, [r3, r2, ROR #22]       @ tbox4 of  8th byte
    eor     r6, r2, ROR #8
    and     r2, r10, #4278190080        @ 12th byte of data
    ldr     r2, [r3, r2, ROR #22]       @ tbox4 of 12th byte
    eor     r7, r2, ROR #8
    mov     r8, r4                      @ move temporary data block
    mov     r9, r5                      @ move temporary data block
    mov     r10, r6                     @ move temporary data block
    mov     r11, r7                     @ move temporary data block
    subs    r12, #1                     @ loop control variable
    bne     .Laes_encrypt_loop
    sub     r3, #1536                   @ pointer to sbox
    ldmia   r1!, {r4-r7}                @ load last round key to r4, r5, r6 and r7
    and     r2, r8, #255                @  1st byte of data
    ldrb    r2, [r3, r2, LSR #0]        @ sbox of  1st byte
    eor     r4, r2, LSL #0
    and     r2, r9, #255                @  5th byte of data
    ldrb    r2, [r3, r2, LSR #0]        @ sbox of  5th byte
    eor     r5, r2, LSL #0
    and     r2, r10, #255               @  9th byte of data
    ldrb    r2, [r3, r2, LSR #0]        @ sbox of  9th byte
    eor     r6, r2, LSL #0
    and     r2, r11, #255               @ 13th byte of data
    ldrb    r2, [r3, r2, LSR #0]        @ sbox of 13th byte
    eor     r7, r2, LSL #0
    and     r2, r9, #65280              @  6th byte of data
    ldrb    r2, [r3, r2, LSR #8]        @ sbox of  6th byte
    eor     r4, r2, LSL #8
    and     r2, r10, #65280             @ 10th byte of data
    ldrb    r2, [r3, r2, LSR #8]        @ sbox of 10th byte
    eor     r5, r2, LSL #8
    and     r2, r11, #65280             @ 14th byte of data
    ldrb    r2, [r3, r2, LSR #8]        @ sbox of 14th byte
    eor     r6, r2, LSL #8
    and     r2, r8, #65280              @  2nd byte of data
    ldrb    r2, [r3, r2, LSR #8]        @ sbox of  2nd byte
    eor     r7, r2, LSL #8
    and     r2, r10, #16711680          @ 11th byte of data
    ldrb    r2, [r3, r2, LSR #16]       @ sbox of 11th byte
    eor     r4, r2, LSL #16
    and     r2, r11, #16711680          @ 15th byte of data
    ldrb    r2, [r3, r2, LSR #16]       @ sbox of 15th byte
    eor     r5, r2, LSL #16
    and     r2, r8, #16711680           @  3rd byte of data
    ldrb    r2, [r3, r2, LSR #16]       @ sbox of  3rd byte
    eor     r6, r2, LSL #16
    and     r2, r9, #16711680           @  7th byte of data
    ldrb    r2, [r3, r2, LSR #16]       @ sbox of  7th byte
    eor     r7, r2, LSL #16
    and     r2, r11, #4278190080        @ 16th byte of data
    ldrb    r2, [r3, r2, LSR #24]       @ sbox of 16th byte
    eor     r4, r2, LSL #24
    and     r2, r8, #4278190080         @  4th byte of data
    ldrb    r2, [r3, r2, LSR #24]       @ sbox of  4th byte
    eor     r5, r2, LSL #24
    and     r2, r9, #4278190080         @  8th byte of data
    ldrb    r2, [r3, r2, LSR #24]       @ sbox of  8th byte
    eor     r6, r2, LSL #24
    and     r2, r10, #4278190080        @ 12th byte of data
    ldrb    r2, [r3, r2, LSR #24]       @ sbox of 12th byte
    eor     r7, r2, LSL #24
    stmia   r0, {r4-r7}                 @ save data
    ldmia   sp!, {r4-r11}               @ load registers
    mov     pc, lr                      @ return

aes_128_decrypt:
    mov     r12, #9                     @ number of main rounds
    b       .Laes_decrypt

aes_192_decrypt:
    mov     r12, #11                    @ number of main rounds
    b       .Laes_decrypt

aes_256_decrypt:
    mov     r12, #13                    @ number of main rounds
    b       .Laes_decrypt

.Laes_decrypt:
    add     r1, #32                     @ pointer to key + 32
    stmdb   sp!, {r4-r11}               @ save registers
    add     r1, r12, LSL #4             @ pointer to last round key
    sub     r3, pc, #2128               @ pointer to invtbox
    ldmia   r0, {r8-r11}                @ load data to r8, r9, r10 and r11
    ldmdb   r1!, {r4-r7}                @ load 1st round key to r4, r5, r6 and r7
    eor     r8, r4                      @ initial round AddRoundKey
    eor     r9, r5                      @ initial round AddRoundKey
    eor     r10, r6                     @ initial round AddRoundKey
    eor     r11, r7                     @ initial round AddRoundKey
.Laes_decrypt_loop:
    ldmdb   r1!, {r4-r7}                @ load last round key to r4, r5, r6 and r7
    and     r2, r8, #255                @  1st byte of data
    ldr     r2, [r3, r2, ROR #30]       @ invtbox1 of  1st byte
    eor     r4, r2, ROR #0
    and     r2, r9, #255                @  5th byte of data
    ldr     r2, [r3, r2, ROR #30]       @ invtbox1 of  5th byte
    eor     r5, r2, ROR #0
    and     r2, r10, #255               @  9th byte of data
    ldr     r2, [r3, r2, ROR #30]       @ invtbox1 of  9th byte
    eor     r6, r2, ROR #0
    and     r2, r11, #255               @ 13th byte of data
    ldr     r2, [r3, r2, ROR #30]       @ invtbox1 of 13th byte
    eor     r7, r2, ROR #0
    and     r2, r11, #65280             @ 14th byte of data
    ldr     r2, [r3, r2, ROR #6]        @ invtbox2 of 14th byte
    eor     r4, r2, ROR #24
    and     r2, r8, #65280              @  2nd byte of data
    ldr     r2, [r3, r2, ROR #6]        @ invtbox2 of  2nd byte
    eor     r5, r2, ROR #24
    and     r2, r9, #65280              @  6th byte of data
    ldr     r2, [r3, r2, ROR #6]        @ invtbox2 of  6th byte
    eor     r6, r2, ROR #24
    and     r2, r10, #65280             @ 10th byte of data
    ldr     r2, [r3, r2, ROR #6]        @ invtbox2 of 10th byte
    eor     r7, r2, ROR #24
    and     r2, r10, #16711680          @ 11th byte of data
    ldr     r2, [r3, r2, ROR #14]       @ invtbox3 of 11th byte
    eor     r4, r2, ROR #16
    and     r2, r11, #16711680          @ 15th byte of data
    ldr     r2, [r3, r2, ROR #14]       @ invtbox3 of 15th byte
    eor     r5, r2, ROR #16
    and     r2, r8, #16711680           @  3rd byte of data
    ldr     r2, [r3, r2, ROR #14]       @ invtbox3 of  3rd byte
    eor     r6, r2, ROR #16
    and     r2, r9, #16711680           @  7th byte of data
    ldr     r2, [r3, r2, ROR #14]       @ invtbox3 of  7th byte
    eor     r7, r2, ROR #16
    and     r2, r9, #4278190080         @  8th byte of data
    ldr     r2, [r3, r2, ROR #22]       @ invtbox4 of  8th byte
    eor     r4, r2, ROR #8
    and     r2, r10, #4278190080        @ 12th byte of data
    ldr     r2, [r3, r2, ROR #22]       @ invtbox4 of 12th byte
    eor     r5, r2, ROR #8
    and     r2, r11, #4278190080        @ 16th byte of data
    ldr     r2, [r3, r2, ROR #22]       @ invtbox4 of 16th byte
    eor     r6, r2, ROR #8
    and     r2, r8, #4278190080         @  4th byte of data
    ldr     r2, [r3, r2, ROR #22]       @ invtbox4 of  4th byte
    eor     r7, r2, ROR #8
    mov     r8, r4                      @ move temporary data block
    mov     r9, r5                      @ move temporary data block
    mov     r10, r6                     @ move temporary data block
    mov     r11, r7                     @ move temporary data block
    subs    r12, #1                     @ loop control variable
    bne     .Laes_decrypt_loop
    sub     r3, #2304                   @ pointer to invsbox
    ldmdb   r1!, {r4-r7}                @ load last round key to r4, r5, r6 and r7
    and     r2, r8, #255                @  1st byte of data
    ldrb    r2, [r3, r2, LSR #0]        @ invsbox of  1st byte
    eor     r4, r2, LSL #0
    and     r2, r9, #255                @  5th byte of data
    ldrb    r2, [r3, r2, LSR #0]        @ invsbox of  5th byte
    eor     r5, r2, LSL #0
    and     r2, r10, #255               @  9th byte of data
    ldrb    r2, [r3, r2, LSR #0]        @ invsbox of  9th byte
    eor     r6, r2, LSL #0
    and     r2, r11, #255               @ 13th byte of data
    ldrb    r2, [r3, r2, LSR #0]        @ invsbox of 13th byte
    eor     r7, r2, LSL #0
    and     r2, r11, #65280             @ 14th byte of data
    ldrb    r2, [r3, r2, LSR #8]        @ invsbox of 14th byte
    eor     r4, r2, LSL #8
    and     r2, r8, #65280              @  2nd byte of data
    ldrb    r2, [r3, r2, LSR #8]        @ invsbox of  2nd byte
    eor     r5, r2, LSL #8
    and     r2, r9, #65280              @  6th byte of data
    ldrb    r2, [r3, r2, LSR #8]        @ invsbox of  6th byte
    eor     r6, r2, LSL #8
    and     r2, r10, #65280             @ 10th byte of data
    ldrb    r2, [r3, r2, LSR #8]        @ invsbox of 10th byte
    eor     r7, r2, LSL #8
    and     r2, r10, #16711680          @ 11th byte of data
    ldrb    r2, [r3, r2, LSR #16]       @ invsbox of 11th byte
    eor     r4, r2, LSL #16
    and     r2, r11, #16711680          @ 15th byte of data
    ldrb    r2, [r3, r2, LSR #16]       @ invsbox of 15th byte
    eor     r5, r2, LSL #16
    and     r2, r8, #16711680           @  3rd byte of data
    ldrb    r2, [r3, r2, LSR #16]       @ invsbox of  3rd byte
    eor     r6, r2, LSL #16
    and     r2, r9, #16711680           @  7th byte of data
    ldrb    r2, [r3, r2, LSR #16]       @ invsbox of  7th byte
    eor     r7, r2, LSL #16
    and     r2, r9, #4278190080         @  8th byte of data
    ldrb    r2, [r3, r2, LSR #24]       @ invsbox of  8th byte
    eor     r4, r2, LSL #24
    and     r2, r10, #4278190080        @ 12th byte of data
    ldrb    r2, [r3, r2, LSR #24]       @ invsbox of 12th byte
    eor     r5, r2, LSL #24
    and     r2, r11, #4278190080        @ 16th byte of data
    ldrb    r2, [r3, r2, LSR #24]       @ invsbox of 16th byte
    eor     r6, r2, LSL #24
    and     r2, r8, #4278190080         @  4th byte of data
    ldrb    r2, [r3, r2, LSR #24]       @ invsbox of  4th byte
    eor     r7, r2, LSL #24
    stmia   r0, {r4-r7}                 @ save data
    ldmia   sp!, {r4-r11}               @ load registers
    mov     pc, lr                      @ return
