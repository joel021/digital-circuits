`timescale 1ns / 1ps
`default_nettype none

module synchronous_R (
    input wire clk, reset, enable,
    input wire [31:0] input_v,
    output reg [31:0] output_v
);

    initial output_v = 32'h400000;

    // sequencial logic: Program counter
    always @(posedge clk) begin
        
        if (reset)
            output_v <= 32'h400000;
        else if (enable) 
                output_v <= input_v;
    end

endmodule