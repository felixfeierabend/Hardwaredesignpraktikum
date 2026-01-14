vlib work
vmap work work

vcom -work work entity_combinatorial_circuit.vhd
vcom -work work architecture_combinatorial_circuit.vhd
vcom -work work tb_combinatorial_circuit.vhd

vsim work.tb_combinatorial_circuit

add wave -r *

run 50 ns