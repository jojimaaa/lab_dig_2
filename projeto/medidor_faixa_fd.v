module medidor_faixa_fd(
    input clock,
    input echo,
    input mensurar,
    input conta_prox_char,
    input conta_time,
    input partida_tx,
    input zera_time,
    input zera,
    input zera_char,
    input [11:0] upperL,
    input [11:0] lowerL,

    output fim_3sec,
    output acertou,
    output trigger,
    output saida_serial,
    output is_ultimo_char,
    output pronto_medida,
    output pronto_tx,
    output fim_time,
    output [11:0] db_medida,
    output dentro
);

// vamos enviar XYZ#
wire [1:0] sel_char, pos_addr;
wire [11:0] w_medida, w_medida_reg;
wire w_dentro, w_fim_3sec;

wire [6:0] centena_ascii, dezena_ascii, unidade_ascii, w_dados_ascii;
wire [6:0] ascii_hash = 7'b0100011;

assign db_medida = w_medida_reg;
assign unidade_ascii = {3'b011, w_medida_reg[3:0]};
assign dezena_ascii  = {3'b011, w_medida_reg[7:4]};
assign centena_ascii = {3'b011, w_medida_reg[11:8]};

assign acertou = fim_3sec;
assign dentro = w_dentro;
assign fim_3sec = w_fim_3sec;

interface_hcsr04 interface_hcsr04 (
    .clock(clock),
    .reset(zera),
    .medir(mensurar),
    .echo(echo),
    .trigger(trigger),
    .medida(w_medida),
    .pronto(pronto_medida)
);

// //3s
// contador_m_trava #(.M(150_000_000), .N(28)) contador_3sec ( //teste
//     .clock(clock),
//     .zera_as(),
//     .zera_s(~w_dentro),
//     .conta(w_dentro),
//     .Q(),
//     .fim(w_fim_3sec),
//     .meio()
// );
// contador_m_trava #(.M(150_000_000), .N(28)) contador_3sec (
//     .clock(clock),
//     .zera_as(),
//     .zera_s(~w_dentro),
//     .conta(w_dentro),
//     .Q(),
//     .fim(w_fim_3sec),
//     .meio()
// );

// //100ms
// contador_m #(.M(5_000_000), .N(24)) contador_time (
//     .clock(clock),
//     .zera_as(),
//     .zera_s(zera_time),
//     .conta(conta_time),
//     .Q(),
//     .fim(fim_time),
//     .meio()
// );

// 20ms p/ teste
contador_m #(.M(1_000_000), .N(28)) contador_3sec (
    .clock(clock),
    .zera_as(),
    .zera_s(~w_dentro),
    .conta(w_dentro),
    .Q(),
    .fim(w_fim_3sec),
    .meio()
);


// 200us para teste
contador_m #(.M(10000), .N(24)) contador_time (
    .clock(clock),
    .zera_as(),
    .zera_s(zera_time),
    .conta(conta_time),
    .Q(),
    .fim(fim_time),
    .meio()
);

comparador_faixa comparador_faixa (
    .upperL(upperL),
    .lowerL(lowerL),
    .medida(w_medida_reg),
    .dentro(w_dentro)
);

tx_serial_7E1 tx_serial_7E1 (
    .clock           (clock),
    .reset           (zera),
    .partida         (partida_tx),
    .dados_ascii     (w_dados_ascii),
    .saida_serial    (saida_serial), // saidas
    .pronto          (pronto_tx)
);

contador_m #(.M(4), .N(3)) contador_char (
    .clock(clock),
    .zera_as(),
    .zera_s(zera_char),
    .conta(conta_prox_char),
    .Q(sel_char),
    .fim(is_ultimo_char),
    .meio()
);

mux_4x1 #(.BITS(7)) mux_char(
    .D3(ascii_hash),
    .D2(unidade_ascii),
    .D1(dezena_ascii),
    .D0(centena_ascii),
    .SEL(sel_char),
    .MUX_OUT(w_dados_ascii)
);


registrador_n #(
    .N(12)
) registrador_medida (
    .clock  (clock    ),
    .clear  (zera),
    .enable (pronto_medida),
    .D      (w_medida ),
    .Q      (w_medida_reg)
);

endmodule