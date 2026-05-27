#!/bin/bash

ISA=(i m a zicsr zifence)
FLAGS+=" -DISA_BASE=\"rv32i\""
FLAGS+=" -DXLEN=32"
FLAGS+=" -DABI=ilp32"
FLAGS+=" -DMMU_TYPE=\"riscv,sv32\""
FLAGS+=" -DRV32"
FLAGS+=" -DRVC=n"
