FILES=configs/naxriscv_sim_raw_defconfig \
      boards/naxriscv_sim/linux/linux_raw.config\
      boards/naxriscv_sim/linux/linux_raw.dts


%: %_raw
	cpp -E -P $^ > $@

rawrrr : $(FILES)
	echo $(FILES)
