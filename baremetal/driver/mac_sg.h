#pragma once

#include "type.h"
#include "io.h"

#define MACSG_TX_BASE 0x100
#define MACSG_TX_CONTROL (MACSG_TX_BASE + 0x00)
#define MACSG_TX_NEXT (MACSG_TX_BASE + 0x10)

#define MACSG_TX_STATUS_BUSY 1
#define MACSG_TX_STATUS_START 1

#define MACSG_TX_DESC_STATUS_COMPLETED (1 << 31)
#define MACSG_TX_DESC_CONTROL_LAST (1 << 30)




// Should be aligned to 64 bytes !
struct macsg_tx_descriptor {
   u32 status;
   u32 control;
   u64 next;
   u64 from;
   u8 user[8];
};

static void macsg_tx_start(u32 base){
    write_u32(MACSG_TX_STATUS_START, base + MACSG_TX_BASE);
}
static int macsg_tx_busy(u32 base){
    return read_u32(base + MACSG_TX_BASE) & MACSG_TX_STATUS_BUSY;
}
static void macsg_tx_set_next(u32 base, u64 next){
    write_u32(next, base + MACSG_TX_NEXT);
    write_u32(next >> 32, base + MACSG_TX_NEXT + 4);
}


#define MACSG_RX_BASE 0x200
#define MACSG_RX_CONTROL (MACSG_RX_BASE + 0x00)
#define MACSG_RX_NEXT (MACSG_RX_BASE + 0x10)

#define MACSG_RX_STATUS_BUSY 1
#define MACSG_RX_STATUS_START 1

#define MACSG_RX_DESC_STATUS_COMPLETED (1 << 31)
#define MACSG_RX_DESC_STATUS_LAST (1 << 30)
#define MACSG_RX_DESC_STATUS_ERROR (1 << 29)
#define MACSG_RX_DESC_STATUS_BYTES 0x7FFFFFF


// Should be aligned to 64 bytes !
struct macsg_rx_descriptor {
   u32 status;
   u32 control;
   u64 next;
   u64 to;
   u8 user[8];
};

static void macsg_rx_start(u32 base){
    write_u32(MACSG_RX_STATUS_START, base + MACSG_RX_BASE);
}
static int macsg_rx_busy(u32 base){
    return read_u32(base + MACSG_RX_BASE) & MACSG_RX_STATUS_BUSY;
}
static void macsg_rx_set_next(u32 base, u64 next){
    write_u32(next, base + MACSG_RX_NEXT);
    write_u32(next >> 32, base + MACSG_RX_NEXT + 4);
}
