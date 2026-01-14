vlib work
vmap work work

vcom -work work periodical_strb_gen_ea.vhd
vcom -work work tb_periodical_strb_gen.vhd

vsim work.tb_periodical_strb_gen

add wave -r *

run 820 ns
