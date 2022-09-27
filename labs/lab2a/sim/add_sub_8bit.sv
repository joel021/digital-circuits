module add_sub_8bit(
	input wire [7:0] A,
	input wire [7:0] B,
	input wire Subtract,
	output wire [7:0] Result
);

	wire [7:0] ToBornottoB;
	wire Cout;
	
	assign ToBornottoB[7:0] = {8{Subtract}}^B[7:0];
	adder8bit add8(A[7:0], ToBornottoB[7:0], Subtract, Result[7:0], Cout);
	
endmodule
