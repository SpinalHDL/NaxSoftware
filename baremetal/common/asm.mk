
RISCV_PATH?=/opt/riscv/
RISCV_NAME = riscv64-unknown-elf
RISCV_OBJCOPY = $(RISCV_PATH)/bin/$(RISCV_NAME)-objcopy
RISCV_OBJDUMP = $(RISCV_PATH)/bin/$(RISCV_NAME)-objdump
RISCV_CLIB=$(RISCV_PATH)$(RISCV_NAME)/lib/
RISCV_CC=$(RISCV_PATH)/bin/$(RISCV_NAME)-gcc
LDSCRIPT?=${STANDALONE}/common/asm.ld

MABI?=ilp32
MARCH?=rv32i


CFLAGS  += -march=$(MARCH)  -mabi=$(MABI) -mcmodel=medany
LDFLAGS += -march=$(MARCH)  -mabi=$(MABI) -mcmodel=medany

ifeq ($(DEBUG),yes)
ifneq ($(DEBUG_Og),yes)
	CFLAGS += -g3 -O0
else
	CFLAGS += -g3 -Og
endif
endif

ifneq ($(DEBUG),yes)
ifneq ($(BENCH),yes)
	CFLAGS += -Os
else
	CFLAGS += -O3
endif
endif

SRCS ?= $(wildcard src/*.c) \
        $(wildcard src/*.cpp)  \
        $(wildcard src/*.S)

OBJDIR ?= build

LDFLAGS += -lc

SPINAL_SIM ?= no
ifeq ($(SPINAL_SIM),yes)
    PROJ_NAME := $(PROJ_NAME)_spinal_sim
    CFLAGS += -DSPINAL_SIM
endif
CFLAGS += ${CFLAGS_ARGS}
CFLAGS += -I${STANDALONE}/include
CFLAGS += -I${STANDALONE}/driver
LDFLAGS += -L${STANDALONE}/common
LDFLAGS +=  -nostdlib -lgcc -nostartfiles -ffreestanding -Wl,-Bstatic,-T,$(LDSCRIPT),-Map,$(OBJDIR)/$(PROJ_NAME).map,--print-memory-usage

DOT:= .
COLON:=:

OBJS := $(SRCS)
OBJS := $(realpath $(OBJS))
OBJS := $(subst $(COLON),,$(OBJS))
OBJS := $(OBJS:.c=.o)
OBJS := $(OBJS:.cpp=.o)
OBJS := $(OBJS:.S=.o)
OBJS := $(OBJS:.s=.o)
OBJS := $(addprefix $(OBJDIR)/,$(OBJS))


compile: $(OBJDIR)/$(PROJ_NAME).elf $(OBJDIR)/$(PROJ_NAME).asm $(OBJDIR)/$(PROJ_NAME).bin

$(OBJDIR)/%.elf: $(OBJS) | $(OBJDIR)
	@echo "LD $(PROJ_NAME)"
	@$(RISCV_CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

%.bin: %.elf
	@$(RISCV_OBJCOPY) -O binary $^ $@

%.asm: %.elf
	@$(RISCV_OBJDUMP) -S -d $^ > $@

define LIST_RULE
$(1)
	@mkdir -p $(dir $(word 1, $(subst $(COLON), ,$(1))))
	@echo "CC $(word 2,$(subst $(COLON), ,$(1)))"
	@$(RISCV_CC) -c $(CFLAGS)  $(INC) -o $(subst $(COLON), ,$(1))
endef

CAT:= $(addsuffix  $(COLON), $(OBJS))
CAT:= $(join  $(CAT), $(SRCS))
$(foreach i,$(CAT),$(eval $(call LIST_RULE,$(i))))

$(OBJDIR):
	@mkdir -p $@

clean:
	@rm -rf $(OBJDIR)





include ${STANDALONE}/common/all_arch.mk

define LIST_ARCH
$(1):
	make compile OBJDIR=${OBJDIR}/$(1)  $(2)
endef
$(foreach l,$(ARCHS),$(eval $(call LIST_ARCH,$(l),$(${l}))))

all_arch: ${ARCHS}

MAKEFLAGS += --no-print-directory



.SECONDARY: $(OBJS)
