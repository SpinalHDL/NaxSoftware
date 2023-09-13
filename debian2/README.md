Based on https://wiki.debian.org/InstallingDebianOn/SiFive/%20HiFiveUnmatched
But with some changes : 
- Different partitions (for litex)
- file images of rootfs, not the whole sdcard


Create a Debian rootfs
```shell
export MNT=$PWD/mnt

# create image file
dd if=/dev/zero of=debian-sid-risc-v-root.img bs=1M count=7168
       
# Mount image in loop device
sudo losetup --partscan --find --show debian-sid-risc-v-root.img

# format partitions
sudo mkfs.ext4 /dev/loop0
sudo e2label /dev/loop0 rootfs

# mount root partition
mkdir -p $MNT
sudo mount /dev/loop0 $MNT

# install base files
sudo apt-get install debootstrap qemu-user-static binfmt-support debian-ports-archive-keyring
sudo debootstrap --arch=riscv64 --keyring /usr/share/keyrings/debian-ports-archive-keyring.gpg --include=debian-ports-archive-keyring unstable $MNT http://deb.debian.org/debian-ports

# chroot into base filesystem and made basic configuration
sudo chroot $MNT

# Update package information
apt-get update

# Set up basic networking
cat >>/etc/network/interfaces <<EOF
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF

# Set root password 
passwd

# Change hostname
echo miaou > /etc/hostname

# Set up fstab
cat > /etc/fstab <<EOF
# <file system> <mount point>   <type>  <options>       <dump>  <pass>

/dev/mmcblk0p2 /               ext4    errors=remount-ro 0       1
/dev/mmcblk0p1 /boot           vfat    nodev,noexec,rw   0       2
EOF


# Install a few things
apt --fix-broken install
apt-get install openssh-server openntpd ntpdate
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
apt-get -y install sl hdparm htop net-tools wget psmisc tmux kbd
apt-get -y install gcc git libncursesw5-dev autotools-dev autoconf automake build-essential
apt-get -y install usbutils
apt-get -y install xorg xserver-xorg-core xinit
apt-get -y install twm wmaker
apt-get -y install chocolate-doom openttd xscreensaver xscreensaver-data xscreensaver-data-extra
apt-get -y install mpg123 ffmpeg
echo export SDL_VIDEODRIVER=x11 >> /root/.bashrc

cat >> /etc/X11/xorg.conf <<EOF
Section "Extensions"
	Option "GLX" "Disable"
EndSection
EOF

apt-get clean

# exit chroot
exit

sudo umount $MNT
```

Compile linux 

```shell
export CROSS_COMPILE=/opt/riscv_rv64gc_linux/bin/riscv64-unknown-linux-gnu-
git clone https://github.com/Dolu1990/litex-linux.git
cd litex-linux
git checkout ae80e67c6b48bbedcd13db753237a25b3dec8301
sed -i 's/SD_SLEEP_US       5/SD_SLEEP_US       0/g' drivers/mmc/host/litex_mmc.c
cp $NAXRISCV/ext/NaxSoftware/debian2/linux/.config .config
make -j$(nproc) ARCH=riscv oldconfig
# optionally configure it further
#make -j8 ARCH=riscv nconfig
make -j$(nproc) ARCH=riscv all

sudo cp vmlinux $BOOT #Not necessary, but in case you need to debug <3
sudo cp arch/riscv/boot/Image $BOOT

cd ..
```

Compile OpenSbi
```shell
git clone https://github.com/litex-hub/opensbi --branch 1.3.1-linux-on-litex-vexriscv
cd opensbi
make CROSS_COMPILE=riscv-none-embed- PLATFORM=litex/vexriscv

sudo cp build/platform/litex/vexriscv/firmware/fw_jump.bin $BOOT/opensbi.bin #Not necessary, but in case you need to debug <3
sudo cp build/platform/litex/vexriscv/firmware/fw_jump.elf $BOOT/opensbi.elf

cd ..
```

setup a sdcard :

```shell
(
echo o
echo n
echo p
echo 1
echo
echo +512M
echo y
echo n
echo p
echo 2
echo
echo +7168M
echo y
echo t
echo 1
echo b
echo p
echo w
) | sudo fdisk $SDCARD

sudo mkfs.vfat ${SDCARD}1

# Copy rootfs
sudo dd if=debian-sid-risc-v-root.img of=${SDCARD}2 bs=64k iflag=fullblock oflag=direct conv=fsync status=progress

# copy boot files
export BOOT=mnt2
mkdir -p $BOOT
sudo mount ${SDCARD}1 $BOOT
sudo cp boot.json $BOOT
sudo cp linux.dtb $BOOT
sudo cp opensbi/build/platform/litex/vexriscv/firmware/fw_jump.bin $BOOT/opensbi.bin #Not necessary, but in case you need to debug <3
sudo cp opensbi/build/platform/litex/vexriscv/firmware/fw_jump.elf $BOOT/opensbi.elf
sudo cp litex-linux/vmlinux $BOOT #Not necessary, but in case you need to debug <3
sudo cp litex-linux/arch/riscv/boot/Image $BOOT
sudo umount $BOOT
```


Tricks and tips:


Got some issue installing packages (mpg123 which needs libasound2) :

```shell
echo deb http://ftp.us.debian.org/debian sid main >> /etc/apt/sources.list
apt-cache madison libasound2  libasound2-data
apt install libasound2-data=1.2.9-2 libasound2=1.2.9-2
```



trash :

```shell
cp opensbi/build/platform/litex/vexriscv/firmware/fw_jump.bin ./opensbi.bin #Not necessary, but in case you need to debug <3
cp opensbi/build/platform/litex/vexriscv/firmware/fw_jump.elf ./opensbi.elf
cp litex-linux/vmlinux . #Not necessary, but in case you need to debug <3
cp litex-linux/arch/riscv/boot/Image .
```
