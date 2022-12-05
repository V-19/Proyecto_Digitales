//probador
`timescale 1ns/1ns

module probador(
output reg clk,
output reg RESET,
output reg [9:0] rx_code_group_out,
input [7:0] RXD,
input RX_DV,
input RX_ER
);



initial begin
clk=0;
RESET=1;
//Prueba de funcionamiento correcto de la maquina
#5 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1101101000;//k27.7 S par
#2 rx_code_group_out=10'b1001110100;//D0.0 impar
#2 rx_code_group_out=10'b1000101011;//D1.0 par
#2 rx_code_group_out=10'b1011010100;//D2.0 impar
#2 rx_code_group_out=10'b1100010100;//D3.0 par
#2 rx_code_group_out=10'b1101010100;//D4.0 impar
#2 rx_code_group_out=10'b1010011011;//D5.0 par
#2 rx_code_group_out=10'b0110011011;//D6.0 impar
#2 rx_code_group_out=10'b0001110100;//D7.0 par
#2 rx_code_group_out=10'b0001101011;//D8.0 impar
#2 rx_code_group_out= 10'b0100010111;//k29.7 T par
#2 rx_code_group_out= 10'b0001010111;;//k23.7 R impar
#2 rx_code_group_out=10'b1100000101;//K28.5 par
//Prueba de no inicio del paquete
#5 RESET=0;
#2 RESET=1;
#5 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
//#2 rx_code_group_out=10'b1101101000;//k27.7 S par
#2 rx_code_group_out=10'b1001110100;//D0.0 impar
#2 rx_code_group_out=10'b1000101011;//D1.0 par
#2 rx_code_group_out=10'b1011010100;//D2.0 impar
#2 rx_code_group_out=10'b1100010100;//D3.0 par
#2 rx_code_group_out=10'b1101010100;//D4.0 impar
#2 rx_code_group_out=10'b1010011011;//D5.0 par
#2 rx_code_group_out=10'b0110011011;//D6.0 impar
#2 rx_code_group_out=10'b0001110100;//D7.0 par
#2 rx_code_group_out=10'b0001101011;//D8.0 impar
#2 rx_code_group_out= 10'b0100010111;//k29.7 T par
#2 rx_code_group_out= 10'b0001010111;;//k23.7 R impar
#2 rx_code_group_out=10'b1100000101;//K28.5 par

//Prueba de code_group invalido 
#5 RESET=0;
#2 RESET=1;
#5 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1101101000;//k27.7 S par
#2 rx_code_group_out=10'b1001110100;//D0.0 impar
#2 rx_code_group_out=10'b0000000000;//D invalido
#2 rx_code_group_out=10'b1011010100;//D2.0 impar
#2 rx_code_group_out=10'b1100010100;//D3.0 par
#2 rx_code_group_out=10'b1101010100;//D4.0 impar
#2 rx_code_group_out=10'b1010011011;//D5.0 par
#2 rx_code_group_out=10'b0110011011;//D6.0 impar
#2 rx_code_group_out=10'b0001110100;//D7.0 par
#2 rx_code_group_out=10'b0001101011;//D8.0 impar
#2 rx_code_group_out= 10'b0100010111;//k29.7 T par
#2 rx_code_group_out= 10'b0001010111;;//k23.7 R impar
#2 rx_code_group_out=10'b1100000101;//K28.5 par
//Prueba de no finalizacion de la cadena 
#5 RESET=0;
#2 RESET=1;
#5 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1100000101;//K28.5
#2 rx_code_group_out=10'b1010010110;//D5.6/D16.2
#2 rx_code_group_out=10'b1101101000;//k27.7 S par
#2 rx_code_group_out=10'b1001110100;//D0.0 impar
#2 rx_code_group_out=10'b1000101011;//D1.0 par
#2 rx_code_group_out=10'b1011010100;//D2.0 impar
#2 rx_code_group_out=10'b1100010100;//D3.0 par
#2 rx_code_group_out=10'b1101010100;//D4.0 impar
#2 rx_code_group_out=10'b1010011011;//D5.0 par
#2 rx_code_group_out=10'b0110011011;//D6.0 impar
#2 rx_code_group_out=10'b0001110100;//D7.0 par
#2 rx_code_group_out=10'b0001101011;//D8.0 impar
#2 rx_code_group_out=10'b1100010100;//D3.0 par
#2 rx_code_group_out= 10'b0001010111;;//k23.7 R impar
#2 rx_code_group_out=10'b1100000101;//K28.5 par






#50
#10 $finish;
end 


always begin
#1 clk = !clk;
end

endmodule

