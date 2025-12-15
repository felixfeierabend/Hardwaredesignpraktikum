vlib work
vmap work work
vcom -work work std_package.vhd
vcom -work work strb_gen_e.vhd
vcom -work work strb_gen_a.vhd
vcom -work work pwm_e.vhd
vcom -work work pwm_a.vhd
vcom -work work DeltaADC_e.vhd
vcom -work work DeltaADC_a.vhd
vcom -work work boardADC_e.vhd
vcom -work work boardADC_a.vhd
vcom -work work tb_deltaAdc.vhd

vsim work.tb_delta_adc

add wave -r *

run 120 ns