#!/bin/bash

FLAGS="-undef"

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source $SCRIPTPATH/configs/$1.sh
ISA_EXTENION_STR="$(echo "${ISA[*]}" | sed "s/ /\",\"/g")"
FLAGS+=" -DISA_STR=\"$ISA_EXTENION_STR\""

doit() {
  cpp -E -P  $FLAGS $1 | sed -e 's/##/#/' > $2
}

doit $SCRIPTPATH/configs/naxriscv_sim_raw_defconfig   $SCRIPTPATH/configs/naxriscv_sim_defconfig
doit $SCRIPTPATH/boards/naxriscv_sim/linux/linux_raw.config  $SCRIPTPATH/boards/naxriscv_sim/linux/linux.config
doit $SCRIPTPATH/boards/naxriscv_sim/linux/linux_raw.dts   $SCRIPTPATH/boards/naxriscv_sim/linux/linux.dts
