#!/bin/bash

FLAGS+=" -DISA=rv32ima"
FLAGS+=" -DISA_STR=\"rv32ima\""
FLAGS+=" -DXLEN=32"
FLAGS+=" -DABI=ilp32"
FLAGS+=" -DMMU_TYPE=\"riscv,sv32\""
FLAGS+=" -DRV32"