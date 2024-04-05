if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom pack_mips_fsd.vhd
vcom mipsFSD.vhd
vcom mipsFSD_tb.vhd

vsim -voptargs=+acc=lprn -t ps work.cpu_tb

do wave.do

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

run 60 us

