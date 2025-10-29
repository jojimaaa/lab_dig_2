module tx_serial_7E1 (
    input        clock           ,
    input        reset           ,
    input        partida         , // entradas
    input  [6:0] dados_ascii     ,
    output       saida_serial    , // saidas
    output       pronto          
    // output       db_clock        , // saidas de depuracao
    // output       db_tick         ,
    // output       db_partida      ,
    // output       db_saida_serial ,
    // output [6:0] db_estado
);
    // sinais internos
    wire       s_reset        = reset;
    wire       s_partida      = partida;
    wire       s_zera         ;
    wire       s_conta        ;
    wire       s_carrega      ;
    wire       s_desloca      ;
    wire       s_tick         ;
    wire       s_fim          ;
    wire       s_saida_serial ;
    wire [3:0] s_estado       ;

    // fluxo de dados (frame: start + 7 dados + paridade + stop = 10 bits)
    tx_serial_7E1_fd tx_serial_7E1_fd (
        .clock        ( clock          ),
        .reset        ( s_reset        ),
        .zera         ( s_zera         ),
        .conta        ( s_conta        ),
        .carrega      ( s_carrega      ),
        .desloca      ( s_desloca      ),
        .dados_ascii  ( dados_ascii    ),
        .saida_serial ( s_saida_serial ),
        .fim          ( s_fim          )
    );

    // unidade de controle (FSM)
    tx_serial_uc tx_serial_uc (
        .clock     ( clock        ),
        .reset     ( s_reset      ),
        .partida   ( s_partida    ),
        .tick      ( s_tick       ),
        .fim       ( s_fim        ),
        .zera      ( s_zera       ),
        .conta     ( s_conta      ),
        .carrega   ( s_carrega    ),
        .desloca   ( s_desloca    ),
        .pronto    ( pronto       ),
        .db_estado ( s_estado     )
    );

    // gerador de tick @115200 bauds -> 50e6/115200 ≈ 434 (9 bits)
    contador_m #(
        .M(434),
        .N(9)
    ) tx_serial_tick_generator (
        .clock   ( clock  ),
        .zera_as ( 1'b0   ),
        .zera_s  ( s_zera ), // zera junto do start para alinhar o primeiro tick
        .conta   ( 1'b1   ),
        .Q       (        ),
        .fim     ( s_tick ),
        .meio    (        )
    );

    // saida serial
    assign saida_serial = s_saida_serial;

    // depuracao
    // assign db_clock        = reset;
    // assign db_tick         = s_tick;
    // assign db_partida      = s_partida;
    // assign db_saida_serial = s_saida_serial;

    // exibicao do estado na 7-seg
    // hexa7seg HEX0 (
    //     .hexa    ( s_estado  ),
    //     .display ( db_estado )
    // );

endmodule