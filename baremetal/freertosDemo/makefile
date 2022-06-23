PROJ_NAME=freertosDemo

DEMO?=test1
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

#https://github.com/coldnew/FreeRTOS-mirror.git



DEMOS= blocktim countsem EventGroupsDemo flop integer QPeek \
      QueueSet recmutex semtest TaskNotify dynamic \
      GenQTest PollQ QueueOverwrite QueueSetPolling sp_flop test1


define LIST_DEMO
$(1):
	make all_arch DEMO=$$@ OBJDIR=${OBJDIR}/$$@
endef
$(foreach l,$(DEMOS),$(eval $(call LIST_DEMO,$(l))))

all_demo: ${DEMOS}


