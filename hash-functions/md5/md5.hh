#pragma once

#include <cstdint>
#include "../hash.hh"

class md5 final : public hash
{
    public:
        md5();
        virtual void write(const unsigned char buf[], int count) override;
        virtual unsigned char *get() override;

    private:
        void calculate(const unsigned char[], unsigned char[]);

        static const unsigned char k[];
        static const unsigned char s[];
        static const unsigned char iv[];

        uint64_t length;
        unsigned int offset;
        unsigned char H[16];
        unsigned char h[16];
        unsigned char block[64];
};
