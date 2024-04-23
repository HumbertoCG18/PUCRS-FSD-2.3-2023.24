vlib work

vcom uart_tx.vhd
vcom uart_tx_tb.vhd

vsim -voptargs=+acc -wlfdeleteonquit  -t ns work.uart_tx_tb

add wave -radix binary sim:/*
add wave -divider "sinais internos"
add wave sim:/duv/*

run 500 ns
