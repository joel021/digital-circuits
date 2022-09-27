`timescale 1ns / 1ps
`default_nettype none

module mux4 #(parameter Dbits = 32) (
    input wire[Dbits-1:0] in0, in1, in2, in3,
    input wire [1:0] sel,
    output wire [Dbits-1:0] out
);

    assign out =    (sel == 2'b01) ? in1 :
                    (sel == 2'b10) ? in2 :
                    (sel == 2'b11) ? in3 :
                    in0;

endmodule