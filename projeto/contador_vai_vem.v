module contador_vai_vem #(parameter M=100, N=7)
  (
    input  wire          clock,
    input  wire          zera_as,
    input  wire          set_pos,
    input  wire          vai,
    input  wire          vem,
    input  wire          enable_mov,
    input  wire [N-1:0]  D,
    output reg  [N-1:0]  Q,
    output reg           fim,
    output reg           meio
  );

  always @(posedge clock or posedge zera_as) begin
    if (zera_as) begin
      Q <= 0;
    end else if (clock) begin
      if (set_pos) begin
        Q <= D;
      end else if (vai) begin
        if (Q == M-1) begin
          Q <= M-1;             //trava no máx
        end else begin
          // Q <= Q + 1;
          Q <= Q + 1'b1;
        end
      end else if (vem) begin
        if (Q == 0) begin
          Q <= 0;               //trava no mín
        end else begin
          // Q <= Q - 1;
          Q <= Q - 1'b1;
        end
      end
    end
  end

  // Saidas
  always @ (Q)
      if (Q == M-1)   fim = 1;
      else            fim = 0;

  always @ (Q)
      if (Q == M/2-1) meio = 1;
      else            meio = 0;

endmodule
