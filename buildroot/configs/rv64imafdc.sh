#!/bin/bash

ISA=(i m a f d c zicsr zifence)
FLAGS+=" -DISA_BASE=\"rv64i\""
FLAGS+=" -DXLEN=64"
FLAGS+=" -DABI=lp64d"
FLAGS+=" -DMMU_TYPE=\"riscv,sv39\""
FLAGS+=" -DRV64"
FLAGS+=" -DRVC=y"
FLAGS+=" -DFPU=y"
