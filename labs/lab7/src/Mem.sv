`timescale 1ns / 1ps
`default_nettype none

module Mem #(
    parameter DATA_WIDTH = 7,
    parameter ADDR_WIDTH = 11,
    parameter MEM_FILE = "smem_screen.mem"
) (
    input  wire        clock,
    input  wire [ADDR_WIDTH-1:0]  address,
    output reg  [DATA_WIDTH-1:0]  data_out);

    reg [DATA_WIDTH-1:0] RAM [0:2**ADDR_WIDTH-1];
    
    initial
        $readmemb(MEM_FILE, RAM);

    assign data_out = RAM[address];

endmodule