module comparator (
	input wire FlagN, FlagV, FlagC, bool0,
	output wire comparison
);

	assign comparison = bool0 & ~FlagC | ~bool0 & FlagN & ~FlagV | ~bool0 & ~FlagN & FlagV;
								
endmodule
