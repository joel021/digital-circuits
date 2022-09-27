
`timescale 1ns / 1ps
`default_nettype none

module countermod7 (
	input  wire 		 clock,
	input  wire 		 reset,
	output logic [2:0] value
);

   always @(posedge clock)
	begin : mod4_counter
		value <= reset | value == 3'b110 ? 3'b000 : (value + 3'b1);
	end

endmodule

//4|2|1
//110 -> 6