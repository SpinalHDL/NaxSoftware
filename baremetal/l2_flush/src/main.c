/*
echo 0123456789ABCDEF > output/block.bin
obj_dir/VNaxRiscv --name play --load-elf ../../../../ext/NaxSoftware/baremetal/block_device/build/rv64imafdc/block_device.elf --start-symbol _start --pass-symbol pass --fail-symbol fail --trace --trace-ref --spike-debug --block-device output/block.bin,wr,0x60000000,0x10001000
*/

#include <type.h>
#include <sim.h>
#include <io.h>

#define FRAMEBUFFER 0x80200000
#define WIDTH 32
#define HEIGHT 16


#define L2_CTRL 0x10020000
#define L2_FLUSH 0x08
#define L2_FLUSH_RESERVED 1
#define L2_FLUSH_START 2
#define L2_FROM 0x10
#define L2_TO 0x18

void l2_flush(u32 l2, u64 from, u64 to){
    while(read_u32(l2 + L2_FLUSH) & L2_FLUSH_RESERVED);
    write_u32(from, l2 + L2_FROM);
    write_u32(to, l2 + L2_TO);
    write_u32(L2_FLUSH_START, l2 + L2_FLUSH);
}

int main(){
  for(int y = 0;y < HEIGHT;y++){
    for(int x = 0;x < WIDTH;x++){
        *((u32*)FRAMEBUFFER + x + y * WIDTH) = ((x & 0x3F) << 2+0) | ((y & 0x3F) << 2+8)  | ((y & 0xFF) << 16);
    }
  }
  l2_flush(L2_CTRL, FRAMEBUFFER, FRAMEBUFFER + WIDTH*HEIGHT*4-1);
  return 0;
}
