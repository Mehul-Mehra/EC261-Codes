// SIPO (Serial-In Parallel-Out) 4-bit shift register: serial data shifted in LSB side

module sipo4(clk, rst, si, po);
    // clk : clock input (rising-edge triggered)
    // rst : asynchronous reset (active high)
    // si  : serial input bit (shifted in on each rising clock edge)
    // po  : 4-bit parallel output reflecting register contents
    input clk, rst, si;
    output [3:0] po;
    reg [3:0] q;                   // internal register storing shifted bits
    // 'po' is driven by a continuous assignment from 'q' so it behaves like a wire.
    assign po = q;

    // Sequential logic:
    // - On posedge rst: asynchronously clear the register to 0.
    // - On posedge clk: shift left, inserting 'si' into LSB.
    // Use non-blocking assignment (<=) for sequential updates.
    always @(posedge clk or posedge rst)
    if (rst) q <= 4'b0000;
    else q <= {q[2:0], si};
endmodule

`timescale 1ps/1ps                   // time unit / time precision for simulation

module tb_sipo4;
reg clk, rst, si;
wire [3:0] po;
sipo4 dut(clk, rst, si, po);

// Testbench notes:
// - $monitor prints listed signals whenever they change.
// - $dumpfile/$dumpvars create a VCD file for waveform viewing.
// - Apply reset, then drive serial input bits; each rising clock captures the bit.
initial begin
    $monitor("clk=%b rst=%b si=%b po=%b",clk,rst,si,po);
    $dumpfile("sipo.vcd");
    $dumpvars(0, tb_sipo4);

    clk = 0; rst = 1; si = 0;   // initialize and assert reset
    #10 rst = 0;                // release reset

    // Drive serial input bits; each assignment is sampled on the next rising edge.
    si = 1; #10;
    si = 0; #10;
    si = 1; #10;
    si = 1; #10;

    #20 $finish; // finish after allowing outputs to settle
end

// Clock generator: toggle every 5 time units -> period = 10 time units
always #5 clk = ~clk;
endmodule