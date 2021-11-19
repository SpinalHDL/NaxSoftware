.globl _start
_start:

    addi x1, x0, 0x1 // 1
    addi x2, x0, 0x2 // 2
    addi x3, x1, 0x2 // 3
    addi x4, x3, 0x4 // 7
    add  x5, x1, x2  // 3
    add  x6, x5, x5  // 6
    add  x7, x4, x5  // 10
    beq x3,x5, j1
    addi x3, x0, -1;
    j1:
    beq x3,x5, j2
    addi x3, x0, -2;
    j2:
    beq x3,x5, j3
    addi x3, x0, -3;
    nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
j3:
    nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
    addi x1, x0, 0x0
    addi x2, x0, 0x0
    addi x3, x0, 0x0
    addi x4, x0, 0x0
    addi x5, x0, 0x0
    addi x6, x0, 0x0
    addi x7, x0, 0x0
    beq x0,x0, _start

    xor x1,x2,x3
    nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;

    addi  x0, x0, 0x00
    addi  x1, x0, 0x01
    addi  x2, x0, 0x02
    addi  x3, x0, 0x03
    addi  x4, x0, 0x04
    addi  x5, x0, 0x05
    addi  x6, x0, 0x06
    addi  x7, x0, 0x07
    addi  x8, x0, 0x08
    addi  x9, x0, 0x09
    addi x10, x0, 0x10
    addi x11, x0, 0x11
    addi x12, x0, 0x12
    addi x13, x0, 0x13
    addi x14, x0, 0x14
    addi x15, x0, 0x15
    addi x16, x0, 0x16
    addi x17, x0, 0x17
    addi x18, x0, 0x18
    addi x19, x0, 0x19
    addi x20, x0, 0x20
    addi x21, x0, 0x21
    addi x22, x0, 0x22
    addi x23, x0, 0x23
    addi x24, x0, 0x24
    addi x25, x0, 0x25
    addi x26, x0, 0x26
    addi x27, x0, 0x27
    addi x28, x0, 0x28
    addi x29, x0, 0x29
    addi x30, x0, 0x30
    addi x31, x0, 0x31

    addi  x0, x0, 0x00
    addi  x1, x0, 0x01
    addi  x2, x0, 0x02
    addi  x3, x0, 0x03
    addi  x4, x0, 0x04
    addi  x5, x0, 0x05
    addi  x6, x0, 0x06
    addi  x7, x0, 0x07
    addi  x8, x0, 0x08
    addi  x9, x0, 0x09
    addi x10, x0, 0x10
    addi x11, x0, 0x11
    addi x12, x0, 0x12
    addi x13, x0, 0x13
    addi x14, x0, 0x14
    addi x15, x0, 0x15
    addi x16, x0, 0x16
    addi x17, x0, 0x17
    addi x18, x0, 0x18
    addi x19, x0, 0x19
    addi x20, x0, 0x20
    addi x21, x0, 0x21
    addi x22, x0, 0x22
    addi x23, x0, 0x23
    addi x24, x0, 0x24
    addi x25, x0, 0x25
    addi x26, x0, 0x26
    addi x27, x0, 0x27
    addi x28, x0, 0x28
    addi x29, x0, 0x29
    addi x30, x0, 0x30
    addi x31, x0, 0x31


    addi  x0, x0, 0x00
    addi  x1, x0, 0x01
    addi  x2, x0, 0x02
    addi  x3, x0, 0x03
    addi  x4, x0, 0x04
    addi  x5, x0, 0x05
    addi  x6, x0, 0x06
    addi  x7, x0, 0x07
    addi  x8, x0, 0x08
    addi  x9, x0, 0x09
    addi x10, x0, 0x10
    addi x11, x0, 0x11
    addi x12, x0, 0x12
    addi x13, x0, 0x13
    addi x14, x0, 0x14
    addi x15, x0, 0x15
    addi x16, x0, 0x16
    addi x17, x0, 0x17
    addi x18, x0, 0x18
    addi x19, x0, 0x19
    addi x20, x0, 0x20
    addi x21, x0, 0x21
    addi x22, x0, 0x22
    addi x23, x0, 0x23
    addi x24, x0, 0x24
    addi x25, x0, 0x25
    addi x26, x0, 0x26
    addi x27, x0, 0x27
    addi x28, x0, 0x28
    addi x29, x0, 0x29
    addi x30, x0, 0x30
    addi x31, x0, 0x31


    addi  x0, x0, 0x00
    addi  x1, x0, 0x01
    addi  x2, x0, 0x02
    addi  x3, x0, 0x03
    addi  x4, x0, 0x04
    addi  x5, x0, 0x05
    addi  x6, x0, 0x06
    addi  x7, x0, 0x07
    addi  x8, x0, 0x08
    addi  x9, x0, 0x09
    addi x10, x0, 0x10
    addi x11, x0, 0x11
    addi x12, x0, 0x12
    addi x13, x0, 0x13
    addi x14, x0, 0x14
    addi x15, x0, 0x15
    addi x16, x0, 0x16
    addi x17, x0, 0x17
    addi x18, x0, 0x18
    addi x19, x0, 0x19
    addi x20, x0, 0x20
    addi x21, x0, 0x21
    addi x22, x0, 0x22
    addi x23, x0, 0x23
    addi x24, x0, 0x24
    addi x25, x0, 0x25
    addi x26, x0, 0x26
    addi x27, x0, 0x27
    addi x28, x0, 0x28
    addi x29, x0, 0x29
    addi x30, x0, 0x30
    addi x31, x0, 0x31