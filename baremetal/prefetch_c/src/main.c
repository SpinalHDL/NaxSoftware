#include <type.h>
#include <stdio.h>
#include <riscv.h>

#define XLEN_T intptr_t
void *mem = (void*)0x90000000;
#define PREFETCHER_CTRL 0x7FF
#define PREFETCHER_CTRL_DISABLE 2

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
static void * st3_fixup(void*framebuf, XLEN_T len);
#define st3_fixup_width 640
#define st3_fixup_height 200

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
//  benchmark("L 1x",   load_1x, BENCH_BYTES);
//  benchmark("L 1x",   load_1x, BENCH_BYTES);
//  benchmark("L 4x",   load_4x, BENCH_BYTES);
//  benchmark("L 16x", load_16x, BENCH_BYTES);
//  benchmark("L 16x", load_16x, BENCH_BYTES);
  benchmark("st3_fixup",   st3_fixup, st3_fixup_width*st3_fixup_height*4);

  benchmark("L 1x416s",   load_1x_416s, BENCH_BYTES/4);
  benchmark("L 1x512s",   load_1x_512s, BENCH_BYTES/4);
  benchmark("L 1x512ms",   load_1x_512ms, BENCH_BYTES/4);
  benchmark("L 1x",   load_1x, BENCH_BYTES);
  benchmark("L 1x",   load_1x, BENCH_BYTES);
  benchmark("L 4x",   load_4x, BENCH_BYTES);
  benchmark("L 16x", load_16x, BENCH_BYTES);
  benchmark("L 16x", load_16x, BENCH_BYTES*4);

  benchmark("S 1x512s",   store_1x_512s, BENCH_BYTES/4);
  benchmark("S 1x512ms",   store_1x_512ms, BENCH_BYTES/4);
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




//Quake scaleup
#define PIXEL24 u32
u32 st2d_8to24table[256];
static void * st3_fixup(void*framebuf, XLEN_T len)
{
    const int x = 0;
    const int y = 0;
    const int width = st3_fixup_width;
    const int height = st3_fixup_height;
    const int bytes_per_line = st3_fixup_width*4;

//    if (vid.output.scale == 1) {
//        for (int yi = y + height - 1; yi >= y; yi--) {
//            const byte *src = (byte *)&framebuf->data[yi * framebuf->bytes_per_line];
//            PIXEL24 *dest = ((PIXEL24 *)src);
//            for(int xi = (x + width - 1); xi >= x; xi--) {
//                dest[xi] = st2d_8to24table[src[xi]];
//            }
//        }
//    } else if (vid.output.scale == 2) {
        for (int yi = y + height - 1; yi >= y; yi--) {
            const u8 *src = (u8 *)&framebuf[yi * bytes_per_line];
            PIXEL24 *dest0 = (PIXEL24 *)&framebuf[(2 * yi + 0) * bytes_per_line];
            PIXEL24 *dest1 = (PIXEL24 *)&framebuf[(2 * yi + 1) * bytes_per_line];
            for (int xi = (x + width - 1); xi >= x; xi--) {
                PIXEL24 color = st2d_8to24table[src[xi]];
                dest0[xi * 2] = dest0[xi * 2 + 1] = color;
                dest1[xi * 2] = dest1[xi * 2 + 1] = color;
            }
        }
//    } else if (vid.output.scale == 4) {
//        for (int yi = y + height - 1; yi >= y; yi--) {
//            const byte *src = (byte *)&framebuf->data[yi * framebuf->bytes_per_line];
//            PIXEL24 *dest0 = (PIXEL24 *)&framebuf->data[(4 * yi + 0) * framebuf->bytes_per_line];
//            PIXEL24 *dest1 = (PIXEL24 *)&framebuf->data[(4 * yi + 1) * framebuf->bytes_per_line];
//            PIXEL24 *dest2 = (PIXEL24 *)&framebuf->data[(4 * yi + 2) * framebuf->bytes_per_line];
//            PIXEL24 *dest3 = (PIXEL24 *)&framebuf->data[(4 * yi + 3) * framebuf->bytes_per_line];
//            for (int xi = (x + width - 1); xi >= x; xi--) {
//                PIXEL24 color = st2d_8to24table[src[xi]];
//                dest0[xi * 4] = dest0[xi * 4 + 1] = dest0[xi * 4 + 2] = dest0[xi * 4 + 3] = color;
//                dest1[xi * 4] = dest1[xi * 4 + 1] = dest1[xi * 4 + 2] = dest1[xi * 4 + 3] = color;
//                dest2[xi * 4] = dest2[xi * 4 + 1] = dest2[xi * 4 + 2] = dest2[xi * 4 + 3] = color;
//                dest3[xi * 4] = dest3[xi * 4 + 1] = dest3[xi * 4 + 2] = dest3[xi * 4 + 3] = color;
//            }
//        }
//    } else {
//        /*
//         * Arbitrary scaling - walk the output lines and calculate the
//         * appropriate source lines as we go.
//         */
//        const int xstep = (vid.width << 16) / vid.output.width;
//        for (int yi = vid.output.height - 1; yi >= 0; yi--) {
//            PIXEL24 *dst = (PIXEL24 *)&framebuf->data[yi * framebuf->bytes_per_line];
//            const int src_row = yi * vid.height / vid.output.height;
//            const byte *src = (byte *)&framebuf->data[src_row * framebuf->bytes_per_line];
//            int frac = (vid.width - 1) << 16;
//            for (int xi = vid.output.width - 1; xi >= 0; xi--) {
//                dst[xi] = st2d_8to24table[src[frac >> 16]];
//                frac -= xstep;
//            }
//        }
//    }
    return framebuf + width*height*4;
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