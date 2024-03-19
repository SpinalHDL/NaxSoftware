.globl _start
_start:

#define flush_cache() \
  .word 0x500F

    //test resume / break / read register
    li a0, 0xc0e70d5d; ebreak
    li a0, 0xca755a1b; ebreak

    //test step
    li a0, 0x4dca2c83
    li a0, 0x5517b9ee

    //Transmit the data address to the debugger
    la a0, data; ebreak

    //Test writing memory and cache flushes
    li a1, 0x44556677; sw a1, 4(a0); ebreak
    /*flush_cache();*/ ebreak

    //Transmit the breakX address to the debugger
    la a0, break1; la a1, break2; la a2, break3;la a3, lb1; la a4, sb1; la a5, data; ebreak

    li a0, 5
    addi a0, a0, 1
    nop
    nop
    addi a0, a0, 2
    addi a0, a0, 3
    addi a0, a0, 4
break1:
    addi a0, a0, 5
    nop
    nop
    nop
    addi a0, a0, 6
break2:
    addi a0, a0, 7

    li a1, 0x00000000
    li a2, 0x10000000
    li a3, 0x20000000

    la x10, data
    li x1, 0x40302010
    sw x1, 0(x10)
break3:
    addi a1, a1, 1
    addi a2, a2, 1
    addi a3, a3, 1
    li a4, 0
    li a5, 0
    li a6, 0
    lb a4, 0(x10)
lb1:
    lb a5, 1(x10) //wp 0x80001001 1 r
    lb a6, 2(x10)
    addi a4, a4, 1
    addi a5, a5, 1
    addi a6, a6, 1
    sb a4, 0(x10)
sb1:
    sb a5, 1(x10)
    sb a6, 2(x10)
    j break3

    j fail


fail:
    j fail
pass:
    j pass

.align 4
data:
  .word 0x523ab3f1
  .word 0xf1ad9f75
  .word 0x18d5ea3a
  .word 0x989d6630
  .word 0x81d7daac
  .word 0xe0817d8d
  .word 0xb775ab3d
  .word 0xd15f2ab1
  .word 0xdee4185b
  .word 0x842dd720
  .word 0x2009df49
  .word 0x4a36fba3
  .word 0x50e7ddb2
  .word 0x35d702f1
  .word 0x78e312ad
  .word 0x44667924
  .word 0x5aab255b
  .word 0xa0fcdba0
  .word 0x5a127285
  .word 0xf201fe9f
  .word 0x86fb587a
  .word 0x2d7b0b80
  .word 0x45cb7518
  .word 0xb95efa65
  .word 0xfad6386d
  .word 0xed556153
  .word 0x281a058d
  .word 0x2c54bf18
  .word 0x6eef3902
  .word 0x3f73d27b
  .word 0xaebd78cf
  .word 0x56613ca0
  .word 0xae52c261
  .word 0xc1103ee6
  .word 0xab6c9286
  .word 0xda5ed76b
  .word 0x9c610437
  .word 0xc4bda8e3
  .word 0x3d4c1d0d
  .word 0x210aa20f
  .word 0xf969d1a9
  .word 0x5223af43
  .word 0x6a8d2575
  .word 0xa393005d
  .word 0xb13a4839
  .word 0xe0ac26b1
  .word 0xb7b00603
  .word 0xc7dae199
  .word 0xf95664ee
  .word 0xb492940e
  .word 0x74354d6d
  .word 0x62880d84
  .word 0xab917f21
  .word 0x634b31a1
  .word 0x5d37b80c
  .word 0x089b10af
  .word 0x6eb7b786
  .word 0x265033fe
  .word 0xbe4ed022
  .word 0x1a3d2e0c
  .word 0xb85256af
  .word 0xef90d370
  .word 0x43eef948
  .word 0xcfd4f44d

