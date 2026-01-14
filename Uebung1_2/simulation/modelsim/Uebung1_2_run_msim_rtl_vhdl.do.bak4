transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/DEV/Uni/WS2025/Hardwaredesign/Uebung1_2/architecture_adder.vhd}
vcom -93 -work work {C:/DEV/Uni/WS2025/Hardwaredesign/Uebung1_2/entity_adder.vhd}

vcom -93 -work work {C:/DEV/Uni/WS2025/Hardwaredesign/Uebung1_2/tb_adder.vhd}
vcom -93 -work work {C:/DEV/Uni/WS2025/Hardwaredesign/Uebung1_2/architecture_adder.vhd}
vcom -93 -work work {C:/DEV/Uni/WS2025/Hardwaredesign/Uebung1_2/entity_adder.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  tb_adder

add wave *
view structure
view signals
run -all
