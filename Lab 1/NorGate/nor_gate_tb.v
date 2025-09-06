`timescale 1ps/1ps
module nor_gate_tb;
    reg A;
    reg B;
    wire Y;

    nor_gate uut (
        .A(A),
        .B(B),
        .Y(Y)
    );

    initial begin
        $monitor("A=%b, B=%b, Y=%b", A, B, Y);

        A = 0; B = 0; #10;
        A = 0; B = 1; #10;  
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;
        $finish;
    end
    initial begin
        $dumpfile("nor_gate_tb.vcd");
        $dumpvars(0, nor_gate_tb);
    end
endmodule