
## How to use

### Preparation
Install riscv-arch-test by reference https://github.com/riscv/riscv-arch-test#getting-started

Note: the tested reference is `887ca0885`


## Build tests
```bash
cd $VEXIIRISCV/
export NAX_SOFTWARE=$VEXIIRISCV/ext/NaxSoftware

cd $ACT_DIR

# RV32
CONFIG_FILES=$NAX_SOFTWARE/riscv-arch-test/config/rv32-vexii/test_config.yaml make -j "$(nproc)"

# RV64
CONFIG_FILES=$NAX_SOFTWARE/riscv-arch-test/config/rv64-vexii/test_config.yaml make -j "$(nproc)"

```

## Start test server
```bash
cd $VEXIIRISCV/

# RV32
mill 'Test[].runMain' vexiiriscv.tester.TestBenchServer \
  --xlen=32 \
  --with-isa=g,c,s,u,b,zfa,zfh,zfhmin,zihpm,zicntr,smcntrpmf,sscofpmf,svade,zbkb,zbkx,zknd,zkne,zknh,zksed,zksh \
  --performance-counters=29 \
  --pmp-size=16 \
  --asid-width=9 \
  --fetch-l1 \
  --lsu-l1

# RV64
mill 'Test[].runMain' vexiiriscv.tester.TestBenchServer \
  --xlen=64 \
  --with-isa=g,c,s,u,b,zfa,zfh,zfhmin,zihpm,zicntr,smcntrpmf,sscofpmf,svade,zbkb,zbkx,zknd,zkne,zknh,zksed,zksh \
  --performance-counters=29 \
  --pmp-size=16 \
  --asid-width=16 \
  --fetch-l1 \
  --lsu-l1
```

```bash
cd $ACT_DIR

# RV32
./run_tests.py -j 8 \
  "$(< $NAX_SOFTWARE/riscv-arch-test/config/rv32-vexii/run_cmd.txt)" \
  work/vexii-rv32/elfs/

# RV64
./run_tests.py -j 8 \
  "$(< $NAX_SOFTWARE/riscv-arch-test/config/rv64-vexii/run_cmd.txt)" \
  work/vexii-rv64/elfs/
```
