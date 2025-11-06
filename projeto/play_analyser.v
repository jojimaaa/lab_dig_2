module play_analyser(
    input clock,
    input jogar,
    input reset,
    input [3:0] botoes,
    input [1:0] pos,
    input confirma,
    input direita,
    input esquerda,
    input [27:0] expected,
    output serial,
    output pronto,
    output acertou,
    output [27:0] resposta,
    output pronto_comparacao
);

    wire jogar_det, 
         confirma_det, 
         reset_det, 
         direita_det, 
         esquerda_det,
         w_pronto_tx,
         w_is_ultimo_char,
         w_zera,
         w_zera_char,
         w_conta_prox_char,
         w_partida_tx,
         w_reg_comp,
         w_reg_jogada;

    wire [3:0] botoes_det;

    wire button_activation;

    assign button_activation =  jogar_det || 
                                confirma_det || 
                                reset_det || 
                                direita_det || 
                                esquerda_det || 
                                botoes_det[0] ||
                                botoes_det[1] ||
                                botoes_det[2] ||
                                botoes_det[3];


    play_analyser_fd play_analyser_fd (
        .clock(clock),
        .jogar(jogar),
        .reset(reset),
        .botoes(botoes),
        .pos(pos),
        .confirma(confirma),
        .conta_prox_char(w_conta_prox_char),
        .zera(w_zera),
        .zera_char(w_zera_char),
        .direita(direita),
        .esquerda(esquerda),
        .partida_tx(w_partida_tx),
        .reg_jogada(w_reg_jogada),
        .reg_comp(w_reg_comp),
        .expected(expected),
        .serial(serial),
        .pronto_tx(w_pronto_tx),
        .resposta(resposta),
        .is_ultimo_char(w_is_ultimo_char),
        .acertou(acertou)
    );

    play_analyser_uc play_analyser_uc (
        .clock(clock),
        .reset(),
        .button_activation(button_activation),
        .pronto_tx(w_pronto_tx),
        .is_ultimo_char(w_is_ultimo_char),
        .zera(w_zera),
        .conta_prox_char(w_conta_prox_char),
        .partida_tx(w_partida_tx),
        .zera_char(w_zera_char),
        .reg_jogada(w_reg_jogada),
        .reg_comp(w_reg_comp),
        .pronto_comparacao(pronto_comparacao),
        .pronto(pronto)
    );


    edge_detector jogar_detector (
        .clock(clock),
        .reset(),
        .sinal(jogar),
        .pulso(jogar_det)
    );
    edge_detector confirma_detector (
        .clock(clock),
        .reset(),
        .sinal(confirma),
        .pulso(confirma_det)
    );
    edge_detector reset_detector (
        .clock(clock),
        .reset(),
        .sinal(reset),
        .pulso(reset_det)
    );
    edge_detector direita_detector (
        .clock(clock),
        .reset(),
        .sinal(direita),
        .pulso(direita_det)
    );
    edge_detector esquerda_detector (
        .clock(clock),
        .reset(),
        .sinal(esquerda),
        .pulso(esquerda_det)
    );
    edge_detector botao0_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes[0]),
        .pulso(botoes_det[0])
    );
    edge_detector botao1_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes[1]),
        .pulso(botoes_det[1])
    );
    edge_detector botao2_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes[2]),
        .pulso(botoes_det[2])
    );
    edge_detector botao3_detector (
        .clock(clock),
        .reset(),
        .sinal(botoes[3]),
        .pulso(botoes_det[3])
    );

endmodule