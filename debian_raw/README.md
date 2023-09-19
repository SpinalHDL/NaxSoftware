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


cd $NAXRISCV/src/test/cpp/naxriscv
export DEBIAN=$NAXRISCV/../debian/riscv-linux
export OPENSBI=$NAXRISCV/../opensbi/build/platform/out-of-tree/firmware
#export LINUX=$NAXRISCV/../debian/linuxSpinal/arch/riscv/boot
export LINUX=/media/data/open/riscv/litex/naxriscv_debian/linux-53b46d10f9a438a29c061cac05fb250568d1d21b/arch/riscv/boot
export DTB=$NAXRISCV/ext/NaxSoftware/debian/linux
export BLOCK=$NAXRISCV/../debian/riscv-linux-raw
./obj_dir/VNaxRiscv \
--load-bin $OPENSBI/fw_jump.bin,0x80000000 \
--load-bin $DTB/linux.dtb,0x83F80000 \
--load-bin $LINUX/Image,0x80400000 \
--block-device $BLOCK/sim.bin,wr,0xBB8F1000,0x10001000

--block-device $BLOCK/sid-rv64-ext4.bin,wr,0xBB8F1000,0x10001000



cd $NAXRISCV/src/test/cpp/naxriscv
export DEBIAN=$NAXRISCV/../debian/riscv-linux
export OPENSBI=$NAXRISCV/../opensbi/build/platform/out-of-tree/firmware
export LINUX=/media/data/open/riscv/litex/naxriscv_debian/linux-53b46d10f9a438a29c061cac05fb250568d1d21b/arch/riscv/boot
#export LINUX=$NAXRISCV/../debian/linuxSpinal/arch/riscv/boot
export DTB=$NAXRISCV/ext/NaxSoftware/debian/linux
export BLOCK=$NAXRISCV/../debian/riscv-linux-raw
./obj_dir/VNaxRiscv \
--load-bin $OPENSBI/fw_jump.bin,0x80000000 \
--load-bin $DTB/linux.dtb,0x83F80000 \
--load-bin $LINUX/Image,0x80400000 \
--load-bin $BLOCK/sid.bin,0x20000000

./obj_dir/VNaxRiscv --load-bin /media/data/open/riscv/VexRiscvOoo/../opensbi/build/platform/out-of-tree/firmware/fw_jump.bin,0x80000000 --load-bin /media/data/open/riscv/VexRiscvOoo/ext/NaxSoftware/debian/linux/linux.dtb,0x83F80000 --load-bin /media/data/open/riscv/litex/naxriscv_debian/linux-53b46d10f9a438a29c061cac05fb250568d1d21b/arch/riscv/boot/Image,0x80400000 --load-bin /media/data/open/riscv/VexRiscvOoo/../debian/riscv-linux/sid.bin,0x20000000 --trace --trace-sporadic 0.001 --memory-latency 27


# OPENSBI
cd $NAXRISCV/../opensbi
rm -rf platform/out-of-tree
cp -r /media/data/open/riscv/VexRiscvOoo/ext/NaxSoftware/debian/opensbi platform/out-of-tree
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
#make -j8 ARCH=riscv nconfig
make -j$(nproc) ARCH=riscv all


CONFIG_RAID6_PQ_BENCHMARK=n
CONFIG_PRINTK_TIME=y



#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem



# logs

rawrr@rawrr:/media/data/open/riscv/VexRiscvOoo/src/test/cpp/naxriscv$ ./obj_dir/VNaxRiscv \
> --load-bin $OPENSBI/fw_jump.bin,0x80000000 \
> --load-bin $DTB/linux.dtb,0x83F80000 \
> --load-bin $LINUX/Image,0x80400000 \
> --load-bin $BLOCK/sid.bin,0x20000000

OpenSBI v0.9
   ____                    _____ ____ _____
/ __ \                  / ____|  _ \_   _|
| |  | |_ __   ___ _ __ | (___ | |_) || |
| |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
| |__| | |_) |  __/ | | |____) | |_) || |_
\____/| .__/ \___|_| |_|_____/|____/_____|
| |
|_|

Platform Name             : NaxRiscv
Platform Features         : timer,mfdeleg
Platform HART Count       : 1
Firmware Base             : 0x80000000
Firmware Size             : 68 KB
Runtime SBI Version       : 0.2

Domain0 Name              : root
Domain0 Boot HART         : 0
Domain0 HARTs             : 0*
Domain0 Region00          : 0x0000000080000000-0x000000008001ffff ()
Domain0 Region01          : 0x0000000000000000-0xffffffffffffffff (R,W,X)
Domain0 Next Address      : 0x0000000080400000
Domain0 Next Arg1         : 0x0000000083f80000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes

Boot HART ID              : 0
Boot HART Domain          : root
Boot HART ISA             : rv64imafdcsu
Boot HART Features        : scounteren,mcounteren
Boot HART PMP Count       : 0
Boot HART PMP Granularity : 18446744073709551615
Boot HART PMP Address Bits: -1
Boot HART MHPM Count      : 4
Boot HART MHPM Count      : 4
Boot HART MIDELEG         : 0x0000000000000222
Boot HART MEDELEG         : 0x000000000000b109
[    0.000000] Linux version 5.10.1+ (rawrr@rawrr) (riscv64-unknown-linux-gnu-gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.37) #29 SMP Tue Jul 12 12:25:07 CEST 2022
[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
[    0.000000] printk: bootconsole [sbi0] enabled
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080400000-0x000000009fffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080400000-0x000000009fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080400000-0x000000009fffffff]
[    0.000000] software IO TLB: mapped [mem 0x000000009b90c000-0x000000009f90c000] (64MB)
[    0.000000] SBI specification v0.2 detected
[    0.000000] SBI implementation ID=0x1 Version=0x9
[    0.000000] SBI v0.2 TIME extension detected
[    0.000000] SBI v0.2 IPI extension detected
[    0.000000] SBI v0.2 RFENCE extension detected
[    0.000000] SBI v0.2 HSM extension detected
[    0.000000] riscv: ISA extensions acdfim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: Embedded 15 pages/cpu s30680 r0 d30760 u61440
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 128270
[    0.000000] Kernel command line: rootwait console=hvc0 earlycon=sbi root=/dev/sblkdev0 rootfstype=btrfs ro rootflags=ssd,subvol=/sid rootwait
[    0.000000] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.000000] Sorting __ex_table...
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 433000K/520192K available (4577K kernel code, 4306K rwdata, 2048K rodata, 137K init, 287K bss, 87192K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped
[    0.000000] riscv_timer_init_dt: Registering clocksource cpuid [0] hartid [0]
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000054] sched_clock: 64 bits at 100MHz, resolution 10ns, wraps every 4398046511100ns
[    0.001035] Console: colour dummy device 80x25
[    0.001398] printk: console [hvc0] enabled
[    0.001398] printk: console [hvc0] enabled
[    0.001901] printk: bootconsole [sbi0] disabled
[    0.001901] printk: bootconsole [sbi0] disabled
[    0.002645] Calibrating delay loop (skipped), value calculated using timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.003347] pid_max: default: 32768 minimum: 301
[    0.004553] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.005207] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.015653] rcu: Hierarchical SRCU implementation.
[    0.020173] smp: Bringing up secondary CPUs ...
[    0.020536] smp: Brought up 1 node, 1 CPU
[    0.022757] devtmpfs: initialized
[    0.026226] random: get_random_u32 called from bucket_table_alloc.isra.0+0x4a/0x136 with crng_init=0
[    0.028437] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.029763] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.032116] NET: Registered protocol family 16
[    0.068084] raid6: skip pq benchmark and using algorithm int64x8
[    0.068521] raid6: using intx1 recovery algorithm
[    0.070784] SCSI subsystem initialized
[    0.075589] clocksource: Switched to clocksource riscv_clocksource
[    0.123830] NET: Registered protocol family 2
[    0.127922] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.128565] TCP established hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.129352] TCP bind hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.130117] TCP: Hash tables configured (established 4096 bind 4096)
[    0.131094] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.131787] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.133105] NET: Registered protocol family 1
[    0.136969] workingset: timestamp_bits=62 max_order=17 bucket_order=0
[    0.170487] fuse: init (API version 7.32)
[    0.172783] 9p: Installing v9fs 9p2000 file system support
[    0.174868] xor: measuring software checksum speed
[    0.213922]    8regs           :   256 MB/sec
[    0.252732]    8regs_prefetch  :   256 MB/sec
[    0.291591]    32regs          :   256 MB/sec
[    0.330315]    32regs_prefetch :   256 MB/sec
[    0.330640] xor: using function: 32regs_prefetch (256 MB/sec)
[    0.331268] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.342194] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.353173] loop: module loaded
[    0.447939] sblkdev: [0x20000000 - 0x7fffffff]
[    0.448290] sblkdev: Capacity 3 MB
[    0.451782] sblkdev: simple block device was created
[    0.456901] libphy: Fixed MDIO Bus: probed
[    0.462915] NET: Registered protocol family 10
[    0.468375] Segment Routing with IPv6
[    0.469222] NET: Registered protocol family 17
[    0.470293] 9pnet: Installing 9P2000 support
[    0.477925] Btrfs loaded, crc32c=crc32c-generic
[    0.482065] BTRFS: device label BTRFS devid 1 transid 1709 /dev/root scanned by swapper/0 (1)


[    0.485789] BTRFS info (device sblkdev0): enabling ssd optimizations
[    0.486292] BTRFS info (device sblkdev0): disk space caching is enabled
[    0.486739] BTRFS info (device sblkdev0): has skinny extents
[    0.543675] VFS: Mounted root (btrfs filesystem) readonly on device 0:12.
[    0.548737] devtmpfs: mounted
[    0.549808] Freeing unused kernel memory: 136K
[    0.740244] ------------[ cut here ]------------
[    0.740622] riscv/mm: Found insecure W+X mapping at address (____ptrval____)/0xffffffe000000000
[    0.741236] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/ptdump.c:231 note_page+0x236/0x23c
[    0.741766] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.1+ #29
[    0.742182] epc: ffffffe0002045f6 ra : ffffffe0002045f6 sp : ffffffe001047c80
[    0.742642]  gp : ffffffe000cb84a8 tp : ffffffe001048000 t0 : ffffffe000c140c8
[    0.743107]  t1 : ffffffe000676cc8 t2 : 0000000000000000 s0 : ffffffe001047e60
[    0.743705]  s1 : ffffffe000200000 a0 : 0000000000000053 a1 : ffffffe000c81e10
[    0.744180]  a2 : 00000000ffffefff a3 : 0000000000000000 a4 : ffffffe000c11d50
[    0.744636]  a5 : ffffffe000c11d50 a6 : 0000000000000000 a7 : 0000000000000001
[    0.745090]  s2 : ffffffe001047e60 s3 : 0000000080600000 s4 : 00000000000000cb
[    0.745538]  s5 : 0000000000000003 s6 : ffffffe01fbff008 s7 : ffffffe000200000
[    0.745986]  s8 : ffffffe00080e1a8 s9 : ffffffe040000000 s10: ffffffe001047da0
[    0.746440]  s11: ffffffe000400000 t3 : 0000000000000001 t4 : 000000000000036d
[    0.746886]  t5 : 0000000000000000 t6 : ffffffe001047a40
[    0.747242] status: 0000000200000120 badaddr: ffffffe0002045f6 cause: 0000000000000003
[    0.747857] ---[ end trace aeeb2e310d50d81a ]---
[    0.748682] Checked W+X mappings: failed, 512 W+X pages found
[    0.749135] Run /sbin/init as init process
[    1.736796] systemd[1]: System time before build time, advancing clock.
[    1.800330] systemd[1]: systemd 247.3-5 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
[    1.802726] systemd[1]: Detected architecture riscv64.

Welcome to Debian GNU/Linux 11 (bullseye)!

[    1.823267] systemd[1]: Set hostname to <sid-rv64>.
[    3.874884] systemd-gpt-auto-generator[53]: File system behind root file system is reported by btrfs to be backed by pseudo-device /dev/root, which is not a valid userspace accessible device node. Cannot determine correct backing block device.
[    4.022185] systemd[47]: /usr/lib/systemd/system-generators/systemd-gpt-auto-generator failed with exit status 1.
[    6.545111] systemd[1]: Queued start job for default target Graphical Interface.
[    6.553065] random: systemd: uninitialized urandom read (16 bytes read)
[    6.562057] systemd[1]: Created slice system-modprobe.slice.
[  OK  ] Created slice system-modprobe.slice.
[    6.565962] random: systemd: uninitialized urandom read (16 bytes read)
[    6.570962] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[  OK  ] Created slice system-systemd\x2dfsck.slice.
[    6.574187] random: systemd: uninitialized urandom read (16 bytes read)
[    6.578524] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[    6.583849] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[  OK  ] Started Dispatch Password …ts to Console Directory Watch.
[    6.588886] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Started Forward Password R…uests to Wall Directory Watch.
[    6.592897] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
[    6.595051] systemd[1]: Reached target Local Encrypted Volumes.
[  OK  ] Reached target Local Encrypted Volumes.
[    6.600361] systemd[1]: Reached target Paths.
[  OK  ] Reached target Paths.
[    6.603324] systemd[1]: Reached target Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[    6.606429] systemd[1]: Reached target Slices.
[  OK  ] Reached target Slices.
[    6.609877] systemd[1]: Reached target Swap.
[  OK  ] Reached target Swap.
[    6.616894] systemd[1]: Listening on fsck to fsckd communication Socket.
[  OK  ] Listening on fsck to fsckd communication Socket.
[    6.622146] systemd[1]: Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[    6.627972] systemd[1]: Condition check resulted in Journal Audit Socket being skipped.
[    6.636601] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[    6.644008] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[    6.652422] systemd[1]: Listening on Network Service Netlink Socket.
[  OK  ] Listening on Network Service Netlink Socket.
[    6.662075] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[    6.669218] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[    6.675646] systemd[1]: Condition check resulted in Huge Pages File System being skipped.
[    6.693225] systemd[1]: Mounting POSIX Message Queue File System...
Mounting POSIX Message Queue File System...
[    6.705654] systemd[1]: Condition check resulted in Kernel Debug File System being skipped.
[    6.719222] systemd[1]: Condition check resulted in Kernel Trace File System being skipped.
[    6.730509] systemd[1]: Condition check resulted in Create list of static device nodes for the current kernel being skipped.
[    6.773216] systemd[1]: Starting Load Kernel Module configfs...
Starting Load Kernel Module configfs...
[    6.982331] systemd[1]: Starting Load Kernel Module drm...
Starting Load Kernel Module drm...
[    7.018146] systemd[1]: Starting Load Kernel Module fuse...
Starting Load Kernel Module fuse...
[    7.041268] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    7.069347] systemd[1]: Starting File System Check on Root Device...
Starting File System Check on Root Device...
[    7.163044] systemd[1]: Starting Journal Service...
Starting Journal Service...
[    7.238419] systemd[1]: Starting Load Kernel Modules...
Starting Load Kernel Modules...
[    7.327347] systemd[1]: Starting Coldplug All udev Devices...
Starting Coldplug All udev Devices...
[    7.642222] systemd[1]: Mounted POSIX Message Queue File System.
[  OK  ] Mounted POSIX Message Queue File System.
[    7.701122] systemd[1]: modprobe@configfs.service: Succeeded.
[    7.728422] systemd[1]: Finished Load Kernel Module configfs.
[  OK  ] Finished Load Kernel Module configfs.
[    7.785145] systemd[1]: modprobe@drm.service: Succeeded.
[    7.816360] systemd[1]: Finished Load Kernel Module drm.
[  OK  ] Finished Load Kernel Module drm.
[    7.854112] systemd[1]: modprobe@fuse.service: Succeeded.
[    7.892611] systemd[1]: Finished Load Kernel Module fuse.
[  OK  ] Finished Load Kernel Module fuse.
[    7.932085] systemd[1]: Finished File System Check on Root Device.
[  OK  ] Finished File System Check on Root Device.
[    8.025452] systemd[1]: Mounting FUSE Control File System...
Mounting FUSE Control File System...
[    8.060065] systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.
[    8.142686] systemd[1]: Starting Remount Root and Kernel File Systems...
Starting Remount Root and Kernel File Systems...
[    8.228338] systemd[1]: Finished Load Kernel Modules.
[  OK  ] Finished Load Kernel Modules.
[    8.307334] systemd[1]: Mounted FUSE Control File System.
[  OK  ] Mounted FUSE Control File System.
[    8.394464] systemd[1]: Starting Apply Kernel Variables...
Starting Apply Kernel Variables...
[    9.227943] systemd[1]: Finished Apply Kernel Variables.
[  OK  ] Finished Apply Kernel Variables.
[    9.265825] BTRFS info (device sblkdev0): disk space caching is enabled
[    9.372520] systemd[1]: Finished Remount Root and Kernel File Systems.
[  OK  ] Finished Remount Root and Kernel File Systems.
[    9.403967] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    9.406009] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[    9.458574] systemd[1]: Starting Load/Save Random Seed...
Starting Load/Save Random Seed...
[    9.542266] systemd[1]: Starting Create System Users...
Starting Create System Users...
[   10.456179] systemd[1]: Finished Create System Users.
[  OK  ] Finished Create System Users.
[   10.514554] systemd[1]: Starting Create Static Device Nodes in /dev...
Starting Create Static Device Nodes in /dev...
[   10.846686] systemd[1]: Started Journal Service.
[  OK  ] Started Journal Service.
Starting Flush Journal to Persistent Storage...
[  OK  ] Finished Create Static Device Nodes in /dev.
[  OK  ] Reached target Local File Systems (Pre).
[   11.730852] systemd-journald[65]: Received client request to flush runtime journal.
Starting Rule-based Manage…for Device Events and Files...
[  OK  ] Finished Coldplug All udev Devices.
[  OK  ] Finished Flush Journal to Persistent Storage.
[   13.167885] random: crng init done
[   13.168198] random: 7 urandom warning(s) missed due to ratelimiting
[  OK  ] Finished Load/Save Random Seed.
[  OK  ] Started Rule-based Manager for Device Events and Files.
Starting Network Service...
[   ***] (2 of 2) A start job is running for Network Service (12s / 1min 36s)


https://unix.stackexchange.com/questions/385281/why-im-giving-message-a-start-job-is-running-for-raise-network-interfaces-at
