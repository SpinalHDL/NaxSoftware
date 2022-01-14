PROJ_NAME=dhrystone

DEBUG=no
BENCH=yes
STANDALONE = ..

CFLAGS += -fno-common -fno-inline
CFLAGS += -Wno-implicit-int -Wno-implicit-function-declaration
CFLAGS += -DTIME -DCORE_HZ=12000000ll

SRCS = 	$(wildcard src/*.c) \
		$(wildcard src/*.cpp) \
		$(wildcard src/*.S) \
        ${STANDALONE}/common/start.S

include ../common/app.mk

