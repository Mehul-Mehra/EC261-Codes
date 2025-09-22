module mux8to1 (
    input  [7:0] d,
    input  [2:0] sel,
    output reg y          
);
    always @(*) begin
        case (sel)
            3'b000: y = d[0];
            3'b001: y = d[1];
            3'b010: y = d[2];
            3'b011: y = d[3];
            3'b100: y = d[4];
            3'b101: y = d[5];
            3'b110: y = d[6];
            3'b111: y = d[7];
            default: y = 1'b0;
        endcase
    end
endmodule

`timescale 1ps/1ps
module tb_mux8to1;
    reg  [7:0] d;     
    reg  [2:0] sel;    
    wire y;            
    mux8to1 uut (
        .d(d),
        .sel(sel),
        .y(y)
    );

    integer i;
    initial begin
        $display("Sel\tD\t\tY");
        $monitor("%b\t%b\t%b", sel, d, y);
        for (i = 0; i < 8; i = i + 1) begin
            sel = i;       
            d = 8'b0;#5;
            d = (1 << i);#5;
        end
        #10 $finish;
    end
    initial begin
        $dumpfile("mux.vcd");
        $dumpvars(0,tb_mux8to1);
    end
endmodule