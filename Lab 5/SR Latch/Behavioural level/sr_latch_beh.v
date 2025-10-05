module sr_latch_beh(
    output reg Q,
    output Qbar,
    input S,
    input R
);
    assign Qbar = ~Q;  

    always @ (S or R) begin
        if (S == 0 && R == 0)
            Q = Q;        
        else if (S == 1 && R == 0)
            Q = 1;        
        else if (S == 0 && R == 1)
            Q = 0;        
        else
            Q = 1'bx;     
    end
endmodule

`timescale 1ps / 1ps
module sr_latch_beh_tb;
    reg S, R;           
    wire Q, Qbar;       
    sr_latch_beh uut (Q, Qbar, S, R);

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