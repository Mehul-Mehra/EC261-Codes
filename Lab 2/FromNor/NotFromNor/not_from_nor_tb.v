`timescale 1ps/1ps
module not_from_nor_tb;
    reg a;
    wire y;
    
    not_from_nor uut (
        .a(a),
        .y(y)
    );
    
    initial begin
        $monitor("a=%b, y=%b", a, y);
        a = 0; #10;
        a = 1; #10;
        $finish;
    end
    initial begin
        $dumpfile("not_from_nor_tb.vcd");
        $dumpvars(0, not_from_nor_tb);
    end
endmodule