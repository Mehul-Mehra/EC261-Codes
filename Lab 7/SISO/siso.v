module siso4(clk, rst, si, so);
    input clk, rst, si;
    output so;
    reg [3:0] q;
    assign so = q[3];
    always @(posedge clk or posedge rst)
    if (rst) q <= 4'b0000;
    else q <= {q[2:0], si};
endmodule

`timescale 1ps/1ps
module tb_siso4;
reg clk, rst, si;
wire so;
siso4 dut(clk, rst, si, so);
initial begin
$monitor("clk=%b rst=%b si=%b so=%b",clk,rst,si,so);
$dumpfile("siso.vcd");
$dumpvars(0, tb_siso4);
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