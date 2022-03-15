
```shell
git clone https://github.com/SpinalHDL/riscv-compliance.git --branch naxriscv riscv-arch-test 
cd riscv-arch-test

export RISCV_TARGET=naxriscv
export XLEN=32

make RISCV_DEVICE=I compile
make RISCV_DEVICE=M compile
make RISCV_DEVICE=C compile
make RISCV_DEVICE=Zifencei compile
make RISCV_DEVICE=privilege compile

export RISCV_TARGET=naxriscv
export XLEN=64

make RISCV_DEVICE=I compile
make RISCV_DEVICE=M compile
make RISCV_DEVICE=C compile
make RISCV_DEVICE=Zifencei compile
make RISCV_DEVICE=privilege compile
```