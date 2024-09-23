.globl _start



#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#include "../../driver/privileged.h"

#define MMU_TABLE_0 0x80001000
#define MMU_TABLE_1 0x80002000
#define MMU_TABLE_2 0x80003000
#define MMU_TABLE_3 0x80004000
#define MMU_TABLE_4 0x80005000
#define MMU_TABLE_5 0x80006000
#define MEMORY_0 0x80007000

#define setNext(table, level, virtual, next) \
    li x1, table + ((virtual >> (level*9+9)) & 0xFF8); \
    li x2, next; srli x2, x2, 2; ori x2, x2, 0x01; \
    sd x2, 0(x1);

#define setLeaf(table, level, virtual, physical, flags) \
    li x1, table + ((virtual >> (level*9+9)) & 0xFF8); \
    li x2, physical; srli x2, x2, 2; li x3, flags; or x2, x2, x3; \
    sd x2, 0(x1);

#define disableMmu() \
    csrw satp, x0; \
    fence.i

#define enableMmu(root) \
    li x1, root; srli x1, x1, 12; \
    li x2, 0x8 << 60;   or x1, x1, x2; \
    sfence.vma; \
    csrw satp, x1; \
    fence.i

ROM_SUPER_0:

_start:
    trap_setup
    ecall
    trap_handle

   // # Flipping just the MSB should result in an illegal address for RV64.
   // trap_setup
   // la t2, fail
   // li t0, 1 << (__riscv_xlen - 1)
   // xor t0, t0, t2
   // jalr t2, t0
   // j fail
   // trap_handle_no_mtval_mepc

   // # A load to an illegal address should not commit.
   // trap_setup
   // li t0, 1 << (__riscv_xlen - 1)
   // xor t0, t0, t2
   // lb t2, (t0)
   // j fail
   // trap_handle_no_mtval_mepc

    li x1, -1
    csrw mideleg, x1
    csrw medeleg, x1

//Setup machine mode trap that redirect to supervisor
    trap_setup
    j redirect_setuped
    trap_handle
    csrr x1, stvec
    machine_to_supervisor_x1
redirect_setuped:

    machine_to_supervisor
    supervisor_trap_failure

    //Test giga leaf
    setLeaf(MMU_TABLE_0, 2, 0x80000000, 0x80000000, 0xCF)
    enableMmu(MMU_TABLE_0)

    li x1, 0x1234
    auipc x1, 0
    andi x1, x1, -3
    lw x1, 0(x1)

    //Test mega leaf
    setLeaf(MMU_TABLE_1, 1, 0x80000000, 0x80000000, 0xCF)
    setNext(MMU_TABLE_0, 2, 0x80000000, MMU_TABLE_1)
    sfence.vma

    li x1, 0x1234
    auipc x1, 0
    andi x1, x1, -3
    lw x1, 0(x1)

    //Test kilo leaf
    setLeaf(MMU_TABLE_2, 0, 0x80000000, 0x80000000, 0xCF)
    setNext(MMU_TABLE_1, 1, 0x80000000, MMU_TABLE_2)
    //setNext(MMU_TABLE_0, 2, 0x80000000, MMU_TABLE_1)
    sfence.vma

    li x1, 0x1234
    auipc x1, 0
    andi x1, x1, -3
    lw x1, 0(x1)


    //Test page fault RVC
test_rvc_fault:
    disableMmu()
    setLeaf(MMU_TABLE_2, 0, MEMORY_0, MEMORY_0, 0xCF)
   // setNext(MMU_TABLE_1, 1, MEMORY_0, MMU_TABLE_2)
   // setNext(MMU_TABLE_0, 2, MEMORY_0, MMU_TABLE_1)
    enableMmu(MMU_TABLE_0)
    sfence.vma
    li x1, MEMORY_0 + 0xFFE
    li x2, 0x13 //NOP
    sh x2, 0(x1)
    supervisor_setup_trap
test_rvc_trap_test:
    li x1, MEMORY_0 + 0xFFE
    jr x1
    supervisor_handle_trap
test_rvc_done:
    supervisor_trap_failure

    //Setup mega leaf for access to the tlb setup
    disableMmu()
    setLeaf(MMU_TABLE_1, 1, 0x80000000, 0x80000000, 0xCF)
    setNext(MMU_TABLE_0, 2, 0x80000000, MMU_TABLE_1)
    sfence.vma
    enableMmu(MMU_TABLE_0)

    supervisor_setup_trap
    ecall
    supervisor_handle_trap

    //test
    #include "mepc_mtval.h"
    disableMmu()
    #include "mepc_mtval.h"

    j pass

pass:
    nop

fail:
    nop


