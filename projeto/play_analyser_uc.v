module play_analyser_uc(
    input   clock,
    input   reset,
    input   button_activation,
    input   pronto_tx,
    input   is_ultimo_char,
    output reg  zera,
    output reg  conta_prox_char,
    output reg  partida_tx,
    output reg  zera_char,
    output reg  reg_jogada,
    output reg  reg_comp,
    output reg  pronto_comparacao,
    output reg  pronto
);

    reg [3:0] Eatual, Eprox;

    // Parâmetros para os estados
    parameter inicial           = 4'b0000;
    parameter registra_jogada   = 4'b0001;
    parameter compara_jogada    = 4'b0010;
    parameter envia_partida     = 4'b0011;
    parameter aguarda_tx        = 4'b0100;
    parameter proximo_char      = 4'b0101;
    parameter pronto_state      = 4'b0110;
    
    // Memória de estado
    always @(posedge clock, posedge reset) begin
        if (reset)
            Eatual <= inicial;
        else
            Eatual <= Eprox; 
    end

    // Lógica de próximo estado
    always @(*) begin
        case (Eatual)
            inicial:            Eprox = button_activation ? registra_jogada : inicial;
            registra_jogada:    Eprox = compara_jogada;
            compara_jogada:     Eprox = envia_partida;
            envia_partida:      Eprox = aguarda_tx;
            aguarda_tx:         Eprox = pronto_tx ? (is_ultimo_char ? pronto_state : proximo_char) : aguarda_tx;
            proximo_char:       Eprox = envia_partida;
            pronto_state:       Eprox = inicial;
            default:            Eprox = inicial;
        endcase
    end

    always @(*) begin
        zera                = (Eatual == inicial);
        conta_prox_char     = (Eatual == proximo_char);
        partida_tx          = (Eatual == envia_partida);
        zera_char           = (Eatual == inicial);
        reg_jogada          = (Eatual == registra_jogada);
        reg_comp            = (Eatual == compara_jogada);
        pronto              = (Eatual == pronto_state);
        pronto_comparacao   = (Eatual == envia_partida || Eatual == aguarda_tx || Eatual == proximo_char || Eatual == pronto_state);
    end


endmodule