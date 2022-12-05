all:	sincronizador	transmit

sincronizador:
	$(MAKE) -C Sincronizador all

transmit:
	$(MAKE) -C Transmit all

transmit_code:
	$(MAKE) -C Transmit_Code_Group all
	
receive:
	$(MAKE) -C Receive all

maquinafinal:
	$(MAKE) -C maquinafinal all

clear:
	$(MAKE) -C Sincronizador clear
	$(MAKE) -C Transmit clear
	$(MAKE) -C Transmit_Code_Group clear
	$(MAKE) -C Receive clear
	$(MAKE) -C maquinafinal clear
