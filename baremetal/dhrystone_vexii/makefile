PROJ_NAME=dhrystone_vexii

DEBUG?=no
BENCH=yes
STANDALONE = ..

CFLAGS += -fno-common -fno-inline  -falign-functions=8 -falign-jumps=8 -falign-loops=8 -mtune=sifive-7-series
CFLAGS += -Wno-implicit-int -Wno-implicit-function-declaration
CFLAGS += -DTIME -DCORE_HZ=12000000ll

SRCS = 	$(wildcard src/*.c) \
		$(wildcard src/*.cpp) \
		$(wildcard src/*.S) \
        ${STANDALONE}/common/start.S

include ../common/app.mk

