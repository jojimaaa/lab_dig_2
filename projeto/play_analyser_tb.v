`timescale 1ns/1ns

module play_analyser_tb();

    reg clock_in;
    reg jogar_in;
    reg reset_in;
    reg [3:0] botoes_in;
    reg [1:0] pos_in;
    reg confirma_in;
    reg direita_in;
    reg esquerda_in;
    reg [27:0] expected_in;
    wire serial_out;
    wire pronto_out;
    wire acertou_out;
    wire [27:0] resposta_out;
    wire pronto_comparacao_out;

    play_analyser dut(
        .clock(clock_in),
        .jogar(jogar_in),
        .reset(reset_in),
        .botoes(botoes_in),
        .pos(pos_in),
        .confirma(confirma_in),
        .direita(direita_in),
        .esquerda(esquerda_in),
        .expected(expected_in),
        .serial(serial_out),
        .pronto(pronto_out),
        .acertou(acertou_out),
        .resposta(resposta_out),
        .pronto_comparacao(pronto_comparacao_out)
    );

    // Configurações do clock
    parameter clockPeriod = 20; // clock de 50MHz
    // Gerador de clock
    always #(clockPeriod/2) clock_in = ~clock_in;

    reg [6:0] C          = 7'b1000011; //C
    reg [6:0] ascii_cif  = 7'b0100100; //$
    reg [6:0] ascii_1    = 7'b0110001; //1
    reg [6:0] ascii_hash = 7'b0100011; //#

    initial begin
        $display("Inicio da simulacao");
        // Valores iniciais
        clock_in=0;
        jogar_in=0;
        reset_in=0;
        botoes_in=0;
        pos_in=0;
        confirma_in=0;
        direita_in=0;
        esquerda_in=0;
        expected_in={C, ascii_cif, ascii_1, ascii_hash};
        #(20*clockPeriod);

        // Reset
        @(negedge clock_in); 
        reset_in = 1;
        #(20*clockPeriod);
        reset_in = 0;
        $display("... reset gerado");
        @(negedge clock_in);
        #(18500*clockPeriod);
        #(700*clockPeriod);


        // Casos de teste - Apertei Direita (pos sobe um)
        direita_in = 1'b1;
        #(clockPeriod)
        pos_in = 2'b01;
        #(20*clockPeriod);
        direita_in = 1'b0;
        #(18500*clockPeriod);
        #(700*clockPeriod);

        // Casos de teste - Apertei A
        botoes_in = 4'b0001;
        #(20*clockPeriod);
        botoes_in = 4'b0000;
        #(18500*clockPeriod);
        #(700*clockPeriod);

        // Casos de teste - Apertei C
        botoes_in = 4'b0100;
        #(20*clockPeriod);
        botoes_in = 4'b0000;
        #(18500*clockPeriod);
        #(700*clockPeriod);

        // Casos de teste - Apertei Confirma
        confirma_in = 1'b1;
        #(20*clockPeriod);
        confirma_in = 1'b0;
        #(18500*clockPeriod);
        #(700*clockPeriod);


        #(10000*clockPeriod);
        // Fim da simulação
        $display("Fim da simulacao");
        #(10*clockPeriod); // Aguarda um pequeno tempo para garantir que o clock pare
        $stop;
    end

endmodule