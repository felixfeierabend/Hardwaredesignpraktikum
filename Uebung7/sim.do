vlib work
vmap work work

vcom -work work shift_register_e.vhd
vcom -work work shift_register_a.vhd
vcom -work work tb_moving_avg_filter.vhd

vsim work.tb_moving_avg

add wave -r *

run 200 ns