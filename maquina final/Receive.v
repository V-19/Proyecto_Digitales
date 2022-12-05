module Receive(
clk,
RESET,
rx_code_group_out,
RXD,//7:0
RX_DV,
RX_ER

);

//-----------Estados------------
parameter WAIT_FOR_K = 8'h1;
parameter RX_K = 8'h2;
parameter IDE_D = 8'h4;
parameter START_OF_PACKET = 8'h8;
parameter RECEIVE = 8'h10;
parameter RX_DATA = 8'h20;
parameter TRI_RRI_1 = 8'h40;
parameter TRI_RRI_2 = 8 'h80;


//-----------Inputs------------
input clk, RESET;
input [9:0] rx_code_group_out;
//-----------outputs-----------
output reg RX_DV, RX_ER;
output reg [7:0] RXD;
//------------Variables auxiliares--------
reg [12:0] state;
reg [12:0] nxt_state;
reg valid;//dato valido de los codegroups de control y datos 

//------------Code groups--------
reg [9:0] code_group [0:29];

//------------Codigo--------
always@(posedge clk)begin//flipflops maquina de estado
	if(RESET)begin 
		
		state<= nxt_state;//cambiar de estado
		
		if(rx_code_group_out==10'b1010010110) RXD<=8'hC5;//D5.6
        else if(rx_code_group_out==10'b1001000101) RXD<=8'h50;//D16.2
        else if(rx_code_group_out==10'b1100000101||rx_code_group_out==10'b0011111010) RXD<=8'hBC; //k28.5
        else if(rx_code_group_out==10'b1101101000||rx_code_group_out==10'b0010010111) RXD<=8'h55; //S
        else if(rx_code_group_out==10'b1001110100||rx_code_group_out==10'b0110001011) RXD<=8'h00; //D0.0
        else if(rx_code_group_out==10'b0111010100||rx_code_group_out==10'b1000101011) RXD<=8'h01; //D1.0
        else if(rx_code_group_out==10'b1011010100||rx_code_group_out==10'b0100101011) RXD<=8'h02; //D2.0
        else if(rx_code_group_out==10'b1100011011||rx_code_group_out==10'b1100010100) RXD<=8'h03; //D3.0
        else if(rx_code_group_out==10'b1101010100||rx_code_group_out==10'b0010101011) RXD<=8'h04; //D4.0
        else if(rx_code_group_out==10'b1010011011||rx_code_group_out==10'b1010010100) RXD<=8'h05; //D5.0
        else if(rx_code_group_out==10'b0110011011||rx_code_group_out==10'b0110010100) RXD<=8'h06; //D6.0
        else if(rx_code_group_out==10'b1110001011||rx_code_group_out==10'b0001110100) RXD<=8'h07; //D7.0
        else if(rx_code_group_out==10'b0001101011||rx_code_group_out==10'b1110010100) RXD<=8'h08; //D8.0
        else if(rx_code_group_out==10'b1001011011||rx_code_group_out==10'b1001010100) RXD<=8'h09; //D9.0
        else if(rx_code_group_out==10'b0100010111||rx_code_group_out==10'b1011101000) RXD<=8'hFD; //K29.7
        else if(rx_code_group_out==10'b1110101000||rx_code_group_out==10'b0001010111) RXD<=8'hF7; //K23.7


	end else begin //reset de todas las salidas y variables auxiliares del modulo
		
		nxt_state<=WAIT_FOR_K;
		RX_DV<=0; 
		RX_ER<=0;

		
	end
end


always @(*)begin

	nxt_state = state;//inicializacion
	
	case(state)//un case para pasar de estado en estado
		
		
		WAIT_FOR_K: begin//1
			
			if(rx_code_group_out==10'b1100000101)begin// k28.5 par

				RX_DV=0;
				RX_ER=0;
				nxt_state = RX_K;

			end else nxt_state = WAIT_FOR_K;

			
		end
	
		RX_K: begin //2

			if(rx_code_group_out==10'b1010010110 || rx_code_group_out==10'b1001000101 )begin//D5.6/D16.2 impar
				RX_DV=0;
				RX_ER=0;
				nxt_state = IDE_D;
			end else nxt_state = WAIT_FOR_K;
		end

		IDE_D: begin//si hay una coma par 4

			if(rx_code_group_out==10'b1101101000)begin//S par/impar
				RX_DV=0;
				RX_ER=0;
				nxt_state = START_OF_PACKET;
			end else nxt_state = RX_K;
			
		end

		START_OF_PACKET: begin//8

			RX_DV=1;
			RX_ER=0;	
			nxt_state = RECEIVE;

		end 
//10
		RECEIVE: begin //si hay una coma par

		if(valid)begin	
			if(rx_code_group_out==10'b0100010111 )begin//T par 
				RX_ER=0;
				nxt_state = TRI_RRI_1;
			end else nxt_state = RX_DATA;
		end else begin
		RX_ER=1;
		nxt_state = RECEIVE; 
		end
			
		end

//20	
	

		RX_DATA: begin  //datos pares e impares

			if(valid)begin
					//decode ?
				RX_ER=0;
				nxt_state=RECEIVE;

			end else 
			begin
				//decode ?
				RX_ER=1;
				nxt_state=RECEIVE;
			end
	
		end
//40
		TRI_RRI_1: begin //40


		if(rx_code_group_out==10'b0001010111/*k23.7/R*/ )begin//R impar
				RX_DV=0;
				nxt_state = TRI_RRI_2;
			end else nxt_state = RECEIVE;
			
		end
//80

		TRI_RRI_2: begin //80

			if(rx_code_group_out==10'b1100000101/*k28.5/I*/ )begin//I par

				RX_DV=0;
				RX_ER=0;
				nxt_state = RX_K;

			end else nxt_state = RECEIVE;

		end


		default: nxt_state = WAIT_FOR_K;//si no pasa nada se pasa al primer estado
	endcase
	
end

always@(posedge clk)begin


	code_group[0]= 10'b1010010110; //D5.6 impar= 1010010110
 	code_group[1]= 10'b1001000101; 	//D16.2 impar=1001000101
	code_group[2]= 10'b1100000101;	// K28.5 par=1100000101
	code_group[3]= 10'b0011111010; //K28.5 impar=0011111010
	code_group[4]= 10'b1101101000; //K27.7 impar=1101101000
	code_group[5]= 10'b0010010111; //K27.7 par=0010010111
	code_group[6]= 10'b1001110100; //D0.0 impar=1001110100\
	code_group[7]= 10'b0110001011; //D0.0 par=0110001011
	code_group[8]= 10'b0111010100; //D1.0 impar=0111010100
	code_group[9]= 10'b1000101011;//D1.0 par=1000101011
	code_group[10]= 10'b1011010100;//D2.0 impar=1011010100
	code_group[11]= 10'b0100101011;//D2.0 par=0100101011
	code_group[12]= 10'b1100011011;//D3.0 impar=1100011011
	code_group[13]= 10'b1100010100;//D3.0 par=1100010100
	code_group[14]= 10'b1101010100;//D4.0 impar=1101010100
	code_group[15]= 10'b0010101011;//D4.0 par=0010101011
	code_group[16]= 10'b1010011011;//D5.0 impar=1010011011
	code_group[17]= 10'b1010010100;//D5.0 par=1010010100
	code_group[18]= 10'b0110011011;//D6.0 impar=0110011011
	code_group[19]= 10'b0110010100;//D6.0 par=0110010100
	code_group[20]= 10'b1110001011;//D7.0 impar=1110001011
	code_group[21]= 10'b0001110100;//D7.0 par=0001110100
	code_group[22]= 10'b0001101011;//D8.0 par=0001101011
	code_group[23]= 10'b1110010100;//D8.0 impar=1110010100
	code_group[24]= 10'b1001011011;//D9.0 impar=1001011011
	code_group[25]= 10'b1001010100;//D9.0 par=1001010100
	code_group[26]= 10'b0100010111;//K29.7=0100010111 par
	code_group[27]= 10'b1011101000;//K29.7=1011101000 impar
	code_group[28]= 10'b1110101000;//k23.7 R par
	code_group[29]= 10'b0001010111;//k23.7 R impar

	//si se cumple que el dato esta en la lista el code group es valido 
	if(rx_code_group_out==code_group[0]||rx_code_group_out==code_group[1]||rx_code_group_out==code_group[2]||rx_code_group_out==code_group[3]||rx_code_group_out==code_group[4]
	||rx_code_group_out==code_group[5]||rx_code_group_out==code_group[6]||rx_code_group_out==code_group[7]||rx_code_group_out==code_group[8]||rx_code_group_out==code_group[9]
	||rx_code_group_out==code_group[10]||rx_code_group_out==code_group[11]||rx_code_group_out==code_group[12]||rx_code_group_out==code_group[13]||rx_code_group_out==code_group[14]
	||rx_code_group_out==code_group[15]||rx_code_group_out==code_group[16]||rx_code_group_out==code_group[17]||rx_code_group_out==code_group[18]||rx_code_group_out==code_group[19]
	||rx_code_group_out==code_group[20]||rx_code_group_out==code_group[21]||rx_code_group_out==code_group[22]||rx_code_group_out==code_group[23]||rx_code_group_out==code_group[24]
	||rx_code_group_out==code_group[25]||rx_code_group_out==code_group[26]||rx_code_group_out==code_group[27]||rx_code_group_out==code_group[28]||rx_code_group_out==code_group[29]
	)begin
	valid=1;
	
	end else valid=0;


end



endmodule
