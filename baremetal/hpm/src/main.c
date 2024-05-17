#include <type.h>
#include <sim.h>
#include <riscv.h>

void delay(){
    asm("nop;nop;nop;nop;nop;");
}

volatile long dummy;


#define BRANCH_COUNT   0x01
#define BRANCH_MISS    0x02

#define ICACHE_ACCESS  0x10
#define ICACHE_MISS    0x11
#define ICACHE_WAITING 0x12

#define DCACHE_ACCESS  0x18
#define DCACHE_MISS    0x19
#define DCACHE_WAITING 0x1A

int main(){
  int *ptr = 0x90000000;
  csr_write(minstret, 0x42);
  delay();
  dummy = csr_swap(minstret, 0x666);
  delay();
  dummy = csr_swap(minstret, 0x666);

  dummy = csr_read(mcycle);
  dummy = csr_read(cycle);
  dummy = csr_read(minstret);
  dummy = csr_read(instret);

  csr_write(mhpmevent3, DCACHE_ACCESS  );
  csr_write(mhpmevent4, DCACHE_MISS    );
  csr_write(mhpmevent5, DCACHE_WAITING );
  csr_write(mhpmcounter3, 0);
  csr_write(mhpmcounter4, 0);
  csr_write(mhpmcounter5, 0);
  csr_write(mhpmcounter31, 0);
  csr_write(mhpmcounter7, 0);
asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");asm("nop;nop;nop;nop;nop;");
  for(int i = 0;i < 1000;i++){
    dummy += *ptr++;
    dummy += *ptr++;
    dummy += *ptr++;
    dummy += *ptr++;
    dummy += csr_swap(minstret, 0x666);
  }
  sim_puthex(csr_read(mhpmcounter3));sim_puts("\n");
  sim_puthex(csr_read(hpmcounter4));sim_puts("\n");
  sim_puthex(csr_read(hpmcounter5));sim_puts("\n");
  sim_puts("Done\n");
  return 0;
}
