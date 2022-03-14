#!/bin/bash

FLAGS+=" -DISA=rv64ima"
FLAGS+=" -DISA_STR=\"rv64ima\""
FLAGS+=" -DXLEN=64"
FLAGS+=" -DABI=lp64"
FLAGS+=" -DMMU_TYPE=\"riscv,sv39\""
FLAGS+=" -DRV64"