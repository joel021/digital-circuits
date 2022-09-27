`timescale 1ns / 1ps
`default_nettype none

module alu #(parameter N=32) (
	input wire [N-1:0] A, B,
	output wire [N-1:0] R,
	input wire [4:0] ALUfn,
	output wire FlagZ
);
	
	wire FlagN, FlagV, FlagC;
	wire subtract, bool1, bool0, shft, math;
	wire compResult;
	
	//separar ALUfn em bits nomeados
	assign {subtract, bool1, bool0, shft, math} = ALUfn[4:0];
	
	//Resultados dos três compoenentes da ALU
	wire [N-1:0] addsubResult, shiftResult, logicalResult;
	
	addsub #(N) AS(A, B, subtract, addsubResult, FlagN, FlagC, FlagV);
	
	shifter #(N) S(B, A[$clog2(N) -1:0], ~bool1&~bool0, bool1&~bool0, shiftResult);
	
	logical #(N) L(A, B, {bool1,bool0}, logicalResult);
	
	comparator C(FlagN, FlagV, FlagC, bool0, compResult);
	
	//Multiplexador de 4 entradas para selecionar a saída
	assign R = (~shft & math) ? addsubResult : 
				(shft & ~math) ? shiftResult : 
				(~shft & ~math) ? logicalResult : {{(N-1){1'b0}}, compResult};
					
	assign FlagZ = ~(|R);
	
	
endmodule
