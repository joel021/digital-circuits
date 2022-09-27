//`timescale 1ns / 1ps
`default_nettype none
/*
This module describe the role of a count circuit
*/
module updowncounter #(parameter N = 19)  (
	input wire clk, up, pause,
	output reg [N-1:0] value = 0
	);
	
	always @(posedge clk) begin
		
		value <= (up && ~pause) ? value + 1'(1) : // count up
						(up && pause) ? value : //pause
						(~up && ~pause) ? value - 1'(1): //count down
						1'(0); // reset
	end
	
endmodule
