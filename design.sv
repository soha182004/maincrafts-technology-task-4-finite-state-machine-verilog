module vending_machine(
    input clk,
    input reset,
    input coin5,
    input coin10,
    output reg dispense
);

parameter S0  = 2'b00;
parameter S5  = 2'b01;
parameter S10 = 2'b10;

reg [1:0] state;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= S0;
        dispense <= 0;
    end
    else
    begin
        dispense <= 0;

        case(state)

            S0:
            begin
                if(coin5)
                    state <= S5;

                else if(coin10)
                begin
                    state <= S10;
                    dispense <= 1;
                end
            end

            S5:
            begin
                if(coin5)
                begin
                    state <= S10;
                    dispense <= 1;
                end
                else if(coin10)
                begin
                    state <= S10;
                    dispense <= 1;
                end
            end

            S10:
            begin
                state <= S0;
            end

            default:
            begin
                state <= S0;
                dispense <= 0;
            end

        endcase
    end
end

endmodule