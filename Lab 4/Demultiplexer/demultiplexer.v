module demux8to1 (
    input  din,          
    input  [2:0] sel,    
    output reg [7:0] y   
);
    always @(*) begin
        y = 8'b0;               // Default all outputs off
        if (din) begin
            case (sel)
                3'b000: y[0] = 1;
                3'b001: y[1] = 1;
                3'b010: y[2] = 1;
                3'b011: y[3] = 1;
                3'b100: y[4] = 1;
                3'b101: y[5] = 1;
                3'b110: y[6] = 1;
                3'b111: y[7] = 1;
            endcase
        end
    end
endmodule

`timescale 1ps/1ps
module tb_demux8to1;
    reg din;             
    reg [2:0] sel;       
    wire [7:0] y;        
    demux8to1 uut (
        .din(din),
        .sel(sel),
        .y(y)
    );
    integer i;
    initial begin
        $display("Sel\tDin\tY");
        $monitor("%b\t%b\t%b", sel, din, y);

        // Loop through all select lines
        for (i = 0; i < 8; i = i + 1) begin
            sel = i;
            din = 1;
            #5;
        end

        #10 $finish;
    end
    initial begin
        $dumpfile("demux.vcd");
        $dumpvars(0,tb_demux8to1);
    end
endmodule