module or_from_nor (
    input a,
    input b,
    output y
);
    wire nor_out;
    nor (nor_out, a, b);
    nor (y, nor_out, nor_out);
endmodule