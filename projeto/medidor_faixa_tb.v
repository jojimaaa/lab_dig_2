/* --------------------------------------------------------------------------
 *  Arquivo   : interface_hcsr04_tb.v
 * --------------------------------------------------------------------------
 *  Descricao : testbench basico para o circuito de inteface com sensor
 *              ultrassonico de distancia
 *              possui 4 casos de teste, com truncamento e arredondamento
 *              
 * --------------------------------------------------------------------------
 *  Revisoes  :
 *      Data        Versao  Autor             Descricao
 *      07/09/2024  1.0     Edson Midorikawa  versao em Verilog
 *      07/09/2025  1.1     Edson Midorikawa  revisao
 * --------------------------------------------------------------------------
 */
 
`timescale 1ns/1ns

module medidor_faixa_tb;

    // Declaração de sinais
    reg         clock_in = 0;
    reg         reset_in = 0;
    reg         medir_in = 0;
    reg [11:0]  upperL_in = 0;
    reg [11:0]  lowerL_in = 0;
    reg         echo_in = 0;
    wire        trigger_out;
    wire [11:0] medida_out;
    wire        acertou_out;
    wire        saida_serial_out;
    wire [3:0]  db_estado_out;
    wire        dentro_out;

    // Componente a ser testado (Device Under Test -- DUT)
    medidor_faixa medidor_faixa(
        .clock(clock_in),
        .reset(reset_in),
        .medir(medir_in),
        .upperL(upperL_in),
        .lowerL(lowerL_in),
        .echo(echo_in),

        .trigger(trigger_out),
        .acertou(acertou_out),
        .saida_serial(saida_serial_out),
        .db_medida(medida_out),
        .db_estado(db_estado_out),
        .dentro(dentro_out)
    );

    // Configurações do clock
    parameter clockPeriod = 20; // clock de 50MHz
    // Gerador de clock
    always #(clockPeriod/2) clock_in = ~clock_in;

    // Array de casos de teste (estrutura equivalente em Verilog)
    reg [31:0] casos_teste [0:3]; // Usando 32 bits para acomodar o tempo
    integer caso;

    // Largura do pulso
    reg [31:0] larguraPulso; // Usando 32 bits para acomodar tempos maiores

    reg [31:0] esperaEntreMedidas = 251_000_000; //(250ms)

    // Geração dos sinais de entrada (estímulos)
    initial begin
        $display("Inicio das simulacoes");

        // Inicialização do array de casos de teste
        casos_teste[0] = 5882;   // 5882us (100cm)
        casos_teste[1] = 5899;   // 5899us (100,29cm) truncar para 100cm
        casos_teste[2] = 4353;   // 4353us (74cm)
        casos_teste[3] = 4399;   // 4399us (74,79cm) arredondar para 75cm

        // Valores iniciais
        medir_in = 0;
        echo_in  = 0;
        upperL_in = 12'b1000_0000_0000; //080cm
        lowerL_in = 12'b0111_0000_0000; //070cm

        // Reset
        caso = 0; 
        #(2*clockPeriod);
        reset_in = 1;
        #(2_000); // 2 us
        reset_in = 0;
        @(negedge clock_in);

        // Espera de 100us
        #(100_000); // 100 us


        // 1) Determina a largura do pulso echo
        $display("Caso de teste %0d: %0dus", 1, casos_teste[0]);
        larguraPulso = casos_teste[0]*1000; // 1us=1000

        // 2) Envia pulso medir
        @(negedge clock_in);
        medir_in = 1;
            
        // 3) Espera por 400us (tempo entre trigger e echo)
        #(400_000); // 400 us

        // 4) Gera pulso de echo
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        #(esperaEntreMedidas);

        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        #(esperaEntreMedidas);

        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        #(esperaEntreMedidas);

        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;


        // 1) Determina a largura do pulso echo
        $display("Caso de teste %0d: %0dus", 4, casos_teste[4]);
        larguraPulso = casos_teste[0]*1000; // 1us=1000

        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;

        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        
        #(esperaEntreMedidas);
        echo_in = 1;
        #(larguraPulso);
        echo_in = 0;
        #(esperaEntreMedidas);
    
    
        // Fim da simulação
        $display("Fim das simulacoes");
        caso = 99; 
        $stop;
    end

endmodule
