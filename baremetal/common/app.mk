LDSCRIPT?=${STANDALONE}/common/app.ld
CFLAGS += -DUSE_GP
include ${STANDALONE}/common/asm.mk
