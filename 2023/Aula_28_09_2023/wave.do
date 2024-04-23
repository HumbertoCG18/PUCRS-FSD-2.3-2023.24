onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/habilita
add wave -noupdate -color Yellow /testbench/dado
add wave -noupdate -divider Latch
add wave -noupdate -color Pink /testbench/saida_latch
add wave -noupdate /testbench/saida_latch_n
add wave -noupdate -divider {FF Subida}
add wave -noupdate /testbench/saida_subida
add wave -noupdate /testbench/saida_subida_n
add wave -noupdate -divider {FF Descida}
add wave -noupdate /testbench/saida_descida
add wave -noupdate /testbench/saida_descida_n
add wave -noupdate -divider {FF 2}
add wave -noupdate /testbench/saida_2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {903 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1050 ns}
