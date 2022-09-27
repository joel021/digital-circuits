`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.svh"

module top(
    ////////////////////	Clock Input	 	///////////////////////////////// 
    input  wire CLOCK_50,					//	50 MHz
    ////////////////////	VGA DAC Output /////////////////////////////////	
    output logic VGA_CLK,					// Clock for the VGA
    output logic VGA_SYNC_N,				// Sync for the VGA
    output logic VGA_BLANK_N, 				// Flag blank or not
    output logic [7:0] VGA_R,				// Color Red
    output logic [7:0] VGA_G,				// Color Green
    output logic [7:0] VGA_B,				// Color Blue
    ////////////////////	VGA Display		/////////////////////////////////	
    output logic VGA_HS,					// horizontal sync
    output logic VGA_VS					// vertical sync
);


    parameter alphabet_length = 27;

    logic [3:0] red, green, blue;
    wire [$clog2(1200)-1:0] sm_address; 
    wire [$clog2(alphabet_length)-1:0] data_out;

    //Consider a screen with 640x480 pixels of resolution. With 16x16 window to each letter, ADDR_WIDTH = 40x30 = 1200 positions
    //37 distinct characters can be binary encoded with 6 bits => ALPHABET_LEN = 6
    VGADisplayDriver #(.SM_LEN($clog2(1200)), 
                        .ALPHABET_LEN($clog2(alphabet_length))) vga_display_driver (.clock(CLOCK_50),
                                                                        .char_code(data_out),
                                                                        .red(red), 
                                                                        .green(green), 
                                                                        .blue(blue), 
                                                                        .hsync(VGA_HS), 
                                                                        .vsync(VGA_VS), 
                                                                        .avideo(VGA_BLANK_N),
                                                                        .sm_addr(sm_address));

    //This instance describe the rule to store the character to be showed on screen.
    Mem #(.DATA_WIDTH($clog2(alphabet_length)), 
        .ADDR_WIDTH($clog2(1200)), 
        .MEM_FILE("./smem_screen.mem")) screen_memory (.clock(CLOCK_50), 
                                                    .address(sm_address), //Receive the screen position address
                                                    .data_out(data_out)); //Return the char to this position
    
    assign VGA_R = {red,4'b0000};
	assign VGA_G = {green,4'b0000};
	assign VGA_B = {blue,4'b0000};

	assign VGA_CLK = CLOCK_50;

endmodule
