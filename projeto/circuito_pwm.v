/*
 * circuito_pwm.v - descrição comportamental
 *
 * gera saída com modulacao pwm conforme parametros do modulo
 *
 * parametros: valores definidos para clock de 50MHz (periodo=20ns)
 * ------------------------------------------------------------------------
 * Revisoes  :
 *     Data        Versao  Autor             Descricao
 *     26/09/2021  1.0     Edson Midorikawa  criacao do componente VHDL
 *     17/08/2024  2.0     Edson Midorikawa  componente em Verilog
 *     28/08/2025  2.1     Edson Midorikawa  revisao do componente
 * ------------------------------------------------------------------------
 */
 
module circuito_pwm #(    // valores default
    parameter conf_periodo = 1_000_000, // Período do sinal PWM [1000000 => f=50Hz (20ms)]
    parameter largura_000   = 56250,    //22,5 dgr
    parameter largura_001   = 68750,    //67,5 dgr
    parameter largura_010   = 81250,    //112,5 dgr
    parameter largura_011   = 93750    //157,5 dgr
) (
    input        clock,
    input        reset,
    input        direita,
    input        esquerda,
    output wire  pwm,
    output wire  [1:0] pos,
    output wire  db_pwm
);

wire [1:0] w_pos;
wire w_dir_det, w_esq_det;

assign pos = w_pos;

reg [31:0] contagem; // Contador interno (32 bits) para acomodar conf_periodo
reg [31:0] largura_pwm;
reg s_pwm;

edge_detector direita_detector (
    .clock(clock),
    .reset(),
    .sinal(direita),
    .pulso(w_dir_det)
);

edge_detector esquerda_detector (
    .clock(clock),
    .reset(),
    .sinal(esquerda),
    .pulso(w_esq_det)
);

contador_vai_vem #(.M(4), .N(2)) contador_vai_vem (
    .clock(clock),
    .zera_as(reset),
    .zera_s(),
    .vai(w_dir_det),
    .vem(w_esq_det),
    .Q(w_pos),
    .fim(),
    .meio()
);


always @(posedge clock or posedge reset) begin
    if (reset) begin
        contagem <= 0;
        s_pwm <= 0;
        largura_pwm <= largura_000; // Valor inicial da largura do pulso
    end else begin
        // Saída PWM
        s_pwm <= (contagem < largura_pwm);

        // Atualização do contador e da largura do pulso
        if (contagem == conf_periodo - 1) begin
            contagem <= 0;
            case (w_pos)
                2'b00: largura_pwm <= largura_000;
                2'b01: largura_pwm <= largura_001;
                2'b10: largura_pwm <= largura_010;
                2'b11: largura_pwm <= largura_011;
                default: largura_pwm <= largura_000; // Valor padrão
            endcase
        end else begin
            contagem <= contagem + 1;
        end
    end
end

assign db_pwm = s_pwm;
assign pwm    = s_pwm;

endmodule
