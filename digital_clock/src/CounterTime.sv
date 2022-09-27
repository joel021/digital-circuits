/*
Author: sgalal
Code found at: https://github.com/sgalal/DigitalClock
Modified by: Joel Pires
*/
module CounterTime (
	input wire clk1hz,
	input wire reset,
	input wire inc,
	output wire [23:0] value // {msb_h, lsb_h, msb_m, lsb_m, msb_s, lsb_s}
);

	wire c_s, c_m; //carray out of seconds and minutes

	// each 60 minutes
	BCDCounter #(.max_num(23)) ch(.clk(c_m), .reset(reset), .inc(inc), .msb(value[23:20]), .lsb(value[19:16]), .c());

	//this value change on each 60 seconds
	BCDCounter #(.max_num(59)) cm(.clk(c_s),.reset(reset), .inc(inc), .msb(value[15:12]), .lsb(value[11:8]), .c(c_m));

	// this value change on each 1 second
	BCDCounter #(.max_num(59)) cs(.clk(clk1hz),.reset(reset), .inc(inc), .msb(value[7:4]), .lsb(value[3:0]), .c(c_s)); 

endmodule