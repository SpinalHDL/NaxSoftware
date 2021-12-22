#pragma once

#include "type.h"
#include "io.h"

#define BASE 0x10000000
#define PUTC BASE
#define CLINT_TIME BASE + 0x1BFF8

int sim_putchar(int c){
    write_u32(c, 0x10000000);
    return c;
}


long __attribute__ ((noinline)) sim_time(){
    return read_u32(CLINT_TIME);
}



