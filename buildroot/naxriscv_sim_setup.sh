#!/bin/bash

FLAGS="-undef"

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source $SCRIPTPATH/configs/$1.sh

doit() {
  cpp -E -P  $FLAGS $1 | sed -e 's/##/#/' > $2
}

doit $SCRIPTPATH/configs/naxriscv_sim_raw_defconfig   $SCRIPTPATH/configs/naxriscv_sim_defconfig
doit $SCRIPTPATH/boards/naxriscv_sim/linux/linux_raw.config  $SCRIPTPATH/boards/naxriscv_sim/linux/linux.config
doit $SCRIPTPATH/boards/naxriscv_sim/linux/linux_raw.dts   $SCRIPTPATH/boards/naxriscv_sim/linux/linux.dts
doit $SCRIPTPATH/boards/naxriscv_sim/opensbi/config_raw.mk  $SCRIPTPATH/boards/naxriscv_sim/opensbi/config.mk
