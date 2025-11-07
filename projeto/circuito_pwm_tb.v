`timescale 1ns/1ns

module circuito_pwm_tb();

    reg       clock_in;
    reg       reset_in;
    reg       direita_in;
    reg       esquerda_in;
    reg       set_pos_in;
    reg [1:0] pos_inicial_in;
    wire      pwm_out;
    wire[1:0] pos_out;

circuito_pwm circuito_pwm (
    .clock(clock_in),
    .zera(reset_in),
    .set_pos(),
    .direita(direita_in),
    .esquerda(esquerda_in),
    .pos_inicial(),
    .pwm(pwm_out),
    .pos(pos_out),
    .db_pwm()
);


 // Configuração do clock
    parameter clockPeriod = 20; // em ns, f=50MHz

    // Gerador de clock
    always #(clockPeriod / 2) clock_in = ~clock_in;

initial begin
        $display("Inicio da simulacao");

        // Valores iniciais
        clock_in   = 1'b0;
        reset_in   = 0;
        direita_in = 0;
        esquerda_in = 0;
        pos_inicial_in = 2'b00;
        set_pos_in = 0;

        // Reset
        @(negedge clock_in); 
        reset_in = 1;
        #(20*clockPeriod);
        reset_in = 0;
        $display("... reset gerado");
        @(negedge clock_in);
        #(50*clockPeriod);

        // Casos de teste
        direita_in = 1'b1;
        #(20*clockPeriod);
        direita_in = 1'b0;
        #(100*clockPeriod);

        direita_in = 1'b1;
        #(20*clockPeriod);
        direita_in = 1'b0;
        #(100*clockPeriod);
            
        direita_in = 1'b1;
        #(20*clockPeriod);
        direita_in = 1'b0;
        #(100*clockPeriod);
        
        direita_in = 1'b1;
        #(20*clockPeriod);
        direita_in = 1'b0;
        #(100*clockPeriod);
        
        direita_in = 1'b1;
        #(20*clockPeriod);
        direita_in = 1'b0;
        #(100*clockPeriod);
        
        esquerda_in = 1'b1;
        #(20*clockPeriod);
        esquerda_in = 1'b0;
        #(100*clockPeriod);
        
        esquerda_in = 1'b1;
        #(20*clockPeriod);
        esquerda_in = 1'b0;
        #(100*clockPeriod);
        
        esquerda_in = 1'b1;
        #(20*clockPeriod);
        esquerda_in = 1'b0;
        #(100*clockPeriod);
        
        esquerda_in = 1'b1;
        #(20*clockPeriod);
        esquerda_in = 1'b0;
        #(100*clockPeriod);
        
        esquerda_in = 1'b1;
        #(20*clockPeriod);
        esquerda_in = 1'b0;
        #(100*clockPeriod);

        // Fim da simulação
        $display("Fim da simulacao");
        #(10*clockPeriod); // Aguarda um pequeno tempo para garantir que o clock pare
        $stop;
    end

endmodule