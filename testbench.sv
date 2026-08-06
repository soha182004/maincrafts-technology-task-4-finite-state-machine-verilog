`timescale 1ns/1ps

module tb_traffic_light;

reg clk = 0;
reg reset = 1;

wire [2:0] light;

traffic_light uut(
    .clk(clk),
    .reset(reset),
    .light(light)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("traffic_light.vcd");
    $dumpvars(0, tb_traffic_light);

    #10 reset = 0;

    #100;

    $finish;

end

initial begin
    $monitor("Time=%0t Reset=%b Light=%b",
              $time, reset, light);
end

endmodule