#include <riscv_asm.h>

.global machine_to_user

machine_to_user:
  addi sp, sp,-8
  sd   ra, 0(sp)
  csrw mscratch, sp
  mv sp, a1
  li t0, MSTATUS_MPP_USER
  csrs mstatus, t0
  csrw mepc, a0
  la a0, 2f
  csrw mtvec, a0
  la ra, 1f
  mret
1:
  ecall
2:
  csrr sp, mscratch
  ld   ra, 0(sp)
  addi sp, sp, 8
  ret

