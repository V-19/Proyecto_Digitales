//se incluyen los otros modulos
`include "tester.v"
`include "moduloconjunto.v"

module testbench;

wire clk;
wire RESET;
wire [9:0] rx_code_group;
wire code_status;
wire [7:0] RXD;
wire RX_DV;
wire RX_ER;
wire tx_en_tb; 
wire tx_er_tb;
wire [7:0]txd_tb;
wire col_tb;
wire crs_tb;

//se genera el archivo gtkwave
initial begin
  $dumpfile("resultados.vcd");
  $dumpvars;
end




//Modulo
pcs m1(
.clk(clk),
.RESET(RESET),
.tx_en(tx_en_tb), 
.tx_er(tx_er_tb),
.txd(txd_tb),
.col(col_tb),
.crs(crs_tb),
.code_status(code_status),
.RXD(RXD),
.RX_DV(RX_DV),
.RX_ER(RX_ER)
);

//modulo tester
// .rx_code_group(rx_code_group),
probador senales(
.clk(clk),
.RESET(RESET),
.tx_en(tx_en_tb), 
.tx_er(tx_er_tb),
.txd(txd_tb),
.col(col_tb),
.crs(crs_tb),
.code_status(code_status),
.RXD(RXD),
.RX_DV(RX_DV),
.RX_ER(RX_ER)
);
//.rx_code_group_out(rx_code_group_out),


endmodule







