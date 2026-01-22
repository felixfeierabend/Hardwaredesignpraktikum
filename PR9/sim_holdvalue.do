vlib work
vmap work work
vcom -work work std_package.vhd
vcom -work work HoldValueOnStrb_e.vhd
vcom -work work HoldValueOnStrb_a.vhd
vcom -work work tb_HoldValueOnStrb.vhd

vsim work.tb_HoldValueOnStrb

add wave -r *

run 17 ns

