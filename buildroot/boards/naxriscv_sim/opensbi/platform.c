/*
 * SPDX-License-Identifier: BSD-2-Clause
 *
 * Copyright (c) 2019 Western Digital Corporation or its affiliates.
 *
 * Authors:
 *   Anup Patel <anup.patel@wdc.com>
 *   Nick Kossifidis <mick@ics.forth.gr>
 */

#include <sbi/riscv_asm.h>
#include <sbi/riscv_encoding.h>
#include <sbi/riscv_io.h>
#include <sbi/sbi_const.h>
#include <sbi/sbi_hart.h>
#include <sbi/sbi_platform.h>
#include <sbi_utils/irqchip/plic.h>
#include <sbi_utils/serial/uart8250.h>
#include <sbi_utils/sys/clint.h>

/* clang-format off */

#define NAX_HART_COUNT			8
#define NAX_PLATFORM_FEATURES  \
	(SBI_PLATFORM_HAS_TIMER_VALUE | SBI_PLATFORM_HAS_MFAULTS_DELEGATION)

#define NAX_HART_STACK_SIZE		4096



#define BASE 0x10000000
#define PUTC BASE
#define PUT_HEX (BASE + 0x8)
#define CLINT_BASE (BASE + 0x10000)
#define CLINT_CMP (CLINT_BASE + 0x4000)
#define CLINT_TIME (CLINT_BASE + 0x0BFF8)
#define MACHINE_EXTERNAL_INTERRUPT_CTRL (BASE+0x10)
#define SUPERVISOR_EXTERNAL_INTERRUPT_CTRL (BASE + 0x18)
#define GETC (BASE + 0x40)


#define NAX_CLINT_ADDR CLINT_BASE
#define NAX_PUTC PUTC
#define NAX_GETC GETC


/* clang-format on */

static struct clint_data clint = {NAX_CLINT_ADDR, 0, NAX_HART_COUNT, true};

static int nax_final_init(bool cold_boot)
{
	return 0;
}

static u32 nax_pmp_region_count(u32 hartid)
{
	return 0;
}

static int nax_pmp_region_info(u32 hartid, u32 index, ulong *prot, ulong *addr,
				ulong *log2size)
{
	int ret = 0;

	switch (index) {
	default:
		ret = -1;
		break;
	};

	return ret;
}


void nax_putc(char ch){
	writel(ch, (void*)NAX_PUTC);
}

int nax_getc(void){
    return readl((void*)NAX_GETC);
}

static int nax_console_init(void)
{
	return 0;
}

static int nax_irqchip_init(bool cold_boot)
{
	return 0;
}

static int nax_ipi_init(bool cold_boot)
{
	int rc;

	if (cold_boot) {
		rc = clint_cold_ipi_init(&clint);
		if (rc)
			return rc;
	}

	return clint_warm_ipi_init();
}

static int nax_timer_init(bool cold_boot)
{
	int rc;
	if (cold_boot) {
		rc = clint_cold_timer_init(&clint, NULL); /* Timer has no reference */
		if (rc)
			return rc;
	}

	return clint_warm_timer_init();
}

static int nax_system_reset(u32 type)
{
	/* Tell the "finisher" that the simulation
	 * was successful so that QEMU exits
	 */

	return 0;
}

const struct sbi_platform_operations platform_ops = {
	.pmp_region_count	= nax_pmp_region_count,
	.pmp_region_info	= nax_pmp_region_info,
	.final_init		    = nax_final_init,
	.console_putc		= nax_putc,
	.console_getc		= nax_getc,
	.console_init		= nax_console_init,
	.irqchip_init		= nax_irqchip_init,
	.ipi_send		    = clint_ipi_send,
	.ipi_clear		    = clint_ipi_clear,
	.ipi_init		    = nax_ipi_init,
	.timer_value		= clint_timer_value,
	.timer_event_stop	= clint_timer_event_stop,
	.timer_event_start	= clint_timer_event_start,
	.timer_init			= nax_timer_init,
	.system_reset		= nax_system_reset
};

const struct sbi_platform platform = {
	.opensbi_version	= OPENSBI_VERSION,
	.platform_version	= SBI_PLATFORM_VERSION(0x0, 0x01),
	.name			    = "NaxRiscv",
	.features		    = NAX_PLATFORM_FEATURES,
	.hart_count		    = NAX_HART_COUNT,
	.hart_stack_size	= NAX_HART_STACK_SIZE,
	.platform_ops_addr	= (unsigned long)&platform_ops
};


