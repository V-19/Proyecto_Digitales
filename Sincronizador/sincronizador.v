module sincronizador(
rx_code_group,
clk,
RESET,
code_status,
rx_code_group_out

);

//-----------Estados------------
parameter Loss_of_sync = 13'h1;
parameter Comma_detect_1 = 13'h2;
parameter Acquire_Sync_1 = 13'h4;
parameter Comma_detect_2 = 13'h8;
parameter Acquire_Sync_2 = 13'h10;
parameter Comma_detect_3 = 13'h20;
parameter Sync_Acquired_1 = 13'h40;
parameter Sync_Acquired_2 = 13'h80;
parameter Sync_Acquired_2A =13'h100 ;
parameter Sync_Acquired_3 = 13'h200;
parameter Sync_Acquired_3A =13'h400 ;
parameter Sync_Acquired_4 = 13'h800;
parameter Sync_Acquired_4A = 13'h1000;
//-----------Inputs------------
input clk, RESET;
input [9:0] rx_code_group;
//-----------outputs-----------
output reg code_status;
output reg [9:0] rx_code_group_out;
//------------Variables auxiliares--------
reg [6:0] rx; //coma
reg [12:0] state;
integer cdg_cont=0;//contador de codegroups buenos
reg [12:0] nxt_state;
reg rn_even=0;//comar par o impar 
reg valid;//dato valido de los codegroups de control y datos 
//------------Code groups--------
reg [9:0] code_group [0:27];

//------------Codigo--------
always@(posedge clk)begin//flipflops maquina de estado
	if(RESET)begin 
		
		state<= nxt_state;//cambiar de estado
		rx_code_group_out<=rx_code_group;
		if(cdg_cont<3)begin//contador para volver a sincronizarse
			if(state==Sync_Acquired_2A||state==Sync_Acquired_3A||state==Sync_Acquired_4A)begin//si los estados son de sincronizacion 
					if(valid)begin//si el dato es valido 
						cdg_cont<=cdg_cont+1;//suma 1 al contador 
					end else cdg_cont<=0;//
			end else cdg_cont<=0;
		end else cdg_cont<=0;

	end else begin //reset de todas las salidas y variables auxiliares del modulo
		cdg_cont<=0;
		nxt_state<=Loss_of_sync;
		code_status<=0;
	end
end


always @(*)begin

	nxt_state = state;//inicializacion
	
	case(state)//un case para pasar de estado en estado
	
		Loss_of_sync: begin//estado de inicio si hay una coma par
			rx[6:0]=rx_code_group[9:3];
			code_status=0;
			if(rx[6:0] ==7'b1100000)begin
				nxt_state=Comma_detect_1;//pase al siguiente estado
				rn_even=!rn_even;
			end else nxt_state=Loss_of_sync;//repite el estado sino hay coma par
		end
		
		Comma_detect_1: begin //2
			if(rx_code_group==10'b1010010110 || rx_code_group==10'b1001000101)begin//El D es 2 de los casos que se necesitan
				rn_even=0;
				nxt_state=Acquire_Sync_1;//pasa al siguiente estado
			end else nxt_state=Loss_of_sync;//repite el estado si D no es cualquiera de los casos 
		end

		Acquire_Sync_1: begin//si hay una coma par
			rx[6:0]=rx_code_group[9:3];
			if(valid)begin
				if(rx[6:0] == 7'b1100000)begin//
					nxt_state=Comma_detect_2;//pase al siguiente estado
					rn_even=!rn_even;
				end else nxt_state=Acquire_Sync_1;//repite el estado sino hay coma par
			end else nxt_state=Loss_of_sync;//reinicia al primer estado sino dato es invalido
		end

		Comma_detect_2: begin//8
			if(rx_code_group==10'b1010010110 || rx_code_group==10'b1001000101)begin//El D es 2 de los casos que se necesitan
				rn_even=0;
				nxt_state=Acquire_Sync_2;//pasa al siguiente estado
			end else nxt_state=Loss_of_sync;//repite el estado si D no es cualquiera de los casos 
		end 

		Acquire_Sync_2: begin //si hay una coma par
			rx[6:0]=rx_code_group[9:3];
			if(valid)begin
				if(rx[6:0]== 7'b1100000)begin
					nxt_state=Comma_detect_3;//pase al siguiente estado
					rn_even=!rn_even;
				end else nxt_state=Acquire_Sync_2;//repite el estado sino hay coma par
			end else nxt_state=Loss_of_sync;//reinicia al primer estado sino dato es invalido
		end


		Comma_detect_3: begin //20
			if(rx_code_group==10'b1010010110 || rx_code_group==10'b1001000101)begin//El D es 2 de los casos que se necesitan
				rn_even=0;
				nxt_state=Sync_Acquired_1;//pasa al siguiente estado
			end else nxt_state=Loss_of_sync;//repite el estado si D no es cualquiera de los casos 
		end

		Sync_Acquired_1 : begin //40
			if(valid)begin//si el dato es valido pase al siguiente estado y habilite la salida code_status
			rn_even=!rn_even;
			code_status=1;
			//cont1=0;
			nxt_state=Sync_Acquired_1;//si el dato es valido se queda en este estado 
			end else nxt_state=Sync_Acquired_2;//si el dato no es valido pase al siguiente estado
		end

		Sync_Acquired_2 : begin //80
		if(valid)begin//si el dato es valido pase al siguiente estado 
			rn_even = !rn_even;
			//cont1=0;
			nxt_state=Sync_Acquired_2A;
			end else nxt_state=Sync_Acquired_3;//si el dato no es valido pase al siguiente estado de datos invalidos
		end

		Sync_Acquired_2A : begin //100
		if(valid)begin//si el dato es valido inicia la cuenta para no perder la sincronizacion 
				if(cdg_cont==3)begin//si el contador de codegroups buenos es 3 vuelve al estado de sincronizacion 
					//cont1=0;
					nxt_state=Sync_Acquired_1;
				end else begin
					rn_even=!rn_even;
					//cont1=cont1+1;
					nxt_state=Sync_Acquired_2A;//mientras cdg_cont no sea 3 se repite el estado 
				end
			end else nxt_state=Sync_Acquired_3;//si el dato no es valido pase al siguiente estado de datos invalidos
		end

		Sync_Acquired_3 : begin //200
		if(valid)begin//si el dato es valido pase al siguiente estado 
			rn_even=!rn_even;
			//cont1=0;
			nxt_state=Sync_Acquired_3A;
			end else nxt_state=Sync_Acquired_4;// //si el dato no es valido pase al siguiente estado de datos invalidos
		end
		

		Sync_Acquired_3A : begin //400
		if(valid)begin//si el dato es valido inicia la cuenta para no perder la sincronizacion 
				if(cdg_cont==3)begin//si el contador de codegroups buenos es 3 vuelve al estado anterior de sincronizacion para poder volver a estar sincronizado
					//cont1=0;
					nxt_state=Sync_Acquired_2;
				end else begin
					rn_even=!rn_even;
					//cont1=cont1+1;
					nxt_state=Sync_Acquired_3A;//mientras cdg_cont no sea 3 se repite el estado 
				end
			end else nxt_state=Sync_Acquired_4;//si el dato no es valido pase al siguiente estado de datos invalidos
		end

		Sync_Acquired_4 : begin //800
		if(valid)begin//si el dato es valido pase al siguiente estado 
			rn_even=!rn_even;
			//cont1=0;
			nxt_state=Sync_Acquired_4A;
			end else nxt_state = Loss_of_sync;//si el dato no es valido pase al estado de inicio y pierde la sincronizacion 
		end

		Sync_Acquired_4A : begin //1000
		if(valid)begin//si el dato es valido inicia la cuenta para no perder la sincronizacion 
				if(cdg_cont==3)begin//si el contador de codegroups buenos es 3 vuelve al estado anterior de sincronizacion para poder volver a estar sincronizado
					nxt_state=Sync_Acquired_3;
					//cont1=0;
				end else begin
					rn_even=!rn_even;
					//cont1=cont1+1;
					nxt_state=Sync_Acquired_4A;//mientras cdg_cont no sea 3 se repite el estado 
				end
			end else nxt_state=Loss_of_sync;//si el dato no es valido pase al estado de inicio y pierde la sincronizacion 
		end

		default: nxt_state = Loss_of_sync;//si no pasa nada se pasa al primer estado
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
	
	//si se cumple que el dato esta en la lista el code group es valido 
	if(rx_code_group==code_group[0]||rx_code_group==code_group[1]||rx_code_group==code_group[2]||rx_code_group==code_group[3]||rx_code_group==code_group[4]
	||rx_code_group==code_group[5]||rx_code_group==code_group[6]||rx_code_group==code_group[7]||rx_code_group==code_group[8]||rx_code_group==code_group[9]
	||rx_code_group==code_group[10]||rx_code_group==code_group[11]||rx_code_group==code_group[12]||rx_code_group==code_group[13]||rx_code_group==code_group[14]
	||rx_code_group==code_group[15]||rx_code_group==code_group[16]||rx_code_group==code_group[17]||rx_code_group==code_group[18]||rx_code_group==code_group[19]
	||rx_code_group==code_group[20]||rx_code_group==code_group[21]||rx_code_group==code_group[22]||rx_code_group==code_group[23]||rx_code_group==code_group[24]
	||rx_code_group==code_group[25]||rx_code_group==code_group[26]||rx_code_group==code_group[27])begin
	valid=1;
	
	end else valid=0;


end


endmodule