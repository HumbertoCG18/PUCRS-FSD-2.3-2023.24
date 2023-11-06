onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/reset
add wave -noupdate /tb/ck
add wave -noupdate /tb/load
add wave -noupdate /tb/init_time
add wave -noupdate -divider {comandos de Jogo}
add wave -noupdate /tb/j1
add wave -noupdate /tb/j2
add wave -noupdate -divider {contador Jogagor 1}
add wave -noupdate -radix hexadecimal /tb/contj1
add wave -noupdate -radix hexadecimal /tb/UUT/contador1/minH
add wave -noupdate -radix hexadecimal /tb/UUT/contador1/minL
add wave -noupdate -radix hexadecimal /tb/UUT/contador1/segH
add wave -noupdate -radix hexadecimal /tb/UUT/contador1/segL
add wave -noupdate -divider {contador Jogador 2}
add wave -noupdate -radix hexadecimal /tb/contj2
add wave -noupdate -radix hexadecimal /tb/UUT/contador2/minH
add wave -noupdate -radix hexadecimal /tb/UUT/contador2/minL
add wave -noupdate -radix hexadecimal /tb/UUT/contador2/segH
add wave -noupdate -radix hexadecimal /tb/UUT/contador2/segL
add wave -noupdate -divider ganhador
add wave -noupdate /tb/winJ1
add wave -noupdate /tb/winJ2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1897739 ps} 0} {{Cursor 2} {53624296 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 204
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 2
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {27300 ns}


add wave -r /*
run 1000 ns
