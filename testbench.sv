`timescale 1ns/1ps

module tb_sequence_detector;

reg clk = 0;
reg reset = 1;
reg in = 0;

wire detected;

sequence_detector uut(
    .clk(clk),
    .reset(reset),
    .in(in),
    .detected(detected)
);

// Clock Generation
always #5 clk = ~clk;

// Test Sequence
initial begin

    $dumpfile("sequence_detector.vcd");
    $dumpvars(0, tb_sequence_detector);

    #10 reset = 0;

    // Input Sequence: 1011001011

    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;   // Detect 1011

    #10 in = 0;
    #10 in = 0;
    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;   // Detect again

    #20;

    $finish;

end

initial begin
    $monitor("Time=%0t Reset=%b In=%b Detected=%b",
              $time, reset, in, detected);
end

endmodule