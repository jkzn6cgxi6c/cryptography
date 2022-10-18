#pragma once

class hash
{
    public:
        virtual void write(const unsigned char buf[], int count) = 0;
        virtual unsigned char *get() = 0;
        virtual ~hash() {}
};
