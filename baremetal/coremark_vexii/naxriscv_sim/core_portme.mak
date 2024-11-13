# Copyright 2018 Embedded Microprocessor Benchmark Consortium (EEMBC)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 
# Original Author: Shay Gal-on

#File : core_portme.mak

OBJDIR?=build
MARCH?=rv32im
MABI?=ilp32
RISCV_PATH?=/opt/riscv/
RISCV_NAME?=riscv64-unknown-elf
RISCV_OBJCOPY = $(RISCV_PATH)/bin/$(RISCV_NAME)-objcopy
RISCV_OBJDUMP = $(RISCV_PATH)/bin/$(RISCV_NAME)-objdump
RISCV_CLIB=$(RISCV_PATH)$(RISCV_NAME)/lib/
RISCV_CC=$(RISCV_PATH)/bin/$(RISCV_NAME)-gcc

# Flag : OUTFLAG
#	Use this flag to define how to to get an executable (e.g -o)
OUTFLAG= -o
# Flag : CC
#	Use this flag to define compiler to use
CC=$(RISCV_CC)
# Flag : CFLAGS
#	Use this flag to define compiler options. Note, you can add compiler options from the command line using XCFLAGS="other flags"
PORT_CFLAGS =  -DPERFORMANCE_RUN=1  -march=${MARCH} -mabi=${MABI} -mcmodel=medany -Wno-pointer-to-int-cast -Wno-int-to-pointer-cast -I../driver
#PORT_CFLAGS += -O3 -fno-common -funroll-loops -finline-functions -falign-functions=16 -falign-jumps=4 -falign-loops=4 -finline-limit=1000 -fno-if-conversion2 -fselective-scheduling -fno-reg-struct-return -fno-rename-registers --param case-values-threshold=8 -fno-crossjumping -freorder-blocks-and-partition -fno-tree-loop-if-convert -fno-tree-sink -fgcse-sm -fno-strict-overflow
#PORT_CFLAGS += -O2 -mtune=sifive-7-series  -fno-common -funroll-loops -finline-functions -falign-functions=16 -falign-jumps=4 -falign-loops=4 -finline-limit=1000 -fno-if-conversion2 -fselective-scheduling -fno-crossjumping -freorder-blocks-and-partition
PORT_CFLAGS += -O2 -fno-common -funroll-loops -finline-functions -funroll-all-loops -falign-functions=8 -falign-jumps=8 -falign-loops=8 -finline-limit=1000 -mtune=sifive-7-series -ffast-math -fno-tree-loop-distribute-patterns --param fsm-scale-path-stmts=3
#PORT_CFLAGS +=  -O2 -funroll-all-loops -funswitch-loops -fgcse-after-reload -fpredictive-commoning -mtune=sifive-7-series -finline-functions -fipa-cp-clone -falign-functions=8 -falign-loops=8 -falign-jumps=8 --param max-inline-insns-auto=20
#PORT_CFLAGS += -O3 -fno-common -funroll-loops -finline-functions -falign-functions=16 -falign-jumps=4 -falign-loops=4 -finline-limit=1000 -fno-if-conversion2 -fselective-scheduling -fno-tree-dominator-opts -fno-reg-struct-return -fno-rename-registers --param case-values-threshold=8 -fno-crossjumping -freorder-blocks-and-partition -fno-tree-loop-if-convert -fno-tree-sink -fgcse-sm -fno-strict-overflow
# Useless ?  -fgcse-sm
#PORT_CFLAGS += -O2 -funroll-all-loops -funswitch-loops -fgcse-after-reload -fpredictive-commoning -mtune=sifive-7-series -finline-functions -fipa-cp-clone -falign-functions=8 -falign-loops=8 -falign-jumps=8 --param max-inline-insns-auto=20

FLAGS_STR = "$(PORT_CFLAGS) $(XCFLAGS) $(XLFLAGS) $(LFLAGS_END)"
CFLAGS = $(PORT_CFLAGS) -I$(PORT_DIR) -I. -DFLAGS_STR=\"$(FLAGS_STR)\"

#Flag : LFLAGS_END
#	Define any libraries needed for linking or other flags that should come at the end of the link line (e.g. linker scripts). 
#	Note : On certain platforms, the default clock_gettime implementation is supported but requires linking of librt.
LFLAGS_END = -lgcc -lc -nostartfiles -ffreestanding -Wl,-Bstatic,-T,../common/app.ld,-Map,coremark.map,--print-memory-usage
# Flag : PORT_SRCS
# 	Port specific source files can be added here
PORT_SRCS = $(PORT_DIR)/core_portme.c ../common/start.S $(PORT_DIR)/cvt.c $(PORT_DIR)/ee_printf.c
# Flag : LOAD
#	For a simple port, we assume self hosted compile and run, no load needed.

# Flag : RUN
#	For a simple port, we assume self hosted compile and run, simple invocation of the executable

#For native compilation and execution
LOAD = echo Loading done
RUN = 

OEXT = .o
EXE = .elf

# Target : port_pre% and port_post%
# For the purpose of this simple port, no pre or post steps needed.

.PHONY : port_prebuild port_postbuild port_prerun port_postrun port_preload port_postload
port_pre% port_post% : 

# FLAG : OPATH
# Path to the output folder. Default - current folder.
OPATH = ./
MKDIR = mkdir -p

miaou:
	echo asd

include ../common/all_arch.mk

define LIST_ARCH
$(1):
	make  PORT_DIR=naxriscv_sim RVM=yes ITERATIONS=10 REBUILD=1 XCFLAGS="-DCORE_DEBUG=0" $(2) clean compile link
	mkdir -p ${OBJDIR}/$(1)
	cp coremark_vexii.elf ${OBJDIR}/$(1)
endef
$(foreach l,$(ARCHS),$(eval $(call LIST_ARCH,$(l),$(${l}))))

all_arch: ${ARCHS}

