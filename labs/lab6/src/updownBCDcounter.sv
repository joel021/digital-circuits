`timescale 1ns / 1ps
`default_nettype none

module updownBCDcounter #(parameter NDIG = 8) (
    input wire clk,
    input wire up, pause,
	 output wire [4*NDIG-1:0] value
	 );
	
	 genvar i;
	 
	 logic [3:0] value_c [NDIG-1:0];
	 
	 logic [NDIG-1:0] to;
	 
	 updowncounterTo #(4, 9) count_  (clk, up, pause, 1, value_c[0], to[0]);
	 
	 generate
		for (i = 1; i < NDIG; i++) begin: counter
			updowncounterTo #(4, 9) count  (.clk(clk), .up(up), .pause(pause), .enable(to[i-1]),.value(value_c[i]), .to(to[i]) );
		end
	 endgenerate
	 
	 generate
		for (i = 0; i < NDIG; i++) begin: assign_
			assign value[4*i+3:4*i] = value_c[i];
		end
	 endgenerate

endmodule

