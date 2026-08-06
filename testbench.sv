`timescale 1ns/1ps

module tb_vending_machine;

reg clk;
reg reset;
reg coin5;
reg coin10;

wire dispense;

vending_machine uut(
    .clk(clk),
    .reset(reset),
    .coin5(coin5),
    .coin10(coin10),
    .dispense(dispense)
);

// Clock
always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    coin5 = 0;
    coin10 = 0;

    $dumpfile("dump.vcd");
    $dumpvars(0,tb_vending_machine);

    // Reset
    #10 reset = 0;

    // ₹5
    #10 coin5 = 1;
    #10 coin5 = 0;

    // ₹5 -> Dispense
    #10 coin5 = 1;
    #10 coin5 = 0;

    // Wait
    #20;

    // ₹10 Direct
    coin10 = 1;
    #10 coin10 = 0;

    #40;

    $finish;
end

initial
begin
    $monitor("Time=%0t State=%b Coin5=%b Coin10=%b Dispense=%b",
              $time,
              uut.state,
              coin5,
              coin10,
              dispense);
end

endmodule