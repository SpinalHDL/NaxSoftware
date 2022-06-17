.globl _start
_start:

/*
cmd="obj_dir/VNaxRiscv --load-bin ../../../../ext/NaxSoftware/baremetal/fpu_test/vector/f64.bin,0x90000000 --load-u32 0x50000,0xA0000000 --load-u32 0x0,0xA0000004 --load-elf ../../../../ext/NaxSoftware/baremetal/fpu_test/build/rv64imafd/fpu_test.elf --pass-symbol pass --fail-symbol fail --seed 72255458"
 --trace --trace-ref --spike-debug --trace-gem5 --stats-print --progress 1
make compile && obj_dir/VNaxRiscv --load-bin ../../../../ext/NaxSoftware/baremetal/fpu_test/vector/f64.bin,0x90000000 --load-u32 0x50000,0xA0000000 --load-u32 0x0,0xA0000004 --load-elf ../../../../ext/NaxSoftware/baremetal/fpu_test/build/rv64imafd/fpu_test.elf --pass-symbol pass --fail-symbol fail --seed 72255458 --trace --trace-ref --spike-debug --trace-gem5
*/

#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#define VECTOR_DATA 0x90000000
#define TEST_COUNT  0xA0000000
#define TEST_KIND   0xA0000004

#define MSTATUS_FS_INITIAL (1 << 13)
#define MSTATUS_FS_CLEAN (2 << 13)
#define MSTATUS_FS_DIRTY (3 << 13)
#define MSTATUS_FS_MASK (3 << 13)



#define test_pre(id) ;\
    li x4, id       ;\
    bne x3, x4, 2f  ;\
1:                  ;\

#define test_post(bytes) ;\
    addi x2, x2, bytes  ;\
    addi x1, x1, -1 ;\
    bnez x1, 1b     ;\
    j pass          ;\
2:                  ;\

#define test_d_d_r(id,op) ;\
    test_pre(id)    ;\
    fld f1, 0(x2)   ;\
    op f10, f1, rtz ;\
    op f10, f1, rmm ;\
    op f10, f1, rdn ;\
    op f10, f1, rup ;\
    op f10, f1, rne ;\
    test_post(8)    ;\

#define test_x_f(id, op) ;\
    test_pre(id)    ;\
    flw f1, 0(x2)   ;\
    op x10, f1 ;\
    test_post(4)    ;\

#define test_d_d_d_r(id, op) ;\
    test_pre(id)    ;\
    fld f1, 0(x2)   ;\
    fld f2, 8(x2)   ;\
    op f10, f1, f2, rtz ;\
    op f10, f1, f2, rmm ;\
    op f10, f1, f2, rdn ;\
    op f10, f1, f2, rup ;\
    op f10, f1, f2, rne ;\
    test_post(16)    ;\

#define test_d_d_d_d_r(id, op) ;\
    test_pre(id)    ;\
    fld f1, 0(x2)   ;\
    fld f2, 8(x2)   ;\
    fld f3, 16(x2)   ;\
    op f10, f1, f2, f3, rtz ;\
    op f10, f1, f2, f3, rmm ;\
    op f10, f1, f2, f3, rdn ;\
    op f10, f1, f2, f3, rup ;\
    op f10, f1, f2, f3, rne ;\
    test_post(24)    ;\

#define test_d_d_d(id, op) ;\
    test_pre(id)    ;\
    fld f1, 0(x2)   ;\
    fld f2, 8(x2)   ;\
    op f10, f1, f2 ;\
    test_post(16)    ;\

#define test_x_d_d(id, op) ;\
    test_pre(id)    ;\
    fld f1, 0(x2)   ;\
    fld f2, 8(x2)   ;\
    op x10, f1, f2 ;\
    test_post(16)    ;\

#define test_x_d(id, op) ;\
    test_pre(id)    ;\
    fld f1, 0(x2)   ;\
    op x10, f1 ;\
    test_post(8)    ;\




#define test_s_s_s_r(id, op) ;\
    test_pre(id)    ;\
    flw f1, 0(x2)   ;\
    flw f2, 8(x2)   ;\
    op f10, f1, f2, rtz ;\
    op f10, f1, f2, rmm ;\
    op f10, f1, f2, rdn ;\
    op f10, f1, f2, rup ;\
    op f10, f1, f2, rne ;\
    test_post(8)    ;\

#define test_s_s_s_s_r(id, op) ;\
    test_pre(id)    ;\
    flw f1, 0(x2)   ;\
    flw f2, 8(x2)   ;\
    flw f3, 16(x2)   ;\
    op f10, f1, f2, f3, rtz ;\
    op f10, f1, f2, f3, rmm ;\
    op f10, f1, f2, f3, rdn ;\
    op f10, f1, f2, f3, rup ;\
    op f10, f1, f2, f3, rne ;\
    test_post(12)    ;\

#define test_s_s_s(id, op) ;\
    test_pre(id)    ;\
    flw f1, 0(x2)   ;\
    flw f2, 8(x2)   ;\
    op f10, f1, f2 ;\
    test_post(8)    ;\

#define test_x_s_s(id, op) ;\
    test_pre(id)    ;\
    flw f1, 0(x2)   ;\
    flw f2, 8(x2)   ;\
    op x10, f1, f2 ;\
    test_post(8)    ;\

#define test_x_s(id, op) ;\
    test_pre(id)    ;\
    flw f1, 0(x2)   ;\
    op x10, f1 ;\
    test_post(4)    ;\


#define test_s_s_r(id,op) ;\
    test_pre(id)    ;\
    flw f1, 0(x2)   ;\
    op f10, f1, rtz ;\
    op f10, f1, rmm ;\
    op f10, f1, rdn ;\
    op f10, f1, rup ;\
    op f10, f1, rne ;\
    test_post(4)    ;\

#define test_f_w_r(id, op) ;\
    test_pre(id)    ;\
    lw x20, 0(x2)   ;\
    op f10, x20, rtz ;\
    op f10, x20, rmm ;\
    op f10, x20, rdn ;\
    op f10, x20, rup ;\
    op f10, x20, rne ;\
    test_post(4)    ;\

#define test_f_w(id, op) ;\
    test_pre(id)    ;\
    lw x20, 0(x2)   ;\
    op f10, x20 ;\
    test_post(4)    ;\


#define test_x_d_r(id, op) ;\
    test_pre(id)    ;\
    fld f1, 0(x2)   ;\
    op x10, f1, rtz ;\
    op x10, f1, rmm ;\
    op x10, f1, rdn ;\
    op x10, f1, rup ;\
    op x10, f1, rne ;\
    test_post(8)    ;\

#define test_x_s_r(id, op) ;\
    test_pre(id)    ;\
    flw f1, 0(x2)   ;\
    op x10, f1, rtz ;\
    op x10, f1, rmm ;\
    op x10, f1, rdn ;\
    op x10, f1, rup ;\
    op x10, f1, rne ;\
    test_post(4)    ;\


#define test_x_d(id, op) ;\
    test_pre(id)    ;\
    fld f1, 0(x2)   ;\
    op x10, f1 ;\
    test_post(8)    ;\

#define test_f_l_r(id, op) ;\
    test_pre(id)    ;\
    ld x20, 0(x2)   ;\
    op f10, x20, rtz ;\
    op f10, x20, rmm ;\
    op f10, x20, rdn ;\
    op f10, x20, rup ;\
    op f10, x20, rne ;\
    test_post(8)    ;\

#define test_f_s(id, op) ;\
    test_pre(id)    ;\
    flw f1, 0(x2)   ;\
    op f10, f1 ;\
    test_post(4)    ;\

#define test_f_d_r(id, op) ;\
    test_pre(id)    ;\
    fld f1, 0(x2)   ;\
    op f10, f1, rtz ;\
    op f10, f1, rmm ;\
    op f10, f1, rdn ;\
    op f10, f1, rup ;\
    op f10, f1, rne ;\
    test_post(8)    ;\

#define test_f_l(id, op) ;\
    test_pre(id)    ;\
    ld x20, 0(x2)   ;\
    op f10, x20      ;\
    test_post(8)    ;\

#define test_f_w(id, op) ;\
    test_pre(id)    ;\
    lw x20, 0(x2)   ;\
    op f10, x20      ;\
    test_post(4)    ;\

#define test_f_x(id, op) ;\
    test_pre(id)    ;\
    ld x20, 0(x2)   ;\
    op f10, x20      ;\
    test_post(8)    ;\


    csrr x1, misa
    li x1, MSTATUS_FS_MASK
    csrc mstatus, x1
    li x1, MSTATUS_FS_INITIAL
    csrs mstatus, x1
    csrwi frm, 7

    li x1, TEST_COUNT
    lw x1, 0(x1)
    li x2, VECTOR_DATA
    li x3, TEST_KIND
    lw x3, 0(x3)

    test_x_f(0, fmv.x.w)

    test_d_d_d_r(1, fadd.d)
    test_d_d_d_r(2, fsub.d)
    test_d_d_d_r(3, fmul.d)
    test_d_d_d_r(4, fdiv.d)
    test_d_d_r(5, fsqrt.d)

    test_d_d_d_d_r(6, fmadd.d)
    test_d_d_d_d_r(7, fmsub.d)
    test_d_d_d_d_r(8, fnmadd.d)
    test_d_d_d_d_r(9, fnmsub.d)

    test_d_d_d(10, fsgnj.d)
    test_d_d_d(11, fsgnjn.d)
    test_d_d_d(12, fsgnjx.d)

    test_d_d_d(13, fmin.d)
    test_d_d_d(14, fmax.d)

    test_x_d_d(15, fle.d)
    test_x_d_d(16, feq.d)
    test_x_d_d(17, flt.d)

    test_x_d  (18, fclass.d)

    test_f_w(19, fcvt.d.wu)
    test_f_w(20, fcvt.d.w)
    test_x_d_r(21, fcvt.wu.d)
    test_x_d_r(22, fcvt.w.d)
    test_f_s(23, fcvt.d.s)
    test_f_d_r(24, fcvt.s.d)

    test_x_d(25, fmv.x.d)
    test_f_x(26, fmv.d.x)

    test_f_l_r(27, fcvt.d.lu)
    test_f_l_r(28, fcvt.d.l)
    test_x_d_r(29, fcvt.lu.d)
    test_x_d_r(30, fcvt.l.d)


    test_f_x(31, fmv.s.x)



    test_s_s_s_r(101, fadd.s)
    test_s_s_s_r(102, fsub.s)
    test_s_s_s_r(103, fmul.s)
    test_s_s_s_r(104, fdiv.s)
    test_s_s_r  (105, fsqrt.s)

    test_s_s_s_s_r(106, fmadd.s)
    test_s_s_s_s_r(107, fmsub.s)
    test_s_s_s_s_r(108, fnmadd.s)
    test_s_s_s_s_r(109, fnmsub.s)

    test_s_s_s(110, fsgnj.s)
    test_s_s_s(111, fsgnjn.s)
    test_s_s_s(112, fsgnjx.s)

    test_s_s_s(113, fmin.s)
    test_s_s_s(114, fmax.s)

    test_x_s_s(115, fle.s)
    test_x_s_s(116, feq.s)
    test_x_s_s(117, flt.s)

    test_x_s  (118, fclass.s)

    test_f_w_r(119, fcvt.s.wu)
    test_f_w_r(120, fcvt.s.w)
    test_x_s_r(121, fcvt.wu.s)
    test_x_s_r(122, fcvt.w.s)

    test_f_l_r(127, fcvt.s.lu)
    test_f_l_r(128, fcvt.s.l)
    test_x_s_r(129, fcvt.lu.s)
    test_x_s_r(130, fcvt.l.s)

    test_f_l(200, fcvt.d.wu)
    test_f_l(201, fcvt.d.w)
    test_f_l_r(202, fcvt.s.wu)
    test_f_l_r(203, fcvt.s.w)

    //nan-boxing
    test_pre(300)
    li x20, 0x3f801234
    fmv.d.x f1, x20
    fmv.x.d x20, f1
    fsgnj.s f2, f1, f1
    fmv.x.d x20, f2
    fadd.s f2, f1, f1, rup
    fmv.x.d x20, f2
    j pass
2:
    
    j fail

pass:
    nop
    j pass

fail:
    nop
    j fail

