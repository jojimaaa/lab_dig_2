module mem2 (
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
    */

    // always @ (posedge clock)
    always @ (*)
    begin
        case (address)
            3'b000:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0000000_0000000_0000000;
            3'b001:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0000000_0000000_0000000;
            3'b010:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0000000_0000000_0000000;
            3'b011:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0000000_0000000_0000000;
            3'b100:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0000000_0000000_0000000;
            3'b101:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0000000_0000000_0000000;
            3'b110:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0000000_0000000_0000000;
            3'b111:  data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0000000_0000000_0000000;
            default: data_out = 60'b00_0000_00_0000_0000_0000_0000_0000_0000_0000000_0000000_0000000_0000000;
        endcase
    end
endmodule