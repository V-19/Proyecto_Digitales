all:	run

run:
	iverilog -o a.out testbench.v
	vvp a.out
	gtkwave resultados.vcd

clear:
	rm a.out
	rm resultados.vcd