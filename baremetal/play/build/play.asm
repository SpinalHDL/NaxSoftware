
build/play.elf:     file format elf32-littleriscv


Disassembly of section .crt_section:

80000000 <_start>:
80000000:	3e800f93          	li	t6,1000
80000004:	00000097          	auipc	ra,0x0
80000008:	16008093          	addi	ra,ra,352 # 80000164 <data>

8000000c <i0>:
8000000c:	00408113          	addi	sp,ra,4
80000010:	0020a023          	sw	sp,0(ra)
80000014:	00010093          	mv	ra,sp
80000018:	ffff8f93          	addi	t6,t6,-1
8000001c:	fe0f98e3          	bnez	t6,8000000c <i0>
80000020:	0000a023          	sw	zero,0(ra)

80000024 <stats>:
80000024:	00000097          	auipc	ra,0x0
80000028:	14008093          	addi	ra,ra,320 # 80000164 <data>

8000002c <j0>:
8000002c:	0000a083          	lw	ra,0(ra)
80000030:	fe009ee3          	bnez	ra,8000002c <j0>
80000034:	0040006f          	j	80000038 <pass>

80000038 <pass>:
80000038:	00000013          	nop

8000003c <fail>:
8000003c:	00000013          	nop

80000040 <delay>:
80000040:	00000013          	nop
80000044:	00000013          	nop
80000048:	00000013          	nop
8000004c:	00000013          	nop
80000050:	00000013          	nop
80000054:	00000013          	nop
80000058:	00000013          	nop
8000005c:	00000013          	nop
80000060:	00000013          	nop
80000064:	00000013          	nop
80000068:	00000013          	nop
8000006c:	00000013          	nop
80000070:	00000013          	nop
80000074:	00000013          	nop
80000078:	00000013          	nop
8000007c:	00000013          	nop
80000080:	00000013          	nop
80000084:	00000013          	nop
80000088:	00000013          	nop
8000008c:	00000013          	nop
80000090:	00000013          	nop
80000094:	00000013          	nop
80000098:	00000013          	nop
8000009c:	00000013          	nop
800000a0:	00000013          	nop
800000a4:	00000013          	nop
800000a8:	00000013          	nop
800000ac:	00000013          	nop
800000b0:	00000013          	nop
800000b4:	00000013          	nop
800000b8:	00000013          	nop
800000bc:	00000013          	nop
800000c0:	00000013          	nop
800000c4:	00000013          	nop
800000c8:	00000013          	nop
800000cc:	00000013          	nop
800000d0:	00000013          	nop
800000d4:	00000013          	nop
800000d8:	00000013          	nop
800000dc:	00000013          	nop
800000e0:	00000013          	nop
800000e4:	00000013          	nop
800000e8:	00000013          	nop
800000ec:	00000013          	nop
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
80000160:	00008067          	ret

80000164 <data>:
80000164:	1b60                	addi	s0,sp,444
80000166:	27e9                	jal	80000930 <data+0x7cc>
80000168:	a656bbbb          	0xa656bbbb
8000016c:	59014f57          	0x59014f57
80000170:	e339e4d3          	0xe339e4d3
80000174:	ce54                	sw	a3,28(a2)
80000176:	1546                	slli	a0,a0,0x31
80000178:	aa010ccf          	fnmadd.d	fs9,ft2,ft0,fs5,rne
8000017c:	2419                	jal	80000382 <data+0x21e>
8000017e:	6bbe                	flw	fs7,204(sp)
80000180:	949e                	add	s1,s1,t2
80000182:	a3cc                	fsd	fa1,128(a5)
80000184:	3d1d386b          	0x3d1d386b
80000188:	285a                	fld	fa6,400(sp)
8000018a:	6d56                	flw	fs10,84(sp)
8000018c:	45e5                	li	a1,25
8000018e:	49b1                	li	s3,12
80000190:	39650987          	0x39650987
80000194:	1b90cb33          	0x1b90cb33
80000198:	38a1                	jal	7ffff9f0 <_start-0x610>
8000019a:	95d5                	srai	a1,a1,0x35
8000019c:	ec1a                	fsw	ft6,24(sp)
8000019e:	2020                	fld	fs0,64(s0)
800001a0:	c666                	sw	s9,12(sp)
800001a2:	e9d9                	bnez	a1,80000238 <data+0xd4>
800001a4:	d35d8173          	0xd35d8173
800001a8:	6196                	flw	ft3,68(sp)
800001aa:	e022                	fsw	fs0,0(sp)
800001ac:	a7b8                	fsd	fa4,72(a5)
800001ae:	e991                	bnez	a1,800001c2 <data+0x5e>
800001b0:	f65a                	fsw	fs6,44(sp)
800001b2:	fdf6                	fsw	ft9,248(sp)
800001b4:	a339                	j	800006c2 <data+0x55e>
800001b6:	c5bc                	sw	a5,72(a1)
800001b8:	72b1                	lui	t0,0xfffec
800001ba:	663c                	flw	fa5,72(a2)
800001bc:	e589                	bnez	a1,800001c6 <data+0x62>
800001be:	f618                	fsw	fa4,40(a2)
800001c0:	bc56                	fsd	fs5,56(sp)
800001c2:	520c                	lw	a1,32(a2)
800001c4:	5a36                	lw	s4,108(sp)
800001c6:	e8d204bf e9c03f34 	0xe9c03f34e8d204bf
800001ce:	d8c151b3          	0xd8c151b3
800001d2:	7d41                	lui	s10,0xffff0
800001d4:	3065                	jal	7ffffa7c <_start-0x584>
800001d6:	66e2                	flw	fa3,24(sp)
800001d8:	467f                	0x467f
800001da:	1a8c                	addi	a1,sp,368
800001dc:	3f5d                	jal	80000192 <data+0x2e>
800001de:	aa44                	fsd	fs1,144(a2)
800001e0:	f07c                	fsw	fa5,100(s0)
800001e2:	e92818e3          	bne	a6,s2,80000072 <delay+0x32>
800001e6:	c40654cf          	0xc40654cf
800001ea:	539f 1c7f 0f2a      	0xf2a1c7f539f
800001f0:	d67e                	sw	t6,44(sp)
800001f2:	7c0d                	lui	s8,0xfffe3
800001f4:	ea6a                	fsw	fs10,20(sp)
800001f6:	90be                	add	ra,ra,a5
800001f8:	2372ad93          	slti	s11,t0,567
800001fc:	ac2d                	j	80000436 <data+0x2d2>
800001fe:	9ec5                	0x9ec5
80000200:	e098                	fsw	fa4,0(s1)
80000202:	5e2a                	lw	t3,168(sp)
80000204:	aca0                	fsd	fs0,88(s1)
80000206:	58df22c7          	fmsub.s	ft5,ft10,fa3,fa1,rdn
8000020a:	850bd393          	0x850bd393
8000020e:	68f5                	lui	a7,0x1d
80000210:	e359                	bnez	a4,80000296 <data+0x132>
80000212:	68b2                	flw	fa7,12(sp)
80000214:	de74                	sw	a3,124(a2)
80000216:	973c0e57          	0x973c0e57
8000021a:	1951                	addi	s2,s2,-12
8000021c:	39fe                	fld	fs3,504(sp)
8000021e:	777133bf 52dad337 	0x52dad337777133bf
80000226:	90a29073          	csrw	0x90a,t0
8000022a:	7990ad07          	flw	fs10,1945(ra)
8000022e:	976a                	add	a4,a4,s10
80000230:	3f55                	jal	800001e4 <data+0x80>
80000232:	8099e283          	0x8099e283
80000236:	1ac8                	addi	a0,sp,372
80000238:	904d                	srli	s0,s0,0x33
8000023a:	b0f3616f          	jal	sp,7ff36d48 <_start-0xc92b8>
8000023e:	482a8567          	jalr	a0,1154(s5)
80000242:	65e6                	flw	fa1,88(sp)
80000244:	9000                	0x9000
80000246:	ebfe                	fsw	ft11,212(sp)
80000248:	e47c                	fsw	fa5,76(s0)
8000024a:	5d74                	lw	a3,124(a0)
8000024c:	8ad1                	andi	a3,a3,20
8000024e:	8df7b6e3          	0x8df7b6e3
80000252:	df85                	beqz	a5,8000018a <data+0x26>
80000254:	f2e4                	fsw	fs1,100(a3)
80000256:	dc3c                	sw	a5,120(s0)
80000258:	6d31                	lui	s10,0xc
8000025a:	be81                	j	7ffffdaa <_start-0x256>
8000025c:	e1a906cf          	fnmadd.s	fa3,fs2,fs10,ft8,rne
80000260:	c191                	beqz	a1,80000264 <data+0x100>
80000262:	5ac5                	li	s5,-15
80000264:	3c54                	fld	fa3,184(s0)
80000266:	555f 614e 7648      	0x7648614e555f
8000026c:	b0de                	fsd	fs7,96(sp)
8000026e:	ba41                	j	7ffffbfe <_start-0x402>
80000270:	061f a39f 99cb      	0x99cba39f061f
80000276:	d0a5                	beqz	s1,800001d6 <data+0x72>
80000278:	f295                	bnez	a3,8000019c <data+0x38>
8000027a:	9852                	add	a6,a6,s4
8000027c:	0460                	addi	s0,sp,524
8000027e:	fc24                	fsw	fs1,120(s0)
80000280:	b3ce                	fsd	fs3,480(sp)
80000282:	84aea643          	0x84aea643
80000286:	7c72                	flw	fs8,60(sp)
80000288:	edcc                	fsw	fa1,28(a1)
8000028a:	644d                	lui	s0,0x13
8000028c:	bede                	fsd	fs7,376(sp)
8000028e:	ed9daa8f          	0xed9daa8f
80000292:	e174                	fsw	fa3,68(a0)
80000294:	c6e1                	beqz	a3,8000035c <data+0x1f8>
80000296:	707a                	flw	ft0,188(sp)
80000298:	319d5487          	0x319d5487
8000029c:	2e31                	jal	800005b8 <data+0x454>
8000029e:	2dc0                	fld	fs0,152(a1)
800002a0:	a08c                	fsd	fa1,0(s1)
800002a2:	24f1f1ef          	jal	gp,8001fcf0 <data+0x1fb8c>
800002a6:	27e2                	fld	fa5,24(sp)
800002a8:	4486                	lw	s1,64(sp)
800002aa:	2123fb4b          	fnmsub.s	fs6,ft7,fs2,ft4
800002ae:	457a                	lw	a0,156(sp)
800002b0:	2784                	fld	fs1,8(a5)
800002b2:	a31d                	j	800007d8 <data+0x674>
800002b4:	5a51                	li	s4,-12
800002b6:	1389                	addi	t2,t2,-30
800002b8:	374e                	fld	fa4,240(sp)
800002ba:	2521                	jal	800008c2 <data+0x75e>
800002bc:	72d5                	lui	t0,0xffff5
800002be:	155a                	slli	a0,a0,0x36
800002c0:	7d9f 9d39 18d8      	0x18d89d397d9f
800002c6:	9524                	0x9524
800002c8:	b2e6                	fsd	fs9,352(sp)
800002ca:	db466ee7          	0xdb466ee7
800002ce:	6b2e                	flw	fs6,200(sp)
800002d0:	baf1                	j	7ffffcac <_start-0x354>
800002d2:	ce8c                	sw	a1,24(a3)
800002d4:	a996                	fsd	ft5,208(sp)
800002d6:	739a                	flw	ft7,164(sp)
800002d8:	bfebad27          	fsw	ft10,-1030(s7)
800002dc:	7e45                	lui	t3,0xffff1
800002de:	1199                	addi	gp,gp,-26
800002e0:	3b0a1f4f          	fnmadd.d	ft10,fs4,fa6,ft7,rtz
800002e4:	e070                	fsw	fa2,68(s0)
800002e6:	1bc9                	addi	s7,s7,-14
800002e8:	ad7d                	j	800009a6 <data+0x842>
800002ea:	e3a6                	fsw	fs1,196(sp)
800002ec:	b28e                	fsd	ft3,352(sp)
800002ee:	20a8                	fld	fa0,64(s1)
800002f0:	eb08                	fsw	fa0,16(a4)
800002f2:	ccf2                	sw	t3,88(sp)
800002f4:	916a                	add	sp,sp,s10
800002f6:	5d4e                	lw	s10,240(sp)
800002f8:	8a49bc6b          	0x8a49bc6b
800002fc:	6bdcc56f          	jal	a0,800cd1b8 <data+0xcd054>
80000300:	73e8                	flw	fa0,100(a5)
80000302:	b8d0                	fsd	fa2,176(s1)
80000304:	16c0                	addi	s0,sp,868
80000306:	678a                	flw	fa5,128(sp)
80000308:	8f73ebd7          	0x8f73ebd7
8000030c:	a94c                	fsd	fa1,144(a0)
8000030e:	333da613          	slti	a2,s11,819
80000312:	4daa                	lw	s11,136(sp)
80000314:	ad04                	fsd	fs1,24(a0)
80000316:	9e4d507b          	0x9e4d507b
8000031a:	0a45                	addi	s4,s4,17
8000031c:	9e4a                	add	t3,t3,s2
8000031e:	23a5                	jal	80000886 <data+0x722>
80000320:	58ff                	0x58ff
80000322:	ccf5                	beqz	s1,8000041e <data+0x2ba>
80000324:	2256                	fld	ft4,336(sp)
80000326:	6359                	lui	t1,0x16
80000328:	fb31                	bnez	a4,8000027c <data+0x118>
8000032a:	3ece                	fld	ft9,240(sp)
8000032c:	7df5                	lui	s11,0xffffd
8000032e:	90bc                	0x90bc
80000330:	3f2a                	fld	ft10,168(sp)
80000332:	fd06                	fsw	ft1,184(sp)
80000334:	8339                	srli	a4,a4,0xe
80000336:	bd700acf          	0xbd700acf
8000033a:	6c90                	flw	fa2,24(s1)
8000033c:	729f 4763 34a0      	0x34a04763729f
80000342:	cbee                	sw	s11,212(sp)
80000344:	6834                	flw	fa3,80(s0)
80000346:	005c27d7          	0x5c27d7
8000034a:	8bd2eebb          	0x8bd2eebb
8000034e:	c2730c8f          	0xc2730c8f
80000352:	5495                	li	s1,-27
80000354:	cb85                	beqz	a5,80000384 <data+0x220>
80000356:	21b4                	fld	fa3,64(a1)
80000358:	6aea                	flw	fs5,152(sp)
8000035a:	b4359953          	0xb4359953
8000035e:	cde5                	beqz	a1,80000456 <data+0x2f2>
80000360:	eebc                	fsw	fa5,88(a3)
80000362:	79e0                	flw	fs0,116(a1)
80000364:	fa48d28f          	0xfa48d28f
80000368:	92d0                	0x92d0
8000036a:	de5d                	beqz	a2,80000328 <data+0x1c4>
8000036c:	1dd928a7          	fsw	ft9,465(s2)
80000370:	0b8e                	slli	s7,s7,0x3
80000372:	58c0                	lw	s0,52(s1)
80000374:	d52c                	sw	a1,104(a0)
80000376:	af1f a764 213c      	0x213ca764af1f
8000037c:	8294                	0x8294
8000037e:	458d                	li	a1,3
80000380:	a801                	j	80000390 <data+0x22c>
80000382:	41c117f7          	0x41c117f7
80000386:	fbdf dc42 5d09      	0x5d09dc42fbdf
8000038c:	debdb353          	0xdebdb353
80000390:	ef10                	fsw	fa2,24(a4)
80000392:	5625                	li	a2,-23
80000394:	ab8e                	fsd	ft3,464(sp)
80000396:	a939                	j	800007b4 <data+0x650>
80000398:	3d09                	jal	800001aa <data+0x46>
8000039a:	5f5a                	lw	t5,180(sp)
8000039c:	83e5                	srli	a5,a5,0x19
8000039e:	16ca                	slli	a3,a3,0x32
800003a0:	8f76                	mv	t5,t4
800003a2:	5475                	li	s0,-3
800003a4:	06e2                	slli	a3,a3,0x18
800003a6:	5ddf602b          	0x5ddf602b
800003aa:	6f4d0cab          	0x6f4d0cab
800003ae:	f4c6                	fsw	fa7,104(sp)
800003b0:	48d8                	lw	a4,20(s1)
800003b2:	05aa6cbf 6b80e7f1 	0x6b80e7f105aa6cbf
800003ba:	33c5                	jal	8000019a <data+0x36>
800003bc:	8b4c                	0x8b4c
800003be:	8bca                	mv	s7,s2
800003c0:	8cd8                	0x8cd8
800003c2:	3102                	fld	ft2,32(sp)
800003c4:	02cc                	addi	a1,sp,324
800003c6:	8931                	andi	a0,a0,12
800003c8:	b90d                	j	7ffffffa <_start-0x6>
800003ca:	e044                	fsw	fs1,4(s0)
800003cc:	58aa                	lw	a7,168(sp)
800003ce:	8876                	mv	a6,t4
800003d0:	fd9d                	bnez	a1,8000030e <data+0x1aa>
800003d2:	e5d1d70b          	0xe5d1d70b
800003d6:	fa9304f3          	0xfa9304f3
800003da:	1fb5                	addi	t6,t6,-19
800003dc:	0f35                	addi	t5,t5,13
800003de:	af132fcb          	fnmsub.q	ft11,ft6,fa7,fs5,rdn
800003e2:	04d8                	addi	a4,sp,580
800003e4:	6514                	flw	fa3,8(a0)
800003e6:	2e29ffd7          	0x2e29ffd7
800003ea:	a6a8                	fsd	fa0,72(a3)
800003ec:	f0ea                	fsw	fs10,96(sp)
800003ee:	ad29                	j	80000a08 <data+0x8a4>
800003f0:	eb3238eb          	0xeb3238eb
800003f4:	272a                	fld	fa4,136(sp)
800003f6:	d723f60b          	0xd723f60b
800003fa:	e090                	fsw	fa2,0(s1)
800003fc:	5200                	lw	s0,32(a2)
800003fe:	733e                	flw	ft6,236(sp)
80000400:	55f2                	lw	a1,60(sp)
80000402:	7b05                	lui	s6,0xfffe1
80000404:	4894                	lw	a3,16(s1)
80000406:	abd7c78f          	0xabd7c78f
8000040a:	dfd9                	beqz	a5,800003a8 <data+0x244>
8000040c:	2be8c9ef          	jal	s3,8008c6ca <data+0x8c566>
80000410:	ea62                	fsw	fs8,20(sp)
80000412:	cd25                	beqz	a0,8000048a <data+0x326>
80000414:	fc20                	fsw	fs0,120(s0)
80000416:	cfec                	sw	a1,92(a5)
80000418:	d648                	sw	a0,44(a2)
8000041a:	7ee4                	flw	fs1,124(a3)
8000041c:	9124                	0x9124
8000041e:	2187ecc7          	fmsub.s	fs9,fa5,fs8,ft4,unknown
80000422:	f11f 68fa 9164      	0x916468faf11f
80000428:	14ad                	addi	s1,s1,-21
8000042a:	0ba05997          	auipc	s3,0xba05
8000042e:	2a66                	fld	fs4,88(sp)
80000430:	d845                	beqz	s0,800003e0 <data+0x27c>
80000432:	2e96                	fld	ft9,320(sp)
80000434:	6024                	flw	fs1,64(s0)
80000436:	17e1                	addi	a5,a5,-8
80000438:	37dc                	fld	fa5,168(a5)
8000043a:	d29c                	sw	a5,32(a3)
8000043c:	7416                	flw	fs0,100(sp)
8000043e:	5f32                	lw	t5,44(sp)
80000440:	8abc                	0x8abc
80000442:	e264                	fsw	fs1,68(a2)
80000444:	a88c                	fsd	fa1,16(s1)
80000446:	051e                	slli	a0,a0,0x7
80000448:	2229                	jal	80000552 <data+0x3ee>
8000044a:	f6c2                	fsw	fa6,108(sp)
8000044c:	dbfc                	sw	a5,116(a5)
8000044e:	c1f8f797          	auipc	a5,0xc1f8f
80000452:	7020                	flw	fs0,96(s0)
80000454:	056a                	slli	a0,a0,0x1a
80000456:	6188                	flw	fa0,0(a1)
80000458:	7c3e                	flw	fs8,236(sp)
8000045a:	4380                	lw	s0,0(a5)
8000045c:	c84c9b6f          	jal	s6,7ffc98e0 <_start-0x36720>
80000460:	111d                	addi	sp,sp,-25
80000462:	de44                	sw	s1,60(a2)
80000464:	6546                	flw	fa0,80(sp)
80000466:	5f75                	li	t5,-3
80000468:	a020a20f          	0xa020a20f
8000046c:	eedb5673          	csrrwi	a2,0xeed,22
80000470:	ea26                	fsw	fs1,20(sp)
80000472:	f080                	fsw	fs0,32(s1)
80000474:	6e64                	flw	fs1,92(a2)
80000476:	17ca                	slli	a5,a5,0x32
80000478:	f20e                	fsw	ft3,36(sp)
8000047a:	834c733b          	0x834c733b
8000047e:	7e32                	flw	ft8,44(sp)
80000480:	fcd61907          	0xfcd61907
80000484:	2b1c                	fld	fa5,16(a4)
80000486:	9d90                	0x9d90
80000488:	cf32                	sw	a2,156(sp)
8000048a:	de5068ef          	jal	a7,7ff0726e <_start-0xf8d92>
8000048e:	54d4ed17          	auipc	s10,0x54d4e
80000492:	dd81                	beqz	a1,800003aa <data+0x246>
80000494:	12b4                	addi	a3,sp,360
80000496:	2e54                	fld	fa3,152(a2)
80000498:	2541                	jal	80000b18 <data+0x9b4>
8000049a:	9f34                	0x9f34
8000049c:	dee8088b          	0xdee8088b
800004a0:	a196                	fsd	ft5,192(sp)
800004a2:	2c02e42f          	0x2c02e42f
800004a6:	df2c                	sw	a1,120(a4)
800004a8:	60a6                	flw	ft1,72(sp)
800004aa:	d221                	beqz	a2,800003ea <data+0x286>
800004ac:	6740                	flw	fs0,12(a4)
800004ae:	50023f33          	0x50023f33
800004b2:	afd2                	fsd	fs4,472(sp)
800004b4:	57bd                	li	a5,-17
800004b6:	6a69                	lui	s4,0x1a
800004b8:	c55aa0ab          	0xc55aa0ab
800004bc:	6a02                	flw	fs4,0(sp)
800004be:	1806                	slli	a6,a6,0x21
800004c0:	674d                	lui	a4,0x13
800004c2:	43c1                	li	t2,16
800004c4:	8186                	mv	gp,ra
800004c6:	255defb3          	0x255defb3
800004ca:	43bc                	lw	a5,64(a5)
800004cc:	60cd                	lui	ra,0x13
800004ce:	65ca                	flw	fa1,144(sp)
800004d0:	72b6                	flw	ft5,108(sp)
800004d2:	bcd5                	j	7fffffc6 <_start-0x3a>
800004d4:	5d2225a3          	sw	s2,1483(tp) # 5cb <_start-0x7ffffa35>
800004d8:	d7b2                	sw	a2,236(sp)
800004da:	df5704eb          	0xdf5704eb
800004de:	b16d                	j	80000188 <data+0x24>
800004e0:	aa14                	fsd	fa3,16(a2)
800004e2:	fc21                	bnez	s0,8000043a <data+0x2d6>
800004e4:	e7a6                	fsw	fs1,204(sp)
800004e6:	f792                	fsw	ft4,236(sp)
800004e8:	7d31                	lui	s10,0xfffec
800004ea:	42a847c3          	fmadd.d	fa5,fa6,fa0,fs0,rmm
800004ee:	982f37a3          	0x982f37a3
800004f2:	bea1                	j	8000004a <delay+0xa>
800004f4:	7456                	flw	fs0,116(sp)
800004f6:	9da4                	0x9da4
800004f8:	2b78                	fld	fa4,208(a4)
800004fa:	5f38237b          	0x5f38237b
800004fe:	dfce                	sw	s3,252(sp)
80000500:	8f55                	or	a4,a4,a3
80000502:	c54e                	sw	s3,136(sp)
80000504:	4c58                	lw	a4,28(s0)
80000506:	2a54                	fld	fa3,144(a2)
80000508:	8c24                	0x8c24
8000050a:	0a69                	addi	s4,s4,26
8000050c:	1489                	addi	s1,s1,-30
8000050e:	5d64                	lw	s1,124(a0)
80000510:	25b4                	fld	fa3,72(a1)
80000512:	495a                	lw	s2,148(sp)
80000514:	a53ac56b          	0xa53ac56b
80000518:	052445c7          	0x52445c7
8000051c:	b0a1                	j	7ffffd64 <_start-0x29c>
8000051e:	f608                	fsw	fa0,40(a2)
80000520:	9144                	0x9144
80000522:	b10f023f 9a1a1379 	0x9a1a1379b10f023f
8000052a:	9e52                	add	t3,t3,s4
8000052c:	c98a3387          	fld	ft7,-872(s4) # 19c98 <_start-0x7ffe6368>
80000530:	bfce                	fsd	fs3,504(sp)
80000532:	9892                	add	a7,a7,tp
80000534:	594a9ce3          	bne	s5,s4,800012cc <data+0x1168>
80000538:	4fa9                	li	t6,10
8000053a:	965d                	srai	a2,a2,0x37
8000053c:	4604                	lw	s1,8(a2)
8000053e:	ee92                	fsw	ft4,92(sp)
80000540:	b05f 9352 9cbc      	0x9cbc9352b05f
80000546:	81ad                	srli	a1,a1,0xb
80000548:	9242                	add	tp,tp,a6
8000054a:	72a741e3          	blt	a4,a0,8000146c <data+0x1308>
8000054e:	a841                	j	800005de <data+0x47a>
80000550:	ad8014bb          	0xad8014bb
80000554:	5b05                	li	s6,-31
80000556:	a5c8                	fsd	fa0,136(a1)
80000558:	bea6                	fsd	fs1,376(sp)
8000055a:	5079                	c.li	zero,-2
8000055c:	496c                	lw	a1,84(a0)
8000055e:	04501aa3          	sh	t0,85(zero) # 55 <_start-0x7fffffab>
80000562:	e0c83b9b          	0xe0c83b9b
80000566:	541a                	lw	s0,164(sp)
80000568:	ff50                	fsw	fa2,60(a4)
8000056a:	1a89                	addi	s5,s5,-30
8000056c:	5615                	li	a2,-27
8000056e:	1815                	addi	a6,a6,-27
80000570:	2749                	jal	80000cf2 <data+0xb8e>
80000572:	420d                	li	tp,3
80000574:	1861                	addi	a6,a6,-8
80000576:	35f1                	jal	80000442 <data+0x2de>
80000578:	2850                	fld	fa2,144(s0)
8000057a:	fd39                	bnez	a0,800004d8 <data+0x374>
8000057c:	a3a8                	fsd	fa0,64(a5)
8000057e:	1d6c                	addi	a1,sp,700
80000580:	b9d8                	fsd	fa4,176(a1)
80000582:	aa4a                	fsd	fs2,272(sp)
80000584:	5331                	li	t1,-20
80000586:	a2187803          	0xa2187803
8000058a:	003e                	c.slli	zero,0xf
8000058c:	2c8e                	fld	fs9,192(sp)
8000058e:	653a4843          	0x653a4843
80000592:	6754                	flw	fa3,12(a4)
80000594:	e919                	bnez	a0,800005aa <data+0x446>
80000596:	ce3d62e7          	0xce3d62e7
8000059a:	4885                	li	a7,1
8000059c:	fe1c                	fsw	fa5,56(a2)
8000059e:	e6f6                	fsw	ft9,76(sp)
800005a0:	a60a                	fsd	ft2,264(sp)
800005a2:	fb76                	fsw	ft9,180(sp)
800005a4:	6211b657          	0x6211b657
800005a8:	51c4                	lw	s1,36(a1)
800005aa:	8cad                	xor	s1,s1,a1
800005ac:	bfb1                	j	80000508 <data+0x3a4>
800005ae:	f871                	bnez	s0,80000582 <data+0x41e>
800005b0:	6e7c                	flw	fa5,92(a2)
800005b2:	ac08                	fsd	fa0,24(s0)
800005b4:	117a                	slli	sp,sp,0x3e
800005b6:	21c0                	fld	fs0,128(a1)
800005b8:	77b4                	flw	fa3,104(a5)
800005ba:	d7aa                	sw	a0,236(sp)
800005bc:	8ddf 08d5 0b98      	0xb9808d58ddf
800005c2:	df90d837          	lui	a6,0xdf90d
800005c6:	7c44                	flw	fs1,60(s0)
800005c8:	b8c1                	j	7ffffe98 <_start-0x168>
800005ca:	619e                	flw	ft3,196(sp)
800005cc:	2cd0                	fld	fa2,152(s1)
800005ce:	33a6                	fld	ft7,104(sp)
800005d0:	24457647          	0x24457647
800005d4:	10ce                	slli	ra,ra,0x33
800005d6:	0549                	addi	a0,a0,18
800005d8:	4292                	lw	t0,4(sp)
800005da:	77e8                	flw	fa0,108(a5)
800005dc:	e7ee                	fsw	fs11,204(sp)
800005de:	ba99                	j	7fffff34 <_start-0xcc>
800005e0:	b841                	j	7ffffe70 <_start-0x190>
800005e2:	b666                	fsd	fs9,296(sp)
800005e4:	b2a5                	j	7fffff4c <_start-0xb4>
800005e6:	3ae6                	fld	fs5,120(sp)
800005e8:	7d67d82b          	0x7d67d82b
800005ec:	5ba4                	lw	s1,112(a5)
800005ee:	7e41                	lui	t3,0xffff0
800005f0:	988e                	add	a7,a7,gp
800005f2:	f145                	bnez	a0,80000592 <data+0x42e>
800005f4:	18c6                	slli	a7,a7,0x31
800005f6:	1f59                	addi	t5,t5,-10
800005f8:	c4fc8f13          	addi	t5,s9,-945
800005fc:	51a8                	lw	a0,96(a1)
800005fe:	3191                	jal	80000242 <data+0xde>
80000600:	dbc23273          	csrrc	tp,0xdbc,tp
80000604:	bf00                	fsd	fs0,56(a4)
80000606:	cb78                	sw	a4,84(a4)
80000608:	a3a123ef          	jal	t2,7ff12842 <_start-0xed7be>
8000060c:	49e276c7          	fmsub.s	fa3,ft4,ft10,fs1
80000610:	4459                	li	s0,22
80000612:	0275                	addi	tp,tp,29
80000614:	9de0                	0x9de0
80000616:	7889ed07          	0x7889ed07
8000061a:	55ea                	lw	a1,184(sp)
8000061c:	f34a                	fsw	fs2,164(sp)
8000061e:	09d6                	slli	s3,s3,0x15
80000620:	8b32fd03          	0x8b32fd03
80000624:	6a9a                	flw	fs5,132(sp)
80000626:	e2a6                	fsw	fs1,68(sp)
80000628:	ddb8                	sw	a4,120(a1)
8000062a:	c253756b          	0xc253756b
8000062e:	0766                	slli	a4,a4,0x19
80000630:	14b9                	addi	s1,s1,-18
80000632:	2c6a                	fld	fs8,152(sp)
80000634:	0c04b003          	0xc04b003
80000638:	ab303773          	csrrc	a4,0xab3,zero
8000063c:	4ba44537          	lui	a0,0x4ba44
80000640:	0522                	slli	a0,a0,0x8
80000642:	00a2                	slli	ra,ra,0x8
80000644:	22e70e9b          	0x22e70e9b
80000648:	b266b457          	0xb266b457
8000064c:	9db9                	0x9db9
8000064e:	b3e4bea7          	fsd	ft10,-1219(s1)
80000652:	5cfc                	lw	a5,124(s1)
80000654:	3c48                	fld	fa0,184(s0)
80000656:	ab3e                	fsd	fa5,400(sp)
80000658:	1fad                	addi	t6,t6,-21
8000065a:	1cc4                	addi	s1,sp,628
8000065c:	7708                	flw	fa0,40(a4)
8000065e:	3663faf3          	csrrci	s5,0x366,7
80000662:	b31e                	fsd	ft7,416(sp)
80000664:	c10ccdf3          	0xc10ccdf3
80000668:	f5d8                	fsw	fa4,44(a1)
8000066a:	349ac4ab          	0x349ac4ab
8000066e:	c0fc                	sw	a5,68(s1)
80000670:	acaa234b          	0xacaa234b
80000674:	6c7c                	flw	fa5,92(s0)
80000676:	207e                	fld	ft0,472(sp)
80000678:	8248                	0x8248
8000067a:	8d5c                	0x8d5c
8000067c:	5dea                	lw	s11,184(sp)
8000067e:	81da                	mv	gp,s6
80000680:	e04e                	fsw	fs3,0(sp)
80000682:	03c4                	addi	s1,sp,452
80000684:	6cb1                	lui	s9,0xc
80000686:	2eb1                	jal	800009e2 <data+0x87e>
80000688:	1374                	addi	a3,sp,428
8000068a:	d68d                	beqz	a3,800005b4 <data+0x450>
8000068c:	c9bfcf93          	xori	t6,t6,-869
80000690:	d57e                	sw	t6,168(sp)
80000692:	b558                	fsd	fa4,168(a0)
80000694:	d97e                	sw	t6,176(sp)
80000696:	0b6be26f          	jal	tp,800be74c <data+0xbe5e8>
8000069a:	6a95                	lui	s5,0x5
8000069c:	3046                	fld	ft0,112(sp)
8000069e:	74c8                	flw	fa0,44(s1)
800006a0:	e8a5                	bnez	s1,80000710 <data+0x5ac>
800006a2:	cf16c84f          	fnmadd.q	fa6,fa3,fa7,fs9,rmm
800006a6:	2642e3af          	0x2642e3af
800006aa:	311cd8ab          	0x311cd8ab
800006ae:	d0c8                	sw	a0,36(s1)
800006b0:	3c3d                	jal	800000ee <delay+0xae>
800006b2:	a1e2                	fsd	fs8,192(sp)
800006b4:	00a8                	addi	a0,sp,72
800006b6:	202d                	jal	800006e0 <data+0x57c>
800006b8:	d195                	beqz	a1,800005dc <data+0x478>
800006ba:	d402                	sw	zero,40(sp)
800006bc:	bab5c80f          	0xbab5c80f
800006c0:	900c                	0x900c
800006c2:	0ce4                	addi	s1,sp,604
800006c4:	e11b61db          	0xe11b61db
800006c8:	2afd                	jal	800008c6 <data+0x762>
800006ca:	fb1e90eb          	0xfb1e90eb
800006ce:	daf1                	beqz	a3,800006a2 <data+0x53e>
800006d0:	409a                	lw	ra,132(sp)
800006d2:	3bac                	fld	fa1,112(a5)
800006d4:	78d1                	lui	a7,0xffff4
800006d6:	83ac                	0x83ac
800006d8:	2930                	fld	fa2,80(a0)
800006da:	d2e6                	sw	s9,100(sp)
800006dc:	cd92                	sw	tp,216(sp)
800006de:	30d6                	fld	ft1,368(sp)
800006e0:	f980                	fsw	fs0,48(a1)
800006e2:	8378                	0x8378
800006e4:	49f8                	lw	a4,84(a1)
800006e6:	faba                	fsw	fa4,116(sp)
800006e8:	10df f277 7583      	0x7583f27710df
800006ee:	4c79                	li	s8,30
800006f0:	8acd                	andi	a3,a3,19
800006f2:	c832                	sw	a2,16(sp)
800006f4:	7d30                	flw	fa2,120(a0)
800006f6:	6aa6                	flw	fs5,72(sp)
800006f8:	0e38                	addi	a4,sp,792
800006fa:	bf02                	fsd	ft0,440(sp)
800006fc:	a6b2                	fsd	fa2,328(sp)
800006fe:	0312                	slli	t1,t1,0x4
80000700:	9a44                	0x9a44
80000702:	38a8                	fld	fa0,112(s1)
80000704:	47ea                	lw	a5,152(sp)
80000706:	229f d03e 4860      	0x4860d03e229f
8000070c:	6eea                	flw	ft9,152(sp)
8000070e:	2d38                	fld	fa4,88(a0)
80000710:	8474                	0x8474
80000712:	ce5e                	sw	s7,28(sp)
80000714:	e86d                	bnez	s0,80000806 <data+0x6a2>
80000716:	f0053d3b          	0xf0053d3b
8000071a:	44c6                	lw	s1,80(sp)
8000071c:	6097a0b3          	0x6097a0b3
80000720:	d583b27b          	0xd583b27b
80000724:	f34a                	fsw	fs2,164(sp)
80000726:	8674                	0x8674
80000728:	9eee                	add	t4,t4,s11
8000072a:	5f6d                	li	t5,-5
8000072c:	1975f7bf fa2ebc82 	0xfa2ebc821975f7bf
80000734:	9461                	srai	s0,s0,0x38
80000736:	7b5c                	flw	fa5,52(a4)
80000738:	07984f2b          	0x7984f2b
8000073c:	dfb8                	sw	a4,120(a5)
8000073e:	5b32                	lw	s6,44(sp)
80000740:	9cec                	0x9cec
80000742:	7172                	flw	ft2,60(sp)
80000744:	693e21f7          	0x693e21f7
80000748:	8a65                	andi	a2,a2,25
8000074a:	6d28                	flw	fa0,88(a0)
8000074c:	a111                	j	80000b50 <data+0x9ec>
8000074e:	95d8                	0x95d8
80000750:	2dd2                	fld	fs11,272(sp)
80000752:	7594de93          	0x7594de93
80000756:	fcab753b          	0xfcab753b
8000075a:	4c00f8db          	0x4c00f8db
8000075e:	08be                	slli	a7,a7,0xf
80000760:	5d9f fa09 46c0      	0x46c0fa095d9f
80000766:	7ca1                	lui	s9,0xfffe8
80000768:	177a                	slli	a4,a4,0x3e
8000076a:	299c                	fld	fa5,16(a1)
8000076c:	3c7f                	0x3c7f
8000076e:	9682                	jalr	a3
80000770:	5bc4                	lw	s1,52(a5)
80000772:	ab8c                	fsd	fa1,16(a5)
80000774:	9f62                	add	t5,t5,s8
80000776:	3509                	jal	80000578 <data+0x414>
80000778:	bfb2                	fsd	fa2,504(sp)
8000077a:	71a18fe3          	beq	gp,s10,80001698 <data+0x1534>
8000077e:	2b85                	jal	80000cee <data+0xb8a>
80000780:	e208                	fsw	fa0,0(a2)
80000782:	3554                	fld	fa3,168(a0)
80000784:	c395                	beqz	a5,800007a8 <data+0x644>
80000786:	231eb263          	0x231eb263
8000078a:	f442                	fsw	fa6,40(sp)
8000078c:	0695                	addi	a3,a3,5
8000078e:	dbb2                	sw	a2,244(sp)
80000790:	cf60                	sw	s0,92(a4)
80000792:	9f24                	0x9f24
80000794:	e4b6                	fsw	fa3,72(sp)
80000796:	f00d59d3          	0xf00d59d3
8000079a:	d121                	beqz	a0,800006da <data+0x576>
8000079c:	5f5e                	lw	t5,244(sp)
8000079e:	a656                	fsd	fs5,264(sp)
800007a0:	16b66b5b          	0x16b66b5b
800007a4:	2b41                	jal	80000d34 <data+0xbd0>
800007a6:	0488                	addi	a0,sp,576
800007a8:	eec5                	bnez	a3,80000860 <data+0x6fc>
800007aa:	8922                	mv	s2,s0
800007ac:	66be                	flw	fa3,204(sp)
800007ae:	f8e9                	bnez	s1,80000780 <data+0x61c>
800007b0:	32e8                	fld	fa0,224(a3)
800007b2:	7c2d                	lui	s8,0xfffeb
800007b4:	9d7a                	add	s10,s10,t5
800007b6:	6c8d                	lui	s9,0x3
800007b8:	0f0c                	addi	a1,sp,912
800007ba:	2890                	fld	fa2,16(s1)
800007bc:	4f54                	lw	a3,28(a4)
800007be:	497f                	0x497f
800007c0:	0f88                	addi	a0,sp,976
800007c2:	08689b17          	auipc	s6,0x8689
800007c6:	8b49db87          	0x8b49db87
800007ca:	243d                	jal	800009f8 <data+0x894>
800007cc:	0301                	addi	t1,t1,0
800007ce:	7346                	flw	ft6,112(sp)
800007d0:	2e21                	jal	80000ae8 <data+0x984>
800007d2:	3254                	fld	fa3,160(a2)
800007d4:	1221                	addi	tp,tp,-24
800007d6:	23bd                	jal	80000d44 <data+0xbe0>
800007d8:	be8e                	fsd	ft3,376(sp)
800007da:	6cfd                	lui	s9,0x1f
800007dc:	43f0                	lw	a2,68(a5)
800007de:	661b708f          	0x661b708f
800007e2:	cfbd                	beqz	a5,80000860 <data+0x6fc>
800007e4:	9d59                	0x9d59
800007e6:	21c8                	fld	fa0,128(a1)
800007e8:	083d                	addi	a6,a6,15
800007ea:	5f72                	lw	t5,60(sp)
800007ec:	3679                	jal	8000037a <data+0x216>
800007ee:	e0b0                	fsw	fa2,64(s1)
800007f0:	5886                	lw	a7,96(sp)
800007f2:	ba51                	j	80000186 <data+0x22>
800007f4:	e79dc46f          	jal	s0,7ffdd66c <_start-0x22994>
800007f8:	dd1a                	sw	t1,184(sp)
800007fa:	fac4bf63          	0xfac4bf63
800007fe:	89859087          	0x89859087
80000802:	c239                	beqz	a2,80000848 <data+0x6e4>
80000804:	51a5                	li	gp,-23
80000806:	047a                	slli	s0,s0,0x1e
80000808:	a35c                	fsd	fa5,128(a4)
8000080a:	9d24                	0x9d24
8000080c:	0031                	c.nop	12
8000080e:	bc91                	j	80000262 <data+0xfe>
80000810:	a67d8a73          	0xa67d8a73
80000814:	c686                	sw	ra,76(sp)
80000816:	21a0                	fld	fs0,64(a1)
80000818:	51f8                	lw	a4,100(a1)
8000081a:	7fa8                	flw	fa0,120(a5)
8000081c:	5a0a                	lw	s4,160(sp)
8000081e:	d53a                	sw	a4,168(sp)
80000820:	d212                	sw	tp,36(sp)
80000822:	1495                	addi	s1,s1,-27
80000824:	26cb1963          	bne	s6,a2,80000a96 <data+0x932>
80000828:	6218                	flw	fa4,0(a2)
8000082a:	2c38                	fld	fa4,88(s0)
8000082c:	7768                	flw	fa0,108(a4)
8000082e:	9135                	srli	a0,a0,0x2d
80000830:	9af04013          	xori	zero,zero,-1617
80000834:	e806                	fsw	ft1,16(sp)
80000836:	a1c4                	fsd	fs1,128(a1)
80000838:	75befb4f          	0x75befb4f
8000083c:	dcc1                	beqz	s1,800007d4 <data+0x670>
8000083e:	c1e1                	beqz	a1,800008fe <data+0x79a>
80000840:	ee8c                	fsw	fa1,24(a3)
80000842:	4801                	li	a6,0
80000844:	5441                	li	s0,-16
80000846:	8c92                	mv	s9,tp
80000848:	1ccc6f8f          	0x1ccc6f8f
8000084c:	dc024b4f          	0xdc024b4f
80000850:	a8d2                	fsd	fs4,80(sp)
80000852:	ba38                	fsd	fa4,112(a2)
80000854:	d2a8                	sw	a0,96(a3)
80000856:	a272                	fsd	ft8,256(sp)
80000858:	0d5d                	addi	s10,s10,23
8000085a:	091526c7          	fmsub.s	fa3,fa0,fa7,ft1,rdn
8000085e:	91c1ace3          	0x91c1ace3
80000862:	4fde1e03          	lh	t3,1277(t3) # ffff04fd <data+0x7fff0399>
80000866:	6329                	lui	t1,0xa
80000868:	2619                	jal	80000b6e <data+0xa0a>
8000086a:	849c                	0x849c
8000086c:	6868                	flw	fa0,84(s0)
8000086e:	06d86983          	0x6d86983
80000872:	9b5d8353          	0x9b5d8353
80000876:	c3de                	sw	s7,196(sp)
80000878:	4ccd                	li	s9,19
8000087a:	7f99                	lui	t6,0xfffe6
8000087c:	15a899c3          	0x15a899c3
80000880:	60b0                	flw	fa2,64(s1)
80000882:	71b0825b          	0x71b0825b
80000886:	bb02                	fsd	ft0,432(sp)
80000888:	7001                	c.lui	zero,0xfffe0
8000088a:	0f0d                	addi	t5,t5,3
8000088c:	f636                	fsw	fa3,44(sp)
8000088e:	1e3b028f          	0x1e3b028f
80000892:	d9d0                	sw	a2,52(a1)
80000894:	0a62                	slli	s4,s4,0x18
80000896:	11ba                	slli	gp,gp,0x2e
80000898:	aa8e                	fsd	ft3,336(sp)
8000089a:	972be033          	0x972be033
8000089e:	5f89c357          	0x5f89c357
800008a2:	6f8d                	lui	t6,0x3
800008a4:	8adf bd93 c168      	0xc168bd938adf
800008aa:	8ad4                	0x8ad4
800008ac:	7c86                	flw	fs9,96(sp)
800008ae:	4e3ce9f3          	csrrsi	s3,0x4e3,25
800008b2:	8a22                	mv	s4,s0
800008b4:	f2d9                	bnez	a3,8000083a <data+0x6d6>
800008b6:	a0b4                	fsd	fa3,64(s1)
800008b8:	b8ca19fb          	0xb8ca19fb
800008bc:	a989                	j	80000d0e <data+0xbaa>
800008be:	a12e                	fsd	fa1,128(sp)
800008c0:	1bf8                	addi	a4,sp,508
800008c2:	c6d4                	sw	a3,12(a3)
800008c4:	14bd                	addi	s1,s1,-17
800008c6:	f73c                	fsw	fa5,104(a4)
800008c8:	29ab7a8f          	0x29ab7a8f
800008cc:	e986                	fsw	ft1,208(sp)
800008ce:	d77a                	sw	t5,172(sp)
800008d0:	8082a487          	flw	fs1,-2040(t0) # ffff4808 <data+0x7fff46a4>
800008d4:	0deec727          	fsq	ft10,206(t4)
800008d8:	16a4                	addi	s1,sp,872
800008da:	fc54                	fsw	fa3,60(s0)
800008dc:	92e6                	add	t0,t0,s9
800008de:	d50da2fb          	0xd50da2fb
800008e2:	1684                	addi	s1,sp,864
800008e4:	0a6a                	slli	s4,s4,0x1a
800008e6:	1c74                	addi	a3,sp,572
800008e8:	894a                	mv	s2,s2
800008ea:	a500                	fsd	fs0,8(a0)
800008ec:	3645                	jal	8000048c <data+0x328>
800008ee:	5a754327          	fsq	ft7,1446(a0) # 4ba445a6 <_start-0x345bba5a>
800008f2:	5a56                	lw	s4,116(sp)
800008f4:	672d                	lui	a4,0xb
800008f6:	f9f9                	bnez	a1,800008cc <data+0x768>
800008f8:	3bd2                	fld	fs7,304(sp)
800008fa:	a774                	fsd	fa3,200(a4)
800008fc:	90b8                	0x90b8
800008fe:	7182                	flw	ft3,32(sp)
80000900:	7066                	flw	ft0,120(sp)
80000902:	1b28                	addi	a0,sp,440
80000904:	a310                	fsd	fa2,0(a4)
80000906:	757be3ef          	jal	t2,800bf85c <data+0xbf6f8>
8000090a:	682a                	flw	fa6,136(sp)
8000090c:	a809                	j	8000091e <data+0x7ba>
8000090e:	4df9                	li	s11,30
80000910:	d604                	sw	s1,40(a2)
80000912:	cb04                	sw	s1,16(a4)
80000914:	f772                	fsw	ft8,172(sp)
80000916:	7a631383          	lh	t2,1958(t1) # a7a6 <_start-0x7fff585a>
8000091a:	9125                	srli	a0,a0,0x29
8000091c:	719a                	flw	ft3,164(sp)
8000091e:	b9c4                	fsd	fs1,176(a1)
80000920:	d39ceacf          	fnmadd.d	fs5,fs9,fs9,fs10,unknown
80000924:	6fdd                	lui	t6,0x17
80000926:	6fcc                	flw	fa1,28(a5)
80000928:	de40                	sw	s0,60(a2)
8000092a:	cf674047          	fmsub.q	ft0,fa4,fs6,fs9,rmm
8000092e:	ace9                	j	80000c08 <data+0xaa4>
80000930:	05be                	slli	a1,a1,0xf
80000932:	b964                	fsd	fs1,240(a0)
80000934:	acc8                	fsd	fa0,152(s1)
80000936:	5b62                	lw	s6,56(sp)
80000938:	b960                	fsd	fs0,240(a0)
8000093a:	14e0                	addi	s0,sp,620
8000093c:	9066                	c.add	zero,s9
8000093e:	65b1                	lui	a1,0xc
80000940:	a0d0                	fsd	fa2,128(s1)
80000942:	19c3ef53          	fdiv.s	ft10,ft7,ft8,unknown
80000946:	da614143          	fmadd.d	ft2,ft2,ft6,fs11,rmm
8000094a:	fa05bd87          	fld	fs11,-96(a1) # bfa0 <_start-0x7fff4060>
8000094e:	ccee                	sw	s11,88(sp)
80000950:	5394                	lw	a3,32(a5)
80000952:	443d                	li	s0,15
80000954:	6d5d                	lui	s10,0x17
80000956:	aacaf9b3          	0xaacaf9b3
8000095a:	a942                	fsd	fa6,144(sp)
8000095c:	1650                	addi	a2,sp,804
8000095e:	6a7ef16f          	jal	sp,800f0804 <data+0xf06a0>
80000962:	ea19                	bnez	a2,80000978 <data+0x814>
