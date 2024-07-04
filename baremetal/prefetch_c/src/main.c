#include <type.h>
#include <stdio.h>
#include <riscv.h>

#define XLEN_T intptr_t
void *mem = (void*)0x90000000;
#define PREFETCHER_CTRL 0x7FF
#define PREFETCHER_CTRL_DISABLE 1

#define ASM_BENCH(name) extern void * name (void*, XLEN_T);

ASM_BENCH(load_1x)
ASM_BENCH(load_4x)
ASM_BENCH(load_16x)
ASM_BENCH(store_1x)
ASM_BENCH(store_4x)
ASM_BENCH(store_16x)
ASM_BENCH(load2_store1_4x)
ASM_BENCH(load_1x_512s)
ASM_BENCH(store_1x_512s)
ASM_BENCH(load_1x_512ms)
ASM_BENCH(store_1x_512ms)
ASM_BENCH(load_1x_416s)

void benchmark(char* name, void *(*bench) (void*, XLEN_T), XLEN_T bytes){
    printf("%s", name);
    XLEN_T start_at = csr_read(mcycle);
    mem = bench(mem, bytes);
    XLEN_T end_at = csr_read(mcycle);
    XLEN_T cycles = end_at - start_at;
    mem += 0x1100;
    printf(" %d.%02d B/cyc %d cyc\n", bytes/cycles, bytes*100/cycles%100, cycles);
}
#define BENCH_BYTES 0x4000

void run_tests(){
  benchmark("L 1x416s",   load_1x_416s, BENCH_BYTES/4);
  benchmark("L 1x512s",   load_1x_512s, BENCH_BYTES/4);
  benchmark("S 1x512s",   store_1x_512s, BENCH_BYTES/4);
  benchmark("L 1x512ms",   load_1x_512ms, BENCH_BYTES/4);
  benchmark("S 1x512ms",   store_1x_512ms, BENCH_BYTES/4);
  benchmark("L 1x",   load_1x, BENCH_BYTES);
  benchmark("L 1x",   load_1x, BENCH_BYTES);
  benchmark("L 4x",   load_4x, BENCH_BYTES);
  benchmark("L 16x", load_16x, BENCH_BYTES);
  benchmark("L 16x", load_16x, BENCH_BYTES*4);
  benchmark("S 1x" , store_1x, BENCH_BYTES);
  benchmark("S 4x" , store_4x, BENCH_BYTES);
  benchmark("S 16x",store_16x, BENCH_BYTES*4);
  benchmark("LLS 4x",load2_store1_4x, BENCH_BYTES);
}

int main(){
  run_tests();
  csr_set(0x7FF, PREFETCHER_CTRL_DISABLE);
  run_tests();
  return 0;
}


/*
L_1x 1.10 B/cyc 7450 cyc
L_4x 1.36 B/cyc 6025 cyc
S_1x 2.15 B/cyc 3808 cyc
S_4x 2.38 B/cyc 3447 cyc

L 1x 2.36 B/cyc 3470 cyc
L 4x 4.05 B/cyc 2024 cyc
S 1x 2.45 B/cyc 3339 cyc
S 4x 2.88 B/cyc 2848 cyc

L 1x 2.24 B/cyc 7322 cyc
L 4x 4.82 B/cyc 3398 cyc
S 1x 2.63 B/cyc 6240 cyc
S 4x 3.03 B/cyc 5411 cyc
*/