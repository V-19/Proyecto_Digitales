`timescale 1ns/1ns

module tester_transmit(txd,
                       tx_en,
                       tx_er,
                       gtx_clk,
                       tx_code_group,
                       col,
                       crs);
    //-----------Inputs------------
    output reg [7:0] txd;
    output reg tx_en, tx_er, gtx_clk;
    //-----------outputs-----------
    input [9:0]tx_code_group;
    input col, crs;
    
    initial begin
        gtx_clk = 0;
        tx_en   = 1;
        tx_er   = 0;
        #20 txd = 8'b10111100;//Coma IDLE
        #20 txd = 8'b01010000;//IDLE
        #20 txd = 8'b10111100;//Coma IDLE
        #20 txd = 8'b01010000;//IDLE
        #20 txd = 8'b11111011; //S
        #20 txd = 8'b00000000;
        #20 txd = 8'b00000001;
        #20 txd = 8'b00000010;
        #20 txd = 8'b00000011;
        #20 txd = 8'b00000100;
        #20 txd = 8'b00000101;
        #20 txd = 8'b00000110;
        #20 txd = 8'b00000111;
        #20 txd = 8'b00001000;
        #20 txd = 8'b00001001;
        #20 txd = 8'b11111101;//T
        #20 txd = 8'b10101111;//R
        #20 txd = 8'b10111100;//Coma IDLE
        #20 txd = 8'b01010000;//IDLE
        #20 txd = 8'b10111100;//Coma IDLE
        #20 txd = 8'b01010000;//IDLE
      
        #2$finish;
    end
    
    always begin
        #1 gtx_clk = !gtx_clk;
    end
endmodule
    
