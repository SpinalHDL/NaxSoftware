#include "type.h"

#include "riscv.h"

void mmu_set_tree(u64 table,u64 level,u64 virt,u64 next) {
  u64* addr = (u64*) (table + ((virt >> (level*9+9)) & 0xFF8));
  u64 entry = ((u64)next >> 2) | 0x01;
  *addr = entry;
}

void mmu_set_leaf(u64 table,u64 level,u64 virt, u64 phys, u64  flags) {
  u64* addr = (u64*) (table + ((virt >> (level*9+9)) & 0xFF8));
  u64 entry = (phys >> 2) | flags;
  *addr = entry;
}


void mmu_disable() {
  csr_write(satp, 0);
}

void mmu_enable(u64 table) {
  csr_write(satp, (table >> 12) | (8l << 60));
  asm("sfence.vma");
}

