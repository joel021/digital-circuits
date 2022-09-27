`timescale 1ns / 1ps
`default_nettype none

/*
This module conect the Register File with the ALU.
The inputs are from test bench and results of alu is passed to be verified
*/
module datapath #(
    parameter Nloc = 32,
    parameter Dbits = 32
) (
    input wire clock, RegWrite,
    input wire [$clog2(Nloc)-1 : 0] ReadAddr1, ReadAddr2, WriteAddr,
    input wire [4:0] ALUFN,
    input wire [Dbits-1 : 0] WriteData,
    
    output logic [Dbits-1 : 0] ReadData1, ReadData2,
    output wire [Dbits-1:0] ALUResult,
    output wire FlagZ
);
   
    register_file #(Nloc, Dbits) reg_f  (clock, RegWrite, ReadAddr1, ReadAddr2, WriteAddr, WriteData, ReadData1, ReadData2);

    alu #(.N(Dbits)) aluu (.A(ReadData1), .B(ReadData2),.R(ALUResult), .ALUfn(ALUFN), .FlagZ(FlagZ));

endmodule
