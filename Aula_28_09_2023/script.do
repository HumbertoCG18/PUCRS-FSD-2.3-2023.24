vlib work

vcom latch.vhd
vcom ff_d_subida.vhd
vcom ff_d_descida.vhd
vcom elementos_memoria_tb.vhd

vsim -voptargs=+acc=lprn -t ns work.testbench

add wave sim:/*
#do wave.do

run 1 us
