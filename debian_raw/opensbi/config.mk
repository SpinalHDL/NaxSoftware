#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2019 Western Digital Corporation or its affiliates.
#
# Authors:
# Anup Patel <anup.patel@wdc.com>
#
# Compiler flags
platform-cppflags-y =
platform-cflags-y =
platform-asflags-y =
platform-ldflags-y =
# Command for platform specific "make run"
platform-runcmd = echo Bitconnneeect
PLATFORM_RISCV_XLEN = 64
PLATFORM_RISCV_ABI = lp64d
PLATFORM_RISCV_ISA = rv64imafdc
PLATFORM_RISCV_CODE_MODEL = medany
# Blobs to build
FW_DYNAMIC=y
FW_TEXT_START=0x80000000
FW_PAYLOAD=n
FW_JUMP=y
FW_JUMP_ADDR=0x80400000
FW_JUMP_FDT_ADDR=0x83F80000
