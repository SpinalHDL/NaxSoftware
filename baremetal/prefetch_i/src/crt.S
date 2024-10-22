#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#include "../../driver/privileged.h"
#define delay() nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;


#define func() \
1: \
    delay(); \
    delay() ;\
    j 1f;\
    delay();\
    delay();\
    delay();\
    delay();\
    delay();\
    delay();\
    delay();

.globl _start
_start:

func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();
func(); func(); func(); func();

1:


    j pass

pass:
    nop
    j pass

fail:
    nop
    j fail



