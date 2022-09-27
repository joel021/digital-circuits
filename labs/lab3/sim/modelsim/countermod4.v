`timescale 1ns / 1ps
`default_nettype none

module countermod4 (
	input  wire 		 clock,
	input  wire 		 reset,
	output logic [1:0] value = 2'b00
);

   always @(posedge clock)
	begin : mod4_counter
		value <= reset ? 2'b00 : (value + 1'b1);
	end

endmodule
