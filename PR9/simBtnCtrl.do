vlib work
vmap work work
vcom -work work std_package.vhd
vcom -work work periodical_strb_gen_ea.vhd
vcom -work work debouncer_ea.vhd
vcom -work work btnCtrl_ea.vhd
vcom -work work tb_btnCtrl.vhd

vsim work.tb_btnCtrl

add wave -r *

run 170 ns
