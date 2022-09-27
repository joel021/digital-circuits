
`timescale 10 us / 1 ns
`default_nettype none

module stopwatch_tb();

    logic CLOCK_50 = 0;
    logic [3:0]	KEY = 4'b1111;
    wire [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    wire[3:0] m1, m0, s1, s0;
    wire up;

    stopwatch digital_clock (CLOCK_50, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, up);

    initial begin      // generate clock
        forever begin   // 2  seconds to each clock cycle
            #2.5 CLOCK_50 = ~CLOCK_50;
            #2.5 CLOCK_50 = ~CLOCK_50;
        end
    end

    initial begin
        // count up
        KEY = 4'b1111;
        #10000000; // 10 seconds

        #1 KEY = 4'b1011; // 10 us
        #1 KEY = 4'b1111; // 10 us

        #10000000; // 10 seconds
        
        #100 ;

        $finish;
    end

endmodule