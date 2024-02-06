# RISCV-ARCH-TEST

This directory contains built riscv-arch-tests and scripts to update the binaries.


A recent riscv compiler is needed (packages for Ubuntu, for other systems refer to riscv-gnu-toolchain docs).
```shell
sudo apt-get install \
  autoconf automake autotools-dev curl \
  python3 python3-pip python-is-python3 \
  libmpc-dev libmpfr-dev libgmp-dev gawk build-essential \
  bison flex texinfo gperf libtool patchutils bc zlib1g-dev \
  libexpat-dev ninja-build git cmake libglib2.0-dev
git clone --recursive https://github.com/riscv-collab/riscv-gnu-toolchain.git
cd riscv-gnu-toolchain
git checkout 2023.12.20
./configure --prefix=/opt/riscv64-unknown-elf-gcc-2023.12.20
sudo make -j16 all
```

With the compiler available we can update the test binaries:
```shell
export PATH=/opt/riscv64-unknown-elf-gcc-2023.12.20/bin:$PATH
# can be checked out somewhere else
git clone https://github.com/riscv-non-isa/riscv-arch-test.git
cd riscv-arch-test
git checkout 8a52b016dbe1e2733cc168b9d6e5c93e39059d4d
cd ..
# pass path to suite folder
./build.py riscv-arch-test/riscv-test-suite
```

The tests built depend on the settings in `build.py`, currently the script needs
to be adapted for changes.
