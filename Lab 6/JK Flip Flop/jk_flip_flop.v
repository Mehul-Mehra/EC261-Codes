module jk_ff (
    input J, K, clk, rst,
    output reg Q,
    output Qbar
);
    assign Qbar=~Q;
    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 0;
        else begin
            case ({J, K})
                2'b00: Q <= Q;       
                2'b01: Q <= 0;       
                2'b10: Q <= 1;       
                2'b11: Q <= ~Q;
            endcase
        end
    end
endmodule
`timescale 1ps/1ps
module tb_jk_ff;
    reg J, K, clk, rst;
    wire Q,Qbar;
    jk_ff uut (
        .J(J),
        .K(K),
        .clk(clk),
        .rst(rst),
        .Q(Q),
        .Qbar(Qbar)
    );
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;
        J = 0; K = 0;
        #10 rst = 0;
        #10 J = 0; K = 0;   
        #10 J = 0; K = 1;   
        #10 J = 1; K = 0;   
        #10 J = 1; K = 1;   
        #10 J = 1; K = 1;   
        #10 J = 0; K = 0;   
        $finish;
    end
    initial begin
        $monitor("Clk=%b | J=%b K=%b | Q=%b Qbar=%b", clk, J, K, Q, Qbar);
    end
    initial begin
        $dumpfile("jk_ff.vcd");
        $dumpvars(0,tb_jk_ff);
    end
endmodule