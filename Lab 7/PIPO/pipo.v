module pipo4(clk, rst, pi, po);
    input clk, rst;
    input [3:0] pi;
    output [3:0] po;
    reg [3:0] q;
    assign po = q;
    always @(posedge clk or posedge rst)
    if (rst) q <= 4'b0000;
    else q <= pi;
endmodule

`timescale 1ps/1ps
module tb_pipo4;
reg clk, rst;
reg [3:0] pi;
wire [3:0] po;
pipo4 dut(clk, rst, pi, po);
initial begin
$monitor("clk=%b rst=%b pi=%b po=%b",clk,rst,pi,po);
$dumpfile("pipo.vcd");
$dumpvars(0, tb_pipo4);
clk = 0; rst = 1; pi = 4'b0000;
#10 rst = 0;
pi = 4'b1010; #10;
pi = 4'b1100; #10;
pi = 4'b1111; #10;
pi = 4'b0001; #10;
#20 $finish;
end
always #5 clk = ~clk;
endmodule
