`timescale 1ns / 1ps
`default_nettype none

module io_demo
	(
	//////////////////////	Clock Input	 	/////////////////////////////////////// 
	input 	wire 			CLOCK_50, //	50 MHz
	//////////////////////	 Push Button   ///////////////////////////////////////
	input	 	wire [3:0]	KEY, //	Pushbutton[3:0]
	//////////////////////	 PS/2 Serial   ///////////////////////////////////////
	input	 	wire 	 		PS2_CLK, //	PS/2 Clock
	input	 	wire 	 		PS2_DAT, //	PS/2 Data
	//////////////////////	9 GREEN LEDs  ///////////////////////////////////////
	output 	wire [8:0]  LEDG // 
);

	wire [31:0] keyb_char;

	keyboard keyb (.clock(CLOCK_50), .ps2_clk(PS2_CLK), .ps2_data(PS2_DAT), .keyb_char(keyb_char)); // receive key_char data from keyboard module
    
	assign LEDG[0] = (keyb_char == 8'b01000001) ? 1 : 0; // A letter. high turns the led on
	assign LEDG[1] = (keyb_char == 8'b01000010) ? 1 : 0;
	assign LEDG[2] = (keyb_char == 8'b01000011) ? 1 : 0;
	assign LEDG[3] = (keyb_char == 8'b01000100) ? 1 : 0;
	assign LEDG[4] = (keyb_char == 8'b01000101) ? 1 : 0;
	assign LEDG[5] = (keyb_char == 8'b01000110) ? 1 : 0;
	assign LEDG[6] = (keyb_char == 8'b01000111) ? 1 : 0;
	assign LEDG[7] = (keyb_char == 8'b01001000) ? 1 : 0; // H

endmodule