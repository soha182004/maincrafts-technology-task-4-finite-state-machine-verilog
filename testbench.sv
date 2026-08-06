`timescale 1ns/1ps

module tb_password_lock;

reg clk;
reg reset;
reg key;

wire unlock;

password_lock uut(
    .clk(clk),
    .reset(reset),
    .key(key),
    .unlock(unlock)
);

// Clock
always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    key = 0;

    $dumpfile("dump.vcd");
    $dumpvars(0, tb_password_lock);

    #10 reset = 0;

    // Correct sequence: 1,1,1
    #10 key = 1;
    #10 key = 1;
    #10 key = 1;

    #10 key = 0;

    // Try again
    #20 key = 1;
    #10 key = 1;
    #10 key = 1;

    #20;

    $finish;
end

initial
begin
    $monitor("Time=%0t State=%b Key=%b Unlock=%b",
             $time,
             uut.state,
             key,
             unlock);
end

endmodule