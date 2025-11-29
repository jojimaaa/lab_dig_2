module mem0 (
    // input            clock,
    input      [2:0] address,
    output reg [59:0] data_out    
);

    /*  Modelo:
        opcode = 2bit
            00 = botão
            01 = botão + servo
            10 = servo
            11 = sensor

        leds = 4bit         - qual led acenderá
        pos_inicial = 2bit  - posição inicial do servo
        lim_inf     = 12bit - Limite inferior do servo (3xBDC)
        lim_sup     = 12bit - Limite superior do servo (3xBDC)

        expected    = 28bit - Resultado esperado para ser considerado acerto (só presente quando input não é sensor)

        opcode      = data_out[59:58]
        leds        = data_out[57:54]
        pos_inicial = data_out[53:52]
        lim_inf     = data_out[51:40]
        lim_sup     = data_out[39:28]
        expected    = data_out[27:0]

        Total = 60 bits


        0100011 = #
        0100100 = $
        1001010 = J - Jogar
        1011010 = Z - Reset
        1011001 = Y - Confirma
        1010010 = R - Direita
        1001100 = L - Esquerda
        1000001 = A - Botão A
        1000010 = B - Botão B
        1000011 = C - Botão C
        1000100 = D - Botão D
    */

    // always @ (posedge clock)
    always @ (*)
    begin
        case (address)
            3'b000:  data_out = 60'b10_1000_00_0000_0000_0000_0000_0000_0000_1011001_0100100_0110001_0100011; //Y$1# Pares Servo
            3'b001:  data_out = 60'b11_0000_00_0000_0001_0000_0000_0010_0101_0000000_0000000_0000000_0000000; //sensor 10 - 25
            3'b010:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_1000011_0100100_0110000_0100011; //C$0# Pares simples - n depende do leds servo
            3'b011:  data_out = 60'b01_0000_00_0000_0000_0000_0000_0000_0000_1000011_0100100_0110011_0100011; //C$3# Pares Completo
            3'b100:  data_out = 60'b00_0100_00_0000_0000_0000_0000_0000_0000_1000100_0100100_0110000_0100011; //D$0# Complete - n depende do leds servo
            3'b101:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_1000100_0100100_0110000_0100011; //D$0# Pares simples - n depende do leds servo
            3'b110:  data_out = 60'b00_0001_01_0000_0001_0000_0000_0010_0000_1000001_0100100_0110001_0100011; //A$1# Complete plus - depende do leds servo
            3'b111:  data_out = 60'b00_0010_00_0000_0000_0000_0000_0000_0000_1000010_0100100_0110000_0100011; //B$0#
            default: data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0100100_0110000_0100011; //
        endcase
    end
endmodule