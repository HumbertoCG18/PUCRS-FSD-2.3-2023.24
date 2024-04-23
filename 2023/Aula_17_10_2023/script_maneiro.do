vlib work
vcom ./fsm_mealy.vhd
vsim -voptargs=+acc=lprn -t ns work.fsm_mealy
add wave sim:/*
force -freeze sim:/clock 1 0, 0 {20 ns} -r 40
force -freeze sim:/entrada 1 0, 0 {7 ns} -r 11

force -freeze sim:/reset 1 0, 0 {23 ns} -r 500


run 500 ns
