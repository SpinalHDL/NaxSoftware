#!/bin/bash

ISA=(i m a c zicsr zifence)
FLAGS+=" -DISA_BASE=\"rv64i\""
FLAGS+=" -DXLEN=64"
FLAGS+=" -DABI=lp64"
FLAGS+=" -DMMU_TYPE=\"riscv,sv39\""
FLAGS+=" -DRV64"
FLAGS+=" -DRVC=y"
