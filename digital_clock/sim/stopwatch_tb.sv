
`timescale 10 us / 1 ns
`default_nettype none

module stopwatch_tb();

    logic CLOCK_50 = 0;
    logic [3:0]	KEY = 4'b1111;
    wire [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    wire[3:0] m1, m0, s1, s0;
    wire up, down;

    stopwatch digital_clock (CLOCK_50, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,  m1, m0, s1, s0,up, down);

    initial begin      // generate clock
        forever begin   // 2  seconds to each clock cycle
            #2.5 CLOCK_50 = ~CLOCK_50;
            #2.5 CLOCK_50 = ~CLOCK_50;
        end
    end

    initial begin
        // count up
        #10 KEY = 4'b0111; //reset
        #10 KEY = 4'b1111; //count up
        #2000;

        #10 KEY = 4'b1101; // count down
        #10 KEY = 4'b1111; // 10 us

        #2000;

        $finish;
    end

endmodule