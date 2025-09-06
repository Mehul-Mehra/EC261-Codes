module nand_from_nor(
    input a,
    input b,
    output y
    );
    
    wire na, nb,ny;
    nor (na, a, a);
    nor (nb, b, b);
    nor (ny, na, nb);
    nor (y, ny, ny);
endmodule