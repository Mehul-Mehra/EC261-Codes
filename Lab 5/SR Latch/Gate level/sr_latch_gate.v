module sr_latch_gate(
    output Q,
    output Qbar,
    input S,
    input R
);
    nor (Q, R, Qbar);   
    nor (Qbar, S, Q);   
endmodule

`timescale 1ps / 1ps
module sr_latch_gate_tb;
    reg S, R;           
    wire Q, Qbar;       
    sr_latch_gate uut (Q, Qbar, S, R);

    initial begin
        $monitor("Time=%0t | S=%b R=%b | Q=%b Qbar=%b", $time, S, R, Q, Qbar);
        S = 0; R = 0; #10;   
        S = 1; R = 0; #10;   
        S = 0; R = 0; #10;   
        S = 0; R = 1; #10;   
        S = 0; R = 0; #10;   
        S = 1; R = 1; #10;   

        $finish;
    end
endmodule