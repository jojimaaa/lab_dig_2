/* --------------------------------------------------------------------------
 *  Arquivo   : contador_cm_uc-PARCIAL.v
 * --------------------------------------------------------------------------
 *  Descricao : unidade de controle do componente contador_cm
 *              
 *              incrementa contagem de cm a cada sinal de tick enquanto
 *              o pulso de entrada permanece ativo
 *              
 * --------------------------------------------------------------------------
 *  Revisoes  :
 *      Data        Versao  Autor             Descricao
 *      07/09/2024  1.0     Edson Midorikawa  versao em Verilog
 * --------------------------------------------------------------------------
 */

module contador_cm_uc (
    input wire clock,
    input wire reset,
    input wire pulso,
    input wire tick,
    output reg zera_tick,
    output reg conta_tick,
    output reg zera_bcd,
    output reg conta_bcd,
    output reg [3:0] db_estado_contacm,
    output reg pronto
);

    // Tipos e sinais
    reg [2:0] Eatual, Eprox; // 3 bits são suficientes para os estados

    // Parâmetros para os estados
    parameter inicial = 3'b000;
    // parameter preparacao = 3'b001;
    parameter espera_tick = 3'b010;
    parameter conta_cm = 3'b011;
    parameter final = 3'b100;

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
            inicial: Eprox = pulso ? espera_tick : inicial;

            espera_tick: Eprox = pulso ? 
                                    (tick ? conta_cm : espera_tick) 
                                : final;

            conta_cm: Eprox = pulso ? espera_tick : final;

            final: Eprox = inicial;
        endcase
    end

    // Lógica de saída (Moore)
    always @(*) begin
        zera_tick = (Eatual == inicial);
        conta_tick = (Eatual == espera_tick);
        zera_bcd = (Eatual == inicial);
        conta_bcd = (Eatual == conta_cm);
        pronto = (Eatual == final);

        case (Eatual)
            inicial:       db_estado_contacm = 4'b0000;
            espera_tick:   db_estado_contacm = 4'b0010;
            conta_cm:      db_estado_contacm = 4'b0011;
            final:         db_estado_contacm = 4'b0100;
            default:       db_estado_contacm = 4'b1110;
        endcase
    end

endmodule