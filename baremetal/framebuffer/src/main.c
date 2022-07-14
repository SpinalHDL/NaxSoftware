/*
echo 0123456789ABCDEF > output/block.bin
obj_dir/VNaxRiscv --name play --load-elf ../../../../ext/NaxSoftware/baremetal/block_device/build/rv64imafdc/block_device.elf --start-symbol _start --pass-symbol pass --fail-symbol fail --trace --trace-ref --spike-debug --block-device output/block.bin,wr,0x60000000,0x10001000
*/

#include <type.h>
#include <sim.h>

#define FRAMEBUFFER 0x80200000
#define WIDTH 800
#define HEIGHT 600

#define REG_STATUS 0x0
#define REG_LOW 0x4
#define REG_HIGH 0x8
#define REG_SIZE 0xC
#define REG_DATA 0x10
#define REG_CAPACITY_LOW 0x20
#define REG_CAPACITY_HIGH 0x24



int main(){
  for(int y = 0;y < HEIGHT;y++){
    for(int x = 0;x < WIDTH;x++){
        *((u32*)FRAMEBUFFER + x + y * WIDTH) = ((x & 0x3F) << 2+0) | ((y & 0x3F) << 2+8)  | ((y & 0xFF) << 16);
    }
  }
  return 0;
}
