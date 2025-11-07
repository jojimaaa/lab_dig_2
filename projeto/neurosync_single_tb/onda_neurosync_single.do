onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /neurosync_controller_single_tb/clock_in
add wave -noupdate /neurosync_controller_single_tb/reset_in
add wave -noupdate /neurosync_controller_single_tb/jogar_in
add wave -noupdate /neurosync_controller_single_tb/confirma_in
add wave -noupdate /neurosync_controller_single_tb/direita_in
add wave -noupdate /neurosync_controller_single_tb/esquerda_in
add wave -noupdate /neurosync_controller_single_tb/botoes_in
add wave -noupdate /neurosync_controller_single_tb/echo_in
add wave -noupdate /neurosync_controller_single_tb/leds_out
add wave -noupdate /neurosync_controller_single_tb/trigger_out
add wave -noupdate /neurosync_controller_single_tb/pwm_out
add wave -noupdate /neurosync_controller_single_tb/db_pwm_out
add wave -noupdate /neurosync_controller_single_tb/hex0_out
add wave -noupdate /neurosync_controller_single_tb/hex1_out
add wave -noupdate /neurosync_controller_single_tb/hex2_out
add wave -noupdate /neurosync_controller_single_tb/serial_out
add wave -noupdate -color Gold /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_uc/Eatual
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/jogar
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/reset
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/botoes
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/pos
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/confirma
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/direita
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/esquerda
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/expected
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/serial
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/pronto
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/acertou
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/resposta
add wave -noupdate -expand -group play_analyser /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/play_analyser/pronto_comparacao
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/medir
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/reset
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/upperL
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/lowerL
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/echo
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/trigger
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/acertou
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/saida_serial
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/db_medida
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/db_estado
add wave -noupdate -expand -group med_faixa /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/dentro
add wave -noupdate -group med_faixa/tx_serial/deslocador /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/medidor_faixa_fd/tx_serial_7E1/tx_serial_7E1_fd/U1/reset
add wave -noupdate -group med_faixa/tx_serial/deslocador /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/medidor_faixa_fd/tx_serial_7E1/tx_serial_7E1_fd/U1/carrega
add wave -noupdate -group med_faixa/tx_serial/deslocador /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/medidor_faixa_fd/tx_serial_7E1/tx_serial_7E1_fd/U1/desloca
add wave -noupdate -group med_faixa/tx_serial/deslocador /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/medidor_faixa_fd/tx_serial_7E1/tx_serial_7E1_fd/U1/entrada_serial
add wave -noupdate -group med_faixa/tx_serial/deslocador /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/medidor_faixa_fd/tx_serial_7E1/tx_serial_7E1_fd/U1/dados
add wave -noupdate -group med_faixa/tx_serial/deslocador /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/medidor_faixa_fd/tx_serial_7E1/tx_serial_7E1_fd/U1/saida
add wave -noupdate -group med_faixa/tx_serial/deslocador /neurosync_controller_single_tb/neurosync_controller_single/neurosync_controller_single_fd/medidor_faixa/medidor_faixa_fd/tx_serial_7E1/tx_serial_7E1_fd/U1/IQ
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22060527 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 343
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ns} {32411810 ns}
