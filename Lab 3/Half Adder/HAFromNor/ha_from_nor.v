module ha_from_nor (
    input a,
    input b,
    output sum,
    output carry
);
    wire t1, t2, t3;
    nor(t1, a, a); 
    nor(t2, b, b);
    nor(carry, t1, t2);
    nor(t3, a, b);
    nor(sum, carry, t3);
endmodule