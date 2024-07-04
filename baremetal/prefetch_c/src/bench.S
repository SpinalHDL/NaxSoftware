#if __riscv_xlen == 64
#define STORE sd
#define LOAD ld
#define WORD 8
#define WORD_LOG2 3
#else
#define STORE sw
#define LOAD lw
#define WORD 4
#define WORD_LOG2 2
#endif


#define prefetch_r(addr) \
  ori x0, addr, 1

#define prefetch_w(addr) \
    ori x0, addr, 3

#define prefetch_r_block(addr, blocks) \
  ori x0, addr, 1+(blocks*64)

#define prefetch_w_block(addr, blocks) \
    ori x0, addr, 3+(blocks*64)


#define prefetch_none(addr) \
    ori x0, addr, 5


.align 6
.globl load_1x
load_1x:
    add t0, a0, a1
1:
    LOAD x0, WORD*0(a0)
    addi a0, a0, WORD
    blt a0, t0, 1b
    ret

.align 6
.globl load_4x
load_4x:
    add t0, a0, a1
1:
    LOAD x0, WORD*0(a0)
    LOAD x0, WORD*1(a0)
    LOAD x0, WORD*2(a0)
    LOAD x0, WORD*3(a0)
    addi a0, a0, WORD*4
    blt a0, t0, 1b
    ret

.align 6
.globl load_16x
load_16x:
    add t0, a0, a1
1:
    LOAD x0, WORD*0(a0)
    LOAD x0, WORD*1(a0)
    LOAD x0, WORD*2(a0)
    LOAD x0, WORD*3(a0)
    LOAD x0, WORD*4(a0)
    LOAD x0, WORD*5(a0)
    LOAD x0, WORD*6(a0)
    LOAD x0, WORD*7(a0)
    LOAD x0, WORD*8(a0)
    LOAD x0, WORD*9(a0)
    LOAD x0, WORD*10(a0)
    LOAD x0, WORD*11(a0)
    LOAD x0, WORD*12(a0)
    LOAD x0, WORD*13(a0)
    LOAD x0, WORD*14(a0)
    LOAD x0, WORD*15(a0)
    addi a0, a0, WORD*16
    blt a0, t0, 1b
    ret


.align 6
.globl store_1x
store_1x:
    add t0, a0, a1
1:
    STORE x0, WORD*0(a0)
    addi a0, a0, WORD*1
    blt a0, t0, 1b
    ret

.align 6
.globl store_4x
store_4x:
    add t0, a0, a1
1:
    STORE x0, WORD*0(a0)
    STORE x0, WORD*1(a0)
    STORE x0, WORD*2(a0)
    STORE x0, WORD*3(a0)
    addi a0, a0, WORD*4
    blt a0, t0, 1b
    ret

.align 6
.globl store_16x
store_16x:
    add t0, a0, a1
1:
    STORE x0, WORD*0(a0)
    STORE x0, WORD*1(a0)
    STORE x0, WORD*2(a0)
    STORE x0, WORD*3(a0)
    STORE x0, WORD*4(a0)
    STORE x0, WORD*5(a0)
    STORE x0, WORD*6(a0)
    STORE x0, WORD*7(a0)
    STORE x0, WORD*8(a0)
    STORE x0, WORD*9(a0)
    STORE x0, WORD*10(a0)
    STORE x0, WORD*11(a0)
    STORE x0, WORD*12(a0)
    STORE x0, WORD*13(a0)
    STORE x0, WORD*14(a0)
    STORE x0, WORD*15(a0)
    addi a0, a0, WORD*16
    blt a0, t0, 1b
    ret


.align 6
.globl load2_store1_4x
load2_store1_4x:
    mv t0, a0
    add a0, a0, a1
    addi a0, a0, 1024

    mv t1, a0
    add a0, a0, a1
    addi a0, a0, 1024

    mv t2, a0
    add a0, a0, a1; mv t3, a0
    addi a0, a0, 1024
1:
    LOAD x0, WORD*0(t0)
    LOAD x0, WORD*1(t0)
    LOAD x0, WORD*2(t0)
    LOAD x0, WORD*3(t0)
    LOAD x0, WORD*0(t1)
    LOAD x0, WORD*1(t1)
    LOAD x0, WORD*2(t1)
    LOAD x0, WORD*3(t1)
    STORE x0, WORD*0(t2)
    STORE x0, WORD*1(t2)
    STORE x0, WORD*2(t2)
    STORE x0, WORD*3(t2)
    addi t0, t0, WORD*4
    addi t1, t1, WORD*4
    addi t2, t2, WORD*4
    blt t2, t3, 1b
    ret

.align 6
.globl load_1x_416s
load_1x_416s:
    li a2, 416/WORD
    mul a1, a1, a2
    add t0, a0, a1
1:
    LOAD x0, WORD*0(a0)
    addi a0, a0, 416
    blt a0, t0, 1b
    ret


.align 6
.globl load_1x_512s
load_1x_512s:
    li a2, 512/WORD
    mul a1, a1, a2
    add t0, a0, a1
1:
    LOAD x0, WORD*0(a0)
    addi a0, a0, 512
    blt a0, t0, 1b
    ret


.align 6
.globl store_1x_512s
store_1x_512s:
    li a2, 512/WORD
    mul a1, a1, a2
    add t0, a0, a1
1:
    STORE x0, WORD*0(a0)
    addi a0, a0, 512
    blt a0, t0, 1b
    ret



.align 6
.globl load_1x_512ms
load_1x_512ms:
    li a2, 512/WORD
    mv t0, a0
    mul a1, a1, a2
    add a0, a0, a1
    addi a0, a0, -512
1:
    LOAD x0, WORD*0(a0)
    addi a0, a0, -512
    bgt a0, t0, 1b
    add a0, a0, a1
    ret


.align 6
.globl store_1x_512ms
store_1x_512ms:
    li a2, 512/WORD
    mv t0, a0
    mul a1, a1, a2
    add a0, a0, a1
    addi a0, a0, -512
1:
    STORE x0, WORD*0(a0)
    addi a0, a0, -512
    bgt a0, t0, 1b
    add a0, a0, a1
    ret
