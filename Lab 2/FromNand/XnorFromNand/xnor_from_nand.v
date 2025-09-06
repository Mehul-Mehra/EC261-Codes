module xnor_from_nand(
    input a,
    input b,
    output y
    );
    
    wire nand_ab;
    wire nand_a_nand_ab;
    wire nand_b_nand_ab;
    wire ny;
    
    nand(nand_ab, a, b);
    nand(nand_a_nand_ab, a, nand_ab);
    nand(nand_b_nand_ab, b, nand_ab);
    nand(ny, nand_a_nand_ab, nand_b_nand_ab);
    nand(y, ny, ny);
endmodule