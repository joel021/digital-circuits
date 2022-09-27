module fulladder (
	input wire A,
	input wire B,
	input wire Cin,
	output wire Sum,
	output wire Cout
);

	wire t1, t2, t3;
	xor x1(t1, A, B);
	xor x2(Sum, Cin, t1);
	and a1(t2, A, B);
	and a2(t3, Cin, t1);
	or o1(Cout, t3, t2);

endmodule