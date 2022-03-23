#!/bin/bash

FLAGS+=" -DISA=rv64imac"
FLAGS+=" -DISA_STR=\"rv64imac\""
FLAGS+=" -DXLEN=64"
FLAGS+=" -DABI=lp64"
FLAGS+=" -DMMU_TYPE=\"riscv,sv39\""
FLAGS+=" -DRV64"
FLAGS+=" -DRVC=y"