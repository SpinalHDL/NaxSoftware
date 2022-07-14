/*
echo 0123456789ABCDEF > output/block.bin
obj_dir/VNaxRiscv --name play --load-elf ../../../../ext/NaxSoftware/baremetal/block_device/build/rv64imafdc/block_device.elf --start-symbol _start --pass-symbol pass --fail-symbol fail --trace --trace-ref --spike-debug --block-device output/block.bin,wr,0x60000000,0x10001000
*/

#include <type.h>
#include <sim.h>

#define BLOCK 0x10001000

#define REG_STATUS 0x0
#define REG_LOW 0x4
#define REG_HIGH 0x8
#define REG_SIZE 0xC
#define REG_DATA 0x10
#define REG_CAPACITY_LOW 0x20
#define REG_CAPACITY_HIGH 0x24

void access(u32 device, int wr, u64 pos, u32 b_len, u8 *b_buf){
    int idx;
    write_u32(pos, device + REG_LOW);
    write_u32(pos >> 32, device + REG_HIGH);
    write_u32(b_len, device + REG_SIZE);
    write_u32(1 | ((wr != 0) << 1), device + REG_STATUS);
    while(read_u32( device + REG_STATUS) & 1);
    if (wr){//WRITE
        for(idx = 0;idx < b_len;idx++){
            write_u32(((char*)b_buf)[idx], device + REG_DATA);
        }
    } else {//READ
        for(idx = 0;idx < b_len;idx++){
            ((char*)b_buf)[idx] = read_u32(device + REG_DATA);
        }
    }
}

int main(){
  char buffer[100];
  sim_puts("Hi");
  access(BLOCK, 0, 2, 10, buffer);  buffer[10] = 0;  sim_puts(buffer); sim_putchar('\n');
  access(BLOCK, 0, 12, 10, buffer); buffer[10] = 0; sim_puts(buffer); sim_putchar('\n');
  access(BLOCK, 1, 48, 20, "ABCDEFGHIJKLMOPQRSTU");
  access(BLOCK, 0, 50, 10, buffer);  buffer[10] = 0;  sim_puts(buffer); sim_putchar('\n');
  return 0;
}
