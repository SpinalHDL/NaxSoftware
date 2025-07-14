.globl _start
_start:

#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#include "../../driver/custom_asm.h"
#include "../../driver/privileged.h"
#define delay_long() nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop

#define machine_read  \
    nop

#define clean(rs1) .word(0x10200F | (regnum_##rs1 << 15))
#define flush(rs1) .word(0x20200F | (regnum_##rs1 << 15))
#define invalidate(rs1) .word(0x00200F | (regnum_##rs1 << 15))

#define cbm_address(address) \
  li x1, CBM_ADDRESS; \
  la x2, address; \
  sw x2, 0(x1);

#define cbm_check_data(value) \
  li x1, CBM_DATA; \
  li x2, value; \
  sw x2, 0(x1);


#define cbm_check(address, value) \
  li x1, CBM_ADDRESS; \
  la x2, address; \
  sw x2, 0(x1); \
  li x1, CBM_DATA; \
  li x2, value; \
  sw x2, 0(x1);


test_io:
    li x1, IO_FAULT_ADDRESS
    clean(x1)  //Should have no side effects
    flush(x1)
    invalidate(x1)


test_empty_line:
    la x1, data
    clean(x1)  //Should have no side effects
    flush(x1)
    invalidate(x1)

test_missaligned:
    la x1, data+1
    clean(x1)  //Should have no side effects
    flush(x1)
    invalidate(x1)


test_tb_cbm_functionality: // refill
  csrwi mcause, 1
  // Read the memory through the CPU
  la x1, data
  lw x3, 0(x1)

  //Ask the TB to check that the memory match
  li x1, CBM_ADDRESS
  la x2, data
  sw x2, 0(x1)
  li x1, CBM_DATA
  sw x3, 0(x1)

test_clean_dirty_line:  // writeback
  csrwi mcause, 2
  cbm_address(data)
  la x1, data
  li x2, 0x1
  sw x2, 0(x1)
  clean(x1)
  fence
  cbm_check_data(0x1)

test_clean_again: //
  csrwi mcause, 3
  cbm_address(data)
  la x1, data
  li x2, 0x1
  clean(x1)
  fence
  cbm_check_data(0x1)


test_flush_dirty: // writeback->refill
  csrwi mcause, 4
  cbm_address(data)
  la x1, data
  li x2, 0x2
  sw x2, 0(x1)
  flush(x1)
  fence
  cbm_check_data(0x2)
  la x1, data
  lw x2, 0(x1)
  li x3, 0x2
  bne x2, x3, fail

test_flush_clean: // refill
  csrwi mcause, 5
  cbm_address(data)
  la x1, data
  lw x2, 0(x1)
  li x3, 0x2
  bne x2, x3, fail
  flush(x1)
  fence
  cbm_check_data(0x2)
  la x1, data
  lw x2, 0(x1)
  li x3, 0x2
  bne x2, x3, fail


test_invalidate_dirty: //refill
  csrwi mcause, 6
  cbm_address(data)
  la x1, data
  li x2, 0x3
  sw x2, 0(x1)
  invalidate(x1)
  fence
  cbm_check_data(0x2)
  la x1, data
  lw x2, 0(x1)
  li x3, 0x2
  bne x2, x3, fail


test_invalidate_clean: //refill
  csrwi mcause, 7
  cbm_address(data)
  la x1, data
  lw x2, 0(x1)
  li x3, 0x2
  bne x2, x3, fail
  invalidate(x1)
  fence
  cbm_check_data(0x2)
  la x1, data
  lw x2, 0(x1)
  li x3, 0x2
  bne x2, x3, fail

test_cbm_to_lsu_hazard: //refill -> refill
  csrwi mcause, 8
  cbm_address(data)
  la x1, data
  invalidate(x1)
  fence
  la x2, 0x8
  sw x2, 0(x1)
  invalidate(x1)
  lw x2, 0(x1) //That load has to be aware of the invalidate, creating a hazard on its first try
  li x3, 0x2
  bne x2, x3, fail

test_cbm_to_lsu_hazard_2: // Here, we check that the store buffer do not messup store -> invalidate -> load ordering
  csrwi mcause, 9
  cbm_address(data)
  la x1, data+64
  invalidate(x1)
  la x1, data
  invalidate(x1)
  fence
  la x2, 0x8
  sw x2, 0(x1) // those store will get stuck in the store queue for a bit of time, and even a bit after refill, as it need to drain
  sw x2, 0(x1)
  sw x2, 0(x1)
  sw x2, 0(x1)
  sw x2, 0(x1)
  sw x2, 0(x1)
  sw x2, 0(x1)
  sw x2, 0(x1)
  sw x2, 0(x1)
  sw x2, 0(x1)
  sw x2, 0(x1)
  sw x2, 0(x1)
  invalidate(x1) // test that this invalidate wait until the store queue is flushed
  lw x2, 0(x1) //That load has to be aware of the invalidate, creating a hazard on its first try
  li x3, 0x2
  bne x2, x3, fail

test_store_after_invalidate:
  csrwi mcause, 10
  la x1, data
  la x2, 0x10
  sw x0, 0(x1)
  invalidate(x1)
  sw x2, 0(x1)
  lw x2, 0(x1)
  li x3, 0x10
  bne x2, x3, fail

check_supervisor:
  li x1, MSTATUS_MPP_MACHINE
  csrw mstatus, x1
  li x1, MSTATUS_MPP_SUPERVISOR
  csrw mstatus, x1
  csrr x2, mstatus
  li x1, MSTATUS_MPP_MACHINE
  and x2, x2, x1
  beq x2, x1, pass
has_supervisor:
  machine_setup_trap; machine_to_supervisor
  ecall
  machine_handle_trap

check_user_trap:
  machine_setup_trap; machine_to_user
  la x1, data; clean(x1)
  machine_handle_trap

  machine_setup_trap; machine_to_user
  la x1, data; flush(x1)
  machine_handle_trap

  machine_setup_trap; machine_to_user
  la x1, data; invalidate(x1)
  machine_handle_trap

check_user_cbcfe_allowance:
  li x1, XENVCFG_CBCFE_OK
  csrw 0x30a, x1
  csrw 0x10a, x1

  machine_setup_trap; machine_to_user
  la x1, data; clean(x1); ecall
  machine_handle_trap

  machine_setup_trap; machine_to_user
  la x1, data; flush(x1); ecall
  machine_handle_trap

check_user_cbie_allowance:
  li x1, XENVCFG_CBIE_OK
  csrw 0x30a, x1
  csrw 0x10a, x1

  machine_setup_trap; machine_to_user
  la x1, data; invalidate(x1); ecall
  machine_handle_trap



test_invalidate_into_flush:
  csrwi mcause, 15

  li x1, XENVCFG_CBIE_FLUSH
  csrw 0x30a, x1
  csrw 0x10a, x1

  machine_setup_trap; machine_to_user
  cbm_address(data)
  la x1, data
  li x2, 0x15
  sw x2, 0(x1)
  invalidate(x1)
  fence
  cbm_check_data(0x15)
  la x1, data
  lw x2, 0(x1)
  li x3, 0x15
  bne x2, x3, fail
  ecall
  machine_handle_trap

  li x1, 0
  csrw 0x30a, x1
  csrw 0x10a, x1


check_supervisor_cbcfe_allowance:
  li x1, XENVCFG_CBCFE_OK
  csrw 0x10a, x1

  machine_setup_trap; machine_to_supervisor
  la x1, data; clean(x1); ecall
  machine_handle_trap

  machine_setup_trap; machine_to_supervisor
  la x1, data; flush(x1); ecall
  machine_handle_trap

check_supervisor_cbie_allowance:
  li x1, XENVCFG_CBIE_OK
  csrw 0x10a, x1

  machine_setup_trap; machine_to_supervisor
  la x1, data; invalidate(x1); ecall
  machine_handle_trap


#if __riscv_xlen == 32
  li x1, XENVCFG_CBCFE_OK | XENVCFG_CBIE_OK
  csrw 0x30a, x1
  machine_setup_trap; machine_to_supervisor
setup_mmu:
    la x1, MMU_TABLE_0 + 0x800
    li x2, 0x80000000
    srli x2, x2, 2
    ori x2, x2, 0x0F | 0xC0
    sw x2, 0(x1)


    la x1, MMU_TABLE_0 + 0x804
    li x2, 0x90000000
    srli x2, x2, 2
    ori x2, x2, 0x0F | 0xC0
    sw x2, 0(x1)

    //Enable the MMU
    la x1, MMU_TABLE_0
    srli x1, x1, 12
    li x2, 0x80000000
    or x1, x1, x2
    sfence.vma
    csrw satp, x1

    addi x1, x1, 1

mmu_test_no_side_effect:
    la x1, 0x80400000
    lw x2, 0(x1)
    sw x2, 0(x1)
    clean(x1)  //Should have no side effects
    flush(x1)
    invalidate(x1)

    li x2, 1
    sw x2, 0(x1)
    flush(x1)

    li x2, 2
    sw x2, 0(x1)
    flush(x1)

    li x2, 3
    sw x2, 0(x1)
    flush(x1)

    li x2, 4
    sw x2, 0(x1)
    clean(x1)

    li x2, 5
    sw x2, 0(x1)
    clean(x1)

    //li x2, 6
    //sw x2, 0(x1)
    //clean(x1)



    ecall
  machine_handle_trap

  call delay

#endif;


  j pass



pass:
  j pass
fail:
  j fail


delay:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret

.align(4)
data:
    .word 0x27e91b60
    .word 0xa656bbbb
    .word 0x59014f57
    .word 0xe339e4d3


.align 12
MMU_TABLE_0:
.word 0

.align 12
MMU_TABLE_1:
.word 0

.align 12
MMU_TABLE_2:
.word 0

.align 12
MMU_TABLE_3:
.word 0
