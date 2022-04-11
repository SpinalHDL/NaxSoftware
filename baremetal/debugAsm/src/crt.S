.globl _start
_start:

#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#include "../../driver/privileged.h"



    li a1, 0x10
    li a2, 0x11
    add a1, a1, a2

    trap_setup
    lw x0, 1(x0)
    trap_handle

    li a1, 0x12
    nop

pass:
   j pass

fail:
    j fail

/*
load_image /media/data/open/riscv/VexRiscvOoo/ext/NaxSoftware/baremetal/debugAsm/build/rv32im/debugAsm.bin 0x80000000
reg pc 0x80000000
step; step; step; step; step; step; step; step;
echo [reg pc]
step
echo [reg pc]
echo [reg mepc]


*/

