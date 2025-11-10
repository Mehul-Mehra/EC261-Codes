module d_ff(
    input wire clk,
    input wire reset,
    input wire D,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule

module up_counter_2bit_d(
    input wire clk,
    input wire reset,
    output wire [1:0] Q
);
    wire D0 = ~Q[0];          // LSB toggles every clock
    wire D1 = Q[1] ^ Q[0];    // Next bit toggles when Q0 = 1

    d_ff ff0(clk, reset, D0, Q[0]);
    d_ff ff1(clk, reset, D1, Q[1]);
endmodule


module tb_up_counter_2bit_d;
    reg clk;
    reg reset;
    wire [1:0] Q;

    up_counter_2bit_d uut (
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | clk=%b | reset=%b | Q=%b",$time, clk, reset, Q);
        $dumpfile("tb_up_counter_2bit_d.vcd");
        $dumpvars(0, tb_up_counter_2bit_d);
        clk = 0;
        reset = 1;
        #15 reset = 0;

        #50;
        $stop;
    end
endmodule