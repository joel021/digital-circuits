`timescale 1ns / 1ps
`default_nettype none
module instruction_reader_tb;


    logic clk, reset, enable;
    wire [31:0] current_pc, pc_plus;

    instruction_reader #(32) instr (.clk(clk), .reset(reset), .enable(enable),.pcsel(2'b00), .BT(32'd0), .J(32'd0), .JT(32'd0), .pc(current_pc), .pc_plus(pc_plus) );

    integer i; 

    initial begin

        clk = 0;
        reset = 0;
        enable = 1;
        #1;

        for (i = 0; i < 10; i = i+1) begin
            #1 clk = ~clk;
            #1 clk = ~clk;

            if (i == 5) begin
                reset = 1;
                #1 clk = ~clk;
                #1 clk = ~clk;

                reset = 0;
                #1 clk = ~clk;
                #1 clk = ~clk;

                enable = 0;
                #1 clk = ~clk;
                #1 clk = ~clk;

                enable = 1;
                #1 clk = ~clk;
                #1 clk = ~clk;
            end

        end

        #2 $finish;
    end

    initial begin
		$timeformat(-9, 2, " ns", 10);
		$monitor("At time %t: current_pc = %h, new_pc = %h", 
					$time, current_pc, pc_plus);
	end

endmodule