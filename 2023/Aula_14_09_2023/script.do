vlib work

vcom meio_somador.vhd
vcom somador_completo.vhd
vcom somador.vhd


vsim -voptargs=+acc=lprn -t ns work.somador_3b


add wave -radix binary sim:/*

add wave -divider "representacao em unsigned"
add wave -radix unsigned sim:/*

force -freeze sim:/somador_3b/op_a(0) 1 0, 0 {5 ns} -r 10
force -freeze sim:/somador_3b/op_a(1) 1 0, 0 {10 ns} -r 20
force -freeze sim:/somador_3b/op_a(2) 1 0, 0 {20 ns} -r 40

force -freeze sim:/somador_3b/op_b(0) 1 0, 0 {40 ns} -r 80
force -freeze sim:/somador_3b/op_b(1) 1 0, 0 {80 ns} -r 160
force -freeze sim:/somador_3b/op_b(2) 1 0, 0 {160 ns} -r 320

run 320 ns
