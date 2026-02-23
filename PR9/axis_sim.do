vlib work
vmap work work
vcom -work work std_package.vhd
vcom -work work strb_gen_e.vhd
vcom -work work strb_gen_a.vhd
vcom -work work periodical_strb_gen_ea.vhd
vcom -work work Commands_p.vhd
vcom -work work CommandROM_ea.vhd
vcom -work work cmd_proc_e.vhd
vcom -work work cmd_proc_a.vhd
vcom -work work debouncer_ea.vhd
vcom -work work moving_avg_ea.vhd
vcom -work work synchronizer_chain.vhd
vcom -work work pwm_e.vhd
vcom -work work pwm_a.vhd
vcom -work work Tilt_e.vhd
vcom -work work Tilt_a.vhd
vcom -work work deltaADC_ea.vhd
vcom -work work ServoControl_ea.vhd
vcom -work work HoldValueOnStrb_e.vhd
vcom -work work HoldValueOnStrb_a.vhd
vcom -work work bin2bcd_ea.vhd
vcom -work work bcd_to_7seg_ea.vhd
vcom -work work Tilt_board_ea.vhd
vcom -work work btnCtrl_ea.vhd
vcom -work work strbgen_K_ea.vhd
vcom -work work axis_controller_ea.vhd
vcom -work work tb_axis_controller.vhd

vsim work.tb_axis_controller

add wave -r *

run 101 ms
