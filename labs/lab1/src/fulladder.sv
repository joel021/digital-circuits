module fulladder (
	input wire A,
	input wire B,
	input wire Cin,
	output wire Sum,
	output wire Cout
);

	assign Sum = Cin ^ A ^ B;
	assign Cout = Cin&(A^B) | A&B;

endmodule