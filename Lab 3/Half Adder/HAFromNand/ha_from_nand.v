module ha_from_nand (
    input a,
    input b,
    output sum,
    output carry
);
    wire nand_ab;
    wire nand_a_nand_ab;
    wire nand_b_nand_ab;
    nand (nand_ab, a, b);
    nand (carry, nand_ab, nand_ab);
    nand (nand_a_nand_ab, a, nand_ab);
    nand (nand_b_nand_ab, b, nand_ab);
    nand (sum, nand_a_nand_ab, nand_b_nand_ab);
endmodule