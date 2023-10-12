## Purpose of this readme 

- How to create a debian rootfs with a few usefull packages
- Compile a debian ready kernel
- Compile opensbi (Litex)
- Prepare the SDCARD

The debian stuff is mostly based on based on https://wiki.debian.org/InstallingDebianOn/SiFive/%20HiFiveUnmatched, but with some changes : 
- Different sdcard partitions setup (for litex)
- Instead of making a full SDCARD image file, this readme create a rootfs image file.

## Create a Debian rootfs

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
apt-get --fix-broken install

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


# Install networking stuff, note the PermitRootLogin to allow SSH root login
apt-get -y install openssh-server openntpd ntpdate net-tools 
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Install a few utilities
apt-get -y install sl hdparm htop wget psmisc tmux kbd usbutils

# Install stuff allowing to compile stuff directly from the target
apt-get -y install gcc git libncursesw5-dev autotools-dev autoconf automake libtool build-essential

# x11 related stuff
apt-get -y install xorg xserver-xorg-core xinit
apt-get -y install twm wmaker
# GLX is very very slow as soon as X11 app start to use pixel based buffer, need to disable it.
cat >> /etc/X11/xorg.conf <<EOF
Section "Extensions"
	Option "GLX" "Disable"
EndSection
EOF

# Multimedia
apt-get -y install mpg123 ffmpeg
apt-get -y install chocolate-doom openttd xscreensaver xscreensaver-data xscreensaver-data-extra
echo export SDL_VIDEODRIVER=x11 >> /root/.bashrc


apt-get clean

# exit chroot
exit

sudo umount $MNT
```

Note that some debian rootfs out there disable the SBI HVC0 console. But by default it is enable.

# Compile linux 

To do so, you will need a riscv toolchain configured to target linux. To get one you can follow https://github.com/riscv-collab/riscv-gnu-toolchain :

```shell
git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git --recursive
cd riscv-gnu-toolchain
./configure --prefix=/opt/riscv_rv64gc_linux
make -j$(nproc) linux
sudo make install
cd ..
```

Then you can compile the kernel :

```shell
git clone https://github.com/Dolu1990/litex-linux.git
cd litex-linux
git checkout ae80e67c6b48bbedcd13db753237a25b3dec8301
# Increase speed by factor 10
sed -i 's/SD_SLEEP_US       5/SD_SLEEP_US       0/g' drivers/mmc/host/litex_mmc.c
cp $NAXRISCV/ext/NaxSoftware/debian2/linux/.config .config

export CROSS_COMPILE=/opt/riscv_rv64gc_linux/bin/riscv64-unknown-linux-gnu-
make -j$(nproc) ARCH=riscv oldconfig
make -j$(nproc) ARCH=riscv all

ls vmlinux               # Kernel elf (has symboles, usefull for debug)
ls arch/riscv/boot/Image # Kernel binary

cd ..
unset CROSS_COMPILE
```

Sometime, on the make all, it will ask you if you want x,y packages, and some important one sometime turn themself off XD

You realy need : 
- CONFIG_SIFIVE_PLIC
- CONFIG_RISCV_SBI_V01
- CONFIG_RISCV_SBI
- CONFIG_HVC_RISCV_SBI

# Compile OpenSbi

```shell
git clone https://github.com/litex-hub/opensbi --branch 1.3.1-linux-on-litex-vexriscv
cd opensbi
make CROSS_COMPILE=riscv-none-embed- PLATFORM=litex/vexriscv

ls build/platform/litex/vexriscv/firmware/fw_jump.bin 
ls build/platform/litex/vexriscv/firmware/fw_jump.elf

cd ..
```

# Generate a DTB from a DTS

For the digilent nexys video, using the litex soc : 
- python3 -m litex_boards.targets.digilent_nexys_video --cpu-type=naxriscv  --bus-standard axi-lite --with-video-framebuffer --with-coherent-dma --with-sdcard --with-ethernet --xlen=64 --scala-args='rvc=true,rvf=true,rvd=true,alu-count=2,decode-count=2'  --with-jtag-tap --sys-clk-freq 100000000 --cpu-count 2 --build --load

```shell
dtc -O dtb -o pi/linux.dtb pi/linux.dts
```

# setup a SDCARD :

This is based on the Digilent nexys video running a Litex SoC with dual core NaxRiscv.
Note that you will need to adjust the linux.dtb to your board / config.

```shell
export SDCARD=/dev/???
export SDCARD_P1=${SDCARD}1
export SDCARD_P2=${SDCARD}2

# Write the partition table
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

sudo mkfs.vfat $SDCARD_P1

# Copy rootfs
sudo dd if=debian-sid-risc-v-root.img of=$SDCARD_P2 bs=64k iflag=fullblock oflag=direct conv=fsync status=progress

# copy boot files
export BOOT=mnt_p1
mkdir -p $BOOT
sudo mount $SDCARD_P1 $BOOT
sudo cp p1/boot.json $BOOT
sudo cp p1/linux.dtb $BOOT
sudo cp opensbi/build/platform/litex/vexriscv/firmware/fw_jump.bin $BOOT/opensbi.bin 
sudo cp opensbi/build/platform/litex/vexriscv/firmware/fw_jump.elf $BOOT/opensbi.elf
sudo cp litex-linux/vmlinux $BOOT 
sudo cp litex-linux/arch/riscv/boot/Image $BOOT
sudo umount $BOOT
```


# Tricks and tips:

# Package version issues
Got some issue installing some packages (mpg123 which needs libasound2).
- What happend is that libasound2 was only available in 1.2.9-1 while libasound2-data was already in 1.2.9.2
- Reason was that the default debian package mirror wasn't updated
- Hopefully, others mirror had the libasound2 1.2.9.2 version 

You can look online for globaly available versions : 
- https://packages.debian.org/search?suite=sid&arch=riscv64&searchon=names&keywords=libasound2
- https://packages.debian.org/sid/libasound2 # On the bottom, you can see supported architectures
- https://packages.debian.org/sid/riscv64/libasound2/download # Will lead you to the mirrors that you can add to the /etc/apt/sources.list

Note that for RISC-V so far, you need to look into the debian "sid" suite (kinda the debian dev/unstable branch), as RISC-V isn't yet mainstream for debian.

Here is an example of fix :

```shell
# Add a mirror to the APT source list
echo deb http://ftp.us.debian.org/debian sid main >> /etc/apt/sources.list

# Check available version, relative to the /etc/apt/sources.list mirror list
apt-cache madison libasound2  libasound2-data

# Install a specific version of the problematic packages
apt install libasound2-data=1.2.9-2 libasound2=1.2.9-2 
```

# Starting x11

Depending the packages installed, x11 will not start automaticaly by default. Here is how to run it manualy :

```shell        
# Start x11
xinit &
# wait a bit

# Start window manager
export DISPLAY=:0
wmaker &
# wait a bit
```

# x11 performances

Another thing is that the x11 GLX extensions will destroy the pixel based framebuffer performances. 
It need to be disabled as described in the "Create a Debian rootfs" chapter 

# Sound

Decently optimzed apps can run sound on a 100 Mhz RISC-V core, but if its "bloated" it will not go too well. 
- /usr/games/chocolate-doom -nomusic -nosfx -nosound
- /usr/games/openttd  -r 640x480 -b 8bpp-optimized -g -s null -m null

mpg123 can run a MP3 file to an USB headset fine.

# Boot console

In the linux DTS you have "console=hvc0 earlycon=hvc0".

This mean that the early phase of the linux kernel will use the opensbi provided terminal. Later, linux will switch to hvc0 which is aswell the opensbi provided terminal.
Note that the liteuart driver seems ot have issues when it comes to debian, but things work fine with hvc0.

If you want linux to use the framebuffer instead of hvc0, replace it with tty1.

Extra packages

```shell
apt install libaa-bin ace-of-penguins numptyphysics sopwith
```