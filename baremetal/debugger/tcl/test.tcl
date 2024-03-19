#src/openocd -f ../tcl/vex_riscv_2x.tcl -f /media/data/open/riscv/VexRiscvOoo/ext/NaxSoftware/baremetal/debugger/tcl/test.tcl

proc reg_read {reg_name} {
  set str [reg $reg_name]
  scan $str "$reg_name %s %x\n" dummy value
  return $value
}

proc check_reg {reg_name expect} {
  set value [reg_read $reg_name]
  echo "Check ${value} == ${expect}"
  if {$value != $expect} {error "ouch... too hot!"}
}

proc pc_incr {offset} {
  reg pc [expr {[reg_read pc]+$offset}]
}

proc read_memory_hex {addr words} {
  set value [mdw $addr $words]
  set value [string trim $value "0123456789abcdef:x"]
  set value [string trim $value " \n"]
  echo "|${value}|"
  return $value
}

proc skip_break {rvc} {
  if {$rvc == 1} { pc_incr 2 }
  if {$rvc == 0} { pc_incr 4 }
}

set misa [reg_read misa]
set rvc [expr {($misa >> 2) % 2}]
set test_wp 1

echo "rvc $rvc"

reset halt
reg pc 0x80000000
check_reg pc 0x80000000



resume; wait_halt 3000; check_reg a0 0xc0e70d5d; skip_break $rvc
resume; wait_halt 3000; check_reg a0 0xca755a1b; skip_break $rvc

step;step; check_reg a0 0x4dca2c83
step;step; check_reg a0 0x5517b9ee

resume; wait_halt 3000; set addr [reg_read a0]; skip_break $rvc
echo $addr

set value [read_memory_hex $addr 8]
if {$value != "523ab3f1 f1ad9f75 18d5ea3a 989d6630 81d7daac e0817d8d b775ab3d d15f2ab1"} {error "ouch... too hot!"}

mww $addr 0x00112233
set value [read_memory_hex $addr 8]
if {$value != "00112233 f1ad9f75 18d5ea3a 989d6630 81d7daac e0817d8d b775ab3d d15f2ab1"} {error "ouch... too hot!"}

resume; set value [read_memory_hex $addr 8]; skip_break $rvc
if {$value != "00112233 44556677 18d5ea3a 989d6630 81d7daac e0817d8d b775ab3d d15f2ab1"} {error "ouch... too hot!"}

resume; set value [read_memory_hex $addr 8]; skip_break $rvc
if {$value != "00112233 44556677 18d5ea3a 989d6630 81d7daac e0817d8d b775ab3d d15f2ab1"} {error "ouch... too hot!"}

resume; wait_halt 3000; set break1 [reg_read a0]; set break2 [reg_read a1]; set break3 [reg_read a2];  set lb1 [reg_read a3];  set sb1 [reg_read a4];  set data [reg_read a5];  skip_break $rvc
puts "Break at ${break1} and ${break2}"
bp $break1 4 hw ; bp $break2 4 hw
resume; wait_halt 3000; check_reg pc $break1; check_reg a0 15; rbp $break1
resume; wait_halt 3000; check_reg pc $break2; check_reg a0 26; rbp $break2

bp $break3 4 hw
resume; wait_halt 3000; check_reg pc $break3;  rbp $break3
echo "got to break3"
check_reg a1 0x00000000; step; check_reg a1 0x00000001
check_reg a2 0x10000000; step; check_reg a2 0x10000001
check_reg a3 0x20000000; step; check_reg a3 0x20000001
step; check_reg a4 0
step; check_reg a5 0
step; check_reg a6 0
check_reg a4 0; step; check_reg a4 0x10
check_reg a5 0; step; check_reg a5 0x20
check_reg a6 0; step; check_reg a6 0x30
step;step;step

set value [read_memory_hex $data 1]
if {$value != "40302010"} {error "ouch... too hot!"}
step
set value [read_memory_hex $data 1]
if {$value != "40302011"} {error "ouch... too hot!"}
step
set value [read_memory_hex $data 1]
if {$value != "40302111"} {error "ouch... too hot!"}
step
set value [read_memory_hex $data 1]
if {$value != "40312111"} {error "ouch... too hot!"}


if {$test_wp == 1} {
    wp [expr {$data + 1}] 1 r;
    resume; wait_halt 3000; check_reg pc $lb1; check_reg a4 0x11; check_reg a5 0; check_reg a6 0;
    rwp [expr {$data + 1}] ; step; check_reg a4 0x11; check_reg a5 0x21; check_reg a6 0;

    wp [expr {$data + 1}] 1 w;
    resume; wait_halt 3000; check_reg pc $sb1;
    set value [read_memory_hex $data 1]
    if {$value != "40312112"} {error "ouch... too hot!"}
    rwp [expr {$data + 1}]
}

echo "success"

exit

