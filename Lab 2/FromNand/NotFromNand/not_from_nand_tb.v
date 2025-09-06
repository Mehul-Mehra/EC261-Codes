`timescale 1ps/1ps
module not_from_nand_tb;
    reg a;
    wire y;
    not_from_nand uut (.a(a), .y(y));
    initial begin
        $monitor("a=%b, y=%b", a, y);
        a = 0; #10;
        a = 1; #10;
        $finish;
    end
endmodule