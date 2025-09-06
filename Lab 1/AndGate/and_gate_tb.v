// (optional) sets simulation time unit and precision
// 1ns → simulation unit (each #1 means 1ns).
// 1ps → precision (smallest step you can represent).
`timescale 1ns/1ps

// Module declaration
// Always ends with _tb (convention).
// Testbenches have no input/output ports (they’re self-contained).
module and_gate_tb;

// Signal Declaration
// Use reg for inputs (since testbench drives them over time).
// Use wire for outputs (they are driven by the DUT).
reg a,b;
wire y;

// DUT Instantiation
// This connects your testbench signals to the design you want to test.
and_gate uut(.a(a),.b(b),.y(y));

// Stimulus (initial block)
// Where you apply test inputs.
initial begin
    // Monitoring the values
    $monitor("a=%b ,b=%b, y=%b",a,b,y);
    
    // Test cases
    a=0;b=0; #10; // apply inputs, wait 10ns
    a=0;b=1; #10;
    a=1;b=0; #10;
    a=1;b=1; #10;
    $finish;
end

// (Optional) Add monitoring or waveform dump.
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, and_gate_tb);
end

endmodule