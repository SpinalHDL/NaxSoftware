.globl _start
_start:

#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#include "../../driver/privileged.h"
#define VECTOR_DATA 0x90000000
#define TEST_COUNT  0xA0000000
#define TEST_KIND   0xA0000004

#define MSTATUS_FS_INITIAL (1 << 13)
#define MSTATUS_FS_CLEAN (2 << 13)
#define MSTATUS_FS_DIRTY (3 << 13)
#define MSTATUS_FS_MASK (3 << 13)



    csrr x1, misa
    li x1, MSTATUS_FS_MASK
    csrc mstatus, x1
    li x1, MSTATUS_FS_INITIAL
    csrs mstatus, x1
    csrwi frm, 7

#if __riscv_flen == 64 && __riscv_xlen == 64
    //nan-boxing
    la x20, nan_boxing_data
    fld f1, 0(x20)
    fmv.x.d x20, f1
    fsgnj.s f2, f1, f1
    fmv.x.d x20, f2
    fadd.s f2, f1, f1, rup
    fmv.x.d x20, f2
#endif

    //dirty fpu
    li x1, MSTATUS_FS_MASK
    csrc mstatus, x1
    li x1, MSTATUS_FS_INITIAL
    csrs mstatus, x1
    csrr x1, mstatus
    csrr x1, fcsr
    fmv.w.x f1, x20
    csrr x1, mstatus
    csrr x1, fcsr

    //dirty csr
    li x1, MSTATUS_FS_MASK
    csrc mstatus, x1
    li x1, MSTATUS_FS_INITIAL
    csrs mstatus, x1
    csrr x1, mstatus
    csrr x1, fcsr
    csrw fflags, x0
    csrr x1, mstatus
    csrr x1, fcsr

    //bad rounding trap
    machine_setup_trap
    csrwi frm, 7
    li x1, -1
    fcvt.s.w f1, x1, rup
    csrwi frm, 2
    fcvt.s.w f1, x1
    csrwi frm, 7
    fcvt.s.w f1, x1
    machine_handle_trap

    //fpu disabled =>  trap
    fcvt.s.w f1, x1, rup
    machine_setup_trap
    li x1, MSTATUS_FS_MASK
    csrc mstatus, x1
    fcvt.s.w f1, x1, rup
    machine_handle_trap

    machine_setup_trap
    csrr x1, fcsr
    machine_handle_trap

    machine_setup_trap
    csrr x1, frm
    machine_handle_trap

    machine_setup_trap
    csrr x1, fflags
    machine_handle_trap


    j pass

    
    j fail

pass:
    nop
    j pass

fail:
    nop
    j fail


.align 4
nan_boxing_data:
.word 0x3f801234