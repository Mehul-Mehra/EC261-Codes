module up_counter (
    input  wire clk,       // Clock
    input  wire reset,     // Asynchronous active-high reset
    output reg  [3:0] count // 4-bit counter output
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'b0000;
        else
            count <= count + 1'b1;
    end
endmodule
`timescale 1ps/1ps

module tb_up_counter;

    reg clk;
    reg reset;
    wire [3:0] count;

    // Instantiate DUT
    up_counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_up_counter);
        $monitor("Time = %0t | clk = %b | reset = %b | count = %b",$time, clk, reset, count);
        clk = 0;
        reset = 1;     // Initial reset
        #15 reset = 0; // Release reset
        #200;          // Run counter
        $stop;
    end
endmodule