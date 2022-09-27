`timescale 1ns / 1ps
`default_nettype none

module propagation_BCD #(parameter NDIG = 8)  (
	input wire clk,
	input reg [4*NDIG-1:0] value,
	output reg [4*NDIG-1:0] value_r
	);
	
	genvar i;
	
	always @(posedge clk) begin
		value_r[3:0] <= value[3:0];
	end

		
	
endmodule
