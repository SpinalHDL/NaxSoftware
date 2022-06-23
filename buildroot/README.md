
## How to build

```
cd $NAXRISCV/..
export NAX_SOFTWARE=$NAXRISCV/ext/NaxSoftware
git clone https://github.com/buildroot/buildroot.git --branch master
cd buildroot
git checkout 9ef54b7d
$NAX_SOFTWARE/buildroot/naxriscv_sim_setup.sh rv32ima
make BR2_EXTERNAL=$NAX_SOFTWARE/buildroot/ naxriscv_sim_defconfig
make
```

## How to run sim

```
cd $NAXRISCV/src/test/cpp/naxriscv
Follow the readme to build the simulator, then 
./obj_dir/VNaxRiscv \
--load-bin $LINUX_IMAGES/fw_jump.bin,0x80000000 \
--load-bin $LINUX_IMAGES/linux.dtb,0x80F80000 \
--load-bin $LINUX_IMAGES/Image,0x80400000 \
--load-bin $LINUX_IMAGES/rootfs.cpio,0x81000000 
```

<3