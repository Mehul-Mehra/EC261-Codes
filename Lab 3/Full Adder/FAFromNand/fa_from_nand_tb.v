`timescale 1ps/1ps
module fa_from_nand_tb;
    reg a,b,cin;
    wire sum,cout;
    fa_from_nand uut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    initial begin
        $monitor("a=%b b=%b cin=%b sum=%b cout=%b",a,b,cin,sum,cout);
        a=0;b=0;cin=0; #10;
        a=0;b=0;cin=1; #10;
        a=0;b=1;cin=0; #10;
        a=0;b=1;cin=1; #10;
        a=1;b=0;cin=0; #10;
        a=1;b=0;cin=1; #10;
        a=1;b=1;cin=0; #10;
        a=1;b=1;cin=1; #10;
        $finish;
    end
    initial begin
        $dumpfile("fa_from_nand_tb.vcd");
        $dumpvars(0,fa_from_nand_tb);
    end
endmodule