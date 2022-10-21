#src/openocd -f ../tcl/vex_riscv_2x.tcl -f /media/data/open/riscv/VexRiscvOoo/ext/NaxSoftware/baremetal/debugger/tcl/test.tcl

proc reg_read {reg_name} {
  set str [reg $reg_name]
  scan $str "$reg_name (/32): %x\n" value
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

proc read_memory_hex {addr} {
  set value [mdw $addr 8]
  set value [string trim $value "0123456789abcdef:x"]
  set value [string trim $value " \n"]
  echo "|${value}|"
  return $value
}

proc skip_break {rvc} {
  if {$rvc == 1} { pc_incr 2 }
  if {$rvc == 0} { pc_incr 4 }
}

set rvc 1

reset halt
load_image /media/data/open/riscv/VexRiscvOoo/ext/NaxSoftware/baremetal/debugger/build/rv32imac/debugger.bin 0x1000
reg pc 0x00001000
check_reg pc 0x00001000

resume; wait_halt 3000; check_reg a0 0xc0e70d5d; skip_break $rvc
resume; wait_halt 3000; check_reg a0 0xca755a1b; skip_break $rvc

step;step; check_reg a0 0xcdca2c83
step;step; check_reg a0 0xf517b9ee

resume; wait_halt 3000; set addr [reg_read a0]; skip_break $rvc
echo $addr

set value [read_memory_hex $addr]
if {$value != "523ab3f1 f1ad9f75 18d5ea3a 989d6630 81d7daac e0817d8d b775ab3d d15f2ab1"} {error "ouch... too hot!"}

mww $addr 0x00112233
set value [read_memory_hex $addr]
if {$value != "00112233 f1ad9f75 18d5ea3a 989d6630 81d7daac e0817d8d b775ab3d d15f2ab1"} {error "ouch... too hot!"}

resume; set value [read_memory_hex $addr]; skip_break $rvc
if {$value != "00112233 44556677 18d5ea3a 989d6630 81d7daac e0817d8d b775ab3d d15f2ab1"} {error "ouch... too hot!"}

resume; set value [read_memory_hex $addr]; skip_break $rvc
if {$value != "00112233 44556677 18d5ea3a 989d6630 81d7daac e0817d8d b775ab3d d15f2ab1"} {error "ouch... too hot!"}

resume; wait_halt 3000; set break1 [reg_read a0]; set break2 [reg_read a1]; skip_break $rvc
puts "Break at ${break1} and ${break2}"
bp $break1 4 hw ; bp $break2 4 hw
resume; wait_halt 3000; check_reg pc $break1; check_reg a0 15; rbp $break1
resume; wait_halt 3000; check_reg pc $break2; check_reg a0 26; rbp $break2

exit

