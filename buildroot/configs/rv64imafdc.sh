#!/bin/bash

FLAGS+=" -DISA=rv64imafdc"
FLAGS+=" -DISA_STR=\"rv64imafdc\""
FLAGS+=" -DXLEN=64"
FLAGS+=" -DABI=lp64d"
FLAGS+=" -DMMU_TYPE=\"riscv,sv39\""
FLAGS+=" -DRV64"
FLAGS+=" -DRVC=y"
FLAGS+=" -DFPU=y"