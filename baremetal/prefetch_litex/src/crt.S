#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#include "../../driver/privileged.h"
#define delay() nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;


#if __riscv_xlen == 64
#define STORE sd
#define LOAD ld
#define WORD 8
#else
#define STORE sw
#define LOAD lw
#define WORD 4
#endif


#define prefetch_r(addr) \
  ori x0, addr, 1

#define prefetch_w(addr) \
    ori x0, addr, 3

#define prefetch_r_block(addr, blocks) \
  ori x0, addr, 1+(blocks*64)

#define prefetch_w_block(addr, blocks) \
    ori x0, addr, 3+(blocks*64)


#define prefetch_none(addr) \
    ori x0, addr, 5


.globl _start
_start:



// Test copy speed without any prefetch
    li x11, 0x40010000
    mv x12, x11
    li x1, 0x1FF800
    add x12, x12, x1
    .align 6
    csrr x9, mcycle
    li x1, 0x10000
cpy_loop:
    //LOAD x2, WORD*0(x11)
    //LOAD x3, WORD*1(x11)
    //LOAD x4, WORD*2(x11)
    //LOAD x5, WORD*3(x11)
    STORE x2, WORD*0(x12)
    STORE x3, WORD*1(x12)
    STORE x4, WORD*2(x12)
    STORE x5, WORD*3(x12)
    addi x11, x11, WORD*4
    addi x12, x12, WORD*4
    addi x1, x1, -1
    bnez x1, cpy_loop
    j _start

