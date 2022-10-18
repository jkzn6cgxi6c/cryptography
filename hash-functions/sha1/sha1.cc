#include <endian.h>
#include "sha1.hh"

const unsigned char sha1::iv[] = {0x67, 0x45, 0x23, 0x01, 0xEF, 0xCD, 0xAB, 0x89, 0x98, 0xBA, 0xDC, 0xFE, 0x10, 0x32, 0x54, 0x76, 0xC3, 0xD2, 0xE1, 0xF0};

sha1::sha1() : length(0), offset(0)
{
    for(unsigned int i = 0; i < sizeof(h); i++)
    {
        h[i] = iv[i];
    }
    return;
}

void sha1::write(const unsigned char buf[], int count)
{
    length += count;
    while(count > 0)
    {
        block[offset] = *buf;
        offset++;
        if(offset == 64)
        {
            offset = 0;
            calculate(block, h);
        }
        buf++;
        count--;
    }
    return;
}

unsigned char *sha1::get()
{
    unsigned int i;
    for(i = 0; i < sizeof(H); i++)
    {
        H[i] = h[i];
    }
    block[offset] = 128;
    i = offset + 1;
    if(offset < 56)
    {
        for(; i < 56; i++)
        {
            block[i] = 0;
        }
        ((uint64_t*)block)[7] = htobe64(length << 3);
        calculate(block, H);
    }
    else
    {
        for(; i < 64; i++)
        {
            block[i] = 0;
        }
        calculate(block, H);
        uint64_t temp[40] = {0, 0, 0, 0, 0, 0, 0, htobe64(length << 3)};
        calculate((unsigned char*)temp, H);
    }
    return H;
}

#define ROTL(x, y) ((x) << (y) | (x) >> (32 - (y)))

#define IV ((uint32_t*)h)

#define FUNC                                                 \
t = be32toh(((uint32_t*)block)[i]) + ROTL(a, 5) + e + f + k; \
e = d;                                                       \
d = c;                                                       \
c = ROTL(b, 30);                                             \
b = a;                                                       \
a = t;

void sha1::calculate(const unsigned char block[64], unsigned char h[16])
{
    uint32_t a = be32toh(IV[0]), b = be32toh(IV[1]), c = be32toh(IV[2]), d = be32toh(IV[3]), e = be32toh(IV[4]), f, k, t;
    int i = 0;
    for(t = 16; t < 80; t++)
    {
        ((uint32_t*)block)[t] = htobe32(ROTL(be32toh(((uint32_t*)block)[t - 3] ^ ((uint32_t*)block)[t - 8] ^ ((uint32_t*)block)[t - 14] ^ ((uint32_t*)block)[t - 16]), 1));
    }
    for(; i < 20; i++)
    {
        f = ((c ^ d) & b ) ^ d;
        k = 0x5A827999;
        FUNC;
    }
    for(; i < 40; i++)
    {
        f = b ^ c ^ d;
        k = 0x6ED9EBA1;
        FUNC;
    }
    for(; i < 60; i++)
    {
        f = ((b | c) & d) | (b & c);
        k = 0x8F1BBCDC;
        FUNC;
    }
    for(; i < 80; i++)
    {
        f = b ^ c ^ d;
        k = 0xCA62C1D6;
        FUNC;
    }
    IV[0] = htobe32(a + be32toh(IV[0]));
    IV[1] = htobe32(b + be32toh(IV[1]));
    IV[2] = htobe32(c + be32toh(IV[2]));
    IV[3] = htobe32(d + be32toh(IV[3]));
    IV[4] = htobe32(e + be32toh(IV[4]));
    return;
}

#undef FUNC
#undef IV
#undef ROTL
