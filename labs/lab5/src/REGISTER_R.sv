module REGISTER_R #(parameter N = 32) (
	input wire clk, reset,
	input wire [N-1:0] d,
	output reg [N-1:0] q
);

	always @(posedge clk) begin
		if (reset) begin
			q <= 0;
		end
		else begin
			q <= d;
		end
	end

endmodule