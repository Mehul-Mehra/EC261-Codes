module xor_from_nor(
    input a,
    input b,
    output y
);
    wire nor1, nor2, nor3,ny;
    nor (nor1, a, b);         
    nor (nor2, a, nor1);      
    nor (nor3, b, nor1);      
    nor (ny, nor2, nor3);
    nor (y, ny, ny);      
endmodule