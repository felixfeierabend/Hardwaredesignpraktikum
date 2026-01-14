vlib work
vmap work work

vcom -work work std_definitions.vhd
vcom -work work e_counter.vhd
vcom -work work a_counter.vhd
vcom -work work e_fsm.vhd
vcom -work work a_fsm.vhd
vcom -work work tb_counter_fsm.vhd

vsim work.tb_fsm_counter

add wave -r *

run 80 ns