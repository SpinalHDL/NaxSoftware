#pragma once

#include "sim.h"

#define BSP_CLINT CLINT_BASE
#define BSP_CLINT_HZ 5000000

// Freertos specifics
#define configMTIME_BASE_ADDRESS        (BSP_CLINT + 0xBFF8)
#define configMTIMECMP_BASE_ADDRESS     (BSP_CLINT + 0x4000)
#define configCPU_CLOCK_HZ              ( ( unsigned int ) ( BSP_CLINT_HZ ) )

static void bsp_putString(const char* str){
    while(*str) sim_putchar(*str++);
}
