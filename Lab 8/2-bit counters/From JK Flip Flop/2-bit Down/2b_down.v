module jk_ff(
    input  wire clk,
    input  wire reset,
    input  wire J,
    input  wire K,
    output reg  Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else begin
            case ({J,K})
                2'b00: Q <= Q;
                2'b01: Q <= 1'b0;
                2'b10: Q <= 1'b1;
                2'b11: Q <= ~Q;
            endcase
        end
    end
endmodule


module down_counter_2bit_jk(
    input  wire clk,
    input  wire reset,
    output wire [1:0] Q
);
    wire t1 = ~Q[0];

    jk_ff ff0(clk, reset, 1'b1, 1'b1, Q[0]);  // toggle always
    jk_ff ff1(clk, reset, t1,   t1,   Q[1]);  // toggle when Q0=0
endmodule


module tb_down_counter_2bit_jk;
    reg clk;
    reg reset;
    wire [1:0] Q;

    down_counter_2bit_jk uut(.clk(clk), .reset(reset), .Q(Q));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_down_counter_2bit_jk);

        $monitor("Time=%0t | clk=%b | reset=%b | Q=%b",$time, clk, reset, Q);

        clk = 0;
        reset = 1;
        #15 reset = 0;

        #80;
        $stop;
    end
endmodule