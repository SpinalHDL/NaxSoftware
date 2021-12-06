
build/lsu.elf:     file format elf32-littleriscv


Disassembly of section .crt_section:

80000000 <_start>:
80000000:	00000097          	auipc	ra,0x0
80000004:	1b008093          	addi	ra,ra,432 # 800001b0 <data>
80000008:	00400f93          	li	t6,4

8000000c <redo>:
8000000c:	0000a103          	lw	sp,0(ra)
80000010:	0040a103          	lw	sp,4(ra)
80000014:	0080a103          	lw	sp,8(ra)
80000018:	00c0a103          	lw	sp,12(ra)
8000001c:	00000013          	nop
80000020:	00000013          	nop
80000024:	00000013          	nop
80000028:	00000013          	nop
8000002c:	00000013          	nop
80000030:	00000013          	nop
80000034:	00000013          	nop
80000038:	00000013          	nop
8000003c:	00000013          	nop
80000040:	00000013          	nop
80000044:	00000013          	nop
80000048:	00000013          	nop
8000004c:	00000013          	nop
80000050:	0000a103          	lw	sp,0(ra)
80000054:	0040a103          	lw	sp,4(ra)
80000058:	0080a103          	lw	sp,8(ra)
8000005c:	00c0a103          	lw	sp,12(ra)
80000060:	0000a103          	lw	sp,0(ra)
80000064:	0040a103          	lw	sp,4(ra)
80000068:	0080a103          	lw	sp,8(ra)
8000006c:	00c0a103          	lw	sp,12(ra)
80000070:	0000a103          	lw	sp,0(ra)
80000074:	0040a103          	lw	sp,4(ra)
80000078:	0080a103          	lw	sp,8(ra)
8000007c:	00c0a103          	lw	sp,12(ra)
80000080:	0000a103          	lw	sp,0(ra)
80000084:	0040a103          	lw	sp,4(ra)
80000088:	0080a103          	lw	sp,8(ra)
8000008c:	00c0a103          	lw	sp,12(ra)
80000090:	0000a103          	lw	sp,0(ra)
80000094:	0040a103          	lw	sp,4(ra)
80000098:	0080a103          	lw	sp,8(ra)
8000009c:	00c0a103          	lw	sp,12(ra)
800000a0:	0000a103          	lw	sp,0(ra)
800000a4:	0040a103          	lw	sp,4(ra)
800000a8:	0080a103          	lw	sp,8(ra)
800000ac:	00c0a103          	lw	sp,12(ra)
800000b0:	0000a103          	lw	sp,0(ra)
800000b4:	0040a103          	lw	sp,4(ra)
800000b8:	0080a103          	lw	sp,8(ra)
800000bc:	00c0a103          	lw	sp,12(ra)
800000c0:	0000a103          	lw	sp,0(ra)
800000c4:	0040a103          	lw	sp,4(ra)
800000c8:	0080a103          	lw	sp,8(ra)
800000cc:	00c0a103          	lw	sp,12(ra)
800000d0:	0000a103          	lw	sp,0(ra)
800000d4:	0040a103          	lw	sp,4(ra)
800000d8:	0080a103          	lw	sp,8(ra)
800000dc:	00c0a103          	lw	sp,12(ra)
800000e0:	04008093          	addi	ra,ra,64
800000e4:	ffff8f93          	addi	t6,t6,-1
800000e8:	f20f92e3          	bnez	t6,8000000c <redo>

800000ec <pass>:
800000ec:	00000013          	nop

800000f0 <fail>:
800000f0:	00000013          	nop
800000f4:	00000013          	nop
800000f8:	00000013          	nop
800000fc:	00000013          	nop
80000100:	00000013          	nop
80000104:	00000013          	nop
80000108:	00000013          	nop
8000010c:	00000013          	nop
80000110:	00000013          	nop
80000114:	00000013          	nop
80000118:	00000013          	nop
8000011c:	00000013          	nop
80000120:	00000013          	nop
80000124:	00000013          	nop
80000128:	00000013          	nop
8000012c:	00000013          	nop
80000130:	00000013          	nop
80000134:	00000013          	nop
80000138:	00000013          	nop
8000013c:	00000013          	nop
80000140:	00000013          	nop
80000144:	00000013          	nop
80000148:	00000013          	nop
8000014c:	00000013          	nop
80000150:	00000013          	nop
80000154:	00000013          	nop
80000158:	00000013          	nop
8000015c:	00000013          	nop
80000160:	00000013          	nop
80000164:	00000013          	nop
80000168:	00000013          	nop
8000016c:	00000013          	nop
80000170:	00000013          	nop
80000174:	00000013          	nop
80000178:	00000013          	nop
8000017c:	00000013          	nop
80000180:	00000013          	nop
80000184:	00000013          	nop
80000188:	00000013          	nop
8000018c:	00000013          	nop
80000190:	00000013          	nop
80000194:	00000013          	nop
80000198:	00000013          	nop
8000019c:	00000013          	nop
800001a0:	00000013          	nop
800001a4:	00000013          	nop
800001a8:	00000013          	nop
800001ac:	00000013          	nop

800001b0 <data>:
800001b0:	1b60                	addi	s0,sp,444
800001b2:	27e9                	jal	8000097c <data+0x7cc>
800001b4:	a656bbbb          	0xa656bbbb
800001b8:	59014f57          	0x59014f57
800001bc:	e339e4d3          	0xe339e4d3
800001c0:	ce54                	sw	a3,28(a2)
800001c2:	1546                	slli	a0,a0,0x31
800001c4:	aa010ccf          	fnmadd.d	fs9,ft2,ft0,fs5,rne
800001c8:	2419                	jal	800003ce <data+0x21e>
800001ca:	6bbe                	flw	fs7,204(sp)
800001cc:	949e                	add	s1,s1,t2
800001ce:	a3cc                	fsd	fa1,128(a5)
800001d0:	3d1d386b          	0x3d1d386b
800001d4:	285a                	fld	fa6,400(sp)
800001d6:	6d56                	flw	fs10,84(sp)
800001d8:	45e5                	li	a1,25
800001da:	49b1                	li	s3,12
800001dc:	39650987          	0x39650987
800001e0:	1b90cb33          	0x1b90cb33
800001e4:	38a1                	jal	7ffffa3c <_start-0x5c4>
800001e6:	95d5                	srai	a1,a1,0x35
800001e8:	ec1a                	fsw	ft6,24(sp)
800001ea:	2020                	fld	fs0,64(s0)
800001ec:	c666                	sw	s9,12(sp)
800001ee:	e9d9                	bnez	a1,80000284 <data+0xd4>
800001f0:	d35d8173          	0xd35d8173
800001f4:	6196                	flw	ft3,68(sp)
800001f6:	e022                	fsw	fs0,0(sp)
800001f8:	a7b8                	fsd	fa4,72(a5)
800001fa:	e991                	bnez	a1,8000020e <data+0x5e>
800001fc:	f65a                	fsw	fs6,44(sp)
800001fe:	fdf6                	fsw	ft9,248(sp)
80000200:	a339                	j	8000070e <data+0x55e>
80000202:	c5bc                	sw	a5,72(a1)
80000204:	72b1                	lui	t0,0xfffec
80000206:	663c                	flw	fa5,72(a2)
80000208:	e589                	bnez	a1,80000212 <data+0x62>
8000020a:	f618                	fsw	fa4,40(a2)
8000020c:	bc56                	fsd	fs5,56(sp)
8000020e:	520c                	lw	a1,32(a2)
80000210:	5a36                	lw	s4,108(sp)
80000212:	e8d204bf e9c03f34 	0xe9c03f34e8d204bf
8000021a:	d8c151b3          	0xd8c151b3
8000021e:	7d41                	lui	s10,0xffff0
80000220:	3065                	jal	7ffffac8 <_start-0x538>
80000222:	66e2                	flw	fa3,24(sp)
80000224:	467f                	0x467f
80000226:	1a8c                	addi	a1,sp,368
80000228:	3f5d                	jal	800001de <data+0x2e>
8000022a:	aa44                	fsd	fs1,144(a2)
8000022c:	f07c                	fsw	fa5,100(s0)
8000022e:	e92818e3          	bne	a6,s2,800000be <redo+0xb2>
80000232:	c40654cf          	0xc40654cf
80000236:	539f 1c7f 0f2a      	0xf2a1c7f539f
8000023c:	d67e                	sw	t6,44(sp)
8000023e:	7c0d                	lui	s8,0xfffe3
80000240:	ea6a                	fsw	fs10,20(sp)
80000242:	90be                	add	ra,ra,a5
80000244:	2372ad93          	slti	s11,t0,567
80000248:	ac2d                	j	80000482 <data+0x2d2>
8000024a:	9ec5                	0x9ec5
8000024c:	e098                	fsw	fa4,0(s1)
8000024e:	5e2a                	lw	t3,168(sp)
80000250:	aca0                	fsd	fs0,88(s1)
80000252:	58df22c7          	fmsub.s	ft5,ft10,fa3,fa1,rdn
80000256:	850bd393          	0x850bd393
8000025a:	68f5                	lui	a7,0x1d
8000025c:	e359                	bnez	a4,800002e2 <data+0x132>
8000025e:	68b2                	flw	fa7,12(sp)
80000260:	de74                	sw	a3,124(a2)
80000262:	973c0e57          	0x973c0e57
80000266:	1951                	addi	s2,s2,-12
80000268:	39fe                	fld	fs3,504(sp)
8000026a:	777133bf 52dad337 	0x52dad337777133bf
80000272:	90a29073          	csrw	0x90a,t0
80000276:	7990ad07          	flw	fs10,1945(ra)
8000027a:	976a                	add	a4,a4,s10
8000027c:	3f55                	jal	80000230 <data+0x80>
8000027e:	8099e283          	0x8099e283
80000282:	1ac8                	addi	a0,sp,372
80000284:	904d                	srli	s0,s0,0x33
80000286:	b0f3616f          	jal	sp,7ff36d94 <_start-0xc926c>
8000028a:	482a8567          	jalr	a0,1154(s5)
8000028e:	65e6                	flw	fa1,88(sp)
80000290:	9000                	0x9000
80000292:	ebfe                	fsw	ft11,212(sp)
80000294:	e47c                	fsw	fa5,76(s0)
80000296:	5d74                	lw	a3,124(a0)
80000298:	8ad1                	andi	a3,a3,20
8000029a:	8df7b6e3          	0x8df7b6e3
8000029e:	df85                	beqz	a5,800001d6 <data+0x26>
800002a0:	f2e4                	fsw	fs1,100(a3)
800002a2:	dc3c                	sw	a5,120(s0)
800002a4:	6d31                	lui	s10,0xc
800002a6:	be81                	j	7ffffdf6 <_start-0x20a>
800002a8:	e1a906cf          	fnmadd.s	fa3,fs2,fs10,ft8,rne
800002ac:	c191                	beqz	a1,800002b0 <data+0x100>
800002ae:	5ac5                	li	s5,-15
800002b0:	3c54                	fld	fa3,184(s0)
800002b2:	555f 614e 7648      	0x7648614e555f
800002b8:	b0de                	fsd	fs7,96(sp)
800002ba:	ba41                	j	7ffffc4a <_start-0x3b6>
800002bc:	061f a39f 99cb      	0x99cba39f061f
800002c2:	d0a5                	beqz	s1,80000222 <data+0x72>
800002c4:	f295                	bnez	a3,800001e8 <data+0x38>
800002c6:	9852                	add	a6,a6,s4
800002c8:	0460                	addi	s0,sp,524
800002ca:	fc24                	fsw	fs1,120(s0)
800002cc:	b3ce                	fsd	fs3,480(sp)
800002ce:	84aea643          	0x84aea643
800002d2:	7c72                	flw	fs8,60(sp)
800002d4:	edcc                	fsw	fa1,28(a1)
800002d6:	644d                	lui	s0,0x13
800002d8:	bede                	fsd	fs7,376(sp)
800002da:	ed9daa8f          	0xed9daa8f
800002de:	e174                	fsw	fa3,68(a0)
800002e0:	c6e1                	beqz	a3,800003a8 <data+0x1f8>
800002e2:	707a                	flw	ft0,188(sp)
800002e4:	319d5487          	0x319d5487
800002e8:	2e31                	jal	80000604 <data+0x454>
800002ea:	2dc0                	fld	fs0,152(a1)
800002ec:	a08c                	fsd	fa1,0(s1)
800002ee:	24f1f1ef          	jal	gp,8001fd3c <data+0x1fb8c>
800002f2:	27e2                	fld	fa5,24(sp)
800002f4:	4486                	lw	s1,64(sp)
800002f6:	2123fb4b          	fnmsub.s	fs6,ft7,fs2,ft4
800002fa:	457a                	lw	a0,156(sp)
800002fc:	2784                	fld	fs1,8(a5)
800002fe:	a31d                	j	80000824 <data+0x674>
80000300:	5a51                	li	s4,-12
80000302:	1389                	addi	t2,t2,-30
80000304:	374e                	fld	fa4,240(sp)
80000306:	2521                	jal	8000090e <data+0x75e>
80000308:	72d5                	lui	t0,0xffff5
8000030a:	155a                	slli	a0,a0,0x36
8000030c:	7d9f 9d39 18d8      	0x18d89d397d9f
80000312:	9524                	0x9524
80000314:	b2e6                	fsd	fs9,352(sp)
80000316:	db466ee7          	0xdb466ee7
8000031a:	6b2e                	flw	fs6,200(sp)
8000031c:	baf1                	j	7ffffcf8 <_start-0x308>
8000031e:	ce8c                	sw	a1,24(a3)
80000320:	a996                	fsd	ft5,208(sp)
80000322:	739a                	flw	ft7,164(sp)
80000324:	bfebad27          	fsw	ft10,-1030(s7)
80000328:	7e45                	lui	t3,0xffff1
8000032a:	1199                	addi	gp,gp,-26
8000032c:	3b0a1f4f          	fnmadd.d	ft10,fs4,fa6,ft7,rtz
80000330:	e070                	fsw	fa2,68(s0)
80000332:	1bc9                	addi	s7,s7,-14
80000334:	ad7d                	j	800009f2 <data+0x842>
80000336:	e3a6                	fsw	fs1,196(sp)
80000338:	b28e                	fsd	ft3,352(sp)
8000033a:	20a8                	fld	fa0,64(s1)
8000033c:	eb08                	fsw	fa0,16(a4)
8000033e:	ccf2                	sw	t3,88(sp)
80000340:	916a                	add	sp,sp,s10
80000342:	5d4e                	lw	s10,240(sp)
80000344:	8a49bc6b          	0x8a49bc6b
80000348:	6bdcc56f          	jal	a0,800cd204 <data+0xcd054>
8000034c:	73e8                	flw	fa0,100(a5)
8000034e:	b8d0                	fsd	fa2,176(s1)
80000350:	16c0                	addi	s0,sp,868
80000352:	678a                	flw	fa5,128(sp)
80000354:	8f73ebd7          	0x8f73ebd7
80000358:	a94c                	fsd	fa1,144(a0)
8000035a:	333da613          	slti	a2,s11,819
8000035e:	4daa                	lw	s11,136(sp)
80000360:	ad04                	fsd	fs1,24(a0)
80000362:	9e4d507b          	0x9e4d507b
80000366:	0a45                	addi	s4,s4,17
80000368:	9e4a                	add	t3,t3,s2
8000036a:	23a5                	jal	800008d2 <data+0x722>
8000036c:	58ff                	0x58ff
8000036e:	ccf5                	beqz	s1,8000046a <data+0x2ba>
80000370:	2256                	fld	ft4,336(sp)
80000372:	6359                	lui	t1,0x16
80000374:	fb31                	bnez	a4,800002c8 <data+0x118>
80000376:	3ece                	fld	ft9,240(sp)
80000378:	7df5                	lui	s11,0xffffd
8000037a:	90bc                	0x90bc
8000037c:	3f2a                	fld	ft10,168(sp)
8000037e:	fd06                	fsw	ft1,184(sp)
80000380:	8339                	srli	a4,a4,0xe
80000382:	bd700acf          	0xbd700acf
80000386:	6c90                	flw	fa2,24(s1)
80000388:	729f 4763 34a0      	0x34a04763729f
8000038e:	cbee                	sw	s11,212(sp)
80000390:	6834                	flw	fa3,80(s0)
80000392:	005c27d7          	0x5c27d7
80000396:	8bd2eebb          	0x8bd2eebb
8000039a:	c2730c8f          	0xc2730c8f
8000039e:	5495                	li	s1,-27
800003a0:	cb85                	beqz	a5,800003d0 <data+0x220>
800003a2:	21b4                	fld	fa3,64(a1)
800003a4:	6aea                	flw	fs5,152(sp)
800003a6:	b4359953          	0xb4359953
800003aa:	cde5                	beqz	a1,800004a2 <data+0x2f2>
800003ac:	eebc                	fsw	fa5,88(a3)
800003ae:	79e0                	flw	fs0,116(a1)
800003b0:	fa48d28f          	0xfa48d28f
800003b4:	92d0                	0x92d0
800003b6:	de5d                	beqz	a2,80000374 <data+0x1c4>
800003b8:	1dd928a7          	fsw	ft9,465(s2)
800003bc:	0b8e                	slli	s7,s7,0x3
800003be:	58c0                	lw	s0,52(s1)
800003c0:	d52c                	sw	a1,104(a0)
800003c2:	af1f a764 213c      	0x213ca764af1f
800003c8:	8294                	0x8294
800003ca:	458d                	li	a1,3
800003cc:	a801                	j	800003dc <data+0x22c>
800003ce:	41c117f7          	0x41c117f7
800003d2:	fbdf dc42 5d09      	0x5d09dc42fbdf
800003d8:	debdb353          	0xdebdb353
800003dc:	ef10                	fsw	fa2,24(a4)
800003de:	5625                	li	a2,-23
800003e0:	ab8e                	fsd	ft3,464(sp)
800003e2:	a939                	j	80000800 <data+0x650>
800003e4:	3d09                	jal	800001f6 <data+0x46>
800003e6:	5f5a                	lw	t5,180(sp)
800003e8:	83e5                	srli	a5,a5,0x19
800003ea:	16ca                	slli	a3,a3,0x32
800003ec:	8f76                	mv	t5,t4
800003ee:	5475                	li	s0,-3
800003f0:	06e2                	slli	a3,a3,0x18
800003f2:	5ddf602b          	0x5ddf602b
800003f6:	6f4d0cab          	0x6f4d0cab
800003fa:	f4c6                	fsw	fa7,104(sp)
800003fc:	48d8                	lw	a4,20(s1)
800003fe:	05aa6cbf 6b80e7f1 	0x6b80e7f105aa6cbf
80000406:	33c5                	jal	800001e6 <data+0x36>
80000408:	8b4c                	0x8b4c
8000040a:	8bca                	mv	s7,s2
8000040c:	8cd8                	0x8cd8
8000040e:	3102                	fld	ft2,32(sp)
80000410:	02cc                	addi	a1,sp,324
80000412:	8931                	andi	a0,a0,12
80000414:	b90d                	j	80000046 <redo+0x3a>
80000416:	e044                	fsw	fs1,4(s0)
80000418:	58aa                	lw	a7,168(sp)
8000041a:	8876                	mv	a6,t4
8000041c:	fd9d                	bnez	a1,8000035a <data+0x1aa>
8000041e:	e5d1d70b          	0xe5d1d70b
80000422:	fa9304f3          	0xfa9304f3
80000426:	1fb5                	addi	t6,t6,-19
80000428:	0f35                	addi	t5,t5,13
8000042a:	af132fcb          	fnmsub.q	ft11,ft6,fa7,fs5,rdn
8000042e:	04d8                	addi	a4,sp,580
80000430:	6514                	flw	fa3,8(a0)
80000432:	2e29ffd7          	0x2e29ffd7
80000436:	a6a8                	fsd	fa0,72(a3)
80000438:	f0ea                	fsw	fs10,96(sp)
8000043a:	ad29                	j	80000a54 <data+0x8a4>
8000043c:	eb3238eb          	0xeb3238eb
80000440:	272a                	fld	fa4,136(sp)
80000442:	d723f60b          	0xd723f60b
80000446:	e090                	fsw	fa2,0(s1)
80000448:	5200                	lw	s0,32(a2)
8000044a:	733e                	flw	ft6,236(sp)
8000044c:	55f2                	lw	a1,60(sp)
8000044e:	7b05                	lui	s6,0xfffe1
80000450:	4894                	lw	a3,16(s1)
80000452:	abd7c78f          	0xabd7c78f
80000456:	dfd9                	beqz	a5,800003f4 <data+0x244>
80000458:	2be8c9ef          	jal	s3,8008c716 <data+0x8c566>
8000045c:	ea62                	fsw	fs8,20(sp)
8000045e:	cd25                	beqz	a0,800004d6 <data+0x326>
80000460:	fc20                	fsw	fs0,120(s0)
80000462:	cfec                	sw	a1,92(a5)
80000464:	d648                	sw	a0,44(a2)
80000466:	7ee4                	flw	fs1,124(a3)
80000468:	9124                	0x9124
8000046a:	2187ecc7          	fmsub.s	fs9,fa5,fs8,ft4,unknown
8000046e:	f11f 68fa 9164      	0x916468faf11f
80000474:	14ad                	addi	s1,s1,-21
80000476:	0ba05997          	auipc	s3,0xba05
8000047a:	2a66                	fld	fs4,88(sp)
8000047c:	d845                	beqz	s0,8000042c <data+0x27c>
8000047e:	2e96                	fld	ft9,320(sp)
80000480:	6024                	flw	fs1,64(s0)
80000482:	17e1                	addi	a5,a5,-8
80000484:	37dc                	fld	fa5,168(a5)
80000486:	d29c                	sw	a5,32(a3)
80000488:	7416                	flw	fs0,100(sp)
8000048a:	5f32                	lw	t5,44(sp)
8000048c:	8abc                	0x8abc
8000048e:	e264                	fsw	fs1,68(a2)
80000490:	a88c                	fsd	fa1,16(s1)
80000492:	051e                	slli	a0,a0,0x7
80000494:	2229                	jal	8000059e <data+0x3ee>
80000496:	f6c2                	fsw	fa6,108(sp)
80000498:	dbfc                	sw	a5,116(a5)
8000049a:	c1f8f797          	auipc	a5,0xc1f8f
8000049e:	7020                	flw	fs0,96(s0)
800004a0:	056a                	slli	a0,a0,0x1a
800004a2:	6188                	flw	fa0,0(a1)
800004a4:	7c3e                	flw	fs8,236(sp)
800004a6:	4380                	lw	s0,0(a5)
800004a8:	c84c9b6f          	jal	s6,7ffc992c <_start-0x366d4>
800004ac:	111d                	addi	sp,sp,-25
800004ae:	de44                	sw	s1,60(a2)
800004b0:	6546                	flw	fa0,80(sp)
800004b2:	5f75                	li	t5,-3
800004b4:	a020a20f          	0xa020a20f
800004b8:	eedb5673          	csrrwi	a2,0xeed,22
800004bc:	ea26                	fsw	fs1,20(sp)
800004be:	f080                	fsw	fs0,32(s1)
800004c0:	6e64                	flw	fs1,92(a2)
800004c2:	17ca                	slli	a5,a5,0x32
800004c4:	f20e                	fsw	ft3,36(sp)
800004c6:	834c733b          	0x834c733b
800004ca:	7e32                	flw	ft8,44(sp)
800004cc:	fcd61907          	0xfcd61907
800004d0:	2b1c                	fld	fa5,16(a4)
800004d2:	9d90                	0x9d90
800004d4:	cf32                	sw	a2,156(sp)
800004d6:	de5068ef          	jal	a7,7ff072ba <_start-0xf8d46>
800004da:	54d4ed17          	auipc	s10,0x54d4e
800004de:	dd81                	beqz	a1,800003f6 <data+0x246>
800004e0:	12b4                	addi	a3,sp,360
800004e2:	2e54                	fld	fa3,152(a2)
800004e4:	2541                	jal	80000b64 <data+0x9b4>
800004e6:	9f34                	0x9f34
800004e8:	dee8088b          	0xdee8088b
800004ec:	a196                	fsd	ft5,192(sp)
800004ee:	2c02e42f          	0x2c02e42f
800004f2:	df2c                	sw	a1,120(a4)
800004f4:	60a6                	flw	ft1,72(sp)
800004f6:	d221                	beqz	a2,80000436 <data+0x286>
800004f8:	6740                	flw	fs0,12(a4)
800004fa:	50023f33          	0x50023f33
800004fe:	afd2                	fsd	fs4,472(sp)
80000500:	57bd                	li	a5,-17
80000502:	6a69                	lui	s4,0x1a
80000504:	c55aa0ab          	0xc55aa0ab
80000508:	6a02                	flw	fs4,0(sp)
8000050a:	1806                	slli	a6,a6,0x21
8000050c:	674d                	lui	a4,0x13
8000050e:	43c1                	li	t2,16
80000510:	8186                	mv	gp,ra
80000512:	255defb3          	0x255defb3
80000516:	43bc                	lw	a5,64(a5)
80000518:	60cd                	lui	ra,0x13
8000051a:	65ca                	flw	fa1,144(sp)
8000051c:	72b6                	flw	ft5,108(sp)
8000051e:	bcd5                	j	80000012 <redo+0x6>
80000520:	5d2225a3          	sw	s2,1483(tp) # 5cb <_start-0x7ffffa35>
80000524:	d7b2                	sw	a2,236(sp)
80000526:	df5704eb          	0xdf5704eb
8000052a:	b16d                	j	800001d4 <data+0x24>
8000052c:	aa14                	fsd	fa3,16(a2)
8000052e:	fc21                	bnez	s0,80000486 <data+0x2d6>
80000530:	e7a6                	fsw	fs1,204(sp)
80000532:	f792                	fsw	ft4,236(sp)
80000534:	7d31                	lui	s10,0xfffec
80000536:	42a847c3          	fmadd.d	fa5,fa6,fa0,fs0,rmm
8000053a:	982f37a3          	0x982f37a3
8000053e:	bea1                	j	80000096 <redo+0x8a>
80000540:	7456                	flw	fs0,116(sp)
80000542:	9da4                	0x9da4
80000544:	2b78                	fld	fa4,208(a4)
80000546:	5f38237b          	0x5f38237b
8000054a:	dfce                	sw	s3,252(sp)
8000054c:	8f55                	or	a4,a4,a3
8000054e:	c54e                	sw	s3,136(sp)
80000550:	4c58                	lw	a4,28(s0)
80000552:	2a54                	fld	fa3,144(a2)
80000554:	8c24                	0x8c24
80000556:	0a69                	addi	s4,s4,26
80000558:	1489                	addi	s1,s1,-30
8000055a:	5d64                	lw	s1,124(a0)
8000055c:	25b4                	fld	fa3,72(a1)
8000055e:	495a                	lw	s2,148(sp)
80000560:	a53ac56b          	0xa53ac56b
80000564:	052445c7          	0x52445c7
80000568:	b0a1                	j	7ffffdb0 <_start-0x250>
8000056a:	f608                	fsw	fa0,40(a2)
8000056c:	9144                	0x9144
8000056e:	b10f023f 9a1a1379 	0x9a1a1379b10f023f
80000576:	9e52                	add	t3,t3,s4
80000578:	c98a3387          	fld	ft7,-872(s4) # 19c98 <_start-0x7ffe6368>
8000057c:	bfce                	fsd	fs3,504(sp)
8000057e:	9892                	add	a7,a7,tp
80000580:	594a9ce3          	bne	s5,s4,80001318 <data+0x1168>
80000584:	4fa9                	li	t6,10
80000586:	965d                	srai	a2,a2,0x37
80000588:	4604                	lw	s1,8(a2)
8000058a:	ee92                	fsw	ft4,92(sp)
8000058c:	b05f 9352 9cbc      	0x9cbc9352b05f
80000592:	81ad                	srli	a1,a1,0xb
80000594:	9242                	add	tp,tp,a6
80000596:	72a741e3          	blt	a4,a0,800014b8 <data+0x1308>
8000059a:	a841                	j	8000062a <data+0x47a>
8000059c:	ad8014bb          	0xad8014bb
800005a0:	5b05                	li	s6,-31
800005a2:	a5c8                	fsd	fa0,136(a1)
800005a4:	bea6                	fsd	fs1,376(sp)
800005a6:	5079                	c.li	zero,-2
800005a8:	496c                	lw	a1,84(a0)
800005aa:	04501aa3          	sh	t0,85(zero) # 55 <_start-0x7fffffab>
800005ae:	e0c83b9b          	0xe0c83b9b
800005b2:	541a                	lw	s0,164(sp)
800005b4:	ff50                	fsw	fa2,60(a4)
800005b6:	1a89                	addi	s5,s5,-30
800005b8:	5615                	li	a2,-27
800005ba:	1815                	addi	a6,a6,-27
800005bc:	2749                	jal	80000d3e <data+0xb8e>
800005be:	420d                	li	tp,3
800005c0:	1861                	addi	a6,a6,-8
800005c2:	35f1                	jal	8000048e <data+0x2de>
800005c4:	2850                	fld	fa2,144(s0)
800005c6:	fd39                	bnez	a0,80000524 <data+0x374>
800005c8:	a3a8                	fsd	fa0,64(a5)
800005ca:	1d6c                	addi	a1,sp,700
800005cc:	b9d8                	fsd	fa4,176(a1)
800005ce:	aa4a                	fsd	fs2,272(sp)
800005d0:	5331                	li	t1,-20
800005d2:	a2187803          	0xa2187803
800005d6:	003e                	c.slli	zero,0xf
800005d8:	2c8e                	fld	fs9,192(sp)
800005da:	653a4843          	0x653a4843
800005de:	6754                	flw	fa3,12(a4)
800005e0:	e919                	bnez	a0,800005f6 <data+0x446>
800005e2:	ce3d62e7          	0xce3d62e7
800005e6:	4885                	li	a7,1
800005e8:	fe1c                	fsw	fa5,56(a2)
800005ea:	e6f6                	fsw	ft9,76(sp)
800005ec:	a60a                	fsd	ft2,264(sp)
800005ee:	fb76                	fsw	ft9,180(sp)
800005f0:	6211b657          	0x6211b657
800005f4:	51c4                	lw	s1,36(a1)
800005f6:	8cad                	xor	s1,s1,a1
800005f8:	bfb1                	j	80000554 <data+0x3a4>
800005fa:	f871                	bnez	s0,800005ce <data+0x41e>
800005fc:	6e7c                	flw	fa5,92(a2)
800005fe:	ac08                	fsd	fa0,24(s0)
80000600:	117a                	slli	sp,sp,0x3e
80000602:	21c0                	fld	fs0,128(a1)
80000604:	77b4                	flw	fa3,104(a5)
80000606:	d7aa                	sw	a0,236(sp)
80000608:	8ddf 08d5 0b98      	0xb9808d58ddf
8000060e:	df90d837          	lui	a6,0xdf90d
80000612:	7c44                	flw	fs1,60(s0)
80000614:	b8c1                	j	7ffffee4 <_start-0x11c>
80000616:	619e                	flw	ft3,196(sp)
80000618:	2cd0                	fld	fa2,152(s1)
8000061a:	33a6                	fld	ft7,104(sp)
8000061c:	24457647          	0x24457647
80000620:	10ce                	slli	ra,ra,0x33
80000622:	0549                	addi	a0,a0,18
80000624:	4292                	lw	t0,4(sp)
80000626:	77e8                	flw	fa0,108(a5)
80000628:	e7ee                	fsw	fs11,204(sp)
8000062a:	ba99                	j	7fffff80 <_start-0x80>
8000062c:	b841                	j	7ffffebc <_start-0x144>
8000062e:	b666                	fsd	fs9,296(sp)
80000630:	b2a5                	j	7fffff98 <_start-0x68>
80000632:	3ae6                	fld	fs5,120(sp)
80000634:	7d67d82b          	0x7d67d82b
80000638:	5ba4                	lw	s1,112(a5)
8000063a:	7e41                	lui	t3,0xffff0
8000063c:	988e                	add	a7,a7,gp
8000063e:	f145                	bnez	a0,800005de <data+0x42e>
80000640:	18c6                	slli	a7,a7,0x31
80000642:	1f59                	addi	t5,t5,-10
80000644:	c4fc8f13          	addi	t5,s9,-945
80000648:	51a8                	lw	a0,96(a1)
8000064a:	3191                	jal	8000028e <data+0xde>
8000064c:	dbc23273          	csrrc	tp,0xdbc,tp
80000650:	bf00                	fsd	fs0,56(a4)
80000652:	cb78                	sw	a4,84(a4)
80000654:	a3a123ef          	jal	t2,7ff1288e <_start-0xed772>
80000658:	49e276c7          	fmsub.s	fa3,ft4,ft10,fs1
8000065c:	4459                	li	s0,22
8000065e:	0275                	addi	tp,tp,29
80000660:	9de0                	0x9de0
80000662:	7889ed07          	0x7889ed07
80000666:	55ea                	lw	a1,184(sp)
80000668:	f34a                	fsw	fs2,164(sp)
8000066a:	09d6                	slli	s3,s3,0x15
8000066c:	8b32fd03          	0x8b32fd03
80000670:	6a9a                	flw	fs5,132(sp)
80000672:	e2a6                	fsw	fs1,68(sp)
80000674:	ddb8                	sw	a4,120(a1)
80000676:	c253756b          	0xc253756b
8000067a:	0766                	slli	a4,a4,0x19
8000067c:	14b9                	addi	s1,s1,-18
8000067e:	2c6a                	fld	fs8,152(sp)
80000680:	0c04b003          	0xc04b003
80000684:	ab303773          	csrrc	a4,0xab3,zero
80000688:	4ba44537          	lui	a0,0x4ba44
8000068c:	0522                	slli	a0,a0,0x8
8000068e:	00a2                	slli	ra,ra,0x8
80000690:	22e70e9b          	0x22e70e9b
80000694:	b266b457          	0xb266b457
80000698:	9db9                	0x9db9
8000069a:	b3e4bea7          	fsd	ft10,-1219(s1)
8000069e:	5cfc                	lw	a5,124(s1)
800006a0:	3c48                	fld	fa0,184(s0)
800006a2:	ab3e                	fsd	fa5,400(sp)
800006a4:	1fad                	addi	t6,t6,-21
800006a6:	1cc4                	addi	s1,sp,628
800006a8:	7708                	flw	fa0,40(a4)
800006aa:	3663faf3          	csrrci	s5,0x366,7
800006ae:	b31e                	fsd	ft7,416(sp)
800006b0:	c10ccdf3          	0xc10ccdf3
800006b4:	f5d8                	fsw	fa4,44(a1)
800006b6:	349ac4ab          	0x349ac4ab
800006ba:	c0fc                	sw	a5,68(s1)
800006bc:	acaa234b          	0xacaa234b
800006c0:	6c7c                	flw	fa5,92(s0)
800006c2:	207e                	fld	ft0,472(sp)
800006c4:	8248                	0x8248
800006c6:	8d5c                	0x8d5c
800006c8:	5dea                	lw	s11,184(sp)
800006ca:	81da                	mv	gp,s6
800006cc:	e04e                	fsw	fs3,0(sp)
800006ce:	03c4                	addi	s1,sp,452
800006d0:	6cb1                	lui	s9,0xc
800006d2:	2eb1                	jal	80000a2e <data+0x87e>
800006d4:	1374                	addi	a3,sp,428
800006d6:	d68d                	beqz	a3,80000600 <data+0x450>
800006d8:	c9bfcf93          	xori	t6,t6,-869
800006dc:	d57e                	sw	t6,168(sp)
800006de:	b558                	fsd	fa4,168(a0)
800006e0:	d97e                	sw	t6,176(sp)
800006e2:	0b6be26f          	jal	tp,800be798 <data+0xbe5e8>
800006e6:	6a95                	lui	s5,0x5
800006e8:	3046                	fld	ft0,112(sp)
800006ea:	74c8                	flw	fa0,44(s1)
800006ec:	e8a5                	bnez	s1,8000075c <data+0x5ac>
800006ee:	cf16c84f          	fnmadd.q	fa6,fa3,fa7,fs9,rmm
800006f2:	2642e3af          	0x2642e3af
800006f6:	311cd8ab          	0x311cd8ab
800006fa:	d0c8                	sw	a0,36(s1)
800006fc:	3c3d                	jal	8000013a <fail+0x4a>
800006fe:	a1e2                	fsd	fs8,192(sp)
80000700:	00a8                	addi	a0,sp,72
80000702:	202d                	jal	8000072c <data+0x57c>
80000704:	d195                	beqz	a1,80000628 <data+0x478>
80000706:	d402                	sw	zero,40(sp)
80000708:	bab5c80f          	0xbab5c80f
8000070c:	900c                	0x900c
8000070e:	0ce4                	addi	s1,sp,604
80000710:	e11b61db          	0xe11b61db
80000714:	2afd                	jal	80000912 <data+0x762>
80000716:	fb1e90eb          	0xfb1e90eb
8000071a:	daf1                	beqz	a3,800006ee <data+0x53e>
8000071c:	409a                	lw	ra,132(sp)
8000071e:	3bac                	fld	fa1,112(a5)
80000720:	78d1                	lui	a7,0xffff4
80000722:	83ac                	0x83ac
80000724:	2930                	fld	fa2,80(a0)
80000726:	d2e6                	sw	s9,100(sp)
80000728:	cd92                	sw	tp,216(sp)
8000072a:	30d6                	fld	ft1,368(sp)
8000072c:	f980                	fsw	fs0,48(a1)
8000072e:	8378                	0x8378
80000730:	49f8                	lw	a4,84(a1)
80000732:	faba                	fsw	fa4,116(sp)
80000734:	10df f277 7583      	0x7583f27710df
8000073a:	4c79                	li	s8,30
8000073c:	8acd                	andi	a3,a3,19
8000073e:	c832                	sw	a2,16(sp)
80000740:	7d30                	flw	fa2,120(a0)
80000742:	6aa6                	flw	fs5,72(sp)
80000744:	0e38                	addi	a4,sp,792
80000746:	bf02                	fsd	ft0,440(sp)
80000748:	a6b2                	fsd	fa2,328(sp)
8000074a:	0312                	slli	t1,t1,0x4
8000074c:	9a44                	0x9a44
8000074e:	38a8                	fld	fa0,112(s1)
80000750:	47ea                	lw	a5,152(sp)
80000752:	229f d03e 4860      	0x4860d03e229f
80000758:	6eea                	flw	ft9,152(sp)
8000075a:	2d38                	fld	fa4,88(a0)
8000075c:	8474                	0x8474
8000075e:	ce5e                	sw	s7,28(sp)
80000760:	e86d                	bnez	s0,80000852 <data+0x6a2>
80000762:	f0053d3b          	0xf0053d3b
80000766:	44c6                	lw	s1,80(sp)
80000768:	6097a0b3          	0x6097a0b3
8000076c:	d583b27b          	0xd583b27b
80000770:	f34a                	fsw	fs2,164(sp)
80000772:	8674                	0x8674
80000774:	9eee                	add	t4,t4,s11
80000776:	5f6d                	li	t5,-5
80000778:	1975f7bf fa2ebc82 	0xfa2ebc821975f7bf
80000780:	9461                	srai	s0,s0,0x38
80000782:	7b5c                	flw	fa5,52(a4)
80000784:	07984f2b          	0x7984f2b
80000788:	dfb8                	sw	a4,120(a5)
8000078a:	5b32                	lw	s6,44(sp)
8000078c:	9cec                	0x9cec
8000078e:	7172                	flw	ft2,60(sp)
80000790:	693e21f7          	0x693e21f7
80000794:	8a65                	andi	a2,a2,25
80000796:	6d28                	flw	fa0,88(a0)
80000798:	a111                	j	80000b9c <data+0x9ec>
8000079a:	95d8                	0x95d8
8000079c:	2dd2                	fld	fs11,272(sp)
8000079e:	7594de93          	0x7594de93
800007a2:	fcab753b          	0xfcab753b
800007a6:	4c00f8db          	0x4c00f8db
800007aa:	08be                	slli	a7,a7,0xf
800007ac:	5d9f fa09 46c0      	0x46c0fa095d9f
800007b2:	7ca1                	lui	s9,0xfffe8
800007b4:	177a                	slli	a4,a4,0x3e
800007b6:	299c                	fld	fa5,16(a1)
800007b8:	3c7f                	0x3c7f
800007ba:	9682                	jalr	a3
800007bc:	5bc4                	lw	s1,52(a5)
800007be:	ab8c                	fsd	fa1,16(a5)
800007c0:	9f62                	add	t5,t5,s8
800007c2:	3509                	jal	800005c4 <data+0x414>
800007c4:	bfb2                	fsd	fa2,504(sp)
800007c6:	71a18fe3          	beq	gp,s10,800016e4 <data+0x1534>
800007ca:	2b85                	jal	80000d3a <data+0xb8a>
800007cc:	e208                	fsw	fa0,0(a2)
800007ce:	3554                	fld	fa3,168(a0)
800007d0:	c395                	beqz	a5,800007f4 <data+0x644>
800007d2:	231eb263          	0x231eb263
800007d6:	f442                	fsw	fa6,40(sp)
800007d8:	0695                	addi	a3,a3,5
800007da:	dbb2                	sw	a2,244(sp)
800007dc:	cf60                	sw	s0,92(a4)
800007de:	9f24                	0x9f24
800007e0:	e4b6                	fsw	fa3,72(sp)
800007e2:	f00d59d3          	0xf00d59d3
800007e6:	d121                	beqz	a0,80000726 <data+0x576>
800007e8:	5f5e                	lw	t5,244(sp)
800007ea:	a656                	fsd	fs5,264(sp)
800007ec:	16b66b5b          	0x16b66b5b
800007f0:	2b41                	jal	80000d80 <data+0xbd0>
800007f2:	0488                	addi	a0,sp,576
800007f4:	eec5                	bnez	a3,800008ac <data+0x6fc>
800007f6:	8922                	mv	s2,s0
800007f8:	66be                	flw	fa3,204(sp)
800007fa:	f8e9                	bnez	s1,800007cc <data+0x61c>
800007fc:	32e8                	fld	fa0,224(a3)
800007fe:	7c2d                	lui	s8,0xfffeb
80000800:	9d7a                	add	s10,s10,t5
80000802:	6c8d                	lui	s9,0x3
80000804:	0f0c                	addi	a1,sp,912
80000806:	2890                	fld	fa2,16(s1)
80000808:	4f54                	lw	a3,28(a4)
8000080a:	497f                	0x497f
8000080c:	0f88                	addi	a0,sp,976
8000080e:	08689b17          	auipc	s6,0x8689
80000812:	8b49db87          	0x8b49db87
80000816:	243d                	jal	80000a44 <data+0x894>
80000818:	0301                	addi	t1,t1,0
8000081a:	7346                	flw	ft6,112(sp)
8000081c:	2e21                	jal	80000b34 <data+0x984>
8000081e:	3254                	fld	fa3,160(a2)
80000820:	1221                	addi	tp,tp,-24
80000822:	23bd                	jal	80000d90 <data+0xbe0>
80000824:	be8e                	fsd	ft3,376(sp)
80000826:	6cfd                	lui	s9,0x1f
80000828:	43f0                	lw	a2,68(a5)
8000082a:	661b708f          	0x661b708f
8000082e:	cfbd                	beqz	a5,800008ac <data+0x6fc>
80000830:	9d59                	0x9d59
80000832:	21c8                	fld	fa0,128(a1)
80000834:	083d                	addi	a6,a6,15
80000836:	5f72                	lw	t5,60(sp)
80000838:	3679                	jal	800003c6 <data+0x216>
8000083a:	e0b0                	fsw	fa2,64(s1)
8000083c:	5886                	lw	a7,96(sp)
8000083e:	ba51                	j	800001d2 <data+0x22>
80000840:	e79dc46f          	jal	s0,7ffdd6b8 <_start-0x22948>
80000844:	dd1a                	sw	t1,184(sp)
80000846:	fac4bf63          	0xfac4bf63
8000084a:	89859087          	0x89859087
8000084e:	c239                	beqz	a2,80000894 <data+0x6e4>
80000850:	51a5                	li	gp,-23
80000852:	047a                	slli	s0,s0,0x1e
80000854:	a35c                	fsd	fa5,128(a4)
80000856:	9d24                	0x9d24
80000858:	0031                	c.nop	12
8000085a:	bc91                	j	800002ae <data+0xfe>
8000085c:	a67d8a73          	0xa67d8a73
80000860:	c686                	sw	ra,76(sp)
80000862:	21a0                	fld	fs0,64(a1)
80000864:	51f8                	lw	a4,100(a1)
80000866:	7fa8                	flw	fa0,120(a5)
80000868:	5a0a                	lw	s4,160(sp)
8000086a:	d53a                	sw	a4,168(sp)
8000086c:	d212                	sw	tp,36(sp)
8000086e:	1495                	addi	s1,s1,-27
80000870:	26cb1963          	bne	s6,a2,80000ae2 <data+0x932>
80000874:	6218                	flw	fa4,0(a2)
80000876:	2c38                	fld	fa4,88(s0)
80000878:	7768                	flw	fa0,108(a4)
8000087a:	9135                	srli	a0,a0,0x2d
8000087c:	9af04013          	xori	zero,zero,-1617
80000880:	e806                	fsw	ft1,16(sp)
80000882:	a1c4                	fsd	fs1,128(a1)
80000884:	75befb4f          	0x75befb4f
80000888:	dcc1                	beqz	s1,80000820 <data+0x670>
8000088a:	c1e1                	beqz	a1,8000094a <data+0x79a>
8000088c:	ee8c                	fsw	fa1,24(a3)
8000088e:	4801                	li	a6,0
80000890:	5441                	li	s0,-16
80000892:	8c92                	mv	s9,tp
80000894:	1ccc6f8f          	0x1ccc6f8f
80000898:	dc024b4f          	0xdc024b4f
8000089c:	a8d2                	fsd	fs4,80(sp)
8000089e:	ba38                	fsd	fa4,112(a2)
800008a0:	d2a8                	sw	a0,96(a3)
800008a2:	a272                	fsd	ft8,256(sp)
800008a4:	0d5d                	addi	s10,s10,23
800008a6:	091526c7          	fmsub.s	fa3,fa0,fa7,ft1,rdn
800008aa:	91c1ace3          	0x91c1ace3
800008ae:	4fde1e03          	lh	t3,1277(t3) # ffff04fd <data+0x7fff034d>
800008b2:	6329                	lui	t1,0xa
800008b4:	2619                	jal	80000bba <data+0xa0a>
800008b6:	849c                	0x849c
800008b8:	6868                	flw	fa0,84(s0)
800008ba:	06d86983          	0x6d86983
800008be:	9b5d8353          	0x9b5d8353
800008c2:	c3de                	sw	s7,196(sp)
800008c4:	4ccd                	li	s9,19
800008c6:	7f99                	lui	t6,0xfffe6
800008c8:	15a899c3          	0x15a899c3
800008cc:	60b0                	flw	fa2,64(s1)
800008ce:	71b0825b          	0x71b0825b
800008d2:	bb02                	fsd	ft0,432(sp)
800008d4:	7001                	c.lui	zero,0xfffe0
800008d6:	0f0d                	addi	t5,t5,3
800008d8:	f636                	fsw	fa3,44(sp)
800008da:	1e3b028f          	0x1e3b028f
800008de:	d9d0                	sw	a2,52(a1)
800008e0:	0a62                	slli	s4,s4,0x18
800008e2:	11ba                	slli	gp,gp,0x2e
800008e4:	aa8e                	fsd	ft3,336(sp)
800008e6:	972be033          	0x972be033
800008ea:	5f89c357          	0x5f89c357
800008ee:	6f8d                	lui	t6,0x3
800008f0:	8adf bd93 c168      	0xc168bd938adf
800008f6:	8ad4                	0x8ad4
800008f8:	7c86                	flw	fs9,96(sp)
800008fa:	4e3ce9f3          	csrrsi	s3,0x4e3,25
800008fe:	8a22                	mv	s4,s0
80000900:	f2d9                	bnez	a3,80000886 <data+0x6d6>
80000902:	a0b4                	fsd	fa3,64(s1)
80000904:	b8ca19fb          	0xb8ca19fb
80000908:	a989                	j	80000d5a <data+0xbaa>
8000090a:	a12e                	fsd	fa1,128(sp)
8000090c:	1bf8                	addi	a4,sp,508
8000090e:	c6d4                	sw	a3,12(a3)
80000910:	14bd                	addi	s1,s1,-17
80000912:	f73c                	fsw	fa5,104(a4)
80000914:	29ab7a8f          	0x29ab7a8f
80000918:	e986                	fsw	ft1,208(sp)
8000091a:	d77a                	sw	t5,172(sp)
8000091c:	8082a487          	flw	fs1,-2040(t0) # ffff4808 <data+0x7fff4658>
80000920:	0deec727          	fsq	ft10,206(t4)
80000924:	16a4                	addi	s1,sp,872
80000926:	fc54                	fsw	fa3,60(s0)
80000928:	92e6                	add	t0,t0,s9
8000092a:	d50da2fb          	0xd50da2fb
8000092e:	1684                	addi	s1,sp,864
80000930:	0a6a                	slli	s4,s4,0x1a
80000932:	1c74                	addi	a3,sp,572
80000934:	894a                	mv	s2,s2
80000936:	a500                	fsd	fs0,8(a0)
80000938:	3645                	jal	800004d8 <data+0x328>
8000093a:	5a754327          	fsq	ft7,1446(a0) # 4ba445a6 <_start-0x345bba5a>
8000093e:	5a56                	lw	s4,116(sp)
80000940:	672d                	lui	a4,0xb
80000942:	f9f9                	bnez	a1,80000918 <data+0x768>
80000944:	3bd2                	fld	fs7,304(sp)
80000946:	a774                	fsd	fa3,200(a4)
80000948:	90b8                	0x90b8
8000094a:	7182                	flw	ft3,32(sp)
8000094c:	7066                	flw	ft0,120(sp)
8000094e:	1b28                	addi	a0,sp,440
80000950:	a310                	fsd	fa2,0(a4)
80000952:	757be3ef          	jal	t2,800bf8a8 <data+0xbf6f8>
80000956:	682a                	flw	fa6,136(sp)
80000958:	a809                	j	8000096a <data+0x7ba>
8000095a:	4df9                	li	s11,30
8000095c:	d604                	sw	s1,40(a2)
8000095e:	cb04                	sw	s1,16(a4)
80000960:	f772                	fsw	ft8,172(sp)
80000962:	7a631383          	lh	t2,1958(t1) # a7a6 <_start-0x7fff585a>
80000966:	9125                	srli	a0,a0,0x29
80000968:	719a                	flw	ft3,164(sp)
8000096a:	b9c4                	fsd	fs1,176(a1)
8000096c:	d39ceacf          	fnmadd.d	fs5,fs9,fs9,fs10,unknown
80000970:	6fdd                	lui	t6,0x17
80000972:	6fcc                	flw	fa1,28(a5)
80000974:	de40                	sw	s0,60(a2)
80000976:	cf674047          	fmsub.q	ft0,fa4,fs6,fs9,rmm
8000097a:	ace9                	j	80000c54 <data+0xaa4>
8000097c:	05be                	slli	a1,a1,0xf
8000097e:	b964                	fsd	fs1,240(a0)
80000980:	acc8                	fsd	fa0,152(s1)
80000982:	5b62                	lw	s6,56(sp)
80000984:	b960                	fsd	fs0,240(a0)
80000986:	14e0                	addi	s0,sp,620
80000988:	9066                	c.add	zero,s9
8000098a:	65b1                	lui	a1,0xc
8000098c:	a0d0                	fsd	fa2,128(s1)
8000098e:	19c3ef53          	fdiv.s	ft10,ft7,ft8,unknown
80000992:	da614143          	fmadd.d	ft2,ft2,ft6,fs11,rmm
80000996:	fa05bd87          	fld	fs11,-96(a1) # bfa0 <_start-0x7fff4060>
8000099a:	ccee                	sw	s11,88(sp)
8000099c:	5394                	lw	a3,32(a5)
8000099e:	443d                	li	s0,15
800009a0:	6d5d                	lui	s10,0x17
800009a2:	aacaf9b3          	0xaacaf9b3
800009a6:	a942                	fsd	fa6,144(sp)
800009a8:	1650                	addi	a2,sp,804
800009aa:	6a7ef16f          	jal	sp,800f0850 <data+0xf06a0>
800009ae:	ea19                	bnez	a2,800009c4 <data+0x814>
