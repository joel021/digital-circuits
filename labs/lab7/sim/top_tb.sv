`timescale 1ns / 1ps

module top_tb;
    
    reg clock;
    wire VGA_CLK, VGA_SYNC_N, VGA_BLANK_N, VGA_HS, VGA_VS;

    wire [7:0] VGA_R, VGA_G, VGA_B;

    top top_instance (.CLOCK_50(clock), 
                    .VGA_CLK(VGA_CLK),
                    .VGA_SYNC_N(VGA_SYNC_N),
                    .VGA_BLANK_N(VGA_BLANK_N),
                    .VGA_R(VGA_R),
                    .VGA_G(VGA_G),
                    .VGA_B(VGA_B),
                    .VGA_HS(VGA_HS),
                    .VGA_VS(VGA_VS));

    integer i;

    initial begin
        clock = 0;

        for (i = 0; i < 256; i = i+1) begin
            #1 clock = ~clock;
            #1 clock = ~clock;
        end

        #2 $finish;
    end

    initial begin
        $display("char_code char_addr");
        $monitor("%d %d", char_code, char_addr);
	end
      
endmodule