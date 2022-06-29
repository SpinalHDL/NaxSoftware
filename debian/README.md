images : https://people.debian.org/~gio/dqib/
doc : https://wiki.debian.org/RISC-V#OS_.2F_filesystem_images
qemu : https://risc-v-getting-started-guide.readthedocs.io/en/latest/linux-qemu.html
how to run debian : https://github.com/esmil/riscv-linux


# Run sim
cd $NAXRISCV/src/test/cpp/naxriscv
export DEBIAN=$NAXRISCV/../debian/riscv-linux
export OPENSBI=$NAXRISCV/../opensbi/build/platform/out-of-tree/firmware
export LINUX=$NAXRISCV/../debian/linux/arch/riscv/boot
export DTB=$NAXRISCV/ext/NaxSoftware/debian/linux
export BUILDROOT=$NAXRISCV/ext/NaxSoftware/buildroot/images/rv64imafdc
./obj_dir/VNaxRiscv \
--load-bin $OPENSBI/fw_jump.bin,0x80000000 \
--load-bin $DTB/linux.dtb,0x83F80000 \
--load-bin $LINUX/Image,0x80400000 \
--load-bin $BUILDROOT/rootfs.cpio,0x84000000

# OPENSBI
cd $NAXRISCV/opensbi
export OPENSBI_PLATEFORM=out-of-tree
export CROSS_COMPILE=riscv-none-embed-
export PLATFORM_RISCV_XLEN=64
make PLATFORM=$OPENSBI_PLATEFORM clean
make PLATFORM=$OPENSBI_PLATEFORM -j$(nproc) 
riscv-none-embed-objdump  -S -d build/platform/$OPENSBI_PLATEFORM/firmware/fw_jump.elf > fw_jump.asm

# DTB
dtc -O dtb -o linux.dtb linux.dts

# Kernel

export CROSS_COMPILE=/opt/riscv_rv64gc_linux/bin/riscv64-unknown-linux-gnu-
git clone https://github.com/torvalds/linux.git --branch v5.9
cp $NAXRISCV/ext/NaxSoftware/debian/linux/config-virt .config
make -j8 ARCH=riscv oldconfig
# optionally configure it further
#make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- nconfig
make -j8 ARCH=riscv all