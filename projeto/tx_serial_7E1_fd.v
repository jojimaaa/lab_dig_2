module tx_serial_7E1_fd (
    input        clock        ,
    input        reset        ,
    input        zera         ,
    input        conta        ,
    input        carrega      ,
    input        desloca      ,
    input  [6:0] dados_ascii  ,
    output       saida_serial ,
    output       fim
);

    wire [10:0] s_dados;
    wire [10:0] s_saida;

    // paridade par dos 7 bits (XOR de redução gera '1' se #de 1's for impar;
    // usar direto como bit de paridade resulta em total de '1's par)
    wire        paridade_par = ^dados_ascii;

    // composicao dos dados seriais (LSB sai primeiro em s_saida[0])
    assign s_dados[0]   = 1'b1;             // repouso (linha em '1')
    assign s_dados[1]   = 1'b0;             // start bit
    assign s_dados[8:2] = dados_ascii[6:0]; // 7 bits de dados
    assign s_dados[9]   = paridade_par;     // paridade PAR
    assign s_dados[10]  = 1'b1;             // stop bit (unico)

    // Deslocador (N=11) injeta '1' no MSB para manter linha em repouso apos o frame
    deslocador_n #(
        .N(11)
    ) U1 (
        .clock          ( clock   ),
        .reset          ( reset   ),
        .carrega        ( carrega ),
        .desloca        ( desloca ),
        .entrada_serial ( 1'b1    ),
        .dados          ( s_dados ),
        .saida          ( s_saida )
    );

    // Contador modulo 12:
    // 1º tick alinha o start (sai de repouso para 0),
    // depois mais 10 bits de frame, e um extra para garantir retorno ao '1'
    contador_m #(
        .M(12),
        .N(4)
    ) U2 (
        .clock   ( clock ),
        .zera_as ( 1'b0  ),
        .zera_s  ( zera  ),
        .conta   ( conta ),
        .Q       (       ), // Q nao utilizado
        .fim     ( fim   ),
        .meio    (       )  // 'meio' nao utilizado
    );

    // Saida serial do transmissor
    assign saida_serial = s_saida[0];

endmodule