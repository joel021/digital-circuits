// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : Joel Pires joelpires70@gmail.com
// File   : stopwatch.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//    Top level interface from a DE2-115 FPGA board
// -----------------------------------------------------------------------------
//`timescale 1ns / 1ps
`default_nettype none

module stopwatch
	(
	//////////////////////	Clock Input	 	/////////////////////////////////////// 
	input 	wire 			CLOCK_50, //	50 MHz
	//////////////////////	 Push Button   ///////////////////////////////////////
	input	 	wire [3:0]	KEY, //	Pushbutton[3:0]
	//////////////////////	7-SEG Display  ///////////////////////////////////////
	output 	wire [6:0]  HEX0, // Display de 7-segmentos (HEX0)
	output 	wire [6:0]  HEX1, // Display de 7-segmentos (HEX1)
	output 	wire [6:0]  HEX2, // Display de 7-segmentos (HEX2)
	output 	wire [6:0]  HEX3, // Display de 7-segmentos (HEX3)
	output 	wire [6:0]  HEX4, // Display de 7-segmentos (HEX4)
	output 	wire [6:0]  HEX5, // Display de 7-segmentos (HEX5)
	//output 	wire [6:0]  HEX6, // Display de 7-segmentos (HEX6)
	//output 	wire [6:0]  HEX7  // Display de 7-segmentos (HEX7)
	output wire[3:0] m1, m0, s1, s0,
	output wire up, pause
);

	//--------------------------------------------------------------------------
	// Internal signals
	//--------------------------------------------------------------------------
	localparam	N_i = 25, N_d=19, NDIG = 6; // interval_change = N_operations*time_of_each_operation => T_c = ( 2^N_i ) * T
	
	wire [3:0] KEY_CLEANED;
	//wire up, pause;
	wire [N_i-1:0] value;
	wire [6:0] segments [0:NDIG-1];
	wire [4*NDIG-1:0] BCS_values;

	//debouncer #(.N(N_d)) d1 (.raw(~KEY[0]), .clk(CLOCK_50),.clean(KEY_CLEANED[0]));
	//debouncer #(.N(N_d)) d2 (.raw(~KEY[1]), .clk(CLOCK_50),.clean(KEY_CLEANED[1]));
	//debouncer #(.N(N_d)) d3 (.raw(~KEY[2]), .clk(CLOCK_50),.clean(KEY_CLEANED[2]));
	//debouncer #(.N(N_d)) d4 (.raw(~KEY[3]), .clk(CLOCK_50),.clean(KEY_CLEANED[3]));
	assign KEY_CLEANED = ~KEY;

	fsm f (.clk(CLOCK_50),.reset(KEY_CLEANED[3]), .key(~KEY_CLEANED[2:0]), .up(up), .pause(pause));
	
	// count from 0 to 2^N_i. This count will work as clock setter. 
	//The N_i digit will change at each time choosed. N_i = 25 will provide the update on each ~1 second
	updowncounter #(.N(N_i)) count (.clk(CLOCK_50), .up(1'(1)), .pause(pause), .value(value));
	
	// the value_BCD will be updated on each value[N_i-1] up transaction.
	CounterTime counter_time (CLOCK_50, KEY_CLEANED[3], up, BCS_values); //value[N_i-1]
	
	displayNdigit #(NDIG) displays (BCS_values, segments); //the N_ith digit will be changed at each approximated 1 s
	
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Lógica de saída
	//--------------------------------------------------------------------------	
	assign HEX0 = segments[0]; // seconds[0]
	assign HEX1 = segments[1]; // seconds[1]
	assign HEX2 = segments[2]; //minutes[0]
	assign HEX3 = segments[3]; //minutes[1]
	assign HEX4 = segments[4]; //hours[0]
	assign HEX5 = segments[5]; //hours[1]
   //--------------------------------------------------------------------------	

	assign s0 = BCS_values[3:0];
	assign s1 = BCS_values[7:4];
	assign m0 = BCS_values[11:8];
	assign m1 = BCS_values[15:12];

endmodule
