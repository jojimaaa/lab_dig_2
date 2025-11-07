module binaryTObcd (
    input [8:0] bin,
    input clock,
    input rst,
    output reg [3:0] centenas,
    output reg [3:0] dezenas,
    output reg [3:0] unidades
);
    // esse módulo irá implementar o algorítmo de conversão de binário para BCD chamado de DOUBLE DABBLE
    //Autor: Enzo Koichi Jojima - 14568285
    //Baseado no EP1 de PCS3225 - Sistemas Digitais 2 (2024) - Prof. Dr. Bruno de Carvalho Albertini

    integer i;
    reg [19:0] shift_reg;  // 20 bits para acomodar o deslocamento

    always @(*) begin
        if (rst) begin
            centenas <= 4'b0;
            dezenas  <= 4'b0;
            unidades <= 4'b0;
            i = 0;
            shift_reg = 0;
        end 
        else begin
            // Inicializa registrador com o valor binário na parte menos significativa
            shift_reg = 0;
            shift_reg[8:0] = bin;

            // Algoritmo Double Dabble
            for (i = 0; i < 8; i = i + 1) begin
                // Ajusta centenas, dezenas e unidades antes do shift
                if (shift_reg[11:8] >= 4'd5) shift_reg[11:8] = shift_reg[11:8] + 4'd3;
                if (shift_reg[15:12] >= 4'd5) shift_reg[15:12] = shift_reg[15:12] + 4'd3;
                if (shift_reg[19:16] >= 4'd5) shift_reg[19:16] = shift_reg[19:16] + 4'd3;

                // Faz o shift para a esquerda
                shift_reg = shift_reg << 1;
            end

            // Saída em BCD
            centenas <= shift_reg[19:16];
            dezenas  <= shift_reg[15:12];
            unidades <= shift_reg[11:8];
        end
    end



endmodule