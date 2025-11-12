module neurosync_controller_dual(
    input  clock,
    input  reset,
    input  jogar,
    input  confirma,
    input  direita,
    input  esquerda,
    input  [3:0] botoes,
    input  echo,
    
    output [3:0] leds,
    output trigger,
    output pwm,
    output db_pwm,
    output wire [6:0] hex0,
    output wire [6:0] hex1,
    output wire [6:0] hex2,
    output serial1,
    output serial2
);



    wire jogar_det, 
         confirma_det, 
         reset_det, 
         direita_det, 
         esquerda_det;

    wire [3:0] botoes_det;

    wire confirma_debou, 
         esquerda_debou,
         direita_debou, 
         jogar_debou, 
         reset_debou; 

    wire [3:0] botoes_debou;

    wire [1:0] w_opcode;
    
    wire w_is_ultima_pergunta,
         w_conta_pergunta,
         w_zera_prep_jogo,
         w_acertou_faixa,
         w_registra_modo,
         w_acertou_play,
         w_pronto_play,
         w_zera,
         w_set_pos,
         w_jogando,
         w_medir;

    neurosync_controller_dual_fd neurosync_controller_dual_fd(
        .clock(clock),
        .reset(reset_det),
        .zera(w_zera),
        .jogar(jogar_det),
        .confirma(confirma_det),
        .direita(direita_det),
        .esquerda(esquerda_det),
        .botoes(botoes_det),
		  //.botoes(~botoes),
        .echo(echo),
        .conta_pergunta(w_conta_pergunta),
        .registra_modo(w_registra_modo),
        .zera_prep_jogo(w_zera_prep_jogo),
        .set_pos(w_set_pos),
        .jogando(w_jogando),
        .medir(w_medir),
        .pronto_play(w_pronto_play),
        .acertou_play(w_acertou_play),
        .acertou_faixa(w_acertou_faixa),
        .opcode(w_opcode),
        .is_ultima_pergunta(w_is_ultima_pergunta),
        .leds(leds),
        .trigger(trigger),
        .pwm(pwm),
        .db_pwm(db_pwm),
        .hex0(hex0),
        .hex1(hex1),
        .hex2(hex2),
        .serial1(serial1),
        .serial2(serial2)
    );

    neurosync_controller_dual_uc neurosync_controller_dual_uc(
        .clock(clock),
        .reset(reset_det),
        .jogar_det(jogar_det),
        .confirma_det(confirma_det),
        .opcode(w_opcode),
        .acertou_faixa(w_acertou_faixa),
        .acertou_play(w_acertou_play),
        .pronto_play(w_pronto_play),
        .is_ultima_pergunta(w_is_ultima_pergunta),
        .zera(w_zera),
        .conta_pergunta(w_conta_pergunta),
        .registra_modo(w_registra_modo),
        .zera_prep_jogo(w_zera_prep_jogo),
        .set_pos(w_set_pos),
        .medir(w_medir),
        .jogando(w_jogando)
    );

    edge_detector jogar_detector (
        .clock(clock),
        .reset(),
        .sinal(jogar_debou),
        .pulso(jogar_det)
    );
    edge_detector confirma_detector (
        .clock(clock),
        .reset(),
        .sinal(confirma_debou),
        .pulso(confirma_det)
    );
    edge_detector reset_detector (
        .clock(clock),
        .reset(),
        .sinal(reset_debou),
        .pulso(reset_det)
    );
    edge_detector direita_detector (
        .clock(clock),
        .reset(),
        .sinal(direita_debou),
        .pulso(direita_det)
    );
    edge_detector esquerda_detector (
        .clock(clock),
        .reset(),
        .sinal(esquerda_debou),
        .pulso(esquerda_det)
    );
    edge_detector botao0_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes_debou[0]),
        //.sinal(~botoes[0]),
		  .pulso(botoes_det[0])
    );
    edge_detector botao1_detector (
        .clock(clock),
        .reset(),
        //.sinal(~botoes[1]),
		  .sinal(botoes_debou[1]),
        .pulso(botoes_det[1])
    );
    edge_detector botao2_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes_debou[2]),
        //.sinal(~botoes[2]),
		  .pulso(botoes_det[2])
    );
    edge_detector botao3_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes_debou[3]),
        //.sinal(~botoes[3]),
		  .pulso(botoes_det[3])
    );

    debounce_better_version debou_jogar (
        .pb_1(jogar),
        .clk(clock),
        .pb_out(jogar_debou)
    );
    debounce_better_version debou_confirma (
        .pb_1(confirma),
        .clk(clock),
        .pb_out(confirma_debou)
    );
    debounce_better_version debou_reset (
        .pb_1(reset),
        .clk(clock),
        .pb_out(reset_debou)
    );
    debounce_better_version debou_direita (
        .pb_1(direita),
        .clk(clock),
        .pb_out(direita_debou)
    );
    debounce_better_version debou_esquerda (
        .pb_1(esquerda),
        .clk(clock),
        .pb_out(esquerda_debou)
    );
    debounce_better_version debou_botao0 (
        .pb_1(botoes[0]),
        .clk(clock),
        .pb_out(botoes_debou[0])
    );
    debounce_better_version debou_botao1 (
        .pb_1(botoes[1]),
        .clk(clock),
        .pb_out(botoes_debou[1])
    );
    debounce_better_version debou_botao2 (
        .pb_1(botoes[2]),
        .clk(clock),
        .pb_out(botoes_debou[2])
    );
    debounce_better_version debou_botao3 (
        .pb_1(botoes[3]),
        .clk(clock),
        .pb_out(botoes_debou[3])
    );



endmodule