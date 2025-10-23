vlib work
vmap work work

vcom -work work AndOr_e.vhd
vcom -work work AndOr_a.vhd
vcom -work work AndOr_tb.vhd

vsim work.AndOr_tb

add wave -r *

run 1000 ns