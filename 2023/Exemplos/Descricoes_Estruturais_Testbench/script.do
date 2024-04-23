vlib work

vcom full_adder.vhd
vcom somador_3b.vhd
vcom testbench.vhd

vsim -wlf /sim/full_adder testbench

add wave sim:/*

run 26000 ns


