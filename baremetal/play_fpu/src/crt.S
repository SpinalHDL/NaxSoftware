.globl _start
_start:

#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#define delay_long() nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop

#define MSTATUS_FS_INITIAL (1 << 13)
#define MSTATUS_FS_CLEAN (2 << 13)
#define MSTATUS_FS_DIRTY (3 << 13)
#define MSTATUS_FS_MASK (3 << 13)

    csrr x1, misa
    li x1, MSTATUS_FS_MASK
    csrc mstatus, x1
    li x1, MSTATUS_FS_INITIAL
    csrs mstatus, x1
    la x1, data
    fld f1, 0(x1)
    fsd f1, 8(x1)
    ld x1, 8(x1)
    li x2, 0x3FF0000000000000
    bne x1, x2, fail


    la x1, one
    fld f1, 0(x1)
    la x1, two
    fld f2, 0(x1)
    la x1, three
    fld f3, 0(x1)
    la x1, sub0001
    fld f4, 0(x1)
    la x1, sub00000001
    fld f5, 0(x1)
    la x1, onedotfve
    fld f6, 0(x1)
    la x1, minusonedotfve
    fld f7, 0(x1)

    delay_long();

    fsqrt.d f10,f1
    fsqrt.d f10,f2
    fsqrt.d f10,f3

//    fmul.d f10,f1,f2
//    fmul.d f10,f10,f2
//    fmul.d f10,f3,f2
//    fmul.d f10,f10,f2
//    fmul.d f10,f3,f3
//    fmul.d f10,f4,f2
//    fmul.d f10,f5,f2
//    fmul.d f10,f5,f3
//    fmul.d f10,f10,f3
//    fmul.d f10,f10,f3
//    fmul.d f10,f10,f3
//    fmul.d f10,f10,f3
//    fmul.d f10,f10,f3
//    fmul.d f10,f10,f3
//    fmul.d f10,f10,f3
//
//    fmv.x.d	a0,f1
//    fmv.x.d	a1,f2
//    fmul.d f1, f1, f2

//    fadd.d f10,f6,f3
//    fadd.d f10,f2,f7
//    fadd.d f10,f1,f7
//    fadd.d f10,f7,f2
//    fadd.d f10,f7,f1
//    fsub.d f10,f2,f7
//    fsub.d f10,f1,f7
//    fsub.d f10,f7,f2
//    fsub.d f10,f7,f1
//    fmadd.d f10, f3, f3, f6

pass:
    nop
    j pass

fail:
    nop
    j fail

.align 6
data:
    .dword 0x3FF0000000000000
    .dword 0xFFFFFFFFFFFFFFFF
one:
    .dword 0x3FF0000000000000
two:
    .dword 0x4000000000000000
three:
    .dword 0x4008000000000000
sub0001:
    .dword 0x0001000000000000
sub00000001:
    .dword 0x0000100000000000

onedotfve:
    .dword 0x3ff8000000000000
minusonedotfve:
    .dword 0xbff8000000000000
