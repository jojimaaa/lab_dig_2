module medidor_faixa_teste(
    input clock_in,
    input medir_in,
    input echo_in,
    output trigger_out,
    output acertou_out,
    output saida_serial_out,
    output wire [6:0] hex0,
    output wire [6:0] hex1,
    output wire [6:0] hex2,
    output dentro_out
);

    reg [11:0] upperL_in = 12'b0000_0010_0000;
    reg [11:0] lowerL_in = 12'b0000_0000_0001;
    wire [11:0] s_medida;

    medidor_faixa medidor_faixa(
        .clock(clock_in),
        .medir(medir_in),
        .upperL(upperL_in),
        .lowerL(lowerL_in),
        .echo(echo_in),

        .trigger(trigger_out),
        .acertou(acertou_out),
        .saida_serial(saida_serial_out),
        .db_medida(s_medida),
        .db_estado(),
        .dentro(dentro_out)
    );
	 
		    hexa7seg H0 (
			     .hexa   (s_medida[3:0]), 
			     .display(hex0         )
			 );
			 hexa7seg H1 (
				  .hexa   (s_medida[7:4]), 
				  .display(hex1         )
			 );
			 hexa7seg H2 (
				  .hexa   (s_medida[11:8]), 
				  .display(hex2          )
			 );

endmodule