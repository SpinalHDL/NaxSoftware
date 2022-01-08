PROJ_NAME=freertosDemo

DEMO?=sp_flop
STANDALONE = ..
FREERTOS=../../../FreeRTOS-mirror/FreeRTOS
FREERTOS_DEMO=${FREERTOS}/Demo/Common
FREERTOS_RISCV=${FREERTOS}/Source/portable/GCC/RISC-V
APP_SOURCE_DIR=${FREERTOS_DEMO}/Minimal


include src/config/${DEMO}/Makefile

SRCS = 	$(wildcard src/*.c) \
		$(wildcard src/*.cpp) \
		$(wildcard src/*.S) \
		$(wildcard ${FREERTOS}/Source/*.c) \
        ${FREERTOS}/Source/portable/MemMang/heap_4.c \
        ${FREERTOS_RISCV}/port.c \
        ${FREERTOS_RISCV}/portASM.S \
        ${STANDALONE}/common/start.S \

SRCS += ${APP_SRC}


CFLAGS += -Isrc
CFLAGS += -Isrc/config/${DEMO}/conf
CFLAGS += -Isrc/config/${DEMO}
CFLAGS += -I${FREERTOS}/Source/include
CFLAGS += -I${FREERTOS_DEMO}/include
CFLAGS += -I${FREERTOS_RISCV}
CFLAGS += -DportasmHANDLE_INTERRUPT=external_interrupt_handler

include ../common/app.mk