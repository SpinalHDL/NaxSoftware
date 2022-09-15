#include <riscv.h>

void machine_to_user(u64 func, u64 user_stack);
//void  __attribute__ ((noinline)) machine_to_user(u64 func){
//  u64 machine_sp = register_read(sp);
//  u64 machine_ra = register_read(ra);
//  csr_set(mstatus, MSTATUS_MPP_USER);
//  csr_write(mepc, func);
//  asm("               ;\
//    csrw mscratch, ra ;\
//    la a0, 2f         ;\
//    csrw mtvec, a0    ;\
//    la ra, 1f         ;\
//    mret              ;\
//1:                    ;\
//    ecall             ;\
//2:                    ;\
//    csrr ra, mscratch ;\
//  ");
//}

