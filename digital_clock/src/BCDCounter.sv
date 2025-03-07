/*
author: sgalal
Code found at: https://github.com/sgalal/DigitalClock
modified by: Joel Pires

Purpose: BCD decimal counter with limit. This module define the role to count in BCD with two decimal digits.
*/

/// @param clk100khz System clock 100 kHz
/// @param inc Increase signal
/// @param dec Decrease signal
/// @param msb Value of msb
/// @param lsb Value of lsb
/// @param c Carry signal
module BCDCounter
	#(parameter int max_num)
(
	input wire clk,
	input wire reset, //set to zero or set to max
	input wire inc, //increase
	output reg [3: 0] msb, //most significative digit
	output reg [3: 0] lsb, //low significative digit
	output reg c //flag carry out
);

	localparam [3: 0] max_msb = 4'(max_num / 10); //get the max value of the most significative digit
	localparam [3: 0] max_lsb = 4'(max_num % 10); // get the max value of the low significative digit

	initial begin //initialize at 0|0 + 0
		msb <= 0;
		lsb <= 0;
		c <= 0;
	end

	always@(posedge clk or posedge reset) begin

		if (reset) begin
			msb <= 0;
			lsb <= 0;
			c <= 1'b1;
		end else if(inc) begin // posedge inc
			if( msb == max_msb && lsb == max_lsb)
			begin
				msb <= 0;
				lsb <= 0;
				c <= 1'b1;
			end
			else if(lsb == max_lsb)
			begin
				lsb <= 0;
				msb <= msb + 1'b1;
				c <= 0;
			end
			else
			begin
				lsb <= lsb + 1'b1;
				c <= 0;
			end
		end
		else begin  // posedge dec
			
			if(msb == 4'b0 && lsb == 4'b0)
			begin
				msb <= max_msb;
				lsb <= max_lsb;
				c <=  1'b1;
			end
			else if(lsb == 4'b0)
			begin
				msb <= msb - 1'b1;
				lsb <= max_lsb;
				c <= 0;
			end
			else begin
				lsb <= lsb - 1'b1;
				c <= 0;
			end
		end

	end

endmodule