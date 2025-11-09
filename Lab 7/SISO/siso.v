// SISO (Serial-In Serial-Out) 4-bit shift register: serial data shifted in LSB side
module siso4(clk, rst, si, so);
    // clk : clock input (rising-edge triggered)
    // rst : asynchronous reset (active high)
    // si  : serial input bit (shifted in on each rising clock edge)
    // so  : serial output bit (taken from MSB q[3])
    input clk, rst, si;
    output so;
    reg [3:0] q;                   // internal 4-bit register storing shifted bits

    // Serial output is the most-significant bit of the register.
    // As the register shifts left, successive bits exit on 'so'.
    assign so = q[3];

    // Sequential logic:
    // - Asynchronous reset (posedge rst) clears the register to zero immediately.
    // - On each rising clock edge, shift left and insert 'si' into LSB.
    // - Use non-blocking assignment (<=) for proper sequential semantics.
    always @(posedge clk or posedge rst)
    if (rst) q <= 4'b0000;
    else q <= {q[2:0], si};
endmodule

`timescale 1ps/1ps                   // time unit / time precision for simulation

module tb_siso4;
reg clk, rst, si;
wire so;
siso4 dut(clk, rst, si, so);

// Testbench notes:
// - $monitor prints the listed signals whenever they change (useful for console debug).
// - $dumpfile/$dumpvars create a VCD waveform file for waveform viewers.
// - The test sequence asserts reset, then provides a series of serial input bits.
//   Each bit is sampled on the next rising clock edge and will propagate to 'so' after shifting.
initial begin
    $monitor("clk=%b rst=%b si=%b so=%b",clk,rst,si,so);
    $dumpfile("siso.vcd");      // VCD file name
    $dumpvars(0, tb_siso4);     // dump all signals in tb_piso4 and instantiated DUT(s)

    clk = 0; rst = 1; si = 0;   // initialize and assert reset
    #10 rst = 0;                // release reset

    // Provide serial input bits; each assignment is captured on the subsequent rising edge.
    si = 1; #10;
    si = 0; #10;
    si = 1; #10;
    si = 1; #10;

    #20 $finish; // finish simulation after allowing outputs to settle
end

// Clock generator: toggle clk every 5 time units -> period = 10 time units
always #5 clk = ~clk;
endmodule