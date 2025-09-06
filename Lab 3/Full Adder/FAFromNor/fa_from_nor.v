module fa_from_nor (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire n1, n2, n3, n4, n5, n6, n7;
    nor (n1, a, b);
    nor (n2, a, n1);
    nor (n3, b, n1);
    nor (n4, n2, n3);
    nor (n5, n4, cin);
    nor (n6, n4, n5);
    nor (n7, cin, n5);
    nor (sum, n6, n7);
    nor (cout, n1, n5);
endmodule