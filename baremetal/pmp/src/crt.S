#include "../../driver/privileged.h"



.global _start
_start:

#define set_cfg0(cfg) li x1, cfg; csrw pmpcfg0, x1; csrr x1, pmpcfg0
#define set_addr0(addr) li x1, addr; csrw pmpaddr0, x1; csrr x1, pmpaddr0
#define set_cfg1(cfg) li x1, 0xFF00; csrc pmpcfg0, x1;  li x1, (cfg) << 8; csrs pmpcfg0, x1; csrr x1, pmpcfg0
#define set_addr1(addr) li x1, addr; csrw pmpaddr1, x1; csrr x1, pmpaddr1
#define set_cfg2(cfg) li x1, 0xFF0000; csrc pmpcfg0, x1;  li x1, (cfg) << 16; csrs pmpcfg0, x1; csrr x1, pmpcfg0
#define set_addr2(addr) li x1, addr; csrw pmpaddr2, x1; csrr x1, pmpaddr2



    set_cfg0(0x00)
    set_cfg0(0x01)
    set_cfg0(0x02)
    set_cfg0(0x03)
    set_cfg0(0x04)
    set_cfg0(0x05)
    set_cfg0(0x06)
    set_cfg0(0x07)

test1: // Trap supervisor fetch when non pmp is set
    set_cfg0(0x00)
    machine_setup_trap; machine_to_supervisor
    machine_handle_trap

test2: // Trap supervisor fetch when pmp is missmatched
    set_cfg0(PMP_X); set_addr0(0x9000FFFF)
    machine_setup_trap; machine_to_supervisor
    machine_handle_trap

test3: // allow supervisor fetch when pmp is set
    set_cfg0(PMP_X | PMP_NAPOT); set_addr0(0x8000FFFF >> 2)
    machine_setup_trap; machine_to_supervisor
    ecall
    machine_handle_trap

test4: // load fault
    set_cfg0(PMP_X | PMP_NAPOT); set_addr0(0x8000FFFF >> 2)
    machine_setup_trap; machine_to_supervisor
    la x1, data; lw x1, 0(x1)
    machine_handle_trap

test5: // store fault
    set_cfg0(PMP_X | PMP_NAPOT); set_addr0(0x8000FFFF >> 2)
    machine_setup_trap; machine_to_supervisor
    la x1, data; lw x1, 0(x1)
    machine_handle_trap

test6: // read ok
    set_cfg0(PMP_X | PMP_R | PMP_NAPOT); set_addr0(0x8000FFFF >> 2)
    machine_setup_trap; machine_to_supervisor
    la x1, data; lw x1, 0(x1)
    ecall
    machine_handle_trap

test7: // store ok
    set_cfg0(PMP_X | PMP_R | PMP_W | PMP_NAPOT); set_addr0(0x8000FFFF >> 2)
    machine_setup_trap; machine_to_supervisor
    la x1, data; sw x1, 0(x1)
    ecall
    machine_handle_trap
    
test8: // NAPOT
    set_cfg0(PMP_X | PMP_NAPOT); set_addr0(0x8000FFFF >> 2)
    set_cfg1(PMP_R | PMP_NAPOT); set_addr1(0x9000FFFF >> 2)
    set_cfg2(PMP_R | PMP_NA4); set_addr2(0xA0000000 >> 2)
    machine_setup_trap; machine_to_supervisor
    li x1, 0x81230000; lw x1, 0(x1)
    machine_handle_trap
    machine_setup_trap; machine_to_supervisor
    li x1, 0x7FFFFFFC; lw x1, 0(x1)
    machine_handle_trap
    machine_setup_trap; machine_to_supervisor
    li x1, 0x80010000; lw x1, 0(x1)
    machine_handle_trap
    machine_setup_trap; machine_to_supervisor
    li x1, 0xA0000004; lw x1, 0(x1)
    machine_handle_trap
    machine_setup_trap; machine_to_supervisor
    li x1, 0x9FFFFFFC; lw x1, 0(x1)
    machine_handle_trap
    machine_setup_trap; machine_to_supervisor
    li x1, 0xB0000001; lw x1, 0(x1)
    machine_handle_trap

    machine_setup_trap; machine_to_supervisor
    li x1, 0x90000000; lw x1, 0(x1)
    li x1, 0x9000FFFC; lw x1, 0(x1)
    li x1, 0xA0000000; lw x1, 0(x1)
    li x1, 0xA0000003; lb x1, 0(x1)
    ecall
    machine_handle_trap
    
test9: // TOR
    set_cfg0(PMP_X | PMP_NAPOT); set_addr0(0x8000FFFF >> 2)
    set_cfg1(0); set_addr1(0x90000000 >> 2)
    set_cfg2(PMP_R | PMP_TOR); set_addr2(0x90010000 >> 2)
    machine_setup_trap; machine_to_supervisor
    li x1, 0x8FFFFFFF; lb x1, 0(x1)
    machine_handle_trap
    machine_setup_trap; machine_to_supervisor
    li x1, 0x90010000; lw x1, 0(x1)
    machine_handle_trap

    machine_setup_trap; machine_to_supervisor
    li x1, 0x90000000; lw x1, 0(x1)
    li x1, 0x9000FFFF; lb x1, 0(x1)
    ecall
    machine_handle_trap

    j pass
fail:
    j fail
pass:
    j pass

data: