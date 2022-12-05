//se incluyen los otros modulos

`include "sincronizador.v"
`include "tester.v"

module testbench;

wire clk;
wire RESET;
wire [9:0] rx_code_group;
wire code_status;
wire rx_code_group_out;


//se genera el archivo gtkwave
initial begin

  $dumpfile("resultados.vcd");
  $dumpvars;
  

end


//Modulo I2C

sincronizador s1(
.clk(clk),
.RESET(RESET),
.rx_code_group(rx_code_group),
.code_status(code_status),
.rx_code_group_out(rx_code_group_out)
);

//modulo tester

probador senales(
.clk(clk),
.RESET(RESET),
.rx_code_group(rx_code_group),
.code_status(code_status),
.rx_code_group_out(rx_code_group_out)
);

endmodule







