module medidor_faixa_teste(
    input clock_in,
    input reset_in,
    input medir_in,
    input echo_in,
    output trigger_out,
    output acertou_out,
    output saida_serial_out,
    output dentro_out
);

    reg [11:0] upperL__in = 12'b0000_0010_0000;
    reg [11:0] lowerL__in = 12'b0000_0001_0000;


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
        .db_medida(),
        .db_estado(),
        .dentro(dentro_out)
    );

endmodule