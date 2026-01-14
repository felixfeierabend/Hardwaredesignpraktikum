vlib work
vmap work work

vcom -work work pwm_e.vhd
vcom -work work pwm_a.vhd
vcom -work work ServoPackage.vhd
vcom -work work ServoControl_e.vhd
vcom -work work ServoControl_a.vhd
vcom -work work tb_servo.vhd

vsim work.tb_servo

add wave -r *

run 6 ms