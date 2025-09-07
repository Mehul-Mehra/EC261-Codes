`timescale 1ps/1ps
module and_from_nor_tb;
    reg a, b;
    wire y;
    
    and_from_nor uut (
        .a(a),
        .b(b),
        .y(y)
    );
    
    initial begin
        $monitor("a=%b, b=%b, y=%b", a, b, y);
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end
    initial begin
        $dumpfile("and_from_nor_tb.vcd");
        $dumpvars(0, and_from_nor_tb);
    end
endmodule