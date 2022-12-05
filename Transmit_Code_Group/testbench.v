`include "transmit_gen_code_groups.v"
`include "tester.v"

module transmit_tb; 
wire [7:0]txd_tb; 
wire tx_en_tb, tx_er_tb, gtx_clk_tb; 
wire [9:0]tx_code_group_tb; 
wire col_tb, crs_tb; 
wire [7:0]code_1;
wire [9:0]code_2, code_3; 

transmit_code_group U1 (
  
  .txd(txd_tb), 
  .tx_en(tx_en_tb), 
  .tx_er(tx_er_tb), 
  .gtx_clk(gtx_clk_tb), 
  .tx_code_group(tx_code_group_tb), 
  .col(col_tb), 
  .crs(cr_tb));

tester_transmit T1(
.txd(txd_tb),
.tx_en(tx_en_tb),
.tx_er(tx_er_tb),
.gtx_clk(gtx_clk_tb),
.tx_code_group(tx_code_group_tb),
.col(col_tb),
.crs(crs_tb)
);

initial begin
    $dumpfile("resultados.vcd");
    $dumpvars(-1,U1);
end
endmodule
