onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /neurosync_controller_dual_tb/clock_in
add wave -noupdate /neurosync_controller_dual_tb/reset_in
add wave -noupdate /neurosync_controller_dual_tb/jogar_in
add wave -noupdate /neurosync_controller_dual_tb/confirma_in
add wave -noupdate /neurosync_controller_dual_tb/direita_in
add wave -noupdate /neurosync_controller_dual_tb/esquerda_in
add wave -noupdate /neurosync_controller_dual_tb/botoes_in
add wave -noupdate /neurosync_controller_dual_tb/echo_in
add wave -noupdate /neurosync_controller_dual_tb/leds_out
add wave -noupdate /neurosync_controller_dual_tb/trigger_out
add wave -noupdate /neurosync_controller_dual_tb/pwm_out
add wave -noupdate /neurosync_controller_dual_tb/db_pwm_out
add wave -noupdate -radix symbolic /neurosync_controller_dual_tb/hex0_out
add wave -noupdate -radix symbolic /neurosync_controller_dual_tb/hex1_out
add wave -noupdate -radix symbolic /neurosync_controller_dual_tb/hex2_out
add wave -noupdate /neurosync_controller_dual_tb/serial1_out
add wave -noupdate /neurosync_controller_dual_tb/serial2_out
add wave -noupdate -color Gold /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_uc/Eatual
add wave -noupdate -group circuito_pwm /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/circuito_pwm/direita
add wave -noupdate -group circuito_pwm /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/circuito_pwm/esquerda
add wave -noupdate -group circuito_pwm /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/circuito_pwm/set_pos
add wave -noupdate -group circuito_pwm /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/circuito_pwm/pos_inicial
add wave -noupdate -group circuito_pwm /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/circuito_pwm/pos
add wave -noupdate -group circuito_pwm /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/circuito_pwm/pwm
add wave -noupdate -group circuito_pwm /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/circuito_pwm/db_pwm
add wave -noupdate -group contador_mem /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/contador_memoria/zera_as
add wave -noupdate -group contador_mem /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/contador_memoria/zera_s
add wave -noupdate -group contador_mem /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/contador_memoria/conta
add wave -noupdate -group contador_mem /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/contador_memoria/Q
add wave -noupdate -group contador_mem /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/contador_memoria/fim
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/jogar
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/reset
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/botoes
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/pos
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/confirma
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/direita
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/esquerda
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/expected
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/serial
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/pronto
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/acertou
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/resposta
add wave -noupdate -group player_analyser /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/play_analyser/pronto_comparacao
add wave -noupdate -group medidor_faixa /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/medir
add wave -noupdate -group medidor_faixa /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/upperL
add wave -noupdate -group medidor_faixa /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/lowerL
add wave -noupdate -group medidor_faixa /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/echo
add wave -noupdate -group medidor_faixa /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/trigger
add wave -noupdate -group medidor_faixa /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/acertou
add wave -noupdate -group medidor_faixa /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/saida_serial
add wave -noupdate -group medidor_faixa -radix hexadecimal /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/db_medida
add wave -noupdate -group medidor_faixa /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/db_estado
add wave -noupdate -group medidor_faixa /neurosync_controller_dual_tb/neurosync_controller_dual/neurosync_controller_dual_fd/medidor_faixa/dentro
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {61690790 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 182
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
WaveRestoreZoom {0 ns} {66057947 ns}
