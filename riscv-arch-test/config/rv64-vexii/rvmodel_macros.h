#ifndef _RVMODEL_MACROS_H
#define _RVMODEL_MACROS_H

#define STANDARD_SM_SUPPORTED

#define RVMODEL_DATA_SECTION \
        .pushsection .tohost,"aw",@progbits;                \
        .align 8; .global tohost; tohost: .dword 0;         \
        .align 8; .global fromhost; fromhost: .dword 0;     \
        .popsection;

##### STARTUP #####

# Perform boot operations. Can be empty or left undefined unless needed for
# DUT-specific behavior such as turning on a memory controller or
# initializing custom state.
//#define RVMODEL_BOOT

// Custom RVMODEL_BOOT_TO_MMODE overrides default RVTEST_BOOT_TO_MMODE
// if defined.  For most DUTs, the default should work and this macro
// should not be defined.  If no M-mode or CSRs are implemented, define this
// macro as blank to bypass the boot process.  If a nonconforming
// M-mode is implemented, define this macro to set up the necessary
// state in a fashion similar to RVTEST_BOOT_TO_MMODE.
//#define RVMODEL_BOOT_TO_MMODE

##### TERMINATION #####

# Terminate test with a pass indication.
# When the test is run in simulation, this should end the simulation.
#define RVMODEL_HALT_PASS  \
  li x1, 1                ;\
  la t0, tohost           ;\
  write_tohost_pass:      ;\
    sw x1, 0(t0)          ;\
    sw x0, 4(t0)          ;\
  pass:                   ;\
    nop                   ;\
    j pass                ;\

# Terminate test with a fail indication.
# When the test is run in simulation, this should end the simulation.
#define RVMODEL_HALT_FAIL \
  li x1, 3                ;\
  la t0, tohost           ;\
  write_tohost_fail:      ;\
    sw x1, 0(t0)          ;\
    sw x0, 4(t0)          ;\
  fail:                   ;\
    nop                   ;\
    j fail                ;\

##### IO #####

# Example UART implementation.
# Expects a PC16550-compatible UART.
# Change these addresses to match your memory map
.EQU UART_BASE_ADDR, 0x10000000
.EQU UART_PUTC, (UART_BASE_ADDR + 0x0)

# Initialization steps needed prior to writing to the console
# _R1, _R2, and _R3 can be used as temporary registers if needed.
# Do not modify any other registers (or make sure to restore them).
# Can be empty or left undefined if no initialization is needed.
#define RVMODEL_IO_INIT(_R1, _R2, _R3) \
  uart_init: ;

# Prints a null-terminated string using a DUT specific mechanism.
# A pointer to the string is passed in _STR_PTR.
# _R1, _R2, and _R3 can be used as temporary registers if needed.
# Do not modify any other registers (or make sure to restore them).
#define RVMODEL_IO_WRITE_STR(_R1, _R2, _R3, _STR_PTR)               \
1:                           ;                          \
  lbu _R1, 0(_STR_PTR)       ;/* Load byte */           \
  beqz _R1, 3f               ;/* Exit if null */        \
2:                           ;                          \
  li _R2, UART_PUTC          ; /* transmit character */ \
  sb _R1, 0(_R2)             ;                          \
  addi _STR_PTR, _STR_PTR, 1 ;/* Next char */           \
  j 1b                       ;/* Loop */                \
3:

##### Access Fault #####

#define RVMODEL_ACCESS_FAULT_ADDRESS 0x00000080

##### Interrupt Latency #####

#define RVMODEL_INTERRUPT_LATENCY 10

##### Machine Timer #####

#define CLINT_BASE_ADDRESS 0x10010000

#define RVMODEL_TIMER_INT_SOON_DELAY 100

#define RVMODEL_MTIME_ADDRESS    (CLINT_BASE_ADDRESS + 0xBFF8) /* Address of mtime CSR */

#define RVMODEL_MTIMECMP_ADDRESS (CLINT_BASE_ADDRESS + 0x4000)   /* Address of mtimecmp CSR */

##### Machine Interrupts #####

#define RVMODEL_MSIP_ADDRESS (CLINT_BASE_ADDRESS + 0x0)

#define RVMODEL_MEXT_INT_ADDRESS (UART_BASE_ADDR + 0x10)

#define RVMODEL_SET_MEXT_INT(_R1, _R2) \
  li _R1, 1; \
  li _R2, RVMODEL_MEXT_INT_ADDRESS; \
  sb _R1, 0(_R2);

#define RVMODEL_CLR_MEXT_INT(_R1, _R2) \
  li _R2, RVMODEL_MEXT_INT_ADDRESS; \
  sb zero, 0(_R2);

#define RVMODEL_SET_MSW_INT(_R1, _R2) \
  li _R1, 1; \
  li _R2, RVMODEL_MSIP_ADDRESS; \
  sw _R1, 0(_R2);

#define RVMODEL_CLR_MSW_INT(_R1, _R2) \
  li _R2, RVMODEL_MSIP_ADDRESS; \
  sw zero, 0(_R2);

##### Supervisor Interrupts #####

#define RVMODEL_SEXT_INT_ADDRESS (UART_BASE_ADDR + 0x18)

#define RVMODEL_SET_SEXT_INT(_R1, _R2) \
  li _R1, 1; \
  li _R2, RVMODEL_SEXT_INT_ADDRESS; \
  sb _R1, 0(_R2);

#define RVMODEL_CLR_SEXT_INT(_R1, _R2) \
  li _R2, RVMODEL_SEXT_INT_ADDRESS; \
  sb zero, 0(_R2);

#define RVMODEL_CLR_SSW_INT(_R1, _R2)

#endif // _RVMODEL_MACROS_H
