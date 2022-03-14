FILES=configs/naxriscv_sim_raw_defconfig \
      boards/naxriscv_sim/linux/linux_raw.config\
      boards/naxriscv_sim/linux/linux_raw.dts \
      boards/naxriscv_sim/opensbi/config_raw.mk


%: %_raw
	cpp -E -P $^ > $@

rawrrr : $(FILES)
	echo $(FILES)
