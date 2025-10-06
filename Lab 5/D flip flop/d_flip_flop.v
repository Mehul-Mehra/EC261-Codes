module d_flip_flop (
    input wire d,       
    input wire clk,      
    input wire rst_n,    
    output reg q         
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0; 
        else
            q <= d;    
    end
endmodule
`timescale 1ps/1ps
module tb_d_flip_flop;
    reg d;
    reg clk;
    reg rst_n;
    wire q;
    d_flip_flop uut (
        .d(d),
        .clk(clk),
        .rst_n(rst_n),
        .q(q)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    initial begin
        rst_n = 0; d = 0; #10; 
        rst_n = 1; #10; 
        d = 1; #10; 
        d = 0; #10; 
        d = 1; #10; 
        rst_n = 0; #10; 
        rst_n = 1; #10; 
        d = 0; #10; 
        d = 1; #20; 
        $finish; 
    end
    initial begin
        $monitor("rst_n: %b | d: %b | q: %b",rst_n, d, q);
    end
    initial begin
        $dumpfile("tb_d_flip_flop.vcd");
        $dumpvars(0, tb_d_flip_flop);
    end
endmodule