module piso4(clk, rst, load, pi, so);
    input clk, rst, load;
    input [3:0] pi;
    output so;
    reg [3:0] q;
    assign so = q[3];
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
initial begin
$monitor("clk=%b rst=%b load=%b pi=%b so=%b",clk,rst,load,pi,so);
$dumpfile("piso.vcd");
$dumpvars(0, tb_piso4);
clk = 0; rst = 1; load = 0; pi = 4'b0000;
#10 rst = 0;
pi = 4'b1011; load = 1; #10;
load = 0; #40;
#20 $finish;
end
always #5 clk = ~clk;
endmodule
