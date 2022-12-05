module transmit(txd,
        tx_en,
        tx_er,
        gtx_clk,
        tx_code_group,
        col,
        crs);

    //-----------Estados------------
    localparam TX_TEST_XMIT = ;
    localparam IDDLE = ;
    localparam XMIT_DATA = ;
    localparam START_OF_PACKET = ;
    localparam TX_PACKET = ;
    localparam TX_DATA = ;
    localparam END_OF_PACKET_NOEXT = ;
    localparam EPD2_NOEXT = ;
    localparam EPD3 = ;

    //-----------Inputs------------
    input [7:0] txd;
    input tx_en, tx_er, gtx_clk;
    //-----------outputs-----------
    output [9:0]tx_code_group;
    output col, crs;
    //------------Variables auxiliares--------
    //reg [6:0] rx; //coma
    reg [4:0] state, nxt_state;
    integer cdg_cont = 0;//contador de codegroups buenos
    reg rn_even      = 0;//comar par o impar
    reg valid;           //dato valido de los codegroups de control y datos
    
                                    //------------Codigo--------
    always @(posedge gtx_clk) begin //flipflops maquina de estado
        state <= nxt_state;         //Actualizar estado
    end
    
    always @(*) begin //Calculo de proximo estado
        case (state)
            TX_TEST_XMIT: begin
              
            end
            IDDLE: begin
              
            end
            XMIT_DATA: begin
              
            end
            START_OF_PACKET: begin
              
            end
            TX_PACKET: begin
              
            end
            TX_DATA: begin
              
            end
            END_OF_PACKET_NOEXT: begin
              
            end
            EPD2_NOEXT: begin
              
            end
            EPD3: begin
              
            end
        endcase
    end
endmodule
