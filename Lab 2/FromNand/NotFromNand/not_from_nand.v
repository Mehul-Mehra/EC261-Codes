module not_from_nand(
    input a,
    output y
    );
    nand(y, a, a);
endmodule