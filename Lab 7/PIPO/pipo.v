// PIPO (Parallel-In Parallel-Out) 4-bit register with synchronous load and asynchronous reset

module pipo4(clk, rst, pi, po);
    input clk, rst;                // clk : clock input (rising-edge triggered)
                                   // rst : asynchronous reset (active high)
    input [3:0] pi;                // pi  : 4-bit parallel input data
    output [3:0] po;               // po  : 4-bit parallel output (current stored data)
    reg [3:0] q;                   // q   : internal register storing the 4-bit state
    // Note: 'q' is declared as reg because it is assigned inside a procedural block.
    // The output 'po' is driven by a continuous assignment from 'q', so 'po' behaves like a wire.

    assign po = q;                 // drive output with internal register value
    // Continuous assignment updates 'po' whenever 'q' changes.

    // On each rising edge of clock, capture parallel input into register q.
    // If reset is asserted (high), clear the register asynchronously to 0.
    // We use non-blocking assignment (<=) for sequential logic to avoid race conditions
    // when multiple registers are updated on the same clock edge.
    always @(posedge clk or posedge rst)
    if (rst) q <= 4'b0000;         // asynchronous reset: clear stored data
    else q <= pi;                  // on clock edge: load input into register
endmodule

`timescale 1ps/1ps                   // time unit / time precision for simulation

module tb_pipo4;
reg clk, rst;
reg [3:0] pi;
wire [3:0] po;
pipo4 dut(clk, rst, pi, po);

// Testbench initial block:
// - $monitor prints signal values whenever they change
// - $dumpfile/$dumpvars create a VCD waveform for viewing with a waveform viewer
// - apply reset and a sequence of parallel inputs, then finish simulation
initial begin
    $monitor("clk=%b rst=%b pi=%b po=%b",clk,rst,pi,po); // observe signals during sim
    $dumpfile("pipo.vcd");      // VCD file name for waveform dump
    $dumpvars(0, tb_pipo4);     // dump all variables in this module and below
    // Note: $dumpvars(0, tb_pipo4) captures signals in tb_pipo4 and instantiated DUT(s).

    clk = 0; rst = 1; pi = 4'b0000; // initialize signals, start with reset asserted
    #10 rst = 0;                     // release reset after 10 time units
    // Because clock toggles every 5 time units, the first rising edge after release
    // will occur at the next #5 boundary; inputs assigned between clock edges will
    // be captured on the next rising edge.

    // Apply a sequence of parallel inputs; each change will be captured on next rising clock
    pi = 4'b1010; #10;
    pi = 4'b1100; #10;
    pi = 4'b1111; #10;
    pi = 4'b0001; #10;

    #20 $finish; // end simulation after letting signals propagate
end

// Clock generation: toggle clk every 5 time units -> period = 10 time units
always #5 clk = ~clk;
endmodule