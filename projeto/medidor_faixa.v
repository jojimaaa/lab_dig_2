module medidor_faixa(
    input wire clock,
    input wire medir,
    input wire [11:0] upperL,
    input wire [11:0] lowerL,
    input wire echo,

    output trigger,
    output acertou,
    output saida_serial,
    output [11:0] db_medida,
    output [3:0] db_estado,
    output dentro
);

wire w_fim_3sec, 
     w_is_ultimo_char, 
     w_pronto_medida,
     w_pronto_tx,
     w_fim_time,
     w_conta_time,
     w_conta_prox_char,
     w_zera_time,
     w_zera_char,
     w_mensurar,
     w_zera,
     w_partida_tx;

medidor_faixa_uc medidor_faixa_uc (
    .clock(clock),
    .medir(medir),
    .fim_3sec(w_fim_3sec),
    .is_ultimo_char(w_is_ultimo_char),
    .pronto_medida(w_pronto_medida),
    .pronto_tx(w_pronto_tx),
    .fim_time(w_fim_time),

    .conta_prox_char(w_conta_prox_char),
    .conta_time(w_conta_time),
    .partida_tx(w_partida_tx),
    .zera_time(w_zera_time),
    .zera_char(w_zera_char),
    .mensurar(w_mensurar),
    .db_estado(db_estado),
    .zera(w_zera)
);

medidor_faixa_fd medidor_faixa_fd (
    .clock(clock),
    .echo(echo),
    .mensurar(w_mensurar),
    .conta_prox_char(w_conta_prox_char),
    .conta_time(w_conta_time),
    .partida_tx(w_partida_tx),
    .zera_time(w_zera_time),
    .zera(w_zera),
    .zera_char(w_zera_char),
    .upperL(upperL),
    .lowerL(lowerL),

    .fim_3sec(w_fim_3sec),
    .acertou(acertou),
    .trigger(trigger),
    .saida_serial(saida_serial),
    .is_ultimo_char(w_is_ultimo_char),
    .pronto_medida(w_pronto_medida),
    .pronto_tx(w_pronto_tx),
    .fim_time(w_fim_time),
    .db_medida(db_medida),
    .dentro(dentro)
);

endmodule