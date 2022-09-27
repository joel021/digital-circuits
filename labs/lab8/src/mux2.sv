`timescale 1ns / 1ps
`default_nettype none

module mux2 #(parameter Dbits = 32) (
    input wire[Dbits-1:0] in0, in1,
    input wire sel,
    output wire [Dbits-1:0] out
);

    assign out = (sel) ? in1 : in0;

endmodule