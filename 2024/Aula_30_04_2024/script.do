## criação da biblioteca de trabalho.
if {! [ file exists work ] } { 
	echo "Criando biblioteca Work..."
	vlib work
} 

## comando de compilação.
vcom ./ULA.vhd
vcom ./testbench.vhd

## comando de simulação
vsim -voptargs=+acc -wlfdeleteonquit -t ns work.testbench

## adição dos sinais na forma de onda.
add wave sim:/*

## execução da simulação.
run 10.3 us
