module xor_from_nand (
    input a,
    input b,
    output y
);
    wire nand_ab, nand_a, nand_b;
    nand (nand_ab, a, b);
    nand (nand_a, a, nand_ab);
    nand (nand_b, b, nand_ab);
    nand (y, nand_a, nand_b);
endmodule