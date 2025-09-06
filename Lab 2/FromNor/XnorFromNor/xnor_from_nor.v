module xnor_from_nor(
    input a,
    input b,
    output y
);
    wire nor1, nor2, nor3;
    nor (nor1, a, b);         
    nor (nor2, a, nor1);      
    nor (nor3, b, nor1);      
    nor (y, nor2, nor3);      
endmodule