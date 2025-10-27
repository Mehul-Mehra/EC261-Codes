module sipo4(clk, rst, si, po);
    input clk, rst, si;
    output [3:0] po;
    reg [3:0] q;
    assign po = q;
    always @(posedge clk or posedge rst)
    if (rst) q <= 4'b0000;
    else q <= {q[2:0], si};
endmodule

`timescale 1ps/1ps
module tb_sipo4;
reg clk, rst, si;
wire [3:0] po;
sipo4 dut(clk, rst, si, po);
initial begin
$monitor("clk=%b rst=%b si=%b po=%b",clk,rst,si,po);
$dumpfile("sipo.vcd");
$dumpvars(0, tb_sipo4);
clk = 0; rst = 1; si = 0;
#10 rst = 0;
si = 1; #10;
si = 0; #10;
si = 1; #10;
si = 1; #10;
#20 $finish;
end
always #5 clk = ~clk;
endmodule