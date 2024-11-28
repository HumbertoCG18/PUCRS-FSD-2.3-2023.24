if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom nanoCPU.vhd
vcom nanoTB.vhd

vsim -voptargs=+acc=lprn -t ps work.nanoCPU_TB

do wave.do

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

run 200  ns


# Adicionar instruções para os estados sJMP e sBRANCH
add wave -position end /nanoCPU/PC
add wave -position end /nanoCPU/ZeroFlag