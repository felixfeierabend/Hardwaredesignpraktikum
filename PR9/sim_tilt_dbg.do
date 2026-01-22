vlib work
vmap work work
vcom -work work std_package.vhd
vcom -work work strb_gen_e.vhd
vcom -work work strb_gen_a.vhd
vcom -work work synchronizer_chain.vhd
vcom -work work pwm_e.vhd
vcom -work work pwm_a.vhd
vcom -work work Tilt_e.vhd
vcom -work work Tilt_a.vhd
vcom -work work btnCtrl_ea.vhd
vcom -work work deltaADC_ea.vhd
vcom -work work ServoControl_ea.vhd
vcom -work work HoldValueOnStrb_e.vhd
vcom -work work HoldValueOnStrb_a.vhd
vcom -work work bin2bcd_ea.vhd
vcom -work work bcd_to_7seg_ea.vhd
vcom -work work Tilt_board_ea.vhd
vcom -work work tb_debug_design.vhd

vsim work.tb_debug_design

add wave -divider "Control Signals"
add wave sim:/tb_debug_design/clk
add wave sim:/tb_debug_design/rst
add wave sim:/tb_debug_design/cmp
add wave sim:/tb_debug_design/dbg_en
add wave sim:/tb_debug_design/btnIncrement
add wave sim:/tb_debug_design/btnDecrement
add wave sim:/tb_debug_design/switchTen

add wave -divider "ADC Signals"
add wave -r sim:/tb_debug_design/tilt_board/adc/*

add wave -divider "BTN-Ctrl Signals"
add wave -r sim:/tb_debug_design/tilt_board/btnCtrl/*

run 170 ns
