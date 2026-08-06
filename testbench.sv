`timescale 1ns/1ps
module tb_mealy_fsm;
reg clk = 0;
reg reset = 1;
reg in = 0;
wire out;
mealy_fsm uut(
    .clk(clk),
    .reset(reset),
    .in(in),
    .out(out)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("mealy_fsm.vcd");
    $dumpvars(0, tb_mealy_fsm);
    #10 reset = 0;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    #20;
    $finish;
end
initial begin
    $monitor("Time=%0t Reset=%b In=%b Out=%b",
              $time, reset, in, out);
end
endmodule