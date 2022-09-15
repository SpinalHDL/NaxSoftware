PROJ_NAME=side_channel

STANDALONE = ..

SRCS = 	$(wildcard src/*.c) \
		$(wildcard src/*.cpp) \
		$(wildcard src/*.S) \
        ${STANDALONE}/common/start.S

CFLAGS += -fPIC -Wno-int-to-pointer-cast -Wno-discarded-qualifiers -Wno-stringop-overflow
LDFLAGS += -fPIC
include ../common/app.mk

