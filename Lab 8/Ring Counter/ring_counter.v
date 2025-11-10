module jk_ff(
    input wire clk,
    input wire reset,
    input wire J,
    input wire K,
    output reg Q,
    input wire init       
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= init;        
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


module ring_counter_jk(
    input wire clk,
    input wire reset,
    output wire [3:0] Q
);
    wire [3:0] D = {Q[2], Q[1], Q[0], Q[3]};

    wire J0 = ~Q[0] & D[0];
    wire K0 =  Q[0] & ~D[0];

    wire J1 = ~Q[1] & D[1];
    wire K1 =  Q[1] & ~D[1];

    wire J2 = ~Q[2] & D[2];
    wire K2 =  Q[2] & ~D[2];

    wire J3 = ~Q[3] & D[3];
    wire K3 =  Q[3] & ~D[3];

    // Initial state = 1000 (Q3 = 1)
    jk_ff ff0(clk, reset, J0, K0, Q[0], 1'b0);
    jk_ff ff1(clk, reset, J1, K1, Q[1], 1'b0);
    jk_ff ff2(clk, reset, J2, K2, Q[2], 1'b0);
    jk_ff ff3(clk, reset, J3, K3, Q[3], 1'b1);
endmodule


module tb_ring_counter_jk;
    reg clk;
    reg reset;
    wire [3:0] Q;

    ring_counter_jk uut (
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_ring_counter_jk);

        $monitor("Time=%0t | clk=%b | reset=%b | Q=%b",$time, clk, reset, Q);
        clk = 0;
        reset = 1;
        #15 reset = 0;
        #200;
        $stop;
    end
endmodule