module or_from_nand (
    input A,
    input B,
    output Y
);
    wire nA,nB;
    nand(nA,A,A);
    nand(nB,B,B);
    nand(Y,nA,nB);
endmodule