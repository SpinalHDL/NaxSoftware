ARCHS=
ifneq ($(RV32),no)
ifneq ($(NEED_FPU),yes)
ARCHS+=rv32i rv32ima rv32imac
endif
ARCHS+=rv32imaf rv32imafc rv32imafd rv32imafdc
endif

ifneq ($(RV64),no)
ifneq ($(NEED_FPU),yes)
ARCHS+=rv64i rv64ima rv64imac
endif
ARCHS+=rv64imaf rv64imafc rv64imafd rv64imafdc rv64imafdc_zb
endif

EXTRA_ARCH=
rv32i=MARCH=rv32i${EXTRA_ARCH} MABI=ilp32
rv32ima=MARCH=rv32ima${EXTRA_ARCH} MABI=ilp32
rv32imac=MARCH=rv32imac${EXTRA_ARCH} MABI=ilp32
rv32imaf=MARCH=rv32imaf${EXTRA_ARCH} MABI=ilp32f
rv32imafc=MARCH=rv32imafc${EXTRA_ARCH} MABI=ilp32f
rv32imafd=MARCH=rv32imafd${EXTRA_ARCH} MABI=ilp32d
rv32imafdc=MARCH=rv32imafdc${EXTRA_ARCH} MABI=ilp32d
rv64i=MARCH=rv64i${EXTRA_ARCH} MABI=lp64
rv64ima=MARCH=rv64ima${EXTRA_ARCH} MABI=lp64
rv64imac=MARCH=rv64imac${EXTRA_ARCH} MABI=lp64
rv64imaf=MARCH=rv64imaf${EXTRA_ARCH} MABI=lp64f
rv64imafc=MARCH=rv64imafc${EXTRA_ARCH} MABI=lp64f
rv64imafd=MARCH=rv64imafd${EXTRA_ARCH} MABI=lp64d
rv64imafdc=MARCH=rv64imafdc${EXTRA_ARCH} MABI=lp64d
rv64imafdc_zb=MARCH=rv64gc_zicsr_zba_zbb_zbc_zbs MABI=lp64d

#zba_zbb_zbc_zbkb_zbkc_zbkx_zbs rv64gc_zicsr_zba_zbb_zbc_zbs

