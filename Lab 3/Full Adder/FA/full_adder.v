module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire xab, ab, w;
    xor (xab, a, b);
    xor (sum, xab, cin);
    and (ab, a, b);
    and (w, xab, cin);
    or  (cout, ab, w);
    
endmodule