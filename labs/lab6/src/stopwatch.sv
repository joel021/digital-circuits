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
`timescale 1ns / 1ps
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
	output 	wire [6:0]  HEX6, // Display de 7-segmentos (HEX6)
	output 	wire [6:0]  HEX7  // Display de 7-segmentos (HEX7)
);

	//--------------------------------------------------------------------------
	//	Sinais internos
	//--------------------------------------------------------------------------
	localparam	N_i = 19, N_c = 49, NDIG = 8; // interval_change = N_operations*time_of_each_operation => T_c = ( 2^N_i ) * T
		
	wire [3:0] KEY_CLEANED;
	wire up, pause;
	wire [N_c-1:0] value;
	wire [6:0] segments [0:NDIG-1];
	
	
	wire [4*NDIG-1:0] value_BCD; // a BCD number with 8 digits
	
	
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Instanciação dos módulos
	//--------------------------------------------------------------------------
	debouncer #(.N(N_i)) d1 (.raw(~KEY[0]), .clk(CLOCK_50),.clean(KEY_CLEANED[0]));
	debouncer #(.N(N_i)) d2 (.raw(~KEY[1]), .clk(CLOCK_50),.clean(KEY_CLEANED[1]));
	debouncer #(.N(N_i)) d3 (.raw(~KEY[2]), .clk(CLOCK_50),.clean(KEY_CLEANED[2]));
		
	fsm f (.clk(CLOCK_50),.key(~KEY_CLEANED), .up(up), .pause(pause));
	
	updowncounter #(.N(N_c)) count (.clk(CLOCK_50), .up(up), .pause(pause), .value(value));
	
	// the value_BCD will be updated on each value[N_i] up transaction. But the value[N_i-1] change at each 1/256 ms, so, the low digit of the value_BCD will change at each 2/256 s
	updownBCDcounter #(.NDIG(NDIG)) bcd_count (.clk(value[N_i-1]),.up(up), .pause(pause), .value(value_BCD)); 
	
	
	displayNdigit #(NDIG) displays (CLOCK_50, value_BCD, segments); //the N_ith digit will be changed at each approximated 1/256 s
	
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Lógica de saída
	//--------------------------------------------------------------------------	
	assign HEX0 = segments[0];
	assign HEX1 = segments[1];
	assign HEX2 = segments[2];
	assign HEX3 = segments[3];
	assign HEX4 = segments[4];
	assign HEX5 = segments[5];
	assign HEX6 = segments[6];
	assign HEX7 = segments[7];
   //--------------------------------------------------------------------------	

endmodule
