module neurosync_controller_single_uc(
    input       clock,
    input       reset,
    input       jogar_det,
    input       confirma_det,
    input [1:0] opcode,
    input       acertou_faixa,
    input       acertou_play,
    input       pronto_play,
    input       is_ultima_pergunta,
 
    output reg  zera,
    output reg  conta_pergunta,
    output reg  registra_modo,
    output reg  zera_prep_jogo,
    output reg  set_pos,
    output reg  medir,
    output reg  enable_mov,
    output reg  show_leds_servo,
    output reg  jogando
);

    reg [3:0] Eatual, Eprox;

    // Parâmetros para os estados
    parameter inicial                   = 4'b0000;
    parameter preparacao                = 4'b0001;
    parameter escolhe_modo              = 4'b0010;
    parameter prepara_jogo              = 4'b0011;
    parameter prepara_pergunta          = 4'b0100;
    parameter aguarda_med_faixa         = 4'b0101;
    parameter aguarda_resp_certa        = 4'b0110;
    parameter feedback                  = 4'b1000;
    parameter ganhou                    = 4'b1001;
    parameter proxima_pergunta          = 4'b1010;
    parameter aguarda_confirma_modo     = 4'b1011;
    parameter aguarda_confirma_feedback = 4'b1100;

    always @(posedge clock, posedge reset) begin
        if (reset)
            Eatual <= inicial;
        else
            Eatual <= Eprox; 
    end

    // Lógica de próximo estado
    always @(*) begin
        case (Eatual)
            inicial:                    Eprox = jogar_det ? preparacao : inicial;
            preparacao:                 Eprox = escolhe_modo;
            escolhe_modo:               Eprox = confirma_det ? aguarda_confirma_modo : escolhe_modo;
            aguarda_confirma_modo:      Eprox = pronto_play ? prepara_jogo : aguarda_confirma_modo;
            prepara_jogo:               Eprox = prepara_pergunta;
            prepara_pergunta:           Eprox = (opcode == 2'b11) ? aguarda_med_faixa : aguarda_resp_certa; 
            aguarda_med_faixa:          Eprox = acertou_faixa ? feedback : aguarda_med_faixa;
            aguarda_resp_certa:         Eprox = (acertou_play && pronto_play) ? feedback : aguarda_resp_certa;
            feedback:                   Eprox = confirma_det ? aguarda_confirma_feedback : feedback;
            aguarda_confirma_feedback:  Eprox = pronto_play ? (is_ultima_pergunta ? ganhou : proxima_pergunta) : aguarda_confirma_feedback;
            proxima_pergunta:           Eprox = prepara_pergunta;
            ganhou:                     Eprox = jogar_det ? preparacao : ganhou;
            default:                    Eprox = inicial;
        endcase
    end

    always @(*) begin
        zera                = (Eatual == preparacao);
        conta_pergunta      = (Eatual == proxima_pergunta);
        registra_modo       = (Eatual == escolhe_modo);
        zera_prep_jogo      = (Eatual == prepara_jogo);
        set_pos             = (Eatual == prepara_pergunta);
        jogando             = (Eatual == prepara_pergunta || Eatual == aguarda_med_faixa || Eatual == aguarda_resp_certa || Eatual == proxima_pergunta);
        medir               = (Eatual == aguarda_med_faixa);
        enable_mov          = (opcode == 00 || opcode == 01 || opcode == 11 || Eatual == escolhe_modo);
        show_leds_servo     = (Eatual == escolhe_modo || 
                               Eatual == prepara_pergunta || 
                               Eatual == aguarda_med_faixa || 
                               Eatual == aguarda_resp_certa || 
                               Eatual == proxima_pergunta ||
                               Eatual == aguarda_confirma_modo || 
                               Eatual == prepara_jogo);
    end




endmodule