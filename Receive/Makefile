all:	correr


correr:	
	iverilog -o prueba testbench.v
	vvp prueba
	gtkwave resultados.vcd

clear:
	rm resultados.vcd
	rm prueba
