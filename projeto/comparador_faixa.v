module comparador_faixa (
    input [11:0] upperL,
    input [11:0] lowerL,
    input [11:0] medida,
    output wire dentro
);
    assign dentro = (medida >= lowerL) && (medida <= upperL);

endmodule