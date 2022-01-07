#pragma once

#include "type.h"
#include "io.h"

#include "sim_asm.h"

int sim_putchar(int c){
    write_u32(c, 0x10000000);
    return c;
}


long __attribute__ ((noinline)) sim_time(){
    return read_u32(CLINT_TIME);
}



