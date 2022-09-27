`timescale 1ns / 1ps
`default_nettype none
module shifter #(parameter N=32)(
	input wire signed [N-1:0] IN,
	input wire [$clog2(N)-1:0] shamt,
	input wire left, logical,
	output wire signed [N-1:0] OUT
);

	assign OUT = left ? (IN << shamt) : 
						(logical ? IN >> shamt : IN >>> shamt);
						
endmodule
