module halfadder (

	input wire A,
	input wire B,
	input wire Cin,
	output wire Sum
);

assign Sum = Cin^A^B;

endmodule