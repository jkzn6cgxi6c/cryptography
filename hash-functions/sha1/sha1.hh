#pragma once

#include <cstdint>
#include "../hash.hh"

class sha1 final : public hash
{
    public:
        sha1();
        virtual void write(const unsigned char buf[], int count) override;
        virtual unsigned char *get() override;

    private:
        void calculate(const unsigned char[], unsigned char[]);

        static const unsigned char iv[];

        uint64_t length;
        unsigned int offset;
        unsigned char H[20];
        unsigned char h[20];
        unsigned char block[320];
};
