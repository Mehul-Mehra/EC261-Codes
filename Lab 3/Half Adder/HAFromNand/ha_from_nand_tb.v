`timescale 1ps/1ps
module ha_from_nand_tb;
    reg a;
    reg b;
    wire sum;
    wire carry;

    ha_from_nand uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        $monitor("a=%b, b=%b => sum=%b, carry=%b", a, b, sum, carry);
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end
    initial begin
        $dumpfile("ha_from_nand_tb.vcd");
        $dumpvars(0, ha_from_nand_tb);
    end
endmodule