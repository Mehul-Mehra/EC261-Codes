`timescale 1ns/1ps

module or_from_nand_tb;

reg A,B;
wire Y; 

or_from_nand uut(.A(A),.B(B),.Y(Y));

initial begin
    $monitor("A=%b B=%b Y=%b",A,B,Y);
    A=0;B=0; #10;
    A=0;B=1; #10;
    A=1;B=0; #10;
    A=1;B=1; #10;
    $finish;
end
initial begin
    $dumpfile("or_from_nand.vcd");
    $dumpvars(0, or_from_nand_tb);
end
endmodule