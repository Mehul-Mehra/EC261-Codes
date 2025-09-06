module and_from_nor(
    input a,
    input b,
    output y
    );
    
    wire na, nb;
    nor (na, a, a);
    nor (nb, b, b);
    nor (y, na, nb);
endmodule