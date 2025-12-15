vlib work
vmap work work

vcom -work work e_pwm.vhd
vcom -work work a_pwm.vhd
vcom -work work tb_pwm.vhd

vsim work.tb_pwm

add wave -r *

run 50 ns