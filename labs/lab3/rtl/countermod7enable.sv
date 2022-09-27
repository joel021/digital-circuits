`timescale 1ns / 1ps
`default_nettype none

module countermod7enable (
	input  wire 		 clock,
	input  wire 		 reset,
	input wire enable,
	output logic [2:0] value = 3'b000
);

   always @(posedge clock)
	begin : mod4_counter
		value 	<= reset ? 3'b000 : 
		~enable ? value 	:
		value 	== 3'b110 ? 3'b000: (value + 3'b001);
	end

endmodule

//4|2|1
//110 -> 6
