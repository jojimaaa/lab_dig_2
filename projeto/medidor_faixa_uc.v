module medidor_faixa_uc (
    input wire clock,
    input wire reset,
    input wire medir,
    input wire fim_3sec,
    input wire is_ultimo_char,
    input wire is_ultimo_char_a,
    input wire pronto_medida,
    input wire pronto_tx,
    input wire fim_time,

    output reg conta_prox_char,
    output reg conta_time,
    output reg partida_tx,
    output reg zera_time,
    output reg zera_char,
    output reg mensurar,
    output reg conta_prox_char_a,
    output reg zera_char_a,
    output reg registra_acertou,
    output reg acertou,
    output reg [3:0] db_estado,
    output reg zera
);

// Tipos e sinais
    reg [4:0] Eatual, Eprox; // 3 bits são suficientes para os estados

    // Parâmetros para os estados
    parameter inicial = 4'b0000;
    parameter preparacao = 4'b0001;
    parameter envia_mensurar = 4'b0010;
    parameter aguarda_med = 4'b0011;
    parameter envia_partida = 4'b0100;
    parameter aguarda_tx = 4'b0101;
    parameter proximo_char = 4'b0110;
    parameter espera = 4'b1000;
    parameter prepara_acerto = 4'b1001;
    parameter acertou_pulse = 4'b1111;
    parameter envia_partida_a = 4'b1010;
    parameter aguarda_tx_a = 4'b1011;
    parameter proximo_char_a = 4'b1100;

    // Memória de estado
    always @(posedge clock, posedge reset, negedge medir) begin
        if (reset || ~medir)
            Eatual <= inicial;
		else
            Eatual <= Eprox; 
    end


    // Logica de transição de estado
    always @(*) begin
        case (Eatual)
            inicial:            Eprox = medir ? preparacao : inicial;
            preparacao:         Eprox = (fim_3sec == 1) ? prepara_acerto : envia_mensurar;
            envia_mensurar:     Eprox = (fim_3sec == 1) ? prepara_acerto : aguarda_med;
            aguarda_med:        Eprox = (fim_3sec == 1) ? prepara_acerto : pronto_medida ? envia_partida : aguarda_med;
            envia_partida:      Eprox = aguarda_tx;
            aguarda_tx:         Eprox = pronto_tx ? (is_ultimo_char ? espera : proximo_char) : aguarda_tx;
            proximo_char:       Eprox = envia_partida;
            espera:             Eprox = (fim_3sec == 1) ? prepara_acerto : fim_time ? envia_mensurar : espera;
            
            prepara_acerto:     Eprox = envia_partida_a;
            envia_partida_a:    Eprox = aguarda_tx_a;
            aguarda_tx_a:       Eprox = pronto_tx ? (is_ultimo_char_a ? acertou_pulse : proximo_char_a) : aguarda_tx_a;
            proximo_char_a:     Eprox = envia_partida_a;
            acertou_pulse:      Eprox = inicial;
            default:            Eprox = inicial;
        endcase
    end

    always @(*) begin
        zera                = (Eatual == preparacao);
        zera_time           = (Eatual == envia_mensurar);
        conta_time          = (Eatual == espera);
        mensurar            = (Eatual == envia_mensurar);
        conta_prox_char     = (Eatual == proximo_char);
        partida_tx          = (Eatual == envia_partida || Eatual == envia_partida_a);
        zera_char           = (Eatual == envia_mensurar);

        conta_prox_char_a   = (Eatual == proximo_char_a);
        zera_char_a         = (Eatual == prepara_acerto);
        registra_acertou    = (Eatual == prepara_acerto);
        acertou             = (Eatual == acertou_pulse);

    end
    
    always @(*) begin
        db_estado = (Eatual == inicial)         ? 4'b0000 :
                    (Eatual == preparacao)      ? 4'b0001 :
                    (Eatual == envia_mensurar)  ? 4'b0010 :
                    (Eatual == aguarda_med)     ? 4'b0011 :
                    (Eatual == envia_partida)   ? 4'b0100 :
                    (Eatual == aguarda_tx)      ? 4'b0101 :
                    (Eatual == proximo_char)    ? 4'b0110 :
                    (Eatual == espera)          ? 4'b1000 :
                    (Eatual == prepara_acerto ) ? 4'b1001 :
                    (Eatual == acertou_pulse  ) ? 4'b1111 :
                    (Eatual == envia_partida_a) ? 4'b1010 :
                    (Eatual == aguarda_tx_a   ) ? 4'b1011 :
                    (Eatual == proximo_char_a ) ? 4'b1100 :
                    4'b1111;            
    end

endmodule