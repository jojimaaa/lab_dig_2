module play_analyser_fd(
    input clock,
    input jogar,
    input reset,
    input [3:0] botoes,
    input [1:0] pos,
    input confirma,
    input conta_prox_char,
    input zera,
    input zera_char,
    input direita,
    input esquerda,
    input partida_tx,
    input reg_jogada,
    input reg_comp,
    input [27:0] expected,

    output serial,
    output pronto_tx,
    output [27:0] resposta,
    output is_ultimo_char,
    output acertou
);

    wire comparacao;
    wire [8:0] pos_9 = {7'b0000000, pos};
    wire [3:0] pos_bcd;
    wire [6:0] pos_ascii, botao_ascii, botao_ascii_reg, pos_ascii_reg, w_dados_ascii;
    wire [6:0] ascii_hash = 7'b0100011; //#
    wire [6:0] ascii_cif = 7'b0100100;  //$
    wire [27:0] resposta_reg = {botao_ascii_reg, ascii_cif, pos_ascii_reg, ascii_hash};

    assign pos_ascii = {3'b011, pos_bcd};
    assign comparacao = (expected == resposta_reg) ? 1'b1 : 1'b0;
    assign resposta = resposta_reg;

    assign botao_ascii  =   jogar       ? 7'b1001010 : //J
                            reset       ? 7'b1011010 : //Z
                            confirma    ? 7'b1011001 : //Y
                            direita     ? 7'b1010010 : //R
                            esquerda    ? 7'b1001100 : //L
                            botoes[0]   ? 7'b1000001 : //A
                            botoes[1]   ? 7'b1000010 : //B
                            botoes[2]   ? 7'b1000011 : //C
                            botoes[3]   ? 7'b1000100 : //D
                                          7'b0000000;


    registrador_n #(.N(7)) registrador_botoes (
        .clock  (clock),
        .clear  (),
        .enable (reg_jogada),
        .D      (botao_ascii),
        .Q      (botao_ascii_reg)
    );

    registrador_n #(.N(7)) registrador_pos (
        .clock  (clock),
        .clear  (),
        .enable (reg_jogada),
        .D      (pos_ascii),
        .Q      (pos_ascii_reg)
    );

    registrador_n #(.N(1)) registrador_comp (
        .clock (clock),
        .clear(),
        .enable(reg_comp),
        .D(comparacao),
        .Q(acertou)

    );

    tx_serial_7E1 tx_serial_7E1 (
    .clock           (clock),
    .reset           (zera),
    .partida         (partida_tx),
    .dados_ascii     (w_dados_ascii),
    .saida_serial    (serial), // saidas
    .pronto          (pronto_tx)
    );

    wire [1:0] sel_char;

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
        .D2(pos_ascii_reg),
        .D1(ascii_cif),
        .D0(botao_ascii_reg),
        .SEL(sel_char),
        .MUX_OUT(w_dados_ascii)
    );

    binaryTObcd binaryTObcd (
        .bin(pos_9),
        .clock(clock),
        .rst(),
        .centenas(),
        .dezenas(),
        .unidades(pos_bcd)
    );
    

endmodule