.globl _start
_start:

#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#include "../../driver/custom_asm.h"
#include "../../driver/privileged.h"
#define opcode_CFU_IMM(opcode, func3, rd, rs1, rs2)   \
.word ((opcode) | (regnum_##rd << 7) | (regnum_##rs1 << 15) | ((func3) << 12) | ((rs2) << 24));

    //Test 1

    trap_setup
    opcode_R(CUSTOM0, 0x0, 0x00, x3, x1, x2) //x3 = cfu(x1, x2)
    trap_handle

    la x1, fail
    csrw mtvec, x1

    li x1, 0x80000000
    csrs 0xBC0, x1
    opcode_R(CUSTOM0, 0x6, 0x00, x2, x1, x1) //x3 = cfu(x1, x2)
.align 6
    opcode_R(CUSTOM0, 0x6, 0x00, x2, x1, x1) //x3 = cfu(x1, x2)
    j test1
    opcode_R(CUSTOM0, 0x7, 0x00, x2, x1, x1) //x3 = cfu(x1, x2)

test1:
    li x1, 0x01234567
    li x2, 0x01FF01FF
    opcode_R(CUSTOM0, 0x2, 0x00, x3, x1, x2)
    li x5, 0x01234567+0x01FF01FF+0x2
    bne x3, x5, fail

test2:
    li x1, 0x01234567
    opcode_CFU_IMM(CUSTOM1, 0x2, x3, x1, 0x2B)
    li x5, 0x01234567+0x2+0x2B
    bne x3, x5, fail

test3:
    li x1, 0
    li x2, 0
    li x3, 0
    li x4, 0
    li x5, 1
    li x6, 1000
1:
    opcode_R(CUSTOM0, 0x0, 0x00, x1, x1, x5)
    opcode_R(CUSTOM0, 0x0, 0x00, x2, x2, x5)
    opcode_R(CUSTOM0, 0x0, 0x00, x3, x3, x5)
    opcode_R(CUSTOM0, 0x0, 0x00, x4, x4, x5)
    opcode_R(CUSTOM0, 0x0, 0x00, x1, x1, x5)
    opcode_R(CUSTOM0, 0x0, 0x00, x2, x2, x5)
    opcode_R(CUSTOM0, 0x0, 0x00, x3, x3, x5)
    opcode_R(CUSTOM0, 0x0, 0x00, x4, x4, x5)
    addi x6, x6, -1
    bnez x6, 1b
    li x6, 2000
    bne x1, x6, fail
    bne x2, x6, fail
    bne x3, x6, fail
    bne x4, x6, fail


    j pass
pass:
    j pass
fail:
    j fail



#define check_R(opcode, func3, func7, rd, rs1, rs2) \
    li x1, rs1;\
    li x2, rs2;\
    opcode_R(opcode, func3, func7, x3, x1, x2);\
    li x5, rd;\
    bne x3, x5, fail;
//check_R(CUSTOM0, 0x0, 0x00, 0x3224766, 0x01234567, 0x01FF01FF)
