# Inicialização da simulação
vsim work.MultSomaPositivos_tb

# Carregar bibliotecas e módulos
vlib work
vlog MultSomaPositivos.vhd
vlog MultSomaPositivos_tb.vhd
vlog multSomaPositivos.asm

# Rodar a simulação
add wave -noupdate /MultSomaPositivos_tb/*
run -all
