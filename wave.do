onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /FIFO_tb/DUT/clk
add wave -noupdate /FIFO_tb/DUT/FIFO_reset_n
add wave -noupdate /FIFO_tb/DUT/FIFO_clr_n
add wave -noupdate /FIFO_tb/DUT/data_in
add wave -noupdate /FIFO_tb/DUT/data_out
add wave -noupdate /FIFO_tb/DUT/push
add wave -noupdate /FIFO_tb/DUT/pop
add wave -noupdate /FIFO_tb/DUT/i
add wave -noupdate -expand /FIFO_tb/DUT/FIFO
add wave -noupdate /FIFO_tb/DUT/top
add wave -noupdate /FIFO_tb/DUT/btm
add wave -noupdate /FIFO_tb/DUT/cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {104378 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {581376 ps}
