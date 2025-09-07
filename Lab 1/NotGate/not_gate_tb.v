`timescale 1ps/1ps
module not_gate_tb;
    reg a;
    wire y;

    not_gate uut (
        .a(a),
        .y(y)
    );

    initial begin
        $monitor("a = %b, y = %b", a, y);
        a = 0; #10;
        a = 1; #10;
        $finish;
    end
    initial begin
        $dumpfile("not_gate_tb.vcd");
        $dumpvars(0, not_gate_tb);
    end
endmodule