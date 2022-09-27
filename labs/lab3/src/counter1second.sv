`timescale 1ns / 1ps
`default_nettype none

module counter1second (
	input  wire 		 clock,
	input  wire 		 reset,
	output logic [31:0] value
);

   always @(posedge clock)
	begin : mod4_counter
		value <= reset ? 0 : (value + 1'b1);
	end

endmodule