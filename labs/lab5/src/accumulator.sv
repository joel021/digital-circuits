module accumulator #(parameter N = 32) (
    input reset, clk,
    output [N-1:0] val
);
    wire [N-1:0] nxt;

    REGISTER_R #(.N(N)) state (.clk(clk), .d(nxt), .q(val), .reset(reset));
    assign nxt = val + 1;

endmodule
