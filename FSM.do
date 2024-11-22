onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /FSM_tb/FSM_DUT/STATE_WIDTH
add wave -noupdate /FSM_tb/FSM_DUT/clk
add wave -noupdate /FSM_tb/FSM_DUT/run
add wave -noupdate /FSM_tb/FSM_DUT/mode
add wave -noupdate -radix binary /FSM_tb/FSM_DUT/vector
add wave -noupdate /FSM_tb/FSM_DUT/current_state
add wave -noupdate /FSM_tb/FSM_DUT/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 243
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
WaveRestoreZoom {0 ps} {230918 ps}
