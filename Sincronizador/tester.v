//probador
`timescale 1ns/1ns

module probador(
output reg clk,
output reg RESET,
output reg [9:0] rx_code_group,
input code_status,
input rx_code_group_out
);



initial begin
clk=0;
RESET=1;

//no sincronizacion 
#5 rx_code_group=10'b1010010110;//D5.6/D16.2
//sincronizacion 
#5 rx_code_group=10'b1100000101;//K28.5
#2 rx_code_group=10'b1010010110;//D5.6/D16.2
#2 rx_code_group=10'b1100000101;//K28.5
#2 rx_code_group=10'b1010010110;//D5.6/D16.2
#2 rx_code_group=10'b1100000101;//K28.5
#2 rx_code_group=10'b1010010110;//D5.6/D16.2
//perdida de sincronizacion 
#5 rx_code_group=10'b0000000000;//dato que no esta en la lista
#3 rx_code_group=10'b0000000001;//dato que no esta en la lista
//#1 rx_code_group=10'b1000101011;//D1.0 par
#10
//sincronizacion y recuperacion de cgs buenos
#5 rx_code_group=10'b1100000101;//K28.5
#2 rx_code_group=10'b1010010110;//D5.6/D16.2
#2 rx_code_group=10'b1100000101;//K28.5
#2 rx_code_group=10'b1010010110;//D5.6/D16.2
#2 rx_code_group=10'b1100000101;//K28.5
#2 rx_code_group=10'b1010010110;//D5.6/D16.2
#5 rx_code_group=10'b0000000000;//dato que no esta en la lista
#3 rx_code_group=10'b0000000001;//dato que no esta en la lista
#1 rx_code_group=10'b1000101011;//D1.0 par

#50
#10 $finish;
end 


always begin
#1 clk = !clk;
end

endmodule

