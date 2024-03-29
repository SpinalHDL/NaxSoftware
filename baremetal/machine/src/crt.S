.globl _start
_start:

#include "../../driver/riscv_asm.h"
#include "../../driver/sim_asm.h"
#define delay_long() nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop

#define trap_setup         \
    la x1, 1f;              \
    csrw mtvec, x1;         \
    addi x1, x1, 0x123;      \
    csrw mtval, x1;         \

#define trap_handle        \
    j fail;                 \
    j fail;                 \
    j fail;                 \
    j fail;                 \
.align 4                ;\
1:                         \
    csrr x1, mepc;          \
    csrr x1, mcause;        \
    csrr x1, mstatus;       \
    csrr x1, mtval;           \
    csrr x1, mip;           \

#define trap_handle_setup \
    trap_handle    \
    trap_setup     \


    li x31, 10
redoAll:
    nop
    nop
    nop
    csrr x1, minstret
    nop
    nop
    nop
    csrr x1, minstret
#if __riscv_xlen == 32
    csrr x1, minstreth
#endif
    li x1, 0x12345678
    csrw minstret,x1
    csrr x1, minstret
#if __riscv_xlen == 32
    csrr x1, minstreth
#endif
#if __riscv_xlen == 32
    li x1, 0xAABBCCDD
    csrw minstreth,x1
    csrr x1, minstret
    csrr x1, minstreth
#endif

    csrr x1, mcycle
    csrr x1, mcycle

    csrwi mhpmevent3, ICACHE_REFILL
    csrwi mhpmevent4, DCACHE_REFILL
    csrwi mhpmevent5, DCACHE_WRITEBACK
    csrwi mhpmevent6, BRANCH_MISS

    li x3, PUTC
    li x4, PUT_HEX
    li x5, '-'
    li x6, '\n'
    sw x5, 0(x3)
    sw x6, 0(x3)

    csrr x1, mhpmcounter3; sw x1, 0(x4); sw x6, 0(x3)
    csrr x1, mhpmcounter4; sw x1, 0(x4); sw x6, 0(x3)
    csrr x1, mhpmcounter5; sw x1, 0(x4); sw x6, 0(x3)
    csrr x1, mhpmcounter6; sw x1, 0(x4); sw x6, 0(x3)

    csrr x1, mstatus
    csrr x1, mtvec
    csrr x1, mepc
    csrr x1, mtval
    li x1, 0x1234FFFF
    csrw mscratch, x1
    csrr x1, mscratch
    csrci mscratch, 3
    csrr x1, mscratch

    trap_setup
    li x1, MIE_MEIE
    csrw mie, x1
    li x1, MSTATUS_MIE
    csrw mstatus, x1
    li x1, MACHINE_EXTERNAL_INTERRUPT_CTRL
    li x2, 1
    sw x2, 0(x1)   //Interrupt test
    delay_long();
    trap_handle
    li x1, MACHINE_EXTERNAL_INTERRUPT_CTRL
    sw x0, 0(x1)   //Interrupt test

    trap_setup
    .word 0  //test decoding error
    trap_handle

    trap_setup
    ecall          // ecall test
    trap_handle

    trap_setup
    ebreak          // ebreak test
    trap_handle

    trap_setup
    csrw 0xFFF, x0 // Trap unimplemented csrw
    trap_handle

    trap_setup
    csrr x1, 0xFFF  // Trap unimplemented csrr
    trap_handle


    trap_setup // Trap unimplemented csrrw
    csrrw x1, 0xFFF, x1
    trap_handle


    trap_setup
    csrw mhartid, x1  // Trap read only csr
    trap_handle

    // Unaligned loads
    trap_setup
    la x1, data
    lw x1, 1(x1)
    trap_handle

    trap_setup
    la x1, data
    lw x1, 2(x1)
    trap_handle

    trap_setup
    la x1, data
    lw x1, 3(x1)
    trap_handle

    trap_setup
    la x1, data
    lh x1, 1(x1)
    trap_handle

    trap_setup
    la x1, BASE
    lw x1, 1(x1)
    trap_handle

    // Unaligned stores
    trap_setup
    la x1, data
    sw x1, 1(x1)
    trap_handle

    trap_setup
    la x1, data
    sw x1, 2(x1)
    trap_handle

    trap_setup
    la x1, data
    sw x1, 3(x1)
    trap_handle

    trap_setup
    la x1, data
    sh x1, 1(x1)
    trap_handle

    trap_setup
    la x1, BASE
    sw x1, 1(x1)
    trap_handle

    //Check no store side effects
    la x1, data
    lw x2, 0(x1)
    lw x2, 4(x1)

    // JALR clear bit 0
    la x1, 2f+1
    jalr x1, x1
    nop
2:  nop


    trap_setup
    li x1, MM_FAULT_ADDRESS
    lw x1, 0(x1) //load fault
    trap_handle

    trap_setup
    li x1, IO_FAULT_ADDRESS
    lw x1, 0(x1) //mmio load fault
    trap_handle

    trap_setup
    li x1, IO_FAULT_ADDRESS
    sw x1, 0(x1) //mmio store fault
    trap_handle

    trap_setup
    li x1, MM_FAULT_ADDRESS
    jalr x1 //fetch fault
    trap_handle


// mret test
    la x1, 1f
    csrw mepc, x1
    la x1, 0x1800 //MPP
    csrw mstatus, x1
    mret
    j fail
    nop
    nop
1:
    csrr x1, mepc


//TODO
/*
#ifndef RVC
    trap_setup
    la x1, data+2
    jalr x1, x1
    trap_handle
#endif*/

    addi x31, x31, -1
    bnez x31, redoAll
    j pass

/*
// CSR tests
    li x31, 10
t0:
    li x10, 0x11223344
    li x11, 0x22334455
    li x12, 0x33445566
    li x13, 0x44556677
    la x14, data
    csrw mscratch, x10
    csrw sscratch, x11
    csrr x1, mscratch
    csrr x2, sscratch
    csrrw x3, mscratch, x12
    lw x4, 0(x14)
    csrrw x3, mscratch, x4
    csrr x5, mscratch


    addi x31, x31, -1
    bnez x31, t0
    j pass
*/
/*
// linked list chain
    li x31, 1000
    la x1, data
i0:
    addi x2, x1, 4
    sw x2, 0(x1)
    mv x1, x2
    addi x31, x31, -1
    bnez x31, i0
    sw x0, 0(x1)

stats:
    la x1, data
j0:
    lw x1, 0(x1)
    bnez x1, j0
    j pass*/

/*

//Store -> load hazard prediction
#define delay() nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop
    li x31, 100
    la x30, data
    sw x30, 4(x30)
j0:
    delay()
    lw x1, 4(x30)
    sw x31, 0(x1)
    lw x2, 0(x30)
    addi x31, x31, -1
    bnez x31, j0
    j pass

*/

/*
#define delay() nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop
    li x31, 100
j0:
    delay()
    call func
    delay()
    addi x31, x31, -1
    bnez x31, j0
    j pass

func:
    delay()
    ret

*/

/*
// Easy to learn loop
#define delay() nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop
    li x31, 100
j0:
    delay()
    andi x1, x31, 3
    bnez x1, j1
    delay()
j1:
    delay()
    addi x31, x31, -1
    bnez x31, j0
*/


//More branch prediction tests
/*
    li x1, 1
    nop
    nop
    beq x0, x0, a1
a1:
    beq x0, x0, a2
    nop
a2:
    beq x0, x0, a3
    nop
    nop
a6:
    beq x0, x0, a7
    nop
    nop
a5:
    beq x0, x0, a6
    nop
    nop
a4:
    beq x0, x0, a5
    nop
a3:
    beq x0, x0, a4
    
a7:
    nop
    nop
    beq x0, x1, b1
    j b1
b1:
    beq x0, x1, b2
    j b2
    nop
b2:
    beq x0, x1, b3
    j b3
    nop
    nop
b6:
    beq x0, x1, b7
    j b7
    nop
    nop
b5:
    beq x0, x1, b6
    j b6
    nop
    nop
b4:
    beq x0, x1, b5
    j b5
    nop
b3:
    beq x0, x1, b4
    j b4

b7:*/

pass:
    nop

fail:
    nop



delay:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret

.align 8
data:
    .word 0x27e91b60
    .word 0xa656bbbb
    .word 0x59014f57
    .word 0xe339e4d3
    .word 0x1546ce54
    .word 0xaa010ccf
    .word 0x6bbe2419
    .word 0xa3cc949e
    .word 0x3d1d386b
    .word 0x6d56285a
    .word 0x49b145e5
    .word 0x39650987
    .word 0x1b90cb33
    .word 0x95d538a1
    .word 0x2020ec1a
    .word 0xe9d9c666
    .word 0xd35d8173
    .word 0xe0226196
    .word 0xe991a7b8
    .word 0xfdf6f65a
    .word 0xc5bca339
    .word 0x663c72b1
    .word 0xf618e589
    .word 0x520cbc56
    .word 0x04bf5a36
    .word 0x3f34e8d2
    .word 0x51b3e9c0
    .word 0x7d41d8c1
    .word 0x66e23065
    .word 0x1a8c467f
    .word 0xaa443f5d
    .word 0x18e3f07c
    .word 0x54cfe928
    .word 0x539fc406
    .word 0x0f2a1c7f
    .word 0x7c0dd67e
    .word 0x90beea6a
    .word 0x2372ad93
    .word 0x9ec5ac2d
    .word 0x5e2ae098
    .word 0x22c7aca0
    .word 0xd39358df
    .word 0x68f5850b
    .word 0x68b2e359
    .word 0x0e57de74
    .word 0x1951973c
    .word 0x33bf39fe
    .word 0xd3377771
    .word 0x907352da
    .word 0xad0790a2
    .word 0x976a7990
    .word 0xe2833f55
    .word 0x1ac88099
    .word 0x616f904d
    .word 0x8567b0f3
    .word 0x65e6482a
    .word 0xebfe9000
    .word 0x5d74e47c
    .word 0xb6e38ad1
    .word 0xdf858df7
    .word 0xdc3cf2e4
    .word 0xbe816d31
    .word 0xe1a906cf
    .word 0x5ac5c191
    .word 0x555f3c54
    .word 0x7648614e
    .word 0xba41b0de
    .word 0xa39f061f
    .word 0xd0a599cb
    .word 0x9852f295
    .word 0xfc240460
    .word 0xa643b3ce
    .word 0x7c7284ae
    .word 0x644dedcc
    .word 0xaa8fbede
    .word 0xe174ed9d
    .word 0x707ac6e1
    .word 0x319d5487
    .word 0x2dc02e31
    .word 0xf1efa08c
    .word 0x27e224f1
    .word 0xfb4b4486
    .word 0x457a2123
    .word 0xa31d2784
    .word 0x13895a51
    .word 0x2521374e
    .word 0x155a72d5
    .word 0x9d397d9f
    .word 0x952418d8
    .word 0x6ee7b2e6
    .word 0x6b2edb46
    .word 0xce8cbaf1
    .word 0x739aa996
    .word 0xbfebad27
    .word 0x11997e45
    .word 0x3b0a1f4f
    .word 0x1bc9e070
    .word 0xe3a6ad7d
    .word 0x20a8b28e
    .word 0xccf2eb08
    .word 0x5d4e916a
    .word 0x8a49bc6b
    .word 0x6bdcc56f
    .word 0xb8d073e8
    .word 0x678a16c0
    .word 0x8f73ebd7
    .word 0xa613a94c
    .word 0x4daa333d
    .word 0x507bad04
    .word 0x0a459e4d
    .word 0x23a59e4a
    .word 0xccf558ff
    .word 0x63592256
    .word 0x3ecefb31
    .word 0x90bc7df5
    .word 0xfd063f2a
    .word 0x0acf8339
    .word 0x6c90bd70
    .word 0x4763729f
    .word 0xcbee34a0
    .word 0x27d76834
    .word 0xeebb005c
    .word 0x0c8f8bd2
    .word 0x5495c273
    .word 0x21b4cb85
    .word 0x99536aea
    .word 0xcde5b435
    .word 0x79e0eebc
    .word 0xfa48d28f
    .word 0xde5d92d0
    .word 0x1dd928a7
    .word 0x58c00b8e
    .word 0xaf1fd52c
    .word 0x213ca764
    .word 0x458d8294
    .word 0x17f7a801
    .word 0xfbdf41c1
    .word 0x5d09dc42
    .word 0xdebdb353
    .word 0x5625ef10
    .word 0xa939ab8e
    .word 0x5f5a3d09
    .word 0x16ca83e5
    .word 0x54758f76
    .word 0x602b06e2
    .word 0x0cab5ddf
    .word 0xf4c66f4d
    .word 0x6cbf48d8
    .word 0xe7f105aa
    .word 0x33c56b80
    .word 0x8bca8b4c
    .word 0x31028cd8
    .word 0x893102cc
    .word 0xe044b90d
    .word 0x887658aa
    .word 0xd70bfd9d
    .word 0x04f3e5d1
    .word 0x1fb5fa93
    .word 0x2fcb0f35
    .word 0x04d8af13
    .word 0xffd76514
    .word 0xa6a82e29
    .word 0xad29f0ea
    .word 0xeb3238eb
    .word 0xf60b272a
    .word 0xe090d723
    .word 0x733e5200
    .word 0x7b0555f2
    .word 0xc78f4894
    .word 0xdfd9abd7
    .word 0x2be8c9ef
    .word 0xcd25ea62
    .word 0xcfecfc20
    .word 0x7ee4d648
    .word 0xecc79124
    .word 0xf11f2187
    .word 0x916468fa
    .word 0x599714ad
    .word 0x2a660ba0
    .word 0x2e96d845
    .word 0x17e16024
    .word 0xd29c37dc
    .word 0x5f327416
    .word 0xe2648abc
    .word 0x051ea88c
    .word 0xf6c22229
    .word 0xf797dbfc
    .word 0x7020c1f8
    .word 0x6188056a
    .word 0x43807c3e
    .word 0xc84c9b6f
    .word 0xde44111d
    .word 0x5f756546
    .word 0xa020a20f
    .word 0xeedb5673
    .word 0xf080ea26
    .word 0x17ca6e64
    .word 0x733bf20e
    .word 0x7e32834c
    .word 0xfcd61907
    .word 0x9d902b1c
    .word 0x68efcf32
    .word 0xed17de50
    .word 0xdd8154d4
    .word 0x2e5412b4
    .word 0x9f342541
    .word 0xdee8088b
    .word 0xe42fa196
    .word 0xdf2c2c02
    .word 0xd22160a6
    .word 0x3f336740
    .word 0xafd25002
    .word 0x6a6957bd
    .word 0xc55aa0ab
    .word 0x18066a02
    .word 0x43c1674d
    .word 0xefb38186
    .word 0x43bc255d
    .word 0x65ca60cd
    .word 0xbcd572b6
    .word 0x5d2225a3
    .word 0x04ebd7b2
    .word 0xb16ddf57
    .word 0xfc21aa14
    .word 0xf792e7a6
    .word 0x47c37d31
    .word 0x37a342a8
    .word 0xbea1982f
    .word 0x9da47456
    .word 0x237b2b78
    .word 0xdfce5f38
    .word 0xc54e8f55
    .word 0x2a544c58
    .word 0x0a698c24
    .word 0x5d641489
    .word 0x495a25b4
    .word 0xa53ac56b
    .word 0x052445c7
    .word 0xf608b0a1
    .word 0x023f9144
    .word 0x1379b10f
    .word 0x9e529a1a
    .word 0xc98a3387
    .word 0x9892bfce
    .word 0x594a9ce3
    .word 0x965d4fa9
    .word 0xee924604
    .word 0x9352b05f
    .word 0x81ad9cbc
    .word 0x41e39242
    .word 0xa84172a7
    .word 0xad8014bb
    .word 0xa5c85b05
    .word 0x5079bea6
    .word 0x1aa3496c
    .word 0x3b9b0450
    .word 0x541ae0c8
    .word 0x1a89ff50
    .word 0x18155615
    .word 0x420d2749
    .word 0x35f11861
    .word 0xfd392850
    .word 0x1d6ca3a8
    .word 0xaa4ab9d8
    .word 0x78035331
    .word 0x003ea218
    .word 0x48432c8e
    .word 0x6754653a
    .word 0x62e7e919
    .word 0x4885ce3d
    .word 0xe6f6fe1c
    .word 0xfb76a60a
    .word 0x6211b657
    .word 0x8cad51c4
    .word 0xf871bfb1
    .word 0xac086e7c
    .word 0x21c0117a
    .word 0xd7aa77b4
    .word 0x08d58ddf
    .word 0xd8370b98
    .word 0x7c44df90
    .word 0x619eb8c1
    .word 0x33a62cd0
    .word 0x24457647
    .word 0x054910ce
    .word 0x77e84292
    .word 0xba99e7ee
    .word 0xb666b841
    .word 0x3ae6b2a5
    .word 0x7d67d82b
    .word 0x7e415ba4
    .word 0xf145988e
    .word 0x1f5918c6
    .word 0xc4fc8f13
    .word 0x319151a8
    .word 0xdbc23273
    .word 0xcb78bf00
    .word 0xa3a123ef
    .word 0x49e276c7
    .word 0x02754459
    .word 0xed079de0
    .word 0x55ea7889
    .word 0x09d6f34a
    .word 0x8b32fd03
    .word 0xe2a66a9a
    .word 0x756bddb8
    .word 0x0766c253
    .word 0x2c6a14b9
    .word 0x0c04b003
    .word 0xab303773
    .word 0x4ba44537
    .word 0x00a20522
    .word 0x22e70e9b
    .word 0xb266b457
    .word 0xbea79db9
    .word 0x5cfcb3e4
    .word 0xab3e3c48
    .word 0x1cc41fad
    .word 0xfaf37708
    .word 0xb31e3663
    .word 0xc10ccdf3
    .word 0xc4abf5d8
    .word 0xc0fc349a
    .word 0xacaa234b
    .word 0x207e6c7c
    .word 0x8d5c8248
    .word 0x81da5dea
    .word 0x03c4e04e
    .word 0x2eb16cb1
    .word 0xd68d1374
    .word 0xc9bfcf93
    .word 0xb558d57e
    .word 0xe26fd97e
    .word 0x6a950b6b
    .word 0x74c83046
    .word 0xc84fe8a5
    .word 0xe3afcf16
    .word 0xd8ab2642
    .word 0xd0c8311c
    .word 0xa1e23c3d
    .word 0x202d00a8
    .word 0xd402d195
    .word 0xbab5c80f
    .word 0x0ce4900c
    .word 0xe11b61db
    .word 0x90eb2afd
    .word 0xdaf1fb1e
    .word 0x3bac409a
    .word 0x83ac78d1
    .word 0xd2e62930
    .word 0x30d6cd92
    .word 0x8378f980
    .word 0xfaba49f8
    .word 0xf27710df
    .word 0x4c797583
    .word 0xc8328acd
    .word 0x6aa67d30
    .word 0xbf020e38
    .word 0x0312a6b2
    .word 0x38a89a44
    .word 0x229f47ea
    .word 0x4860d03e
    .word 0x2d386eea
    .word 0xce5e8474
    .word 0x3d3be86d
    .word 0x44c6f005
    .word 0x6097a0b3
    .word 0xd583b27b
    .word 0x8674f34a
    .word 0x5f6d9eee
    .word 0x1975f7bf
    .word 0xfa2ebc82
    .word 0x7b5c9461
    .word 0x07984f2b
    .word 0x5b32dfb8
    .word 0x71729cec
    .word 0x693e21f7
    .word 0x6d288a65
    .word 0x95d8a111
    .word 0xde932dd2
    .word 0x753b7594
    .word 0xf8dbfcab
    .word 0x08be4c00
    .word 0xfa095d9f
    .word 0x7ca146c0
    .word 0x299c177a
    .word 0x96823c7f
    .word 0xab8c5bc4
    .word 0x35099f62
    .word 0x8fe3bfb2
    .word 0x2b8571a1
    .word 0x3554e208
    .word 0xb263c395
    .word 0xf442231e
    .word 0xdbb20695
    .word 0x9f24cf60
    .word 0x59d3e4b6
    .word 0xd121f00d
    .word 0xa6565f5e
    .word 0x16b66b5b
    .word 0x04882b41
    .word 0x8922eec5
    .word 0xf8e966be
    .word 0x7c2d32e8
    .word 0x6c8d9d7a
    .word 0x28900f0c
    .word 0x497f4f54
    .word 0x9b170f88
    .word 0xdb870868
    .word 0x243d8b49
    .word 0x73460301
    .word 0x32542e21
    .word 0x23bd1221
    .word 0x6cfdbe8e
    .word 0x708f43f0
    .word 0xcfbd661b
    .word 0x21c89d59
    .word 0x5f72083d
    .word 0xe0b03679
    .word 0xba515886
    .word 0xe79dc46f
    .word 0xbf63dd1a
    .word 0x9087fac4
    .word 0xc2398985
    .word 0x047a51a5
    .word 0x9d24a35c
    .word 0xbc910031
    .word 0xa67d8a73
    .word 0x21a0c686
    .word 0x7fa851f8
    .word 0xd53a5a0a
    .word 0x1495d212
    .word 0x26cb1963
    .word 0x2c386218
    .word 0x91357768
    .word 0x9af04013
    .word 0xa1c4e806
    .word 0x75befb4f
    .word 0xc1e1dcc1
    .word 0x4801ee8c
    .word 0x8c925441
    .word 0x1ccc6f8f
    .word 0xdc024b4f
    .word 0xba38a8d2
    .word 0xa272d2a8
    .word 0x26c70d5d
    .word 0xace30915
    .word 0x1e0391c1
    .word 0x63294fde
    .word 0x849c2619
    .word 0x69836868
    .word 0x835306d8
    .word 0xc3de9b5d
    .word 0x7f994ccd
    .word 0x15a899c3
    .word 0x825b60b0
    .word 0xbb0271b0
    .word 0x0f0d7001
    .word 0x028ff636
    .word 0xd9d01e3b
    .word 0x11ba0a62
    .word 0xe033aa8e
    .word 0xc357972b
    .word 0x6f8d5f89
    .word 0xbd938adf
    .word 0x8ad4c168
    .word 0xe9f37c86
    .word 0x8a224e3c
    .word 0xa0b4f2d9
    .word 0xb8ca19fb
    .word 0xa12ea989
    .word 0xc6d41bf8
    .word 0xf73c14bd
    .word 0x29ab7a8f
    .word 0xd77ae986
    .word 0x8082a487
    .word 0x0deec727
    .word 0xfc5416a4
    .word 0xa2fb92e6
    .word 0x1684d50d
    .word 0x1c740a6a
    .word 0xa500894a
    .word 0x43273645
    .word 0x5a565a75
    .word 0xf9f9672d
    .word 0xa7743bd2
    .word 0x718290b8
    .word 0x1b287066
    .word 0xe3efa310
    .word 0x682a757b
    .word 0x4df9a809
    .word 0xcb04d604
    .word 0x1383f772
    .word 0x91257a63
    .word 0xb9c4719a
    .word 0xd39ceacf
    .word 0x6fcc6fdd
    .word 0x4047de40
    .word 0xace9cf67
    .word 0xb96405be
    .word 0x5b62acc8
    .word 0x14e0b960
    .word 0x65b19066
    .word 0xef53a0d0
    .word 0x414319c3
    .word 0xbd87da61
    .word 0xcceefa05
    .word 0x443d5394
    .word 0xf9b36d5d
    .word 0xa942aaca
    .word 0xf16f1650
    .word 0xea196a7e

