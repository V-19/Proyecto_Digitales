`include "sincronizador.v"
`include "Receive.v"
`include "../Transmit_Code_Group/transmit_gen_code_groups.v"


module pcs(  


input clk,
input RESET,
input tx_en, 
input tx_er,
input [7:0]txd,

//input [9:0] rx_code_group, 
output col,
output crs,
output code_status,
output [7:0] RXD,
output RX_DV,
output RX_ER
 );

wire [9:0]tx_to_rx_code_group;
wire [9:0] a;//conexion entre la salida y entrada del receptor y el sincronizador


//Modulo sincronizador

sincronizador s1(
.clk(clk),
.RESET(RESET),
.rx_code_group(tx_to_rx_code_group),
.code_status(code_status),
.rx_code_group_out(a)
);

//modulo receive

Receive r1(
.clk(clk),
.RESET(RESET),
.rx_code_group_out(a),
.RXD(RXD),
.RX_DV(RX_DV),
.RX_ER(RX_ER)
);

//Transmit Code Group
transmit_code_group tcg (
.txd(txd),
.tx_en(tx_en),
.tx_er(tx_er),
.gtx_clk(clk),
.tx_code_group(tx_to_rx_code_group),
.col(col),
.crs(crs)
);
endmodule 