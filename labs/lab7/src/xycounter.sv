`timescale 1ns / 1ps
`default_nettype none

module xycounter #(
	parameter WIDTH=2,
	parameter HEIGHT=2
	)(
	input  wire clock,
	input  wire enable,
	output logic [$clog2(WIDTH)-1:0]  x = 0,
	output logic [$clog2(HEIGHT)-1:0] y = 0
);
	always @(posedge clock) begin

		if (enable) begin
			
			if (x < WIDTH-1) begin
				x <= x + 1'b1;
			end
			else begin
				x <= 0;
				y <= y < HEIGHT-1'b1 ? y + 1'b1 : 0;
			end
		end
	end
endmodule