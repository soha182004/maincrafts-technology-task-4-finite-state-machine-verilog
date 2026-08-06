`timescale 1ns/1ps
module tb_moore_fsm;
reg clk = 0;
reg reset = 1;
wire [1:0] state;
moore_fsm uut(
    .clk(clk),
    .reset(reset),
    .state(state)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("moore_fsm.vcd");
    $dumpvars(0, tb_moore_fsm);

    #10 reset = 0;
    #60;
    $finish;
end
initial begin
    $monitor("Time=%0t Reset=%b State=%b",
              $time, reset, state);
end
endmodule