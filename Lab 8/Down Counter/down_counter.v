module down_counter (
    input  wire clk,        // Clock
    input  wire reset,      // Asynchronous active-high reset
    output reg  [3:0] count // 4-bit counter output
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'b1111;      // Start from max (15)
        else
            count <= count - 1'b1; // Decrement
    end
endmodule

`timescale 1ps/1ps

module tb_down_counter;

    reg clk;
    reg reset;
    wire [3:0] count;

    // Instantiate DUT
    down_counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation: 10-unit period
    always #5 clk = ~clk;

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_down_counter);

        $monitor("Time = %0t | clk = %b | reset = %b | count = %b",$time, clk, reset, count);
        clk = 0;
        reset = 1;       // Apply reset (count = 15)
        #15 reset = 0;   // Release reset
        #200;            // Let it run
        $stop;
    end

endmodule