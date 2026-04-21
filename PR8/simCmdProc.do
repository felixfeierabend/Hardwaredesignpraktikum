vlib work
vmap work work

vcom -work work std_package.vhd
vcom -work work strb_gen_e.vhd
vcom -work work strb_gen_a.vhd
vcom -work work Commands_p.vhd
vcom -work work CommandROM_ea.vhd
vcom -work work periodical_strb_gen_ea.vhd
vcom -work work cmd_proc_e.vhd
vcom -work work cmd_proc_a.vhd
vcom -work work tb_cmd_proc.vhd

vsim work.tb_cmd_proc

add wave -r *

run 101 ms
