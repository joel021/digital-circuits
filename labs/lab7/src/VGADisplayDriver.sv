`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.svh"

module VGADisplayDriver #(
    parameter SM_LEN = $clog2(1200),
    parameter ALPHABET_LEN = $clog2(37)
    ) (
    input wire clock,
    input wire [ALPHABET_LEN-1:0] char_code, // with 6 bits it is possible to map 36 distinct characters
    output wire [3:0] red, green, blue,
    output wire hsync, vsync, avideo,
    output wire [SM_LEN-1:0] sm_addr // screen memory address
);
    wire activevideo;
    wire [11:0] RBG_pixel;
    wire [(`xbits)-1:0] x;
    wire [(`ybits)-1:0] y;
    wire [ALPHABET_LEN+7:0] bm_addr; //ALPHABET_LEN+7 = $clog2(n_chars*256)-1. Each char uses 256 words on memory

    assign avideo = activevideo;

    VGATimer vgatimer (clock, hsync, vsync, activevideo, x, y);

// ----------------- Bitmap Memory ------------------------------------------------------------------------------------
    /* 
    This module describe all characters supported. Each address of the memory (each line on file memory) is the description of the character.
    The description is in RGB colors.
    let {sR:fR}{sG:fG}{sB:fB} = RGB_i coding to colors of one pixel i. fR-sR = fG-sG = fB-sB = 4 bits.
    let one line of the file defined as {R,G,B}.
    One character is constructed with 16x16 pixels.
    256 positions on memory is used to store a character.
    */

    assign bm_addr = {char_code,y[3:0],x[3:0]}; //map logic to get the RGB pixel value
    
    Mem #(.DATA_WIDTH(12), 
        .ADDR_WIDTH(ALPHABET_LEN+8), //Quantity of words in memory = (how many chars) x (how many lines is necessary to encode them) = n_chars x 256
        .MEM_FILE("bmem_screen.mem")) bitmap_memory (.clock(clock),
                                                    .address(bm_addr),
                                                    .data_out(RBG_pixel));
    /*
    The address is mapped from 0 to 16*16 to each char constructed.
    So, each char is mapped with 256 memory positions.
    Each position have 12 bits: 4-> Red, 4->Green and 4 -> Blue.
    */
// -------------------------------------------------------------------------------------------------------------------
    assign sm_addr = {y[8:4], x[9:4]}; // // divide by 16 is equivalent to shift right by 4. The remaing most higher bits are no mapped on the adress because it is out of the screen references

    assign red[3:0]   = (activevideo == 1) ? RBG_pixel[11:8] : 4'b0; 
    assign green[3:0] = (activevideo == 1) ? RBG_pixel[7:4] : 4'b0; 
    assign blue[3:0]  = (activevideo == 1) ? RBG_pixel[3:0] : 4'b0;

endmodule
