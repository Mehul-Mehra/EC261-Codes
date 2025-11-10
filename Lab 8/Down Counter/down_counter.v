module jk_ff(
    input wire clk,
    input wire reset,
    input wire J,
    input wire K,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b1;       // Start at 1 for proper down-counter MSB init
        else begin
            case ({J, K})
                2'b00: Q <= Q;
                2'b01: Q <= 1'b0;
                2'b10: Q <= 1'b1;
                2'b11: Q <= ~Q;
            endcase
        end
    end
endmodule


module down_counter_jk(
    input wire clk,
    input wire reset,
    output wire [3:0] Q
);
    wire t1 = ~Q[0];
    wire t2 = (~Q[1]) & (~Q[0]);
    wire t3 = (~Q[2]) & (~Q[1]) & (~Q[0]);

    jk_ff ff0(clk, reset, 1'b1, 1'b1, Q[0]);
    jk_ff ff1(clk, reset, t1,   t1,   Q[1]);
    jk_ff ff2(clk, reset, t2,   t2,   Q[2]);
    jk_ff ff3(clk, reset, t3,   t3,   Q[3]);
endmodule


module tb_down_counter_jk;
    reg clk;
    reg reset;
    wire [3:0] Q;

    down_counter_jk uut (
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_down_counter_jk);

        $monitor("Time=%0t | clk=%b | reset=%b | Q=%b",$time, clk, reset, Q);

        clk = 0;
        reset = 1;
        #15 reset = 0;

        #200;
        $stop;
    end
endmodule