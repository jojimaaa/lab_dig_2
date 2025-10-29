module medidor_faixa_uc (
    input wire clock,
    input wire reset,
    input wire medir,
    input wire fim_3sec,
    input wire is_ultimo_char,
    input wire pronto_medida,
    input wire pronto_tx,
    input wire fim_time,

    output reg conta_prox_char,
    output reg conta_time,
    output reg partida_tx,
    output reg zera_time,
    output reg zera_char,
    output reg mensurar,
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


    // Memória de estado
    always @(posedge clock, posedge reset, posedge fim_3sec, negedge medir) begin
        if (reset || fim_3sec || ~medir)
            Eatual <= inicial;
        else
            Eatual <= Eprox; 
    end


    // Logica de transição de estado
    always @(*) begin
        case (Eatual)
            inicial: Eprox = medir ? preparacao : inicial;
            preparacao: Eprox = envia_mensurar;
            envia_mensurar: Eprox = aguarda_med;
            aguarda_med: Eprox = pronto_medida ? envia_partida : aguarda_med;
            envia_partida: Eprox = aguarda_tx;
            aguarda_tx: Eprox = pronto_tx ? (is_ultimo_char ? espera : proximo_char) : aguarda_tx;
            proximo_char: Eprox = envia_partida;
            espera: Eprox = fim_time ? envia_mensurar : espera;
        endcase
    end

    always @(*) begin
        zera = (Eatual == preparacao);
        zera_time = (Eatual == envia_mensurar);
        conta_time = (Eatual == espera);
        mensurar = (Eatual == envia_mensurar);
        conta_prox_char = (Eatual == proximo_char);
        partida_tx = (Eatual == envia_partida);
        zera_char = (Eatual == envia_mensurar);
    end
    
    always @(*) begin
        db_estado = (Eatual == inicial) ? 4'b0000 :
                    (Eatual == preparacao) ? 4'b0001 :
                    (Eatual == envia_mensurar) ? 4'b0010 :
                    (Eatual == aguarda_med) ? 4'b0011 :
                    (Eatual == envia_partida) ? 4'b0100 :
                    (Eatual == aguarda_tx) ? 4'b0101 :
                    (Eatual == proximo_char) ? 4'b0110 :
                    (Eatual == espera) ? 4'b1000:
                    4'b1111;
    end

endmodule