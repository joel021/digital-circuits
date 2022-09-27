`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.svh"

module VGATimer (
	input  wire  clock, 
	output logic hsync,
	output logic vsync,
	output logic activevideo,
	output logic [`xbits-1:0] x,
	output logic [`ybits-1:0] y
);

	// As linhas abaixo possibilitam contar a cada 2 ciclos de clock
	// Isso acontece porque, dependendo da resolução escolhida, você pode
	//   precisar contar a 50 MHz ou 25 MHz. Neste roteiro consideramos a  
	//   resolução 640x480 a qual utiliza o clock de 25 MHz.

	logic clock_count = 0;

	always @(posedge clock) begin : proc_clock_count
		clock_count <= clock_count + 1'b1;
	end
	
	wire Every2ndTick;

	assign Every2ndTick = (clock_count == 1'b1);

	// Esta parte instancia um xy-counter usando o contador de clock adequado 
	// xycounter #(`WholeLine, `WholeFrame) xy (clock, 1'b1, x, y); // Conta em 50 MHz
	xycounter #(`WholeLine, `WholeFrame) xy (clock, Every2ndTick, x, y); // Conta em 25 MHz
   
	assign activevideo 	= (x >= `hVisible && x <= `WholeLine - 1'b1) ? 1'b0 : 1'b1;
	assign hsync 	    = (x >= `hSyncStart && x <= `hSyncEnd) ? 1'b0 : 1'b1;
	assign vsync 		= (y == `vSyncStart) ? 1'b0 : 1'b1;

   
endmodule
