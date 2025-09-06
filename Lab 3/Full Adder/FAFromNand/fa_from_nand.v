module fa_from_nand (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire ab,a_ab,b_ab,xab,c_xab,t1,t2;
    nand(ab,a,b);
    nand(a_ab,a,ab);
    nand(b_ab,b,ab);
    nand(xab,a_ab,b_ab);
    nand(c_xab,xab,cin);
    nand(t1,c_xab,xab);
    nand(t2,c_xab,cin);
    nand(sum,t1,t2);
    nand(cout,ab,c_xab);
endmodule