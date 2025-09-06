module and_from_nand(
    input a,
    input b,
    output y
    );
    
    wire nand_out;
    nand(nand_out, a, b);
    nand(y, nand_out, nand_out);
endmodule