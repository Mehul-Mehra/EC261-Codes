module nor_from_nand(
    input a,
    input b,
    output y
    );
    wire na,nb,ny;
    nand(na,a,a);
    nand(nb,b,b);
    nand(ny,na,nb);
    nand(y,ny,ny);
endmodule