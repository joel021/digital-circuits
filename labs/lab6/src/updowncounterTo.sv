`timescale 1ns / 1ps
`default_nettype none

module updowncounterTo #(parameter N = 4, T_O = 9)  (
	input wire clk, up, pause, enable,
	output reg [N-1:0] value = 0,
	output reg to = 0
	);
	
	reg[N-1:0] v_aux = 0;
	
	always @(posedge clk) begin
		
		if (enable) begin
			
			v_aux <= value;
			
			if (up && ~pause) begin
			
				if (value < T_O) begin
					value <= value + 1;
					to = 0;
				end
				else begin
					to <= 1;
					value <= 0;
				end
				
			end
			else if (~up && pause) begin
				value <= value; // pause
				to <= 0;
			end
			else if (~up && ~pause) begin
				//count
				if (value > 0) begin
					value <= value -1;
					to <= 0;
				end
				else begin
					value <= T_O;
					to <= 1;
				end
			end
			else begin
				value <= 0; //reset
				to <= 0;
			end
		
		end
		
		else begin
			value <= value;
			to <= 0;
		end
	end
	
endmodule
