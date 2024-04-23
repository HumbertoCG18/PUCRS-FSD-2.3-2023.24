vlib work

vcom decoder_facil.vhd
vcom testbench.vhd

vsim -voptargs=+acc=lprn -t ns work.testbench

add wave sim:/*

run 500 ns