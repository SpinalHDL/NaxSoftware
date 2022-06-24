.globl _start
_start:

#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#include "../../driver/privileged.h"
#define VECTOR_DATA 0x90000000

#define MSTATUS_FS_INITIAL (1 << 13)
#define MSTATUS_FS_CLEAN (2 << 13)
#define MSTATUS_FS_DIRTY (3 << 13)
#define MSTATUS_FS_MASK (3 << 13)



    csrr x1, misa
    li x1, MSTATUS_FS_MASK
    csrc mstatus, x1
    li x1, MSTATUS_FS_INITIAL
    csrs mstatus, x1
    csrwi frm, 1

    li x1, VECTOR_DATA
    li x2, VECTOR_DATA-400
#include "randomRvfd.h"
    j pass



pass:
    nop
    j pass

fail:
    nop
    j fail


.align 4
nan_boxing_data:
.word 0x3f801234