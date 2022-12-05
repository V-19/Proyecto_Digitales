//se incluyen los otros modulos

`include "Receive.v"
`include "tester.v"
//`include "decoder.v"
module testbench;

wire clk;
wire RESET;
wire [9:0] rx_code_group_out;
wire [7:0] RXD;
wire RX_DV;
wire RX_ER;
//wire [7:0] a;

//se genera el archivo gtkwave
initial begin

  $dumpfile("resultados.vcd");
  $dumpvars;
  

end

//Modulo receive

Receive r1(
.clk(clk),
.RESET(RESET),
.rx_code_group_out(rx_code_group_out),
.RXD(RXD),
.RX_DV(RX_DV),
.RX_ER(RX_ER)
);

//modulo tester

probador senales(
.clk(clk),
.RESET(RESET),
.rx_code_group_out(rx_code_group_out),
.RXD(RXD),
.RX_DV(RX_DV),
.RX_ER(RX_ER)
);

endmodule







