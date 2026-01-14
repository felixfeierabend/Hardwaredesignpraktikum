vlib work
vmap work work

vcom -work work e_pwm.vhd
vcom -work work a_pwm.vhd
vcom -work work DeltaADC_e.vhd
vcom -work work DeltaADC_a.vhd
vcom -work work strb_gen_e.vhd
vcom -work work strb_gen_a.vhd
vcom -work work boardADC_e.vhd
vcom -work work boardADC_a.vhd
vcom -work work tb_DeltaADC.vhd

vsim work.tb_delta_adc

add wave -r *

run 50 ns