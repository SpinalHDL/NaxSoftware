#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2019 Western Digital Corporation or its affiliates.
#
# Authors:
#   Anup Patel <anup.patel@wdc.com>
#

platform-objs-y += platform.o
platform-genflags-y += "-I$(BR2_EXTERNAL_NAXRISCV_SIM_PATH)/boards/naxriscv_sim/opensbi"

