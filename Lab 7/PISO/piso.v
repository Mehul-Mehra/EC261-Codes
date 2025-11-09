module piso4(clk, rst, load, pi, so);
    // clk  : clock input (rising-edge triggered)
    // rst  : asynchronous reset (active high)
    // load : control signal; when high, parallel data is loaded into the shift register
    // pi   : 4-bit parallel input to be loaded
    // so   : serial output (we output the MSB q[3])
    input clk, rst, load;
    input [3:0] pi;
    output so;
    reg [3:0] q;                   // internal 4-bit register holding current state

    // The serial output is taken from the most-significant bit of the register.
    // As the register shifts, successive MSB values appear on 'so'.
    assign so = q[3];

    // Sequential logic:
    // - Asynchronous reset (posedge rst) clears the register to 0.
    // - If load is asserted on a clock edge, parallel input 'pi' is captured.
    // - Otherwise the register shifts left by one bit; LSB is filled with 0.
    // Note: non-blocking assignments (<=) are used for proper sequential behavior.
    always @(posedge clk or posedge rst)
    if (rst) q <= 4'b0000;
    else if (load) q <= pi;
    else q <= {q[2:0], 1'b0};
endmodule

`timescale 1ps/1ps

module tb_piso4;
reg clk, rst, load;
reg [3:0] pi;
wire so;
piso4 dut(clk, rst, load, pi, so);

// Testbench notes:
// - $monitor prints values whenever one of the listed signals changes.
// - $dumpfile/$dumpvars create a VCD file for waveform inspection.
// - The test sequence asserts reset, loads a parallel word, then releases load
//   so the register shifts the bits out serially at each clock rising edge.
initial begin
    $monitor("clk=%b rst=%b load=%b pi=%b so=%b",clk,rst,load,pi,so);
    $dumpfile("piso.vcd");
    $dumpvars(0, tb_piso4);

    clk = 0; rst = 1; load = 0; pi = 4'b0000; // initialize and assert reset
    #10 rst = 0;                              // release reset

    // Load parallel data while 'load' is high; the data will appear in q at next rising edge.
    pi = 4'b1011; load = 1; #10;
    // Disable load so the register will start shifting the contents out via 'so'.
    load = 0; #40; // allow several clock cycles for bits to shift out

    #20 $finish;
end

// Clock generator: toggle every 5 time units -> 10 time unit period
always #5 clk = ~clk;
endmodule
