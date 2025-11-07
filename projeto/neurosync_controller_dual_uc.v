module neurosync_controller_dual_uc(
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
    output reg  jogando
);

    reg [3:0] Eatual, Eprox;

    // Parâmetros para os estados
    parameter inicial            = 4'b0000;
    parameter preparacao         = 4'b0001;
    parameter escolhe_modo       = 4'b0010;
    parameter prepara_jogo       = 4'b0011;
    parameter prepara_pergunta   = 4'b0100;
    parameter aguarda_med_faixa  = 4'b0101;
    parameter aguarda_resp_certa = 4'b0110;
    parameter feedback           = 4'b1000;
    parameter ganhou             = 4'b1001;
    parameter proxima_pergunta   = 4'b1010;

    always @(posedge clock, posedge reset) begin
        if (reset)
            Eatual <= inicial;
        else
            Eatual <= Eprox; 
    end

    // SUGESTÕES CASO DE MERDA: Só transicionar dps que acabar as transmissões seriais - estados adicionais e nova input pronto_tx;

    // Lógica de próximo estado
    always @(*) begin
        case (Eatual)
            inicial:            Eprox = jogar_det ? preparacao : inicial;
            preparacao:         Eprox = escolhe_modo;
            escolhe_modo:       Eprox = confirma_det ? prepara_jogo : escolhe_modo;
            prepara_jogo:       Eprox = prepara_pergunta;
            prepara_pergunta:   Eprox = (opcode == 2'b11) ? aguarda_med_faixa : aguarda_resp_certa; 
            aguarda_med_faixa:  Eprox = acertou_faixa ? feedback : aguarda_med_faixa;
            aguarda_resp_certa: Eprox = (acertou_play && pronto_play) ? feedback : aguarda_resp_certa;
            feedback:           Eprox = confirma_det ? (is_ultima_pergunta ? ganhou : proxima_pergunta) : feedback;
            proxima_pergunta:   Eprox = prepara_pergunta;
            ganhou:             Eprox = jogar_det ? preparacao : ganhou;
            default:            Eprox = inicial;
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
    end




endmodule