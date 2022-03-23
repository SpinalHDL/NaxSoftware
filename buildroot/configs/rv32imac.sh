#!/bin/bash

FLAGS+=" -DISA=rv32imac"
FLAGS+=" -DISA_STR=\"rv32imac\""
FLAGS+=" -DXLEN=32"
FLAGS+=" -DABI=ilp32"
FLAGS+=" -DMMU_TYPE=\"riscv,sv32\""
FLAGS+=" -DRV32"
FLAGS+=" -DRVC=y"