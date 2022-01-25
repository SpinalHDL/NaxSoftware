
## How to build

```
cd $NAXRISCV/..
git clone https://github.com/buildroot/buildroot.git --branch master
cd buildroot
git checkout 9ef54b7d
make BR2_EXTERNAL=$NAX_SOFTWARE/buildroot/ naxriscv_sim_defconfig
```

## How to run sim

```
./obj_dir/VNaxRiscv \
--load-bin $LINUX_IMAGES/fw_jump.bin,0x80000000 \
--load-bin $LINUX_IMAGES/linux.dtb,0x80F80000 \
--load-bin $LINUX_IMAGES/Image,0x80400000 \
--load-bin $LINUX_IMAGES/rootfs.cpio,0x81000000 
```
fw_dynamic.bin  fw_dynamic.elf  fw_jump.bin  fw_jump.elf  Image  linux.dtb  rootfs.cpio  rootfs.tar
