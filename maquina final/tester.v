//probador
`timescale 1ns/1ns

module probador(
// output reg [9:0] rx_code_group,
output reg clk,
output reg RESET,
output reg tx_en, 
output reg tx_er,
output reg [7:0]txd,
input col,
input crs,
input code_status,
input [7:0] RXD,
input RX_DV,
input RX_ER
);


initial begin
clk=0;
RESET=1;
//Prueba1
tx_en = 1; 
tx_er = 0;
txd = 0;
// //Prueba 1 Paquete completo
//     #16 txd = 8'b10111100;//Coma IDLE
//     #16 txd = 8'b01010000;//IDLE
//     #16 txd = 8'b10111100;//Coma IDLE
//     #16 txd = 8'b01010000;//IDLE
//     #16 txd = 8'b11111011; //S
//     #16 txd = 8'b00000000;
//     #16 txd = 8'b00000001;
//     #16 txd = 8'b00000010;
//     #16 txd = 8'b00000011;
//     #16 txd = 8'b00000100;
//     #16 txd = 8'b00000101;
//     #16 txd = 8'b00000110;
//     #16 txd = 8'b00000111;
//     #16 txd = 8'b00001000;
//     #16 txd = 8'b00001001;
//     #16 txd = 8'b11111101;//T
//     #16 txd = 8'b10101111;//R
//     #16 txd = 8'b10111100;//Coma IDLE
//     #16 txd = 8'b01010000;//IDLE
//     #16 txd = 8'b10111100;//Coma IDLE
//     #16 txd = 8'b01010000;//IDLE
  
// //Prueba 2 No incia el paquete
//     #16 txd = 8'b10111100;//Coma IDLE
//     #16 txd = 8'b01010000;//IDLE
//     #16 txd = 8'b10111100;//Coma IDLE
//     #16 txd = 8'b01010000;//IDLE
//     #16 txd = 8'b00000000;
//     #16 txd = 8'b00000001;
//     #16 txd = 8'b00000010;
//     #16 txd = 8'b00000011;
//     #16 txd = 8'b00000100;
//     #16 txd = 8'b00000101;
//     #16 txd = 8'b11111101;//T
//     #16 txd = 8'b10101111;//R
//     #16 txd = 8'b10111100;//Coma IDLE
//     #16 txd = 8'b01010000;//IDLE
//     #16 txd = 8'b10111100;//Coma IDLE
//     #16 txd = 8'b01010000;//IDLE

//Prueba 3 La no finalización de la cadena 
    #16 txd = 8'b10111100;//Coma IDLE
    #16 txd = 8'b01010000;//IDLE
    #16 txd = 8'b10111100;//Coma IDLE
    #16 txd = 8'b01010000;//IDLE
    #16 txd = 8'b10111100;//Coma IDLE
    #16 txd = 8'b01010000;//IDLE
    #16 txd = 8'b11111011;//S
    #16 txd = 8'b00000000;
    #16 txd = 8'b00000001;
    #16 txd = 8'b00000010;
    #16 txd = 8'b00000011;
    #16 txd = 8'b00000100;
    #16 txd = 8'b00000101;
    #16 txd = 8'b00000110;
    #16 txd = 8'b00000111;
    #16 txd = 8'b11111110;//T
    #16 txd = 8'b10101111;//R
    #16 txd = 8'b10111100;//Coma IDLE
    #16 txd = 8'b01010000;//IDLE
    #16 txd = 8'b10111100;//Coma IDLE
    #16 txd = 8'b01010000;//IDLE
    #16 txd = 8'b10111100;//Coma IDLE
    #16 txd = 8'b01010000;//IDLE
//Finish
#50
#10 $finish;
end 


always begin
#1 clk = !clk;
end

endmodule

