vlib work
vmap work work
vcom -work work std_package.vhd
vcom -work work strb_gen_e.vhd
vcom -work work strb_gen_a.vhd
vcom -work work synchronizer_chain.vhd
vcom -work work pwm_e.vhd
vcom -work work pwm_a.vhd
vcom -work work Tilt_e.vhd
vcom -work work Tilt_a.vhd
vcom -work work DeltaADC_e.vhd
vcom -work work DeltaADC_a.vhd
vcom -work work boardADC_e.vhd
vcom -work work boardADC_a.vhd
vcom -work work ServoControl_e.vhd
vcom -work work ServoControl_a.vhd
vcom -work work HoldValueOnStrb_e.vhd
vcom -work work HoldValueOnStrb_a.vhd
vcom -work work bin2bcd_ea.vhd
vcom -work work bcd_to_7seg_ea.vhd
vcom -work work Tilt_board_ea.vhd
vcom -work work tb_digital.vhd

vsim work.tb_digital

add wave -r *

run 71 ms