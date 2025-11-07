`timescale 1ns/1ns
module neurosync_controller_dual_tb();

    reg clock_in;
    reg reset_in;
    reg jogar_in;
    reg confirma_in;
    reg direita_in;
    reg esquerda_in;
    reg [3:0] botoes_in;
    reg echo_in;
    
    wire [3:0] leds_out;
    wire trigger_out;
    wire pwm_out;
    wire db_pwm_out;
    wire [6:0] hex0_out;
    wire [6:0] hex1_out;
    wire [6:0] hex2_out;
    wire serial1_out;
    wire serial2_out;

    // Componente a ser testado (Device Under Test -- DUT)
    neurosync_controller_dual neurosync_controller_dual (
        .clock(clock_in),
        .reset(reset_in),
        .jogar(jogar_in),
        .confirma(confirma_in),
        .direita(direita_in),
        .esquerda(esquerda_in),
        .botoes(botoes_in),
        .echo(echo_in),
        .leds(leds_out),
        .trigger(trigger_out),
        .pwm(pwm_out),
        .db_pwm(db_pwm_out),
        .hex0(hex0_out),
        .hex1(hex1_out),
        .hex2(hex2_out),
        .serial1(serial1_out),
        .serial2(serial2_out)
    );

    // Configurações do clock
    parameter clockPeriod = 20; // clock de 50MHz
    // Gerador de clock
    always #(clockPeriod/2) clock_in = ~clock_in;

    // Casos de teste
    reg [31:0] casos_teste [0:3]; // Usando 32 bits para acomodar o tempo

    // Largura do pulso
    reg [31:0] larguraPulso; // Usando 32 bits para acomodar tempos maiores

    initial begin
        $display("Inicio das simulacoes");

        // Inicialização do array de casos de teste
        casos_teste[0] = 5882;   // 5882us (100cm)
        casos_teste[1] = 5899;   // 5899us (100,29cm) truncar para 100cm
        casos_teste[2] = 4353;   // 4353us (74cm)
        casos_teste[3] = 4399;   // 4399us (74,79cm) arredondar para 75cm

        // 1) Determina a largura do pulso echo
        larguraPulso = casos_teste[3]*1000; // 1us=1000

        // Valores iniciais
        confirma_in = 0;
        esquerda_in = 0;
        direita_in = 0;
        botoes_in = 0;
        clock_in = 0;
        reset_in = 0;
        jogar_in = 0;
        echo_in = 0;

        // Reset
        #(2*clockPeriod);
        reset_in = 1;
        #(2_000); // 2 us
        reset_in = 0;

        // Espera de 400us
        #(400_000); // 400 us

        jogar_in = 1;
        #(2000);
        jogar_in = 0;
        #(5*400_000); // 400 us

        direita_in = 1;
        #(2000);
        direita_in = 0;
        #(2*400_000); // 400 us

        esquerda_in = 1;
        #(2000);
        esquerda_in = 0;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        // ------------------------------------------------ A0

        // Aperta B (errado)
        botoes_in = 4'b0010;
        #(2000)
        botoes_in = 4'b0000;
        #(2*400_000); // 400 us

        // Aperta A (Certo)
        botoes_in = 4'b0001;
        #(2000)
        botoes_in = 4'b0001;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        // ------------------------------------------------ B1

        esquerda_in = 1;
        #(2000);
        esquerda_in = 0;
        #(2*400_000); // 400 us

        esquerda_in = 1;
        #(2000);
        esquerda_in = 0;
        #(2*400_000); // 400 us

        // Aperta B (certo)
        botoes_in = 4'b0010;
        #(2000)
        botoes_in = 4'b0000;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        // ------------------------------------------------ C2

        direita_in = 1;
        #(2000);
        direita_in = 0;
        #(2*400_000); // 400 us

        // Aperta C (certo)
        botoes_in = 4'b0100;
        #(2000)
        botoes_in = 4'b0000;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        // ------------------------------------------------ D3

        direita_in = 1;
        #(2000);
        direita_in = 0;
        #(2*400_000); // 400 us

        direita_in = 1;
        #(2000);
        direita_in = 0;
        #(2*400_000); // 400 us

        direita_in = 1;
        #(2000);
        direita_in = 0;
        #(2*400_000); // 400 us

        // Aperta D (certo)
        botoes_in = 4'b1000;
        #(2000)
        botoes_in = 4'b0000;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        // ------------------------------------------------ Y2

        direita_in = 1;
        #(2000);
        direita_in = 0;
        #(2*400_000); // 400 us

        direita_in = 1;
        #(2000);
        direita_in = 0;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        // ------------------------------------------------ Y1

        direita_in = 1;
        #(2000);
        direita_in = 0;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(clockPeriod);
        confirma_in = 0;

        // ------------------------------------------------ sensor

        // 1) commeça com medida errada
        larguraPulso = casos_teste[0]*1000; // 1us=1000

        wait (trigger_out == 1'b1);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        wait (trigger_out == 1'b1);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        // 1) mede certo
        larguraPulso = casos_teste[3]*1000; // 1us=1000

        wait (trigger_out == 1'b1);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        wait (trigger_out == 1'b1);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        wait (trigger_out == 1'b1);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        wait (trigger_out == 1'b1);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        wait (trigger_out == 1'b1);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        #(2*400_000); // 400 us

        //5 medidas são suficientes para o modelo de teste
        
        #(2*400_000); // 400 us
        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        // ------------------------------------------------ D1

        // Aperta D (certo)
        botoes_in = 4'b1000;
        #(2000)
        botoes_in = 4'b0000;
        #(2*400_000); // 400 us

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        // ------------------------------------------------ fim

        confirma_in = 1;
        #(2000);
        confirma_in = 0;
        #(2*400_000); // 400 us

        // Fim da simulação
        $display("Fim das simulacoes");
        $stop;
    end

endmodule